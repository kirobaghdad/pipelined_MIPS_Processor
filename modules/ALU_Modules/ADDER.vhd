library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ADDER is
    PORT(
        R1 : in STD_LOGIC_VECTOR (15 downto 0);
        R2 : in STD_LOGIC_VECTOR (15 downto 0);
        c : in STD_LOGIC;

        result : out STD_LOGIC_VECTOR (15 downto 0);
        newCCR : out STD_LOGIC_VECTOR (2 downto 0)
    );
end ADDER;

architecture Behavioral of ADDER is
    signal temp_result : std_logic_vector(16 downto 0);
    signal temp_carry : std_logic_vector(16 downto 0);
    begin
        temp_carry <= "0000000000000000" & c;
        temp_result <= std_logic_vector(unsigned('0' & R1) + unsigned('0' & R2) + unsigned(temp_carry));

        result <= temp_result(15 downto 0);

        -- Zero Flag
        newCCr(0) <= '1' when temp_result(15 downto 0) = "0000000000000000" else '0';
        -- Negative Flag 
        newCCR(1) <= temp_result(15);
        -- Carry Flag 
        newCCR(2) <= temp_result(16);
end Behavioral;