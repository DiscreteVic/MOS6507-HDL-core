LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
use ieee.numeric_std.all;

ENTITY gp_register IS
    PORT ( 
        clk : IN STD_LOGIC;
        op : IN STD_LOGIC_VECTOR(2 downto 0);
        iData : IN STD_LOGIC_VECTOR(7 downto 0);
        oData : OUT STD_LOGIC_VECTOR(7 downto 0)) ;
END gp_register ;

ARCHITECTURE Behavioral OF gp_register IS
    -- Internal register
    signal intData : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
    signal wr : STD_LOGIC;
    signal dec : STD_LOGIC;
    signal inc : STD_LOGIC;
BEGIN

    process (clk)
    begin
        if rising_edge(clk) then -- 000 nop
            if op = "001" then          -- reset operation
                intData <= (others => '0');

            elsif op = "010" then       -- write operation
                intData <= iData;

            elsif op = "011" then       -- increment operation
                intData <= std_logic_vector(unsigned(intData) + 1);

            elsif op = "100" then       -- decrement operation
                intData <= std_logic_vector(unsigned(intData) - 1);

            end if;
        end if;
    end process;

    oData <= intData;



END Behavioral;