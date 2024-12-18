library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity instruction_memory is 
    port(
        PC     : in std_logic_vector (15 downto 0);
	instruction  : out std_logic_vector (15 downto 0)
    );
end instruction_memory;

architecture arch of instruction_memory is
    type instructions_memo is array (0 to 65535) of std_logic_vector(15 downto 0);
    signal instructions : instructions_memo := (
	0  => "0001000000000001",
        1  => "0001000100000010",
        2  => "0001001000000011",
        3  => "0001001100000100",

        4  => "0010000000010001",
        5  => "0010000100100010",
        6  => "0011001000110011",
        7  => "0011001100000000",

        8  => "0100000000010000",
        9  => "0100000100100001",
        10 => "0100001000110010",

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
    process(PC)
    begin 
        instruction <= instructions(to_integer(unsigned(PC)));
    end process;   
end arch;