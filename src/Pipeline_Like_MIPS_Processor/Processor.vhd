library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Processor is
  port (
      -- inputs
      clk : in std_logic;
      rst : in std_logic;
      user_input : in std_logic_vector(15 downto 0);

      -- outputs
      output : out std_logic_vector(15 downto 0)
    ) ;
end entity;


architecture behavioral of Processor is
  -- defining the intermediate signals
  
  ---------------------------------------------------------------
  ------------------------- Fetch Signals ----------------------
  ---------------------------------------------------------------
  Signal returned_Rsrc1 : std_logic_vector(15 downto 0);
  Signal updated_pc : std_logic_vector(15 downto 0);


  ---------------------------------------------------------------
  ------------------------- Decode Signals ----------------------
  ---------------------------------------------------------------
  Signal instr : std_logic_vector(15 downto 0);

  Signal returned_rdst : std_logic_vector(2 downto 0);
  Signal returned_write_data : std_logic_vector(15 downto 0);
  Signal reg_write : std_logic;

  -- Signal d_user_input : std_logic_vector(15 downto 0);
  Signal d_updated_pc : std_logic_vector(15 downto 0);
  signal d_instruction_op : std_logic_vector(4 downto 0);
  signal d_instruction : std_logic_vector(15 downto 0);
  Signal d_Rsrc1 : std_logic_vector(2 downto 0);
  Signal d_Rsrc2 : std_logic_vector(2 downto 0);
  Signal d_Rdst : std_logic_vector(2 downto 0);

  Signal e_Mread : std_logic;
  Signal e_Mwrite : std_logic;
  Signal e_RegWrite : std_logic;
  Signal e_Alu2 : std_logic;
  Signal e_Alu1 : std_logic;
  Signal e_Alu0 : std_logic;
  Signal e_alu_control : std_logic_vector(2 downto 0);
  Signal e_Branch : std_logic;
  Signal e_Memory_to_Reg : std_logic;
  Signal e_inst_imm : std_logic;
  Signal e_Stack : std_logic;
  Signal e_Call : std_logic;
  Signal e_Pop : std_logic;
  Signal e_Push : std_logic;
  Signal e_LDM : std_logic;
  Signal e_RET : std_logic;
  Signal e_RTI : std_logic;
  Signal e_Store : std_logic;
  Signal e_HLT : std_logic;
  Signal e_Reset : std_logic;
  Signal e_Int : std_logic;
  Signal e_zero : std_logic;
  Signal e_i_n : std_logic;
  Signal e_enable : std_logic;
  Signal e_Flags_Sel : std_logic_vector(1 downto 0);


  -- other outputs
  Signal e_R1 : std_logic_vector(15 downto 0);
  Signal e_R2 : std_logic_vector(15 downto 0);
  Signal e_Rdst : std_logic_vector(2 downto 0);

  Signal e_user_input : std_logic_vector(15 downto 0);
  Signal e_updated_pc : std_logic_vector(15 downto 0);

  ---------------------------------------------------------------
  ------------------------- Execute Signals ---------------------
  ---------------------------------------------------------------

  Signal immd : STD_LOGIC_VECTOR (15 downto 0); 

  Signal m_reg_write : std_logic;
  Signal m_Rdst : std_logic_vector(2 downto 0);
  Signal m_updated_PC : std_logic_vector(15 downto 0);
  Signal m_result : std_logic_vector(15 downto 0);
  Signal m_mem_read : std_logic;
  Signal m_mem_write : std_logic;

  Signal m_mem_to_reg : std_logic;
  Signal m_stack : std_logic;
  Signal m_call : std_logic;
  Signal m_pop : std_logic;
  Signal m_push : std_logic;
  Signal m_ldm : std_logic;
  Signal m_ret : std_logic;
  Signal m_rti : std_logic;
  Signal m_store : std_logic;
  Signal m_int : std_logic;
  Signal m_enable : std_logic;
  
  Signal m_flags_in_signal : std_logic;
  Signal m_flags_out_signal : std_logic;
  Signal m_flags : std_logic_vector(2 downto 0);

  ---------------------------------------------------------------
  ------------------------- Memory Signals ----------------------
  ---------------------------------------------------------------

  Signal wb_flags_out : std_logic_vector(2 downto 0); 

  Signal data_out : std_logic_vector(15 downto 0);
  Signal empty_stack : std_logic; 

  -- passing
  Signal wb_pc : std_logic_vector(15 downto 0);
  Signal wb_Rs1 : std_logic_vector(15 downto 0);

  Signal wb_rdst : std_logic_vector(2 downto 0);

  Signal wb_reg_write : std_logic;

  Signal wb_result : std_logic_vector(15 downto 0);

  Signal wb_mem_to_reg : std_logic;

  Signal wb_enable : std_logic;


  ---------------------------------------------------------------
  --------------------- Write Back Signals ----------------------
  ---------------------------------------------------------------
  Signal retuned_Rsrc1 : std_logic_vector(15 downto 0); -- to be injected into fetch stage



