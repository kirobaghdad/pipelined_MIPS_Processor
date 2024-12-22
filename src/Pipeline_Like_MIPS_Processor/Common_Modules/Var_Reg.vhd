library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Var_Reg is
  generic (
    size : integer := 8
  );
  port (
    D : in std_logic_vector(size-1 downto 0);
    clk : in std_logic;
    rst : in std_logic;
    Q : out std_logic_vector(size-1 downto 0)
  );
end entity Var_Reg;

architecture Behavioral of Var_Reg is
  signal Q_reg : std_logic_vector(size-1 downto 0);
begin
  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        Q_reg <= (others => '0');
      else
        Q_reg <= D;
      end if;
    end if;
  end process;

  Q <= Q_reg;
end architecture Behavioral;
