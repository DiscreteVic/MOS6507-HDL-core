LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY Index_Reg_XY IS
    PORT ( 
        ctrl : IN STD_LOGIC;
        data : INOUT STD_LOGIC_VECTOR(7 downto 0)) ;
END Index_Reg_XY ;

ARCHITECTURE LogicFunction OF Index_Reg_XY IS
    signal intData : STD_LOGIC_VECTOR(7 downto 0) := "ZZZZZZZZ";
BEGIN
    
    statesReg : PROCESS (ctrl, data)  
    BEGIN
        IF(ctrl='Z') THEN
            data <= (others=>'Z');
        ELSIF (ctrl='0') THEN
                data <= intData;
        ELSIF (ctrl='1') THEN
                intData <= data;
        END IF ;
    END PROCESS statesReg;


END LogicFunction ;