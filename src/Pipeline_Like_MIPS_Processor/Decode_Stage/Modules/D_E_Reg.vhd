library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity D_E_Reg is
  port (
    clk : in std_logic;
    rst : in std_logic;

    -- inputs from decode stage
    d_Mread : in STD_LOGIC;
    d_Mwrite : in STD_LOGIC;
    d_RegWrite : in STD_LOGIC;
    d_Alu2 : in STD_LOGIC;
    d_Alu1 : in STD_LOGIC;
    d_Alu0 : in STD_LOGIC;
    d_Branch : in STD_LOGIC;
    d_Memory_to_Reg : in STD_LOGIC;
    d_inst_imm : in STD_LOGIC;
    d_Stack : in STD_LOGIC;
    d_Call : in STD_LOGIC;
    d_Pop : in STD_LOGIC;
    d_push : in std_logic;
    d_LDM : in STD_LOGIC;
    d_RET : in STD_LOGIC;
    d_RTI : in STD_LOGIC;
    d_Store : in STD_LOGIC;
    -- d_HLT : in STD_LOGIC;
    -- d_Reset : in STD_LOGIC;
    d_Int : in STD_LOGIC;
    d_zero : in STD_LOGIC;
    d_i_n : in STD_LOGIC;
    d_enable : in STD_LOGIC;
    d_Flags_Sel : in STD_LOGIC_VECTOR(1 DOWNTO 0);

    -- other inputs
    d_R1 : in STD_LOGIC_VECTOR(15 downto 0);
    d_R2 : in STD_LOGIC_VECTOR(15 downto 0);
    d_Rdst : in STD_LOGIC_VECTOR(2 downto 0);

    d_user_input : in std_logic_vector(15 downto 0);
    d_updated_pc : in STD_LOGIC_VECTOR(15 downto 0);


    -- outputs to execute stage
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
    e_push : out std_logic;
    e_LDM : OUT STD_LOGIC;
    e_RET : OUT STD_LOGIC;
    e_RTI : OUT STD_LOGIC;
    e_Store : OUT STD_LOGIC;
    -- e_HLT : OUT STD_LOGIC;
    -- e_Reset : OUT STD_LOGIC;
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
end D_E_Reg;


architecture behavioral of D_E_Reg is
    signal d_inputs : std_logic_vector(89 downto 0);    
    signal e_outputs : std_logic_vector(89 downto 0);    
begin

    d_inputs <= d_push & d_Mread & d_Mwrite & d_RegWrite & d_Alu2 & d_Alu1 & d_Alu0 & d_Branch & d_Memory_to_Reg & d_inst_imm & d_Stack & d_Call & d_Pop & d_LDM & d_RET & d_RTI & d_Store & d_Int & d_zero & d_i_n & d_enable & d_Flags_Sel & d_R1 & d_R2 & d_Rdst & d_user_input & d_updated_pc;

    e_push <= e_outputs(89);
    e_Mread <= e_outputs(88); e_Mwrite <= e_outputs(87); e_RegWrite <= e_outputs(86); e_Alu2 <= e_outputs(85); e_Alu1 <= e_outputs(84); e_Alu0 <= e_outputs(83); e_Branch <= e_outputs(82); e_Memory_to_Reg <= e_outputs(81); e_inst_imm <= e_outputs(80); e_Stack <= e_outputs(79); e_Call <= e_outputs(78); e_Pop <= e_outputs(77); e_LDM <= e_outputs(76); e_RET <= e_outputs(75); e_RTI <= e_outputs(74); e_Store <= e_outputs(73); e_Int <= e_outputs(72); e_zero <= e_outputs(71); e_i_n <= e_outputs(70); e_enable <= e_outputs(69); e_Flags_Sel <= e_outputs(68 downto 67); e_R1 <= e_outputs(66 downto 51); e_R2 <= e_outputs(50 downto 35); e_Rdst <= e_outputs(34 downto 32); e_user_input <= e_outputs(31 downto 16); e_updated_pc <= e_outputs(15 downto 0);
    
    pip_D_E: entity work.var_reg 
    generic map (size => 90) 
    port map ( 
        clk => clk, 
        rst => rst, 
        D => d_inputs, 
        Q => e_outputs 
    );
    

end architecture behavioral;