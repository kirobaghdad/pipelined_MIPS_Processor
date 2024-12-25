library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory_stage_without_buffer is
    port(
        push, pop, load, store, call, ret, INT, RTI, clk, rst,wb: in std_logic;
        memory_read, memory_write: in std_logic;
        updated_pc: in std_logic_vector(15 downto 0);
        Rs1: in std_logic_vector(15 downto 0);
        address: in std_logic_vector(15 downto 0);
        flags_in_signal: in std_logic;
        flags_out_signal: in std_logic;
        flags_in: in std_logic_vector(2 downto 0);
        flags_out: out std_logic_vector(2 downto 0);
        data_out: out std_logic_vector(15 downto 0);
        empty_stack,wb_out: out std_logic
    );
end entity;

architecture arch of memory_stage_without_buffer is
    signal sp: unsigned(15 downto 0) := to_unsigned(2**12 - 1, 16);
    type memory_type is array(0 to 2**12-1) of std_logic_vector(15 downto 0);
    signal data_memory: memory_type;
begin 
    process(clk, rst)
        variable final_data: std_logic_vector(15 downto 0);
        variable final_address: unsigned(15 downto 0);
    begin 
        wb_out <= wb;
        empty_stack <= '0';
        data_out <= (others => '0');
        flags_out <= (others => '0');
        if (rst = '1') then
            data_out <= (others => '0');
            data_memory <= (others => (others => '0'));
            sp <= to_unsigned(2**12 - 1, 16);
        elsif (rising_edge(clk)) then
            if (memory_write = '1') then
                if (store = '1') then
                    final_address := unsigned(address);
                else
                    final_address := sp(11 downto 0);
                    sp <= sp - 1;
                end if;

                if (store = '1' or push='1') then
                    final_data := Rs1;
                elsif (flags_in_signal = '1') then 
                    final_data := (others => '0'); 
                    final_data(2 downto 0) := flags_in;
                else
                    final_data := updated_pc;
                end if;

                data_memory(to_integer(final_address)) <= final_data;
            end if;

            if (memory_read = '1') then
                if (pop = '1' and sp = to_unsigned(2**12 - 1, 16)) then
                    data_out <= (others => '0');
                    empty_stack <= '1';
                    wb_out <= '0';
                else 
                    empty_stack <= '0';
                    if (load = '1') then
                        final_address := unsigned(address);
                    else
                        final_address := sp(11 downto 0) + 1;
                        sp <= sp + 1;
                    end if;
                    data_out <= data_memory(to_integer(final_address));
                    flags_out <= data_memory(to_integer(final_address))(2 downto 0);
                end if;
            end if;
        end if;
    end process;
end arch;

