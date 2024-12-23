LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY RegFile_tb IS
END RegFile_tb;

ARCHITECTURE behavior OF RegFile_tb IS

    COMPONENT RegFile
        PORT (
            RAddr1 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            RAddr2 : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            WAddr : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            WData : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            RegWrite : IN STD_LOGIC;
            Clk : IN STD_LOGIC;
            Reset : IN STD_LOGIC;

            RData1 : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
            RData2 : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL Clk : STD_LOGIC := '0';
    SIGNAL Reset : STD_LOGIC := '0';
    SIGNAL RegWrite : STD_LOGIC := '0';
    SIGNAL RAddr1 : STD_LOGIC_VECTOR (2 DOWNTO 0) := (OTHERS => '0');
    SIGNAL RAddr2 : STD_LOGIC_VECTOR (2 DOWNTO 0) := (OTHERS => '0');
    SIGNAL WAddr : STD_LOGIC_VECTOR (2 DOWNTO 0) := (OTHERS => '0');
    SIGNAL WData : STD_LOGIC_VECTOR (15 DOWNTO 0) := (OTHERS => '0');
    SIGNAL RData1 : STD_LOGIC_VECTOR (15 DOWNTO 0);
    SIGNAL RData2 : STD_LOGIC_VECTOR (15 DOWNTO 0);

    CONSTANT clk_period : TIME := 10 ns;

BEGIN

    dut : RegFile PORT MAP(
        RAddr1 => RAddr1,
        RAddr2 => RAddr2,
        WAddr => WAddr,
        WData => WData,
        RegWrite => RegWrite,
        Clk => Clk,
        Reset => Reset,
        RData1 => RData1,
        RData2 => RData2
    );

    clk_process : PROCESS
    BEGIN
        WHILE TRUE LOOP
            Clk <= '0';
            WAIT FOR clk_period / 2;
            Clk <= '1';
            WAIT FOR clk_period / 2;
        END LOOP;
    END PROCESS;

    stim_proc : PROCESS
    BEGIN
        -- Reset the register file
        REPORT "Applying Reset...";
        Reset <= '1';
        WAIT FOR clk_period;
        Reset <= '0';
        WAIT FOR clk_period;

        -- Write data to Register 1
        REPORT "Writing 0xAAAA to Register 1";
        WAddr <= "001"; -- Write to register 1
        WData <= x"AAAA"; -- Data = 0xAAAA
        RegWrite <= '1';
        WAIT FOR clk_period;
        RegWrite <= '0';

        -- Write data to Register 2
        REPORT "Writing 0x5555 to Register 2";
        WAddr <= "010"; -- Write to register 2
        WData <= x"5555"; -- Data = 0x5555
        RegWrite <= '1';
        WAIT FOR clk_period;
        RegWrite <= '0';

        -- Read from Register 1 and Register 2
        REPORT "Reading from Register 1 and Register 2";
        RAddr1 <= "001"; -- Read from register 1
        RAddr2 <= "010"; -- Read from register 2
        WAIT FOR clk_period;

        -- Check outputs
        ASSERT RData1 = x"AAAA"
        REPORT "Error: RData1 does not match 0xAAAA" SEVERITY ERROR;
        ASSERT RData2 = x"5555"
        REPORT "Error: RData2 does not match 0x5555" SEVERITY ERROR;

        -- Write data to Register 3
        REPORT "Writing 0x1234 to Register 3";
        WAddr <= "011"; -- Write to register 3
        WData <= x"1234"; -- Data = 0x1234
        RegWrite <= '1';
        WAIT FOR clk_period;
        RegWrite <= '0';

        -- Read from Register 3
        REPORT "Reading from Register 3";
        RAddr1 <= "011"; -- Read from register 3
        WAIT FOR clk_period;

        -- Check output
        ASSERT RData1 = x"1234"
        REPORT "Error: RData1 does not match 0x1234" SEVERITY ERROR;

        REPORT "Testbench Completed Successfully!";
        WAIT;
    END PROCESS;

END behavior;
