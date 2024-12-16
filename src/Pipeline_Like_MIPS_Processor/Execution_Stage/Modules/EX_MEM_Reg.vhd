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

    -- outputs    
    reg_write_r : out std_logic;
    Rdst_r : out std_logic_vector(2 downto 0);
    updated_PC_r : out std_logic_vector(15 downto 0);
    result_r : out std_logic_vector(15 downto 0);
    mem_read_r : out std_logic;
    mem_write_r : out std_logic
  ) ;
end EX_MEM_Reg;
architecture behavioral of EX_MEM_Reg is
    signal reg_write_vec : std_logic_vector(0 downto 0);
    signal reg_write_r_vec : std_logic_vector(0 downto 0);
    signal mem_vec : std_logic_vector(1 downto 0);
    signal mem_r_vec : std_logic_vector(1 downto 0);

begin
    reg_write_vec(0) <= reg_write;
    reg_write_r <= reg_write_r_vec(0);

    mem_vec <= mem_write & mem_read;

    mem_read_r <= mem_r_vec(0);
    mem_write_r <= mem_r_vec(1);


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