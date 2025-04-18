library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory_stage_tb_without_buffer is
end entity;

architecture tb of memory_stage_tb_without_buffer is
    -- Component declaration
    component memory_stage_without_buffer
        port(
            push, pop, load, store, call, ret, INT, RTI, clk, rst: in std_logic;
            memory_read, memory_write: in std_logic;
            updated_pc: in std_logic_vector(15 downto 0);
            Rs1: in std_logic_vector(15 downto 0);
            address: in std_logic_vector(11 downto 0);
            flags_in_signal: in std_logic;
            flags_out_signal: in std_logic;
            flags_in: in std_logic_vector(2 downto 0);
            flags_out: out std_logic_vector(2 downto 0);
            data_out: out std_logic_vector(15 downto 0);
            empty_stack: out std_logic
        );
    end component;

    -- Signals for the testbench
    signal push, pop, load, store, call, ret, INT, RTI, clk, rst: std_logic := '0';
    signal memory_read, memory_write: std_logic := '0';
    signal updated_pc: std_logic_vector(15 downto 0) := (others => '0');
    signal Rs1: std_logic_vector(15 downto 0) := (others => '0');
    signal address: std_logic_vector(11 downto 0) := (others => '0');
    signal flags_in_signal: std_logic := '0';
    signal flags_out_signal: std_logic := '0';
    signal flags_in: std_logic_vector(2 downto 0) := (others => '0');
    signal flags_out: std_logic_vector(2 downto 0);
    signal data_out: std_logic_vector(15 downto 0);
    signal empty_stack: std_logic;

    constant clk_period: time := 10 ns;

begin
    -- Instantiate the memory_stage unit under test (UUT)
    uut: memory_stage_without_buffer
        port map (
            push => push,
            pop => pop,
            load => load,
            store => store,
            call => call,
            ret => ret,
            INT => INT,
            RTI => RTI,
            clk => clk,
            rst => rst,
            memory_read => memory_read,
            memory_write => memory_write,
            updated_pc => updated_pc,
            Rs1 => Rs1,
            address => address,
            flags_in_signal => flags_in_signal,
            flags_out_signal => flags_out_signal,
            flags_in => flags_in,
            flags_out => flags_out,
            data_out => data_out,
            empty_stack => empty_stack
        );

    -- Clock generation
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    
    -- Stimulus process
    stimulus_process: process
    begin
        -- Reset the system
        rst <= '1';
        wait for clk_period;
        rst <= '0';

        -- Test case 1: Push operation
        push <= '1';
        memory_write <= '1';
        Rs1 <= x"1234";
        wait for clk_period;
        push <= '0';
        memory_write <= '0';
        wait for clk_period;

        -- Test case 2: Pop operation
        pop <= '1';
        memory_read <= '1';
        wait for clk_period;
        pop <= '0';
        memory_read <= '0';
        wait for clk_period;

        -- Test case 3: Store operation
        store <= '1';
        memory_write <= '1';
        address <= "000000000001";
        Rs1 <= x"5678";
        wait for clk_period;
        store <= '0';
        memory_write <= '0';
        wait for clk_period;

        -- Test case 4: Load operation
        load <= '1';
        memory_read <= '1';
        address <= "000000000001";
        wait for clk_period;
        load <= '0';
        memory_read <= '0';
        wait for clk_period;

        -- Test case 4: exception
        pop <= '1';
        memory_read <= '1';
        wait for clk_period;
        load <= '0';
        memory_read <= '0';
        wait for clk_period;

        -- Finish simulation
        wait;
    end process;

end architecture;
