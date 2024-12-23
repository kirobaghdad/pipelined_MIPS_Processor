-- the processor now contains only the Execute and Decode Stages

entity Processor is
  port (
      -- inputs
      clk : in std_logic;
      rst : in std_logic;
      user_input : in std_logic_vector(15 downto 0);

      -- outputs
      output : out std_logic_vector(15 downto 0)
    ) ;
end Processor;


architecture architecture of Processor is
  
begin
  
  fetch_stage: work.Fetch
  port map(
    ,
    hlt,
    int,
    int_pc,
    rst,
    branch_taken,
    empty_stack
    invalid_address,
    ret,
    rti,
    call,
    Rsrc1,
    data_memory,

    pc_out
  ); 

  instruction_memory: work.instruction_memory
  port map(
    pc_out,
    int_location,

    instruction,
    int_pc
  );

  Fetch_Decode_block: work.Fetch_Decode_block
  (
    clk,

    PC     	         : in std_logic_vector(15 downto 0);
    instruction      : in std_logic_vector(15 downto 0);
  
    flush            : in std_logic;
    INT             ,
          updated_PC       : out std_logic_vector(15 downto 0);
    instruction_out  : out std_logic_vector(4 downto 0);
    Rsrc1    	 : out std_logic_vector(2 downto 0);
    Rsrc2    	 : out std_logic_vector(2 downto 0);
    Rdst             : out std_logic_vector(2 downto 0);
    immd             : out std_logic_vector(15 downto 0);
  
          INT_location     : out std_logic_vector(5 downto 0)
  );

  Fetch_RegFile: work.Fetch_RegFile
  (
    clk             : in  std_logic;
    PC_in           : in  std_logic_vector(15 downto 0);  
    instruction_in  : in std_logic_vector(4 downto 0);
    Rsrc1_in        : in std_logic_vector(2 downto 0);
    Rsrc2_in        : in std_logic_vector(2 downto 0);
    Rdst_in         : in std_logic_vector(2 downto 0);
    immd_in         : in std_logic_vector(15 downto 0);
    PC_out          : out std_logic_vector(15 downto 0);
    instruction_out : out std_logic_vector(4 downto 0);
    Rsrc1_out       : out std_logic_vector(2 downto 0);
    Rsrc2_out       : out std_logic_vector(2 downto 0);
    Rdst_out        : out std_logic_vector(2 downto 0);
    immd_out        : out std_logic_vector(15 downto 0)
  );

  -- fetch still not complete

  decode_stage: work.decode_stage
  port map(
    clk,
    rst,

    -- inputs
    instruction,
    updated_pc,

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
    e_RegWrite
    e_Alu2,
    e_Alu1,
    e_Alu0,
    e_Branch,
    e_Memory_to_Reg,
    e_inst_imm,
    e_Stack,
    e_Call,
    e_Pop,
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


  -- ES should output the Rsrc1
  Execution_Stage: work.Execution_Stage
  (
     -- INPUTS 
     clk,
     rst,

     e_user_input,
     e_R1,
     e_R2,
     e_updated_pc,
     IMMD : in STD_LOGIC_VECTOR (15 downto 0);

     e_Rdst,

     e_Mread,
     e_Mwrite,
     e_RegWrite
     e_Alu2,
     e_Alu1,
     e_Alu0,
     e_Branch,
     e_Memory_to_Reg,
     e_Stack,
     e_Call,
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
     m_pop,
     m_ldm,
     m_ret,
     m_rti,
     m_store,
     m_int,
     m_enable

     -- e_IMMD_Control : out STD_LOGIC;
     -- e_zero : out std_logic;
     -- branch : in std_logic;
  );


  Memory_Stage: work.memory_stage
  port map(
    m_push, -- todo
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
    m_Rsrc1, -- 
    m_result, -- todo
    m_flags_signal_in, -- todo
    m_flags_signal_out, -- todo
    m_flags_in, -- todo
    m_flags_out, -- todo

    data_out, -- todo
    empty_stack,

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

  Write_Back_Stage: work.Write_Back_Stage
  port map(
    rst,

    wb_updated_sp,
    wb_updated_pc,
    wb_Rs1,
    wb_result,
    data_out,
    wb_rdst,
    wb_stack, -- todo

    wb_mem_to_reg,
    wb_reg_write,


    updated_sp,
    updated_pc,
    retuned_Rsrc1,
    returned_Rdst,
    reg_write,

    output,
    returned_write_data
  );
  
end architecture architecture;





  -- instr : in std_logic_vector(15 downto 0);
  -- -- inputs
  -- instr : in std_logic_vector(15 downto 0);
  -- updated_pc : in std_logic_vector(15 downto 0);

  -- -- write back stage inputs
  -- returned_rdst : in std_logic_vector(2 downto 0);
  -- returned_write_data : in std_logic_vector(15 downto 0);
  -- reg_write : in std_logic;

  -- -- controls
  -- user_input : in std_logic;
