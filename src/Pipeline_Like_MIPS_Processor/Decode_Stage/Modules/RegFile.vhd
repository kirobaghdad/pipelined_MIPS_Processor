LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY RegFile IS
    PORT (
        RAddr1 : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        RAddr2 : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        WAddr : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        WData : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
        RegWrite : IN STD_LOGIC;
        Clk : IN STD_LOGIC;
        Reset : IN STD_LOGIC;

        RData1 : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
        RData2 : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
    );

END RegFile;

ARCHITECTURE RegFile_Arch OF RegFile IS

    TYPE reg_array IS ARRAY (0 TO 7) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL registers : reg_array;

BEGIN
    PROCESS (Clk)
    BEGIN
        IF rising_edge(Clk) THEN -- Is the Reset Sync or Async ?? 
            IF Reset = '1' THEN
                registers <= (
                "0000000000001111",    
                "0000000000001111",   
                OTHERS => (OTHERS => '0'));

            ELSIF RegWrite = '1' THEN
                registers(to_integer(unsigned(WAddr))) <= WData;
            END IF;
        END IF;
    END PROCESS;

    -- Assign outputs
    RData1 <= registers(to_integer(unsigned(RAddr1)));
    RData2 <= registers(to_integer(unsigned(RAddr2)));

END RegFile_Arch;
