LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY Accumulator  IS
    PORT ( 
        ctrl : IN STD_LOGIC;
        dALU : INOUT STD_LOGIC_VECTOR(7 downto 0);
        data : INOUT STD_LOGIC_VECTOR(7 downto 0)) ;
END Accumulator ;

ARCHITECTURE LogicFunction OF Accumulator IS
    -- Internal register
    signal intData : STD_LOGIC_VECTOR(7 downto 0) := "ZZZZZZZZ";
BEGIN
    
    statesReg : PROCESS (ctrl, dALU, data)  
    BEGIN
        IF(ctrl='Z') THEN
            data <= (others=>'Z');
            dALU <= (others=>'Z');
        ELSIF (ctrl='0') THEN
                dALU <= intData;
                data <= intData;
        ELSIF (ctrl='1') THEN 
            -- SET FROM TWO SOURCES IN CASE OF CONFLICT **DONT WRITE**
            IF ((data = "ZZZZZZZZ") and  (dALU /= "ZZZZZZZZ")) THEN
                intData <= dALU;
            ELSIF ((data /= "ZZZZZZZZ") and  (dALU = "ZZZZZZZZ")) THEN
                intData <= data;
            ELSIF ((data /= "ZZZZZZZZ") and  (dALU /= "ZZZZZZZZ")) THEN
                --NOTHING
            END IF;
        END IF ;
    END PROCESS statesReg;


END LogicFunction ;