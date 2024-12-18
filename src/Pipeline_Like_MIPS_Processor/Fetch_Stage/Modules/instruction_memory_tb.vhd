library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
entity instruction_memory_tb is
end instruction_memory_tb;
ARCHITECTURE testbench_a OF instruction_memory_tb IS
    COMPONENT instruction_memory IS
        PORT (
            PC : IN std_logic_vector(15 downto 0);
            instruction: OUT std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    SIGNAL PC : std_logic_vector(15 downto 0) := (others => '0');
    SIGNAL instruction : std_logic_vector(15 downto 0);
BEGIN
    my_instance : instruction_memory
        PORT MAP (
	    PC =>  PC,
            instruction => instruction
        );
    
    stimulus : process
    begin
	------test one
        PC <= "0000000000000001";
	wait for 20 ps;  	
        assert (instruction = "0001000100000010")
            report "Test Failed."
            severity note;
	-----test two
	wait for 20 ps;
        PC <= "0000000000000101";
	wait for 20 ps;  	
        assert (instruction = "0010000100100010")
            report "Test Failed."
            severity note;
	----- test three
         PC <= "0000000000000111";
	wait for 20 ps;  	
        assert (instruction = "0011001100000000")
            report "Test Failed."
            severity note;
        wait;
    end process stimulus;
END testbench_a;