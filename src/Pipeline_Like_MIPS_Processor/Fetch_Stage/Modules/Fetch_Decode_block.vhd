library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity Fetch_Decode_block is 
    port(
        clk              : in std_logic;

	PC     	         : in std_logic_vector(15 downto 0);
	instruction      : in std_logic_vector(15 downto 0);

        flush            : in std_logic;
	INT              : out std_logic;
        updated_PC       : out std_logic_vector(15 downto 0);
	instruction_out  : out std_logic_vector(4 downto 0);
	Rsrc1    	 : out std_logic_vector(2 downto 0);
	Rsrc2    	 : out std_logic_vector(2 downto 0);
	Rdst             : out std_logic_vector(2 downto 0);
	immd             : out std_logic_vector(15 downto 0);

        INT_location     : out std_logic_vector(5 downto 0)
    );
end Fetch_Decode_block;

architecture arch of Fetch_Decode_block is

constant INT_Offset      : std_logic_vector(1 downto 0) := "11";
begin 
    process(clk)
    variable index       : std_logic_vector(4 downto 0);
    begin
	if(falling_edge(clk)) then
		if flush = '1' then  ------- flush
			INT		<= '0';
			instruction_out <= "00000";
			immd 		<= (others => '0');
			Rsrc1 		<= (others => '0');
			Rsrc2 		<= (others => '0');
			Rdst 		<= (others => '0');
			updated_PC      <= std_logic_vector(unsigned(PC) + 1);
		elsif instruction(15 downto 11)= "11110" then  ----- interrupt
			INT		<= '1';
			instruction_out <= instruction(15 downto 11);
			immd 		<= (others => '0');
			Rsrc1 		<= (others => '0');
			Rsrc2 		<= (others => '0');
			Rdst 		<= (others => '0');
			index           := instruction(7 downto 3);
			INT_location    <= std_logic_vector(unsigned('0' & index ) + unsigned("0000" & INT_Offset));
			updated_PC      <= std_logic_vector(unsigned(PC) + 1);
		else
			INT		<= '0';
			updated_PC 	<= PC;
			instruction_out <= instruction(15 downto 11);
			immd 		<= instruction;
			Rsrc1 		<= instruction(7 downto 5);
			Rsrc2 		<= instruction(4 downto 2);
			Rdst 		<= instruction(10 downto 8);
			
		end if;
	end if;
    end process;
     
end arch;