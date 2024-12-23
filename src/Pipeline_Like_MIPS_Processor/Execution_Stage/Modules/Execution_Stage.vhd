library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Execution_Stage is
  port (
    -- INPUTS 
    clk : in std_logic;
    rst : in std_logic;
    user_input: in std_logic_vector(15 downto 0);
    R1 : in STD_LOGIC_VECTOR (15 downto 0);
    R2 : in STD_LOGIC_VECTOR (15 downto 0);
    updated_PC : in STD_LOGIC_VECTOR (15 downto 0);
    IMMD : in STD_LOGIC_VECTOR (15 downto 0);
    Rdst : in STD_LOGIC_VECTOR (2 downto 0);

    
    -- Control Signals
    mem_read : in std_logic;
    mem_write : in std_logic;
    reg_write : in std_logic;
    alu_control : in STD_LOGIC_VECTOR (2 downto 0);
    in_control : in STD_LOGIC;
    IMMD_Control : in STD_LOGIC;

    branch : in std_logic;
    mem_to_reg : in std_logic;
    stack : in std_logic;
    call : in std_logic;
    push : in std_logic;
    pop : in std_logic;
    ldm: in std_logic;
    ret: in std_logic;
    rti: in std_logic;
    store : in std_logic;
    int : in std_logic;
    zero : in std_logic;
    enable : in std_logic;


    -- Outputs 
    m_reg_write : out std_logic;
    m_Rdst : out std_logic_vector(2 downto 0);
    m_updated_PC : out std_logic_vector(15 downto 0);
    m_result : out std_logic_vector(15 downto 0);
    m_mem_read : out std_logic;
    m_mem_write : out std_logic;

    m_mem_to_reg : out std_logic;
    m_stack : out std_logic;
    m_call : out std_logic;
    m_push : out std_logic;
    m_pop : out std_logic;
    m_ldm: out std_logic;
    m_ret: out std_logic;
    m_rti: out std_logic;
    m_store : out std_logic;
    m_int : out std_logic;
    m_enable : out std_logic;

    m_flags_in_signal : out std_logic;
    m_flags_out_signal : out std_logic;

    m_flags : out std_logic_vector(2 downto 0) -- CCR from ALU
    
  ) ;
end Execution_Stage;

-- CCR -> How to get it??
architecture behavioral of Execution_Stage is
  signal OP1 : std_logic_vector(15 downto 0);
  signal temp_result : std_logic_vector(15 downto 0);

  signal flags_in_signal : std_logic;
  signal flags_out_signal : std_logic;

  signal CCR : std_logic_vector(2 downto 0);
begin
    uut1: entity work.alu PORT MAP(alu_control => alu_control, OP1 => OP1, OP2 => R2, old_CCR => CCR, result => temp_result, new_CCR => CCR);

    uut2: entity work.Ex_MEM_Reg PORT MAP(clk => clk, rst => rst, reg_write => reg_write, Rdst => Rdst, updated_PC => updated_PC, mem_read => mem_read, mem_write => mem_write, mem_to_reg => mem_to_reg, stack => stack, call => call, push => push,pop => pop, ldm => ldm, ret => ret, rti => rti, store => store, int => int, enable => enable, result => temp_result, flags_in_signal => flags_in_signal, flags_out_signal => flags_out_signal, flags => CCR, reg_write_r => m_reg_write, Rdst_r => m_Rdst, updated_PC_r => m_updated_PC, result_r => m_result, mem_read_r => m_mem_read, mem_write_r => m_mem_write, mem_to_reg_r => m_mem_to_reg, stack_r => m_stack, call_r=> m_call, push_r => m_push, pop_r => m_pop, ldm_r => m_ldm, ret_r => m_ret, rti_r => m_rti, store_r => m_store, int_r => m_int, enable_r => m_enable, flags_in_signal_r => m_flags_in_signal, flags_out_signal_r => m_flags_out_signal, flags_r => m_flags);

    -- IMMD in R2
    uut3: entity work.R1_Selector PORT MAP(IMMD_Control => IMMD_Control, in_control => in_control, IMMD => IMMD, user_input => user_input, R1 => R1, OP1 => OP1);
    
    
end architecture behavioral;