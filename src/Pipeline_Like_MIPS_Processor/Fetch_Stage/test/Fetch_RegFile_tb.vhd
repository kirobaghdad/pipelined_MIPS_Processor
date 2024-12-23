library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Fetch_RegFile_tb is
end Fetch_RegFile_tb;

architecture Behavioral of Fetch_RegFile_tb is
    component Fetch_RegFile
        Port (
            clk             : in  std_logic;
            PC_in           : in  std_logic_vector(15 downto 0);
            instruction_in  : in  std_logic_vector(4 downto 0);
            Rsrc1_in        : in  std_logic_vector(2 downto 0);
            Rsrc2_in        : in  std_logic_vector(2 downto 0);
            Rdst_in         : in  std_logic_vector(2 downto 0);
            immd_in         : in  std_logic_vector(15 downto 0);
            PC_out          : out std_logic_vector(15 downto 0);
            instruction_out : out std_logic_vector(4 downto 0);
            Rsrc1_out       : out std_logic_vector(2 downto 0);
            Rsrc2_out       : out std_logic_vector(2 downto 0);
            Rdst_out        : out std_logic_vector(2 downto 0);
            immd_out        : out std_logic_vector(15 downto 0)
        );
    end component;

    signal clk             : std_logic := '0';
    signal PC_in           : std_logic_vector(15 downto 0);
    signal instruction_in  : std_logic_vector(4 downto 0);
    signal Rsrc1_in        : std_logic_vector(2 downto 0);
    signal Rsrc2_in        : std_logic_vector(2 downto 0);
    signal Rdst_in         : std_logic_vector(2 downto 0);
    signal immd_in         : std_logic_vector(15 downto 0);
    
    signal PC_out          : std_logic_vector(15 downto 0);
    signal instruction_out : std_logic_vector(4 downto 0);
    signal Rsrc1_out       : std_logic_vector(2 downto 0);
    signal Rsrc2_out       : std_logic_vector(2 downto 0);
    signal Rdst_out        : std_logic_vector(2 downto 0);
    signal immd_out        : std_logic_vector(15 downto 0);

    

begin

    UUT: Fetch_RegFile PORT MAP (
        clk             => clk,
        PC_in           => PC_in,
        instruction_in  => instruction_in,
        Rsrc1_in        => Rsrc1_in,
        Rsrc2_in        => Rsrc2_in,
        Rdst_in         => Rdst_in,
        immd_in         => immd_in,
        PC_out          => PC_out,
        instruction_out => instruction_out,
        Rsrc1_out       => Rsrc1_out,
        Rsrc2_out       => Rsrc2_out,
        Rdst_out        => Rdst_out,
        immd_out        => immd_out
    );
    process
    begin
        clk <= '0'; wait for 10 ns;
        clk <= '1'; wait for 10 ns;
    end process;

    process
    begin
        PC_in <= "0000000000000000";  
        instruction_in <= "11001";   
        Rsrc1_in <= "001";            
        Rsrc2_in <= "010";            
        Rdst_in <= "011";             
        immd_in <= x"1234";           

        wait for 20 ns;

        PC_in <= "0000000000000001";
        instruction_in <= "10101";
        Rsrc1_in <= "110";
        Rsrc2_in <= "101";
        Rdst_in <= "100";
        immd_in <= x"5678";
        wait for 20 ns;

        wait;
    end process;

end Behavioral;

