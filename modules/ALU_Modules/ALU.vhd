library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
    PORT(
        aluControl : in STD_LOGIC_VECTOR (2 downto 0);
        R1 : in STD_LOGIC_VECTOR (15 downto 0);
        R2 : in STD_LOGIC_VECTOR (15 downto 0);
        oldCCR : in STD_LOGIC_VECTOR (2 downto 0);

        result : out STD_LOGIC_VECTOR (15 downto 0);
        newCCR : out STD_LOGIC_VECTOR (2 downto 0)
    );
end ALU;

architecture Behavioral of ALU is
    component ADDER is 
        PORT(
            R1 : in STD_LOGIC_VECTOR (15 downto 0);
            R2 : in STD_LOGIC_VECTOR (15 downto 0);
            c : in STD_LOGIC;

            result : out STD_LOGIC_VECTOR (15 downto 0);
            newCCR : out STD_LOGIC_VECTOR (2 downto 0)
        );
    end component;

    signal invR2 : STD_LOGIC_VECTOR (15 downto 0);
    
    begin
    
    -- In case of SUB operation
    invR2 <= not R2 when aluControl(2) = '1' else R2;

    uut1 : ADDER PORT MAP(R1 => R1, R2 => invR2, c => aluControl(2), result => result, newCCR => newCCR);

end Behavioral;
