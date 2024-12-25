LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;


entity Write_Back_Stage is
  port (
    reset : in std_logic;  
    clk : in std_logic;

    -- inputs
    updated_pc_r : in std_logic_vector(15 downto 0);
    Rsrc1_r : in std_logic_vector(15 downto 0);
    alu_result : in std_logic_vector(15 downto 0);
    dm_output : in std_logic_vector(15 downto 0);
    returned_rdst_r : in std_logic_vector(2 downto 0);

    -- controls 
    mem_to_reg : in std_logic;
    reg_write_r : in std_logic;
    out_enable : in std_logic;


    -- outputs
    updated_pc : out std_logic_vector(15 downto 0);
    Rsrc1 : out std_logic_vector(15 downto 0);
    returned_rdst : out std_logic_vector(2 downto 0);
    reg_write : out std_logic;
    Output : out std_logic_vector(15 downto 0);
    returned_write_data : out std_logic_vector(15 downto 0)
  ) ;
end Write_Back_Stage;


architecture behavioral of Write_Back_Stage is
    -- signal SP : std_logic_vector(15 downto 0);
    -- signal user_output : std_logic_vector(15 downto 0);
begin
    
    process(reset, clk)
    begin
        if reset = '1'then
            returned_write_data <= (others => '0');
            Output <= (others => '0');

            -- SP <= (others => '0');
            updated_pc <= (others => '0');
            RSrc1 <= (others => '0');
            returned_rdst <= (others => '0');
            reg_write <= '0';
        else 
            if rising_edge(clk) THEN
                -- write back
                if mem_to_reg = '1' then
                    returned_write_data <= dm_output;
                else 
                    returned_write_data <= alu_result;
                end if;

                if out_enable = '1' then
                    Output <= Rsrc1_r; 
                else 
                    Output <= (others => '0');
                end if;

                updated_pc <= updated_pc_r;
                Rsrc1 <= Rsrc1_r;

                -- if stack = '1' then
                --     SP <= updated_sp_r; 
                -- end if;

                returned_rdst <= returned_rdst_r;

                reg_write <= reg_write_r;
            end if;

        end if;        

        -- updated_sp <= SP;
    end process;
    
    
end architecture behavioral;