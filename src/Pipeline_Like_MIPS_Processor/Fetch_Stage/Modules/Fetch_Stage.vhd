LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;


entity Fetch_Stage is
  port (
    clk : in std_logic;
    reset : in std_logic;

    -- input controls
    user_reset : in std_logic;
    user_input : in std_logic_vector(15 downto 0);
    dm_output : in std_logic_vector(15 downto 0);

    int_pc : in std_logic_vector(15 downto 0);

    hlt : in std_logic;
    empty_stack : in std_logic;
    call : in std_logic;
    ret_rti : in std_logic;
    invalid_address : in std_logic;
    int : in std_logic;     -- interrupt signal
    updated_pc : in std_logic_vector(15 downto 0);
    -- flush : in std_logic;

    -- inputs
    Rsrc1 : in std_logic_vector(15 downto 0);


    -- outputs
    -- F/D reg outputs
    PC : out std_logic_vector(15 downto 0)
  ) ;
end Fetch_Stage;


architecture behavioral of Fetch_Stage is
    signal pc_call : std_logic_vector(15 downto 0);
    signal pc_ret_rti : std_logic_vector(15 downto 0);
    signal pc_invalid_address : std_logic_vector(15 downto 0);
    signal pc_empty_stack : std_logic_vector(15 downto 0);
    -- ununderstandable mux???
    -- signal pc_br_taken : std_logic;
    signal pc_reset : std_logic_vector(15 downto 0);
    signal pc_int : std_logic_vector(15 downto 0);
    
begin
    -- implement the fetch muxs

    -- process(hlt)
    -- begin process 
    --     if hlt = '0' then
        pc_call <= Rsrc1 when call = '1' else updated_pc;
        pc_ret_rti <= dm_output when ret_rti = '1' else pc_call;
        pc_invalid_address <= "0000000000000100" when invalid_address = '1' else pc_ret_rti; -- TODO
        pc_empty_stack <= "0000000000000011" when empty_stack = '1' else pc_invalid_address;
        -- ununderstandable mux
        -- pc_br_taken <= Rsrc1 when 

        pc_reset <= "0000000000000000" when reset = '1' else pc_empty_stack;
        pc_int <= int_pc when int = '1' else pc_reset;

        PC <= pc_int;
        -- else 
        --     PC <= -- old PC 
        -- end if;
    -- end process;
end architecture behavioral;