library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    PORT(
        alu_control : in STD_LOGIC_VECTOR (2 downto 0);
        OP1 : in STD_LOGIC_VECTOR (15 downto 0);
        OP2 : in STD_LOGIC_VECTOR (15 downto 0);
        old_CCR : in STD_LOGIC_VECTOR (2 downto 0);

        result : out STD_LOGIC_VECTOR (15 downto 0);
        new_CCR : out STD_LOGIC_VECTOR (2 downto 0)
    );
end ALU;

-- Result = OP1	000
-- SetC	        001
-- Not	        010
-- Add	        011
-- Sub	        100
-- And	        101
-- INC      	110

-- Z<0>:=CCR<0> 
-- N<0>:=CCR<1> 
-- C<0>:=CCR<2> 

-- There is a room for optimization
architecture Behavioral of ALU is
    -- itegrate
    begin
    process(OP1, OP2, alu_control) 
        variable temp_result : std_logic_vector(16 downto 0) := (others => '0');
    begin case alu_control is
        when "000" => 
            temp_result(15 downto 0) := OP1; -- It doesn't matter
            new_CCR <= old_CCR; --
        when "001" => 
            temp_result(15 downto 0) := OP1;  -- It doesn't matter
            new_CCR(2) <= '1';
            new_CCR(1 downto 0) <= old_CCR(1 downto 0); -- 
        when "010" =>    -- Not
            temp_result(15 downto 0) := not OP1;  
            
            if temp_result(15 downto 0) = ("0000000000000000") then
                new_CCR(0) <= '1';
            else 
                new_CCR(0) <= '0';
            end if;

            new_CCR(1) <= temp_result(15);
            new_CCR(2) <= '0';

        when "011" =>  -- Add
            temp_result := std_logic_vector(unsigned('0' & OP1) + unsigned('0' & OP2));   
                
            if temp_result(15 downto 0) = ("0000000000000000") then
                new_CCR(0) <= '1';
            else 
                new_CCR(0) <= '0';
            end if;

            new_CCR(1) <= temp_result(15);
            new_CCR(2) <= temp_result(16);

        when "100" =>  -- Sub
            temp_result := std_logic_vector(unsigned('0' & OP1) - unsigned('0' & OP2));   
                    
            if temp_result(15 downto 0) = ("0000000000000000") then
                new_CCR(0) <= '1';
            else 
                new_CCR(0) <= '0';
            end if;x

            new_CCR(1) <= temp_result(15);
            new_CCR(2) <= temp_result(16);

        when "101" =>  -- And
            temp_result(15 downto 0) := OP1 and OP2;

            if temp_result(15 downto 0) = ("0000000000000000") then
                new_CCR(0) <= '1';
            else 
                new_CCR(0) <= '0';
            end if;

            new_CCR(1) <= temp_result(15);
            new_CCR(2) <= '0';

        when "110" =>    -- Inc -- We Should Change it to make it normal add op, but OP2 is 1!!!!!!!
            temp_result := std_logic_vector(unsigned('0' & OP1) + ("00000000000000001"));   -- needs testing
                    
            if temp_result(15 downto 0) = ("0000000000000000") then
                new_CCR(0) <= '1';
            else 
                new_CCR(0) <= '0';
            end if;

            new_CCR(1) <= temp_result(15);
            new_CCR(2) <= temp_result(16);

        when others => temp_result := (others => '0'); end case;
        
        result <= temp_result(15 downto 0);
    end process;



end Behavioral;
