LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY Stack_Pointer_Reg IS
    PORT ( 
        ctrl : IN STD_LOGIC;
        addr : OUT STD_LOGIC_VECTOR(7 downto 0);
        data : INOUT STD_LOGIC_VECTOR(7 downto 0)) ;
END Stack_Pointer_Reg ;

ARCHITECTURE LogicFunction OF Stack_Pointer_Reg IS
    -- Internal register
    signal intData : STD_LOGIC_VECTOR(7 downto 0) := "ZZZZZZZZ";
BEGIN
    
    statesReg : PROCESS (ctrl, addr,data)  
    BEGIN
        IF(ctrl='Z') THEN
            data <= (others=>'Z');
            addr <= (others=>'Z');
        ELSIF (ctrl='0') THEN
                addr <= intData;
                data <= intData;
        ELSIF (ctrl='1') THEN
                addr <= (others=>'Z');
                intData <= data;
        END IF ;
    END PROCESS statesReg;


END LogicFunction ;