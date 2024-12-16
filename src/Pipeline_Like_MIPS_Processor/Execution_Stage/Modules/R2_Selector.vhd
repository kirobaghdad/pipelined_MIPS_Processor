-- This module selects the R2 that will be input to ALU
-- In single cycle processor, it does not consider the Forwarding and Hazards

-- Probably We will not need it in the single cycle

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity R1_Selector is
  port (
    -- Selectors
    IMMD_Control : in STD_LOGIC;
    inControl : in STD_LOGIC;

    -- Inputs
    IMMD : in STD_LOGIC_VECTOR (15 downto 0);
    user_input : in STD_LOGIC_VECTOR (15 downto 0);
    -- R2 : in STD_LOGIC_VECTOR (15 downto 0);

    -- Outputs
    OP2 : out STD_LOGIC_VECTOR (15 downto 0)
  );
end R1_Selector;

architecture behavioral of R1_Selector is
    
begin
    OP1 <= IMMD when IMMD_Control = '1'
    else user_input when inControl = '1'
    else R1;    
    
end architecture behavioral;