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
    IMMD_Control : in STD_LOGIC;
    in_control : in STD_LOGIC;
    alu_control : in STD_LOGIC_VECTOR (2 downto 0);
    reg_write : in std_logic;
    mem_read : in std_logic;
    mem_write : in std_logic;
    
    
    -- Outputs (that gets out of the EX_MEM_Reg)
    reg_write_r : out std_logic;
    Rdst_r : out std_logic_vector(2 downto 0);
    updated_PC_r : out std_logic_vector(15 downto 0);
    result_r : out std_logic_vector(15 downto 0);
    mem_read_r : out std_logic;
    mem_write_r : out std_logic
  ) ;
end Execution_Stage;


architecture behavioral of Execution_Stage is
  signal OP1 : std_logic_vector(15 downto 0);
  signal temp_result : std_logic_vector(15 downto 0);
begin
    uut1: entity work.alu PORT MAP(alu_control => alu_control, OP1 => OP1, OP2 => R2, old_CCR => "000", result => temp_result);

    uut2: entity work.Ex_MEM_Reg PORT MAP(clk => clk, rst => rst, reg_write => reg_write, Rdst => Rdst, updated_PC => updated_PC, mem_read => mem_read, mem_write => mem_write, result => temp_result, reg_write_r => reg_write_r, Rdst_r => Rdst_r, updated_PC_r => updated_PC_r, result_r => result_r, mem_read_r => mem_read_r, mem_write_r => mem_write_r);

    uut3: entity work.R1_Selector PORT MAP(IMMD_Control => IMMD_Control, in_control => in_control, IMMD => IMMD, user_input => user_input, R1 => R1, OP1 => OP1);
    
    
end architecture behavioral;