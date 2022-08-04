LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY Program_Counter IS
    PORT ( 
        ctrl : IN STD_LOGIC;
        adr : INOUT STD_LOGIC_VECTOR(15 downto 0);
        data : INOUT STD_LOGIC_VECTOR(15 downto 0)) ;
END Program_Counter ;

ARCHITECTURE LogicFunction OF Program_Counter IS
    -- Internal register
    signal intData : STD_LOGIC_VECTOR(15 downto 0);
BEGIN
    
statesReg : PROCESS (ctrl, adr, data)  
BEGIN
    IF(ctrl='Z') THEN
        data <= "ZZZZZZZZZZZZZZZZ";
        adr <= "ZZZZZZZZZZZZZZZZ";
    ELSIF (ctrl='0') THEN
            adr <= intData;
            data <= intData;
    ELSIF (ctrl='1') THEN 
        -- SET FROM TWO SOURCES IN CASE OF CONFLICT **DONT WRITE**
        IF ((data = "ZZZZZZZZZZZZZZZZ") and  (adr /= "ZZZZZZZZZZZZZZZZ")) THEN
            intData <= adr;
        ELSIF ((data /= "ZZZZZZZZZZZZZZZZ") and  (adr = "ZZZZZZZZZZZZZZZZ")) THEN
            intData <= data;
        ELSIF ((data /= "ZZZZZZZZZZZZZZZZ") and  (adr /= "ZZZZZZZZZZZZZZZZ")) THEN
            --NOTHING
        END IF;
    END IF ;
END PROCESS statesReg;


END LogicFunction ;