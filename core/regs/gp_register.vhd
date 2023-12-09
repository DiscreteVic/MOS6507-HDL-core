LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
use ieee.numeric_std.all;

ENTITY gp_register IS
    PORT ( 
        clk : IN STD_LOGIC;
        op : IN STD_LOGIC; -- store 1 / load 0
        en : IN STD_LOGIC;
        dataport : INOUT STD_LOGIC_VECTOR(7 downto 0);
END gp_register ;

ARCHITECTURE Behavioral OF gp_register IS
    -- Internal register
    signal intData : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
    signal iData : STD_LOGIC_VECTOR(7 downto 0);
    signal oData : STD_LOGIC_VECTOR(7 downto 0);
BEGIN

    process (clk, en)
    begin
        if op = '1' then
            intData <= iData;

        else 
            oData <= intData;

    
        end if;
    end process;


    dataport   <= oData when en = '1' else 'Z';
    iData <= dataport;



END Behavioral;