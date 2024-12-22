library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Fetch_RegFile is
    Port (
        clk             : in  std_logic;
        PC_in           : in  std_logic_vector(15 downto 0);  
        instruction_in  : in std_logic_vector(4 downto 0);
        Rsrc1_in        : in std_logic_vector(2 downto 0);
        Rsrc2_in        : in std_logic_vector(2 downto 0);
        Rdst_in         : in std_logic_vector(2 downto 0);
        immd_in         : in std_logic_vector(15 downto 0);
	PC_out          : out std_logic_vector(15 downto 0);
	instruction_out : out std_logic_vector(4 downto 0);
        Rsrc1_out       : out std_logic_vector(2 downto 0);
        Rsrc2_out       : out std_logic_vector(2 downto 0);
        Rdst_out        : out std_logic_vector(2 downto 0);
        immd_out        : out std_logic_vector(15 downto 0)
    );
end Fetch_RegFile;

architecture Behavioral of Fetch_RegFile is

begin
    process(clk)
    begin
        if rising_edge(clk) then
            PC_out <= PC_in;
	    instruction_out <= instruction_in;
	    Rsrc1_out <= Rsrc1_in;
	    Rsrc2_out <= Rsrc2_in;
	    Rdst_out <= Rdst_in;
	    immd_out <= immd_in;
        end if;
    end process;
end Behavioral;

