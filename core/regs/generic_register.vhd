LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY generic_register IS
    PORT ( 
        clk : IN STD_LOGIC;
        wr : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        iData : IN STD_LOGIC_VECTOR(7 downto 0);
        oData : OUT STD_LOGIC_VECTOR(7 downto 0)) ;
END generic_register ;

ARCHITECTURE Behavioral OF generic_register IS
    -- Internal register
    signal intData : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
BEGIN

    process (clk, rst)
    begin
        if rst = '1' then
            intData <= (others => '0');

        elsif rising_edge(clk) then
        
            if wr = '1' then
                intData <= iData;
            end if;
        end if;
    end process;

    oData <= intData;


END Behavioral;