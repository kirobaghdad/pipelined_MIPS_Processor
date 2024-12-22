library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity Fetch_tb is
end Fetch_tb;
ARCHITECTURE testbench_a OF Fetch_tb IS
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
    SIGNAL PC             : std_logic_vector(15 downto 0) := (others => '0');
    SIGNAL HLT 		  : std_logic :='0';
    SIGNAL INT 		  : std_logic  :='0';
    SIGNAL INT_PC  	  : std_logic_vector(15 downto 0) := (others => '0');
    SIGNAL Reset 	  : std_logic  :='0';
    SIGNAL Instruction	  : std_logic_vector(4 downto 0)  := (others => '0');
    SIGNAL Rsrc1	  : std_logic_vector(15 downto 0)  := (others => '0');
    SIGNAL Branch_Taken   : std_logic  :='0';
    SIGNAL EmptyStack 	  : std_logic  :='0';
    SIGNAL InvalidAddress : std_logic  :='0';
    SIGNAL RET		  : std_logic  :='0';
    SIGNAL RTI 		  : std_logic  :='0';
    SIGNAL Call 	  : std_logic  :='0';

    SIGNAL Data_Memory  : std_logic_vector(15 downto 0)  := (others => '0');
    SIGNAL PC_Out       : std_logic_vector(15 downto 0)  := (others => '0');
BEGIN
    my_instance : Fetch
        PORT MAP (
	    PC             =>  PC,
	    HLT            => HLT,
            INT            => INT,
	    INT_PC         => INT_PC,
	    Branch_Taken   => Branch_Taken,
	    Reset          => Reset,
	    Instruction    => Instruction,
	    Rsrc1          => Rsrc1,
	    EmptyStack     => EmptyStack,
	    InvalidAddress => InvalidAddress,
	    RET            => RET,
	    RTI            => RTI,
	    Call           => Call,
	    Data_Memory    => Data_Memory,
	    PC_Out         => PC_Out
		
        );
    
    stimulus : process
    begin
	------ test one
        PC           <= "0000000000000001";
	wait for 20 ps;  	
        assert (PC_Out = "0000000000000001")
            report "Test one Failed."
            severity note;
	
	------ test two
	INT <= '1';
	INT_PC <= "0001001100000100";
	wait for 10 ps;  
	assert (PC_Out      = "0001001100000100")
        	report "Test two Failed."
        	severity note;
	-----test three
	wait for 20 ps;
	INT <= '0';
	Reset <= '1';
        PC <= "0000000000000101";
	wait for 20 ps;  	
        assert (PC_Out      = "0000000000000000")
		report "Test three Failed."
            	severity note;
	----- test four
	Reset <= '0';
	Instruction <= "11011";
	Rsrc1       <= "0001001100000100";
	wait for 20 ps;
	assert (PC_Out      = "0001001100000100")
            	report "Test four Failed."
            	severity note;
	----- test five
        PC <= "0000000000000111";
	Call <='1';
	Instruction <= "10011";
	Rsrc1       <= "0001001100000110";
	wait for 20 ps;  	
        assert (PC_Out      = "0001001100000110")
            	report "Test five Failed."
            	severity note;
	-----test six
	PC <= "0000000000000101";
	Call <= '0';
	RET <= '1';
	Data_Memory <= "0000000011100101";
	wait for 20 ps;  	
	assert (PC_Out      = "0000000011100101")
            	report "Test six Failed."
            	severity note;
        wait;
    end process stimulus;
END testbench_a;