begin
  e_alu_control <= e_Alu2 & e_Alu1 & e_Alu0;
    
  ---------------------------------------------------------------
  ------------------------- Fetch Stage -------------------------
  ---------------------------------------------------------------

  Fetch_Stage: entity work.fetch_top
  port map(
    clk,
    '0', -- todo
    '0', -- todo
    rst,
    empty_stack, 
    '0', -- todo 
    e_RET,
    e_RTI,
    e_Call,
    returned_Rsrc1, -- from write back?? 
    returned_write_data,
    
    d_updated_pc,
    d_instruction_op,
    d_Rsrc1,
    d_Rsrc2,
    d_Rdst,
    immd
  );


  ---------------------------------------------------------------
  ------------------------- Decode Stage ------------------------
  ---------------------------------------------------------------

  d_instruction <= d_instruction_op & d_Rdst & d_Rsrc1 & d_Rsrc2 & "00";

  decode_stage: entity work.decode_stage
  port map(
    clk,
    rst,

    -- inputs
    d_instruction,
    d_updated_pc,

    -- write back stage inputs
    returned_rdst,
    returned_write_data,
    reg_write,

    -- controls
    user_input,

    --outputs
    -- D/E Reg Outputs
    -- Control Unit Controls
    e_Mread,
    e_Mwrite,
    e_RegWrite,
    e_Alu2,
    e_Alu1,
    e_Alu0,
    e_Branch,
    e_Memory_to_Reg,
    e_inst_imm,
    e_Stack,
    e_Call,
    e_Pop,
    e_Push,
    e_LDM,
    e_RET,
    e_RTI,
    e_Store,
    e_HLT,
    e_Reset,
    e_Int,
    e_zero,
    e_i_n,
    e_enable,
    e_Flags_Sel,


    -- other outputs
    e_R1,
    e_R2,
    e_Rdst,

    e_user_input,
    e_updated_pc
  );


  
  ---------------------------------------------------------------
  ------------------------- Execute Stage -----------------------
  ---------------------------------------------------------------

  -- ES should output the Rsrc1
  Execution_Stage: entity work.Execution_Stage
  port map(
     -- INPUTS 
     clk,
     rst,

     e_user_input,
     e_R1,
     e_R2,
     e_updated_pc,
     immd, -- todo
     -- should get it from the fetch 

     e_Rdst,

     e_Mread,
     e_Mwrite,
     e_RegWrite,
     e_alu_control,
     e_i_n,
     e_inst_imm,
     e_Branch,
     e_Memory_to_Reg,
     e_Stack,
     e_Call,
     e_Push, 
     e_Pop,
     e_LDM,
     e_RET,
     e_RTI,
     e_Store,
     e_Int,
     e_zero,
     e_enable,

 
     -- Outputs 
     m_reg_write,
     m_Rdst,
     m_updated_PC,
     m_result,
     m_mem_read,
     m_mem_write,
 
     m_mem_to_reg,
     m_stack,
     m_call,
     m_push,
     m_pop,
     m_ldm,
     m_ret,
     m_rti,
     m_store,
     m_int,
     m_enable,

     m_flags_in_signal,
     m_flags_out_signal,
     m_flags
  );

  ---------------------------------------------------------------
  ------------------------- Memory Stage ------------------------
  ---------------------------------------------------------------

  Memory_Stage: entity work.memory_stage
  port map(
    m_push, 
    m_pop,
    m_ldm,
    m_store,
    m_call,
    m_ret,
    m_int,
    m_rti,
    clk,
    rst,

    m_mem_read,
    m_mem_write,
    m_updated_pc,
    "0000000000000000",  -- todo
    
    m_flags_in_signal,
    m_flags_out_signal, 

    m_flags,

    -- outputs 
    wb_flags_out, 

    data_out, 
    empty_stack,

    m_enable,
    wb_enable,

    -- passing
    wb_pc,
    wb_Rs1,

    m_rdst,
    wb_rdst,

    m_reg_write,
    wb_reg_write,

    m_result,
    wb_result,

    m_mem_to_reg,
    wb_mem_to_reg
  );

  ---------------------------------------------------------------
  --------------------------- WB Stage --------------------------
  ---------------------------------------------------------------

  Write_Back_Stage: entity work.Write_Back_Stage
  port map(
    rst,

    -- wb_updated_sp,
    wb_pc,
    wb_Rs1,
    wb_result,
    data_out, 
    wb_rdst,

    wb_mem_to_reg,
    wb_reg_write,
    wb_enable, 

    updated_pc, -- pass to the fetch
    returned_Rsrc1,
    returned_Rdst,
    reg_write,

    output,
    returned_write_data
  );
  
end architecture behavioral;

