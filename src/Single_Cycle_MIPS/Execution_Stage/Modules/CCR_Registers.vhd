library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CCR_Register is
    Port ( 
           reset : in STD_LOGIC;
           load : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR (7 downto 0);
           data_out : out STD_LOGIC_VECTOR (7 downto 0)
        );
end CCR_Register;

architecture Behavioral of CCR_Register is
    signal reg : STD_LOGIC_VECTOR (2 downto 0);
begin
    process(reset)
    begin
        if reset = '1' then
            reg <= (others => '0');
        else 
            if load = '1' then
                reg <= data_in;
            end if;
        end if;
    end process;

    data_out <= reg;
end Behavioral;
