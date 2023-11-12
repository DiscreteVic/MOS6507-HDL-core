LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
use ieee.numeric_std.all;

ENTITY alu IS
    PORT ( 
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        op : IN STD_LOGIC;
        carry : IN STD_LOGIC;
        iData : IN STD_LOGIC_VECTOR(7 downto 0);
        accData : IN STD_LOGIC_VECTOR(7 downto 0);
        oData : OUT STD_LOGIC_VECTOR(7 downto 0)) ;
END alu ;

ARCHITECTURE Behavioral OF alu IS
    -- Internal register
    signal intData : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
BEGIN
    
    process(clk, rst)
        variable temp: std_logic_vector(7 downto 0);
        variable uCarry: unsigned(7 downto 0) := (others => '0');
    begin
        if rst = '1' then
            intData <= (others => '0');

        elsif rising_edge(clk) then
            if carry = '1' then
                uCarry := to_unsigned(1, 8);
            end if;

            if op = '0' then
                temp := (others => '0'); -- Inicializa la suma con 0
                temp := std_logic_vector(unsigned(accData) + unsigned(iData) + uCarry);
                intData <= temp;
            end if;
            if op = '1' then
                temp := (others => '0'); -- Inicializa la suma con 0
                temp := std_logic_vector(unsigned(accData) - unsigned(iData) - uCarry);
                intData <= temp;
            end if;
        end if;
    end process;

    oData <= intData;

END Behavioral;