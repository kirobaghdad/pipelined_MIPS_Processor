library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity instruction_memory is 
    port(
        PC           : in std_logic_vector (15 downto 0);
	INT_location : in std_logic_vector (5 downto 0);
	instruction  : out std_logic_vector (15 downto 0);
	INT_PC       : out std_logic_vector (15 downto 0)
    );
end instruction_memory;

architecture arch of instruction_memory is
    type instructions_memo is array (0 to 65535) of std_logic_vector(15 downto 0);
    signal instructions : instructions_memo := (
	    0  => "0000000000000000",
        1  => "0100101100101000", -- Add R3,R1,R2
        2  => "0000000000000000", -- NOP
        3  => "0000000000000000",
-- Add R1,R2,R3
        4  => "0000000000000000",
        5  => "0000000000000000",
        6  => "0000000000000000",
        7  => "0000000000000000",

        8  => "0000000000000000",
        9  => "0000000000000000",
        10 => "0000000000000000",

        11 => "0110000000001000",
        12 => "0111000100000100",
        13 => "0111001000000101",

        14 => "1000000000010001",
        15 => "1000000100100010",
        16 => "1001001000110011",
        17 => "1001001100000000",

        18 => "1010000000010001",
        19 => "1011000100000001",

        20 => "1111000000000000",
        21 => "1110000000000000",
	others => (others => '0')
	);
----------

	--- fill ur instructions

----------
begin 
    process(PC,INT_location)
    begin 
        instruction <= instructions(to_integer(unsigned(PC)));
	INT_PC      <= instructions(to_integer(unsigned(INT_location)));
    end process;   
end arch;