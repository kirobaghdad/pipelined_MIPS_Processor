LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

entity Fetch_Top is
    port (
	clk	       : in std_logic;
	flush          : in std_logic;
	Branch_Taken   : in std_logic;
	Reset          : in std_logic;
	EmptyStack     : in std_logic;
	InvalidAddress : in std_logic;
	RET	       : in std_logic;
        RTI 	       : in std_logic;
        Call 	       : in std_logic;
	Rsrc1_in       : in std_logic_vector(15 downto 0);
	Data_Memory    : in std_logic_vector(15 downto 0);
	
	updated_PC     : out std_logic_vector(15 downto 0);
        Instruction_out_out:out std_logic_vector(4 downto 0);
    	Rsrc1_out      : out std_logic_vector(2 downto 0);
    	Rsrc2          : out std_logic_vector(2 downto 0);
    	Rdst           : out std_logic_vector(2 downto 0);
    	immd_out           : out std_logic_vector(15 downto 0)
    );
end Fetch_Top;

architecture behavioral of Fetch_Top is

COMPONENT Fetch IS
        port (
        PC             : in  std_logic_vector(15 downto 0);
        HLT            : in std_logic;

        INT            : in std_logic;
        INT_PC         : in std_logic_vector(15 downto 0);

        Reset          : in std_logic;

        Instruction    : in std_logic_vector(4 downto 0);
        Branch_Taken   : in std_logic;

        EmptyStack     : in std_logic;
        InvalidAddress : in std_logic;

        RET            : in std_logic;
        RTI            : in std_logic;
        Call           : in std_logic;

        Rsrc1          : in std_logic_vector(15 downto 0);
        Data_Memory    : in std_logic_vector(15 downto 0);

        PC_Out         : out std_logic_vector(15 downto 0)
    );
END COMPONENT;
COMPONENT instruction_memory IS
        PORT (
       		PC           : in std_logic_vector (15 downto 0);
		INT_location : in std_logic_vector (5 downto 0);
		instruction  : out std_logic_vector (15 downto 0);
		INT_PC       : out std_logic_vector (15 downto 0)
        );
END COMPONENT;

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
            immd         : out std_logic_vector(15 downto 0);
            INT_location     : out std_logic_vector(5 downto 0)
        );
    end component;

----------
    SIGNAL PC           : std_logic_vector(15 downto 0) := (others => '0');----------------------------
    SIGNAL INT_location_sig : std_logic_vector(5 downto 0) ;-----------------------------
    SIGNAL instruction  : std_logic_vector(15 downto 0);--------------------------
----------
    SIGNAL HLT 		  : std_logic ;----------------------------------------------------
    SIGNAL INT 		  : std_logic  ;---------------------------------------------------
    SIGNAL INT_PC  	  : std_logic_vector(15 downto 0);-------------------

    SIGNAL PC_Out         : std_logic_vector(15 downto 0) ;------------------------

-------------
    signal updated_PC_sig   : std_logic_vector(15 downto 0);
    signal instruction_out  : std_logic_vector(4 downto 0);
    signal rsrc1_sig            : std_logic_vector(2 downto 0);
    signal rsrc2_sig            : std_logic_vector(2 downto 0);
    signal rdst_sig             : std_logic_vector(2 downto 0);
    signal immd_sigg             : std_logic_vector(15 downto 0);

-------------
begin
Fetch_instance : Fetch
        PORT MAP (
	    PC             =>  PC,------------------------------
	    HLT            => HLT,------------------------------
            INT            => INT,------------------------------
	    INT_PC         => INT_PC,---------------------------
	    Branch_Taken   => Branch_Taken,---------------------
	    Reset          => Reset,----------------------------
	    Instruction=> Instruction_out,----------------------
	    Rsrc1          => Rsrc1_in,----------------------------
	    EmptyStack     => EmptyStack,-----------------------
	    InvalidAddress => InvalidAddress,-------------------
	    RET            => RET,------------------------------
	    RTI            => RTI,------------------------------
	    Call           => Call,-----------------------------
	    Data_Memory    => Data_Memory,----------------------
	    PC_Out         => PC_Out----------------------------
		
        );

instruction_memory_instance : instruction_memory
        PORT MAP (
	    PC           =>  PC_Out,----------------------------
	    INT_location => INT_location_sig,-----------------------
            instruction  => instruction,------------------------
	    INT_PC       => INT_PC------------------------------
        );
Fetch_Decode_block_instance: Fetch_Decode_block
        port map (
            clk              => clk,----------------
            PC               => PC_Out,-----------------
            instruction      => instruction,-----------
            flush            => flush,----------------
            INT              => INT,------------------
            updated_PC       => updated_PC_sig,------------
            instruction_out  => instruction_out,
            Rsrc1            => rsrc1_sig,
            Rsrc2            => rsrc2_sig,
            Rdst             => rdst_sig,
            immd             => immd_sigg,
            INT_location     => INT_location_sig
        );
    process(clk)
    begin
	updated_PC     		<= updated_PC_sig;
	PC                      <= updated_PC_sig;
        Instruction_out_out 	<= instruction_out;
    	Rsrc1_out           	<= rsrc1_sig;
    	Rsrc2           	<= rsrc2_sig;
    	Rdst            	<= rdst_sig;
    	Immd_out            	<= immd_sigg;
    end process;
end architecture behavioral;
