LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY Stack_Pointer_Reg IS
    PORT ( 
        ctrl : IN STD_LOGIC;
        adr : OUT STD_LOGIC_VECTOR(7 downto 0);
        data : INOUT STD_LOGIC_VECTOR(7 downto 0)) ;
END Stack_Pointer_Reg ;

ARCHITECTURE LogicFunction OF Stack_Pointer_Reg IS
    -- Internal register
    signal intData : STD_LOGIC_VECTOR(7 downto 0);
BEGIN
    
    statesReg : PROCESS (ctrl, adr,data)  
    BEGIN
        IF(ctrl='Z') THEN
            data <= (others=>'Z');
            adr <= (others=>'Z');
        ELSIF (ctrl='0') THEN
                adr <= intData;
                data <= intData;
        ELSIF (ctrl='1') THEN
                adr <= (others=>'Z');
                intData <= data;
        END IF ;
    END PROCESS statesReg;


END LogicFunction ;