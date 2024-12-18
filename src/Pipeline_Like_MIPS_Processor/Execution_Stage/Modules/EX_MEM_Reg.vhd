library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity EX_MEM_Reg is
  port (
    clk : in std_logic;
    rst : in std_logic;

    -- inputs to just pass to the next stage
    reg_write : in std_logic;
    Rdst : in std_logic_vector(2 downto 0);
    updated_PC : in std_logic_vector(15 downto 0);
    result : in std_logic_vector(15 downto 0);
    mem_read : in std_logic;
    mem_write : in std_logic;

    mem_to_reg : in std_logic;
    stack : in std_logic;
    call : in std_logic;
    pop : in std_logic;
    ldm: in std_logic;
    ret: in std_logic;
    rti: in std_logic;
    store : in std_logic;
    int : in std_logic;
    enable : in std_logic;

    -- outputs    
    reg_write_r : out std_logic;
    Rdst_r : out std_logic_vector(2 downto 0);
    updated_PC_r : out std_logic_vector(15 downto 0);
    result_r : out std_logic_vector(15 downto 0);
    mem_read_r : out std_logic;
    mem_write_r : out std_logic;

    mem_to_reg_r : out std_logic;
    stack_r : out std_logic;
    call_r : out std_logic;
    pop_r : out std_logic;
    ldm_r: out std_logic;
    ret_r: out std_logic;
    rti_r: out std_logic;
    store_r : out std_logic;
    int_r : out std_logic;
    enable_r : out std_logic
  ) ;
end EX_MEM_Reg;
architecture behavioral of EX_MEM_Reg is
    signal reg_write_vec : std_logic_vector(0 downto 0);
    signal reg_write_r_vec : std_logic_vector(0 downto 0);
    signal mem_vec : std_logic_vector(1 downto 0);
    signal mem_r_vec : std_logic_vector(1 downto 0);

    signal vec : std_logic_vector(9 downto 0);
    signal vec_r : std_logic_vector(9 downto 0);
    -- signal vec : std_logic_vector(9 downto 0);
begin
    reg_write_vec(0) <= reg_write;
    reg_write_r <= reg_write_r_vec(0);

    mem_vec <= mem_write & mem_read;

    mem_read_r <= mem_r_vec(0);
    mem_write_r <= mem_r_vec(1);

    vec <= mem_to_reg & stack & call & pop & ldm & ret & rti & store & int & enable;

    mem_to_reg_r <= vec_r(9);
    stack_r <= vec_r(8);
    call_r <= vec_r(7);
    pop_r <= vec_r(6);
    ldm_r <= vec_r(5);
    ret_r <= vec_r(4);
    rti_r <= vec_r(3);
    store_r <= vec_r(2);
    int_r <= vec_r(1);
    enable_r <= vec_r(0);

    pip_EX_MEM5: entity work.var_reg
    generic map (size => 10)
    port map(
        clk => clk,
        rst => rst,
        D => vec,
        Q => vec_r
    );


    pip_EX_MEM0: entity work.var_reg 
    generic map (size => 1) 
    port map ( 
        clk => clk, 
        rst => rst, 
        D => reg_write_vec, 
        Q => reg_write_r_vec 
    );
    
    pip_EX_MEM1: entity work.var_reg 
    generic map (size => 3) 
    port map ( 
        clk => clk, 
        rst => rst, 
        D => Rdst, 
        Q => Rdst_r 
    );

    pip_EX_MEM2: entity work.var_reg 
    generic map (size => 16) 
    port map ( 
        clk => clk, 
        rst => rst, 
        D => updated_PC, 
        Q => updated_PC_r 
    );

    pip_EX_MEM3: entity work.var_reg 
    generic map (size => 16) 
    port map ( 
        clk => clk, 
        rst => rst, 
        D => result, 
        Q => result_r 
    );

    pip_EX_MEM4: entity work.var_reg 
    generic map (size => 2) 
    port map ( 
        clk => clk, 
        rst => rst, 
        D => mem_vec, 
        Q => mem_r_vec 
    );
    
end architecture behavioral;