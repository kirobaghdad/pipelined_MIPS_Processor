library IEEE;
use IEEE.NUMERIC_STD.All;
use IEEE.STD_LOGIC_1164.ALL;
-- use IEEE.STD_LOGIC_ARITH.ALL;
-- use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity InstructionMemory is
    Port ( 
        -- TODO -> Do We need to make it 16 bits??
        address : in STD_LOGIC_VECTOR (15 downto 0); 
        data_out : out STD_LOGIC_VECTOR (15 downto 0)
    );
end InstructionMemory;

architecture Behavioral of InstructionMemory is
    type memory_array is array (0 to 4095) of STD_LOGIC_VECTOR (15 downto 0);
    signal memory : memory_array := (
        others => "0000000000000000"
    );

begin
    process(address)
    begin
        data_out <= memory(to_integer(unsigned(address)));
    end process;
end Behavioral;
