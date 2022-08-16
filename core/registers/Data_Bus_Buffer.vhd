LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY Data_Bus_Buffer IS
    PORT ( 
        rw : INOUT STD_LOGIC;
        dbe : INOUT STD_LOGIC;
        int_data_bus : INOUT STD_LOGIC_VECTOR(15 downto 0);
        data_bus : INOUT STD_LOGIC_VECTOR(7 downto 0));
END Data_Bus_Buffer ;

ARCHITECTURE LogicFunction OF Data_Bus_Buffer IS
    -- Internal register
    signal intData : STD_LOGIC_VECTOR(7 downto 0) := "ZZZZZZZZ";
BEGIN
    
statesReg : PROCESS (rw, int_data, data)  
BEGIN
    IF(rw='Z') THEN
        data_bus <= "ZZZZZZZZ";
        int_data_bus <= "ZZZZZZZZ";
    ELSIF (rw='0') THEN
        data_bus <= intData;
        int_data_bus <= intData;
    ELSIF (rw='1') THEN 
        intData <= data_bus;
        intData <= int_data_bus;
    END IF ;
END PROCESS statesReg;


END LogicFunction ;