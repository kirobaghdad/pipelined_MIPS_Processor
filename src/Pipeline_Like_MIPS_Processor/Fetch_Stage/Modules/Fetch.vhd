LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

entity Fetch is
    port (
        PC             : in  std_logic_vector(15 downto 0);
        HLT            : in std_logic;

        INT            : in std_logic;
        INT_PC         : in std_logic_vector(15 downto 0);

        Reset          : in std_logic;

        Instruction    : in std_logic_vector(4 downto 0);
        Branch_Taken   : in std_logic;

        EmptyStack     : in std_logic;
        InvalidAddress : in std_logic;

        RET            : in std_logic;
        RTI            : in std_logic;
        Call           : in std_logic;

        Rsrc1          : in std_logic_vector(15 downto 0);
        Data_Memory    : in std_logic_vector(15 downto 0);

        PC_Out         : out std_logic_vector(15 downto 0)
    );
end Fetch;

architecture behavioral of Fetch is
constant IM0                : std_logic_vector(15 downto 0) := (others => '0');
constant IM3                : std_logic_vector(15 downto 0) := (others => '0');
constant IM4                : std_logic_vector(15 downto 0) := (others => '0');

begin
    process(PC, HLT, INT, Reset, Instruction, Branch_Taken, EmptyStack, InvalidAddress, RET, RTI, Call)
    variable Signals            : std_logic_vector(7 downto 0);
    variable CheckJumpCondition : std_logic;
    variable CheckReturn        : std_logic;

    begin
	CheckJumpCondition := '1' when (Instruction = "11011" or Branch_Taken = '1') else '0';
	CheckReturn        := '1' when (RTI = '1' or RET = '1') else '0';
	Signals    	   := Call & CheckReturn & InvalidAddress & EmptyStack & CheckJumpCondition & Reset & INT & HLT ;
	
	Case Signals is
		when "10000000" => PC_Out <= Rsrc1;
		when "01000000" => PC_Out <= Data_Memory;
		when "00100000" => PC_Out <= IM4;
		when "00010000" => PC_Out <= IM3;
		when "00001000" => PC_Out <= Rsrc1;
		when "00000100" => PC_Out <= IM0;
		when "00000010" => PC_Out <= INT_PC;
		when "00000001" => PC_Out <= PC;
		when others     => PC_Out <= PC;
	end Case;

    end process;
end architecture behavioral;