library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
entity instruction_memory_tb is
end instruction_memory_tb;
ARCHITECTURE testbench_a OF instruction_memory_tb IS
    COMPONENT instruction_memory IS
        PORT (
       		PC           : in std_logic_vector (15 downto 0);
		INT_location : in std_logic_vector (5 downto 0);
		instruction  : out std_logic_vector (15 downto 0);
		INT_PC       : out std_logic_vector (15 downto 0)
        );
    END COMPONENT;
    SIGNAL PC           : std_logic_vector(15 downto 0) := (others => '0');
    SIGNAL INT_location : std_logic_vector(5 downto 0) := (others => '0');
    SIGNAL instruction  : std_logic_vector(15 downto 0);
    SIGNAL INT_PC       : std_logic_vector(15 downto 0);
BEGIN
    my_instance : instruction_memory
        PORT MAP (
	    PC           =>  PC,
	    INT_location => INT_location,
            instruction  => instruction,
	    INT_PC       => INT_PC
        );
    
    stimulus : process
    begin
	------test one
        PC           <= "0000000000000001";
	wait for 20 ps;  	
        assert (instruction = "0001000100000010")
            report "Test Failed."
            severity note;
	INT_location <= "000011";
	wait for 10 ps;  
	assert (INT_PC      = "0001001100000100")
        	report "Test Failed."
        	severity note;
	-----test two
	wait for 20 ps;
        PC <= "0000000000000101";
	wait for 20 ps;  	
        assert (instruction = "0010000100100010")
		report "Test Failed."
            	severity note;
	INT_location <= "000111";
	wait for 20 ps;
	assert (INT_PC      = "0011001100000000")
            	report "Test Failed."
            	severity note;
	----- test three
        PC <= "0000000000000111";
	wait for 20 ps;  	
        assert (instruction = "0011001100000000")
            	report "Test Failed."
            	severity note;
	INT_location <= "000101";
	wait for 20 ps;  	
	assert (INT_PC      = "0010000100100010")
            	report "Test Failed."
            	severity note;
        wait;
    end process stimulus;
END testbench_a;