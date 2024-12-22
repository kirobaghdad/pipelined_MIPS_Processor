-- Testbench for Fetch_Decode_block entity
library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Fetch_Decode_block_tb is
end Fetch_Decode_block_tb;

architecture tb of Fetch_Decode_block_tb is

    component Fetch_Decode_block
        port (
            clk              : in std_logic;
            PC               : in std_logic_vector(15 downto 0);
            instruction      : in std_logic_vector(15 downto 0);
            flush            : in std_logic;
            INT              : out std_logic;
            updated_PC       : out std_logic_vector(15 downto 0);
            instruction_out  : out std_logic_vector(4 downto 0);
            Rsrc1            : out std_logic_vector(2 downto 0);
            Rsrc2            : out std_logic_vector(2 downto 0);
            Rdst             : out std_logic_vector(2 downto 0);
            immd             : out std_logic_vector(15 downto 0);
            INT_location     : out std_logic_vector(5 downto 0)
        );
    end component;

    signal clk              : std_logic := '0';
    signal PC               : std_logic_vector(15 downto 0);
    signal instruction      : std_logic_vector(15 downto 0);
    signal flush            : std_logic;
    signal INT              : std_logic;
    signal updated_PC       : std_logic_vector(15 downto 0);
    signal instruction_out  : std_logic_vector(4 downto 0);
    signal Rsrc1            : std_logic_vector(2 downto 0);
    signal Rsrc2            : std_logic_vector(2 downto 0);
    signal Rdst             : std_logic_vector(2 downto 0);
    signal immd             : std_logic_vector(15 downto 0);
    signal INT_location     : std_logic_vector(5 downto 0);

begin

    uut: Fetch_Decode_block
        port map (
            clk              => clk,
            PC               => PC,
            instruction      => instruction,
            flush            => flush,
            INT              => INT,
            updated_PC       => updated_PC,
            instruction_out  => instruction_out,
            Rsrc1            => Rsrc1,
            Rsrc2            => Rsrc2,
            Rdst             => Rdst,
            immd             => immd,
            INT_location     => INT_location
        );

    clk_process: process
    begin
        clk <= '0'; -- initialize clock
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process clk_process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Test case 1
        PC <= "0000000001010100";
        instruction <= "0000000001010101"; -- Some normal instruction
        flush <= '0';
        wait for 20 ns;
	assert (updated_PC = "0000000000000001")
        	report "Test one Failed."
        	severity note;
        -- Test case 2
        PC <= "0000000000000010";
        instruction <= "1111000000000000";
        flush <= '0';
        wait for 20 ns;

        -- Test case 3
        PC <= "0000000000000100";
        instruction <= "0000000000000000"; -- Normal instruction
        flush <= '1';
        wait for 20 ns;

        -- Test case 4
        PC <= "0000000000000110";
        instruction <= "1111000000000000"; -- Interrupt instruction
        flush <= '1';
        wait for 20 ns;

        wait;
    end process stim_proc;

end tb;

