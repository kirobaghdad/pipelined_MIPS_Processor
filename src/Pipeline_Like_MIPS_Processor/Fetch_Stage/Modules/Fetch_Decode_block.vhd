library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity Fetch_Decode_block is 
    port(
        clk              : in std_logic;
        reset            : in std_logic;

	updated_PC     	 : in std_logic_vector(15 downto 0);
	instruction      : in std_logic_vector(15 downto 0);

        user_input       : in std_logic_vector(15 downto 0);
        flush            : in std_logic;
	INT              : out std_logic;
	interrupt_offset : out std_logic_vector(3 downto 0);
        updated_PC_out   : out std_logic_vector(15 downto 0);
	instruction_out      : out std_logic_vector(4 downto 0);
	Rsrc1    	 : out std_logic_vector(2 downto 0);
	Rsrc2    	 : out std_logic_vector(2 downto 0);
	immd             : out std_logic_vector(15 downto 0);
        user_reset       : out std_logic;
	Rdst             : out std_logic_vector(2 downto 0);
        user_input_out   : out std_logic_vector(15 downto 0)
    );
end Fetch_Decode_block;

architecture arch of Fetch_Decode_block is
begin 
    process(clk) -- check if there is another signals which will influence  
    begin
	if(rising_edge(clk)) then
        	if reset = '1' then
			INT		<= '0';
			updated_PC_out 	<= (others => '0');
			instruction_out <= (others => '0');
			immd 		<= (others => '0');
			user_reset 	<= '1';
			Rsrc1 		<= (others => '0');
			Rsrc2 		<= (others => '0');
			Rdst 		<= (others => '0');
			user_input_out  <= (others => '0');
		elsif(instruction(15 downto 11)= "11110") then
			INT		<= '1';
			instruction_out <= (others => '0');
			interrupt_offset<= "0110"; -- offset is equal to 6
			user_reset 	<= '0';
			immd 		<= (others => '0');
			Rsrc1 		<= (others => '0');
			Rsrc2 		<= (others => '0');
			Rdst 		<= (others => '0');
			user_input_out  <= (others => '0');
		elsif(instruction(15 downto 11)= "00110") then
			INT		<= '0';
			updated_PC_out 	<= updated_PC;
			instruction_out <= instruction(15 downto 11);
			user_reset 	<= '0';
			user_input_out  <= user_input;
			immd 		<= (others => '0');
			Rsrc1 		<= (others => '0');
			Rsrc2 		<= (others => '0');
			Rdst 		<= (others => '0');

		else
			INT		<= '0';
			updated_PC_out 	<= updated_PC;
			instruction_out <= instruction(15 downto 11);
			user_reset 	<= '0';
			user_input_out  <= (others => '0');
			immd 		<= instruction;
			Rsrc1 		<= instruction(7 downto 5);
			Rsrc2 		<= instruction(4 downto 2);
			Rdst 		<= instruction(10 downto 8);
			user_input_out  <= (others => '0');
			
		end if;
	end if;
    end process;
     
end arch;
