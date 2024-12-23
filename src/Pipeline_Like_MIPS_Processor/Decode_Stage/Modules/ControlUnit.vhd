LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Control_Unit IS
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
        Push : OUT STD_LOGIC;
        LDM : OUT STD_LOGIC;
        RET : OUT STD_LOGIC;
        RTI : OUT STD_LOGIC;
        Store : OUT STD_LOGIC;
        HLT : OUT STD_LOGIC;
        Reset : OUT STD_LOGIC;
        -- LDD : OUT STD_LOGIC;
        Int : OUT STD_LOGIC;
        zero : OUT STD_LOGIC;
        i_n : OUT STD_LOGIC;
        enable : OUT STD_LOGIC;
        Flags_Sel : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END Control_Unit;

ARCHITECTURE Behavioral OF Control_Unit IS
BEGIN
    PROCESS (opcode)
    BEGIN
        CASE opcode(4) IS

            WHEN '0' =>
                -- here we entered the operands ops
                Mread <= '0';
                Mwrite <= '0';
                Branch <= '0';
                Memory_to_Reg <= '0';
                Stack <= '0';
                Call <= '0';
                Pop <= '0';
                Push <= '0';
                LDM <= '0';
                RET <= '0';
                RTI <= '0';
                Store <= '0';
                -- LDD <= '0';
                Int <= '0';

                CASE opcode(3) IS
                    WHEN '0' =>
                        inst_imm <= '0';

                        CASE opcode(2 DOWNTO 0) IS
                            WHEN "000" =>
                                -- Nop operation
                                Alu2 <= '0';
                                Alu1 <= '0';
                                Alu0 <= '0';
                                RegWrite <= '0';
                                HLT <= '0';
                                Reset <= '0';
                                zero <= '0';
                                i_n <= '0';
                                enable <= '0';
                                Flags_Sel <= "00";
                            WHEN "001" =>
                                -- HLT operation
                                RegWrite <= '0';
                                Alu2 <= '0';
                                Alu1 <= '0';
                                Alu0 <= '0';
                                HLT <= '1';
                                Reset <= '0';
                                zero <= '0';
                                i_n <= '0';
                                enable <= '0';
                                Flags_Sel <= "00";
                            WHEN "010" =>
                                -- SETC operation
                                RegWrite <= '0';
                                Alu2 <= '0';
                                Alu1 <= '0';
                                Alu0 <= '1';
                                HLT <= '0';
                                Reset <= '0';
                                zero <= '0';
                                i_n <= '0';
                                enable <= '0';
                                Flags_Sel <= "01";
                            WHEN "011" =>
                                -- NOT operation
                                RegWrite <= '1';
                                Alu2 <= '0';
                                Alu1 <= '1';
                                Alu0 <= '0';
                                HLT <= '0';
                                Reset <= '0';
                                zero <= '0';
                                i_n <= '0';
                                enable <= '0';
                                Flags_Sel <= "10";
                            WHEN "100" =>
                                -- INC operation
                                RegWrite <= '1';
                                Alu2 <= '1';
                                Alu1 <= '1';
                                Alu0 <= '0';
                                HLT <= '0';
                                Reset <= '0';
                                zero <= '0';
                                i_n <= '0';
                                enable <= '0';
                                Flags_Sel <= "10";
                            WHEN "101" =>
                                -- OUT operation
                                RegWrite <= '0';
                                Alu2 <= '0';
                                Alu1 <= '0';
                                Alu0 <= '0';
                                HLT <= '0';
                                Reset <= '0';
                                zero <= '1';
                                i_n <= '0';
                                enable <= '1';
                                Flags_Sel <= "00";
                            WHEN "110" =>
                                -- IN operation
                                RegWrite <= '1';
                                Alu2 <= '0';
                                Alu1 <= '0';
                                Alu0 <= '0';
                                HLT <= '0';
                                Reset <= '0';
                                zero <= '0';
                                i_n <= '1';
                                enable <= '0';
                                Flags_Sel <= "00";
                            WHEN "111" =>
                                -- Reset operation
                                RegWrite <= '0';
                                Alu2 <= '0';
                                Alu1 <= '0';
                                Alu0 <= '0';
                                HLT <= '0';
                                Reset <= '1';
                                zero <= '0';
                                i_n <= '0';
                                enable <= '0';
                                Flags_Sel <= "00";
                            WHEN OTHERS =>
                        END CASE;
                    WHEN '1' =>
                        -- two operands
                        RegWrite <= '1';
                        HLT <= '0';
                        Reset <= '0';
                        i_n <= '0';
                        enable <= '0';
                        CASE opcode(2 DOWNTO 0) IS
                            WHEN "000" =>
                                -- Mov operation
                                Alu2 <= '0';
                                Alu1 <= '1';
                                Alu0 <= '1';
                                inst_imm <= '0';
                                zero <= '1';
                                Flags_Sel <= "00";
                            WHEN "001" =>
                                -- Add operation
                                Alu2 <= '0';
                                Alu1 <= '1';
                                Alu0 <= '1';
                                inst_imm <= '0';
                                zero <= '0';
                                Flags_Sel <= "10";
                            WHEN "010" =>
                                -- Sub operation
                                Alu2 <= '1';
                                Alu1 <= '0';
                                Alu0 <= '0';
                                inst_imm <= '0';
                                zero <= '0';
                                Flags_Sel <= "10";
                            WHEN "011" =>
                                -- And operation
                                Alu2 <= '1';
                                Alu1 <= '0';
                                Alu0 <= '1';
                                inst_imm <= '0';
                                zero <= '0';
                                Flags_Sel <= "10";
                            WHEN "100" =>
                                -- IAdd operation
                                Alu2 <= '0';
                                Alu1 <= '1';
                                Alu0 <= '1';
                                inst_imm <= '1';
                                zero <= '0';
                                Flags_Sel <= "10";
                            WHEN OTHERS =>
                        END CASE;

                    WHEN OTHERS =>
                END CASE;
            WHEN '1' =>
                -- here we entered the memory / branching ops
                Alu2 <= '0';
                HLT <= '0';
                Reset <= '0';
                -- LDD <= '0';
                i_n <= '0';
                enable <= '0';
                Reset <= '0';
                Flags_Sel <= "00";
                --- Memory
                CASE opcode(3) IS
                    WHEN '0' =>
                        Branch <= '0';
                        RTI <= '0';
                        Int <= '0';
                        Call <= '0';
                        RET <= '0';
                        RTI <= '0';
                        CASE opcode(2 DOWNTO 0) IS
                            WHEN "000" =>
                                -- Push operation
                                Mread <= '0';
                                Mwrite <= '1';
                                RegWrite <= '0';
                                Alu1 <= '0';
                                Alu0 <= '0';
                                Memory_to_Reg <= '0';
                                inst_imm <= '0';
                                Stack <= '1';
                                Pop <= '0';
                                Push <= '1';
                                LDM <= '0';
                                Store <= '0';
                                zero <= '1';
                            WHEN "001" =>
                                -- Pop operation
                                Mread <= '1';
                                Mwrite <= '0';
                                RegWrite <= '1';
                                Alu1 <= '0';
                                Alu0 <= '0';
                                Memory_to_Reg <= '1';
                                inst_imm <= '0';
                                Stack <= '1';
                                Pop <= '1';
                                Push <= '0';
                                LDM <= '0';
                                Store <= '0';
                                zero <= '0';
                            WHEN "010" =>
                                -- LDM operation
                                Mread <= '0';
                                Mwrite <= '0';
                                RegWrite <= '1';
                                Alu1 <= '0';
                                Alu0 <= '0';
                                Memory_to_Reg <= '0';
                                inst_imm <= '0';
                                Stack <= '0';
                                Pop <= '0';
                                Push <= '0';
                                LDM <= '1';
                                Store <= '0';
                                zero <= '0';
                            WHEN "011" =>
                                -- LDD operation
                                Mread <= '1';
                                Mwrite <= '0';
                                RegWrite <= '1';
                                Alu1 <= '1';
                                Alu0 <= '1';
                                Memory_to_Reg <= '1';
                                inst_imm <= '1';
                                Stack <= '0';
                                Pop <= '0';
                                Push <= '0';
                                LDM <= '0';
                                Store <= '0';
                                zero <= '0';
                            WHEN "100" =>
                                -- STD operation
                                Mread <= '0';
                                Mwrite <= '1';
                                RegWrite <= '0';
                                Alu1 <= '1';
                                Alu0 <= '1';
                                Memory_to_Reg <= '0';
                                inst_imm <= '0';
                                Stack <= '0';
                                Pop <= '0';
                                Push <= '0';
                                LDM <= '0';
                                Store <= '1';
                                zero <= '0';
                            WHEN OTHERS =>
                        END CASE;
                    WHEN '1' =>
                        Alu1 <= '0';
                        Alu0 <= '0';
                        Memory_to_Reg <= '0';
                        inst_imm <= '0';
                        LDM <= '0';
                        RegWrite <= '0';
                        Store <= '0';
                        -- Branching
                        CASE opcode(2 DOWNTO 0) IS
                                -- WHEN "000" =>
                                --     -- JZ operation
                                --     Mread <= '0';
                                --     Mwrite <= '0';
                                --     Branch <= '1';
                                --     Stack <= '0';
                                --     Call <= '0';
                                --     Pop <= '0';
                                --     Push <= '0';
                                --     RET <= '0';
                                --     RTI <= '0';
                                --     Int <= '0';
                                --     zero <= '0';
                                -- WHEN "001" =>
                                --     -- JN operation
                                --     Mread <= '0';
                                --     Mwrite <= '0';
                                --     Branch <= '1';
                                --     Stack <= '0';
                                --     Call <= '0';
                                --     Pop <= '0';
                                --     Push <= '0';
                                --     RET <= '0';
                                --     RTI <= '0';
                                --     Int <= '0';
                                --     zero <= '0';
                                -- WHEN "010" =>
                                --     -- JC operation
                                --     Mread <= '0';
                                --     Mwrite <= '0';
                                --     Branch <= '1';
                                --     Stack <= '0';
                                --     Call <= '0';
                                --     Pop <= '0';
                                --     Push <= '0';
                                --     RET <= '0';
                                --     RTI <= '0';
                                --     Int <= '0';
                                --     zero <= '0';
                                -- WHEN "011" =>
                                --     -- JMP operation
                                --     Mread <= '0';
                                --     Mwrite <= '0';
                                --     Branch <= '1';
                                --     Stack <= '0';
                                --     Call <= '0';
                                --     Pop <= '0';
                                --     Push <= '0';
                                --     RET <= '0';
                                --     RTI <= '0';
                                --     Int <= '0';
                                --     zero <= '0';
                            WHEN "100" =>
                                -- CALL operation
                                Mread <= '0';
                                Mwrite <= '1';
                                Branch <= '0';
                                Stack <= '1';
                                Call <= '1';
                                Pop <= '0';
                                Push <= '1';
                                Push <= '1';
                                RET <= '0';
                                RTI <= '0';
                                Int <= '0';
                                zero <= '1';
                            WHEN "101" =>
                                -- RET operation
                                Mread <= '1';
                                Mwrite <= '0';
                                Branch <= '0';
                                Stack <= '1';
                                Call <= '0';
                                Pop <= '1';
                                Push <= '0';
                                RET <= '1';
                                RTI <= '0';
                                Int <= '0';
                                zero <= '0';
                            WHEN "110" =>
                                -- Int operation
                                Mread <= '0';
                                Mwrite <= '1';
                                Branch <= '1';
                                Stack <= '1';
                                Call <= '0';
                                Pop <= '0';
                                Push <= '1';
                                RET <= '0';
                                RTI <= '0';
                                Int <= '1';
                                zero <= '1';
                            WHEN "111" =>
                                -- RTI operation
                                Mread <= '1';
                                Mwrite <= '0';
                                Branch <= '0';
                                Stack <= '1';
                                Call <= '0';
                                Pop <= '1';
                                Push <= '0';
                                RET <= '1';
                                RTI <= '1';
                                Int <= '0';
                                zero <= '0';
                            WHEN OTHERS =>
                                Mread <= '0';
                                Mwrite <= '0';
                                Branch <= '1';
                                Stack <= '0';
                                Call <= '0';
                                Pop <= '0';
                                Push <= '0';
                                RET <= '0';
                                RTI <= '0';
                                Int <= '0';
                                zero <= '0';
                        END CASE;

                    WHEN OTHERS =>
                END CASE;
            WHEN OTHERS =>

        END CASE;
    END PROCESS;
END Behavioral;
