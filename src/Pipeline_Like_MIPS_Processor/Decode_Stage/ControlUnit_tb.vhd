LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Control_Unit_tb IS
END Control_Unit_tb;

ARCHITECTURE Behavioral OF Control_Unit_tb IS
    -- Component declaration for Control_Unit
    COMPONENT Control_Unit
        PORT (
            opcode : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            Mread : OUT STD_LOGIC;
            Mwrite : OUT STD_LOGIC;
            RegWrite : OUT STD_LOGIC;
            Alu2 : OUT STD_LOGIC;
            Alu1 : OUT STD_LOGIC;
            Alu0 : OUT STD_LOGIC;
            Branch : OUT STD_LOGIC;
            Memory_to_Reg : OUT STD_LOGIC;
            inst_imm : OUT STD_LOGIC;
            Stack : OUT STD_LOGIC;
            Call : OUT STD_LOGIC;
            Pop : OUT STD_LOGIC;
            LDM : OUT STD_LOGIC;
            RET : OUT STD_LOGIC;
            RTI : OUT STD_LOGIC;
            Store : OUT STD_LOGIC;
            HLT : OUT STD_LOGIC;
            Reset : OUT STD_LOGIC;
            Int : OUT STD_LOGIC;
            zero : OUT STD_LOGIC;
            i_n : OUT STD_LOGIC;
            enable : OUT STD_LOGIC;
            Flags_Sel : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
        );
    END COMPONENT;

    -- Signals for simulation
    SIGNAL opcode : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL Mread, Mwrite, RegWrite, Alu2, Alu1, Alu0 : STD_LOGIC;
    SIGNAL Branch, Memory_to_Reg, inst_imm, Stack, Call, Pop : STD_LOGIC;
    SIGNAL LDM, RET, RTI, Store, HLT, Reset, Int, zero, i_n, enable : STD_LOGIC;
    SIGNAL Flags_Sel : STD_LOGIC_VECTOR(1 DOWNTO 0);

BEGIN
    -- Instantiate the Unit Under Test (UUT)
    UUT : Control_Unit PORT MAP(
        opcode => opcode,
        Mread => Mread,
        Mwrite => Mwrite,
        RegWrite => RegWrite,
        Alu2 => Alu2,
        Alu1 => Alu1,
        Alu0 => Alu0,
        Branch => Branch,
        Memory_to_Reg => Memory_to_Reg,
        inst_imm => inst_imm,
        Stack => Stack,
        Call => Call,
        Pop => Pop,
        LDM => LDM,
        RET => RET,
        RTI => RTI,
        Store => Store,
        HLT => HLT,
        Reset => Reset,
        Int => Int,
        zero => zero,
        i_n => i_n,
        enable => enable,
        Flags_Sel => Flags_Sel
    );

    -- Test process
    PROCESS
    BEGIN
        -- Test Case 1: NOP operation
        opcode <= "00000";
        WAIT FOR 10 ns;

        -- Test Case 2: HLT operation
        opcode <= "00001";
        WAIT FOR 10 ns;

        -- Test Case 3: SETC operation
        opcode <= "00010";
        WAIT FOR 10 ns;

        -- Test Case 4: NOT operation
        opcode <= "00011";
        WAIT FOR 10 ns;

        -- Test Case 5: INC operation
        opcode <= "00100";
        WAIT FOR 10 ns;

        -- Test Case 6: PUSH operation
        opcode <= "10000";
        WAIT FOR 10 ns;

        -- Test Case 7: POP operation
        opcode <= "10001";
        WAIT FOR 10 ns;

        -- Test Case 8: LDM operation
        opcode <= "10010";
        WAIT FOR 10 ns;

        -- Test Case 9: CALL operation
        opcode <= "11000";
        WAIT FOR 10 ns;

        -- Test Case 10: RET operation
        opcode <= "11001";
        WAIT FOR 10 ns;

        -- End simulation
        WAIT;
    END PROCESS;

END Behavioral;
