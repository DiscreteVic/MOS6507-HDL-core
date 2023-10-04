LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY generic_register IS
    PORT ( 
        wr : IN STD_LOGIC;
        rd : IN STD_LOGIC;
        iData : IN STD_LOGIC_VECTOR(7 downto 0);
        oData : OUT STD_LOGIC_VECTOR(7 downto 0)) ;
END acc ;

ARCHITECTURE Behavioral OF generic_register IS
    -- Internal register
    signal intData : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
BEGIN
    
    process(wr)
    begin
        if rising_edge(wr) then
            intData <= iData;
        end if;
    end process;

    process(rd)
    begin
        if rising_edge(rd) then
            oData <= intData;
        end if;
    end process;

END Behavioral