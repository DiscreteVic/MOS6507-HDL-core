LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY Input_Latch_Data IS
    PORT ( 
        ctrl : IN STD_LOGIC;
        addr : INOUT STD_LOGIC_VECTOR(15 downto 0);
        data : IN STD_LOGIC_VECTOR(7 downto 0));
END Input_Latch_Data ;

ARCHITECTURE LogicFunction OF Input_Latch_Data IS
    -- Internal register
    alias addrH is addr(15 downto 8);
    alias addrL is addr(7 downto 0);
    signal intData : STD_LOGIC_VECTOR(7 downto 0) := "ZZZZZZZZ";
BEGIN
    
statesReg : PROCESS (ctrl, addr, addrH, addrL, data)  
BEGIN
    IF(ctrl='Z') THEN
        addr <= "ZZZZZZZZZZZZZZZZ";
    ELSIF (ctrl='0') THEN
        addrH <= data;
        addrL <= intData;
    ELSIF (ctrl='1') THEN 
        intData <= data;
    END IF ;
END PROCESS statesReg;


END LogicFunction ;