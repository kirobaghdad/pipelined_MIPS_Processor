
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory_stage is
  port (
    push, pop, load, store, call, ret, INT, RTI, clk, rst: in std_logic;
    memory_read, memory_write: in std_logic;
    updated_pc: in std_logic_vector(15 downto 0);
    Rs1: in std_logic_vector(15 downto 0);
    -- address: in std_logic_vector(11 downto 0);
    flags_in_signal: in std_logic;
    flags_out_signal: in std_logic;
    flags_in: in std_logic_vector(2 downto 0);
    flags_out: out std_logic_vector(2 downto 0);
    data_out: out std_logic_vector(15 downto 0);
    empty_stack: out std_logic;

    -- passing
    updated_pc_out: out std_logic_vector(15 downto 0);
    Rs1_out: out std_logic_vector(15 downto 0);

    Rdst: in std_logic_vector(2 downto 0);
    Rdst_out: out std_logic_vector(2 downto 0);

    input_port: in std_logic_vector(15 downto 0);
    input_port_out: out std_logic_vector(15 downto 0);

    wb:in std_logic;
    wb_out: out std_logic

    -- Alu_data_in: in std_logic_vector(15 downto 0);
    -- Alu_data_out: out std_logic_vector(15 downto 0);

    memory_to_reg:: in std_logic;
    memory_to_reg_out:out std_logic
  );
end entity;


architecture arch of memory_stage is

    component memory_stage_without_buffer is
        port(
            push, pop, load, store, call, ret, INT, RTI, clk, rst,wb: in std_logic;
            memory_read, memory_write: in std_logic;
            updated_pc: in std_logic_vector(15 downto 0);
            Rs1: in std_logic_vector(15 downto 0);
            address: in std_logic_vector(11 downto 0);
            flags_in_signal: in std_logic;
            flags_out_signal: in std_logic;
            flags_in: in std_logic_vector(2 downto 0);
            flags_out: out std_logic_vector(2 downto 0);
            data_out: out std_logic_vector(15 downto 0);
            empty_stack,wb_out: out std_logic
        );
    end component;

    component Var_Reg is
        generic (
          size : integer := 8
        );
        port (
          D : in std_logic_vector(size-1 downto 0);
          clk : in std_logic;
          rst : in std_logic;
          Q : out std_logic_vector(size-1 downto 0)
        );
      end component Var_Reg;
      signal D_vector : std_logic_vector(31 downto 0);
      signal Q_vector : std_logic_vector(31 downto 0);
    signal updated_pc_out_reg, Rs1_out_reg: std_logic_vector(15 downto 0);
    -- signal address_reg :std_logic_vector(11 downto 0);
    signal alu_in_reg :std_logic_vector(11 downto 0);
    signal wb_reg: std_logic;
    signal flags_out_temp: std_logic_vector(2 downto 0);
    signal data_out_temp: std_logic_vector(15 downto 0);
    signal empty_stack_temp: std_logic;
    signal wb_out_temp: std_logic;
    -- signal wb_vector : std_logic_vector(0 downto 0);
    -- signal temp_wb: std_logic_vector(0 downto 0);

begin
    D_vector(0) <= push;
    D_vector(1) <= pop;
    D_vector(2) <= load;
    D_vector(3) <= store;
    D_vector(4) <= call;
    D_vector(5) <= ret;
    D_vector(6) <= INT;
    D_vector(7) <= RTI;
    D_vector(8) <= memory_read;
    D_vector(9) <= memory_write;
    D_vector(10) <= rst;
    D_vector(11) <= flags_in_signal;
    D_vector(12) <= flags_out_signal;
    D_vector(15 downto 13) <= flags_in;
    D_vector(16) <= wb;
    D_vector(17)<=memory_to_reg;

    memory_to_reg_out<=Q_vector(17);
    -- Single instance of Var_Reg
var_reg20 : Var_Reg
generic map (
    size => 16  -- Adjust size as needed
)
port map (
    D => D_vector,
    clk => clk,
    rst => rst,
    Q => Q_vector
);
-- wb_reg<=wb_vector(0);
-- temp_wb(0)<=wb;
--     var_reg6 : Var_Reg generic map (
--             size => 1
--         ) port map (
--             D => temp_wb,
--             clk => clk,
--             rst => rst,
--             Q => wb_vector
--         );
    var_reg17 : Var_Reg generic map (
            size => 16
        ) port map (
            D => updated_pc,
            clk => clk,
            rst => rst,
            Q => updated_pc_out_reg
        );

    var_reg18 : Var_Reg generic map (
            size => 16
        ) port map (
            D => Rs1,
            clk => clk,
            rst => rst,
            Q => Rs1_out_reg
        );

    var_reg19 : Var_Reg generic map (
            size => 16
        ) port map (
            D => alu_in_reg,
            clk => clk,
            rst => rst,
            Q => alu_in_reg
        );


    var_reg1 : Var_Reg
        generic map (
            size => 16
        )
        port map (
            D => updated_pc,
            clk => clk,
            rst => rst,
            Q => updated_pc_out
        );

    var_reg3 : Var_Reg
        generic map (
            size => 3
        )
        port map (
            D => Rdst,
            clk => clk,
            rst => rst,
            Q => Rdst_out
        );
    -- var_reg4 : Var_Reg generic map (
    --         size => 16
    --     )
    --     port map (
    --         D => input_port,
    --         clk => clk,
    --         rst => rst,
    --         Q => input_port_out
    --     );
    var_reg13 : Var_Reg generic map (
            size => 16
        )
        port map (
            D => Alu_data_in,
            clk => clk,
            rst => rst,
            Q => Alu_data_out
        );
        
    updated_pc_out<=updated_pc_out_reg;
    Rs1_out<=Rs1_out_reg;
    flags_out<=flags_out_temp;
    data_out<=data_out_temp;
    empty_stack<=empty_stack_temp;
    wb_out<=wb_out_temp;
    memory_stage1:memory_stage_without_buffer port map (
        push => Q_vector(0),
        pop => Q_vector(1),
        load => Q_vector(2),
        store =>   Q_vector(3),
        call => Q_vector(4),
        ret => Q_vector(5),
        INT => Q_vector(6),
        RTI => Q_vector(7),
        clk => clk,
        rst => Q_vector(10),
        memory_read => Q_vector(8),
        memory_write => Q_vector(9),
        updated_pc => updated_pc_out_reg,
        Rs1 => Rs1_out_reg,
        address => alu_in_reg,
        flags_in_signal => Q_vector(11),
        flags_out_signal => Q_vector(12),
        flags_in => Q_vector(15 downto 13),
        flags_out => flags_out_temp,
        data_out => data_out_temp,
        empty_stack => empty_stack_temp,
        wb_out => wb_out_temp,
        wb => Q_vector(16)
    );
    
end architecture;