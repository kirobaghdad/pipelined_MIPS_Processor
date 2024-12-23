LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

entity Decode_Stage is
  port (
    clk : in std_logic;
    rst : in std_logic;

    -- inputs
    instr : in std_logic_vector(15 downto 0);
    updated_pc : in std_logic_vector(15 downto 0);

    -- write back stage inputs
    returned_rdst : in std_logic_vector(2 downto 0);
    returned_write_data : in std_logic_vector(15 downto 0);
    reg_write : in std_logic;

    -- controls
    user_input : in std_logic_vector(15 downto 0);
    -- user_reset : in std_logic;


    --outputs
    -- D/E Reg Outputs
    -- Control Unit Controls
    e_Mread : OUT STD_LOGIC;
    e_Mwrite : OUT STD_LOGIC;
    e_RegWrite : OUT STD_LOGIC;
    e_Alu2 : OUT STD_LOGIC;
    e_Alu1 : OUT STD_LOGIC;
    e_Alu0 : OUT STD_LOGIC;
    e_Branch : OUT STD_LOGIC;
    e_Memory_to_Reg : OUT STD_LOGIC;
    e_inst_imm : OUT STD_LOGIC;
    e_Stack : OUT STD_LOGIC;
    e_Call : OUT STD_LOGIC;
    e_Pop : OUT STD_LOGIC;
    e_Push : OUT std_logic;
    e_LDM : OUT STD_LOGIC;
    e_RET : OUT STD_LOGIC;
    e_RTI : OUT STD_LOGIC;
    e_Store : OUT STD_LOGIC;
    e_HLT : OUT STD_LOGIC;
    e_Reset : OUT STD_LOGIC;
    e_Int : OUT STD_LOGIC;
    e_zero : OUT STD_LOGIC;
    e_i_n : OUT STD_LOGIC;
    e_enable : OUT STD_LOGIC;
    e_Flags_Sel : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);


    -- other outputs
    e_R1 : out STD_LOGIC_VECTOR(15 downto 0);
    e_R2 : out STD_LOGIC_VECTOR(15 downto 0);
    e_Rdst : out STD_LOGIC_VECTOR(2 downto 0);

    e_user_input : out std_logic_vector(15 downto 0);
    e_updated_pc : out STD_LOGIC_VECTOR(15 downto 0)
  ) ;
end Decode_Stage;

architecture behavioral of Decode_Stage is
    Signal d_Mread :  STD_LOGIC;
    Signal d_Mwrite :  STD_LOGIC;
    Signal d_RegWrite :  STD_LOGIC;
    Signal d_Alu2 :  STD_LOGIC;
    Signal d_Alu1 :  STD_LOGIC;
    Signal d_Alu0 :  STD_LOGIC;
    Signal d_Branch :  STD_LOGIC;
    Signal d_Memory_to_Reg :  STD_LOGIC;
    Signal d_inst_imm :  STD_LOGIC;
    Signal d_Stack :  STD_LOGIC;
    Signal d_Call :  STD_LOGIC;
    Signal d_Pop :  STD_LOGIC;
    Signal d_Push :  STD_LOGIC;
    Signal d_LDM :  STD_LOGIC;
    Signal d_RET :  STD_LOGIC;
    Signal d_RTI :  STD_LOGIC;
    Signal d_Store :  STD_LOGIC;
    Signal d_HLT :  STD_LOGIC;
    Signal d_Reset :  STD_LOGIC;
    Signal d_Int :  STD_LOGIC;
    Signal d_zero :  STD_LOGIC;
    Signal d_i_n :  STD_LOGIC;
    Signal d_enable :  STD_LOGIC;
    Signal d_Flags_Sel :  STD_LOGIC_VECTOR(1 DOWNTO 0);

    Signal d_R1 : STD_LOGIC_VECTOR(15 downto 0);
    Signal d_R2 : STD_LOGIC_VECTOR(15 downto 0);

    -- Signal d_Rdst : out STD_LOGIC_VECTOR(2 downto 0);

    -- Signal d_user_input : out std_logic;
    -- Signal d_updated_pc : out STD_LOGIC_VECTOR(15 downto 0);

begin


    CU : entity work.control_unit
    port map(
        instr(15 downto 11),

        d_Mread,
        d_Mwrite,
        d_RegWrite,
        d_Alu2,
        d_Alu1,
        d_Alu0,
        d_Branch,
        d_Memory_to_Reg,
        d_inst_imm,
        d_Stack,
        d_Call,
        d_Pop,
        d_push,
        d_LDM,
        d_RET,
        d_RTI,
        d_Store,
        d_HLT,
        d_Reset,
        d_Int,
        d_zero,
        d_i_n,
        d_enable,
        d_Flags_Sel
    );

    RF : entity work.RegFile
    port map(
        instr(7 downto 5),
        instr(4 downto 2),
        returned_rdst,
        returned_write_data,
        reg_write,
        clk,
        rst,

        d_R1,
        d_R2
    );

    D_E_Reg: entity work.D_E_Reg
    port map(
        clk,
        rst,

        d_Mread,
        d_Mwrite,
        d_RegWrite,
        d_Alu2,
        d_Alu1,
        d_Alu0,
        d_Branch,
        d_Memory_to_Reg,
        d_inst_imm,
        d_Stack,
        d_Call,
        d_Pop,
        d_push,
        d_LDM,
        d_RET,
        d_RTI,
        d_Store,
        -- d_HLT,
        -- d_Reset,
        d_Int,
        d_zero,
        d_i_n,
        d_enable,
        d_Flags_Sel,
    
        -- other inputs
        d_R1,
        d_R2,
        instr(10 downto 8),
    
        user_input,
        updated_pc,



        -- outputs to execute stage
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
        -- e_HLT,
        -- e_Reset,
        e_Int,
        e_zero,
        e_i_n,
        e_enable,
        e_Flags_Sel,
    
        -- other inputs
        e_R1,
        e_R2,
        e_Rdst,
    
        e_user_input,
        e_updated_pc
    );

    
end architecture behavioral;