LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY Processor_Status_Reg IS
    PORT ( 
        p_state : INOUT STD_LOGIC_VECTOR(7 downto 0);
        data : INOUT STD_LOGIC_VECTOR(7 downto 0));
END Processor_Status_Reg ;

ARCHITECTURE LogicFunction OF Processor_Status_Reg IS
    -- Internal register
    variable p_state_reg : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
BEGIN
    
    -- JUST CONNECTED TO INST. DECODE 
    -- TBD
    p_state_reg := p_state;

END LogicFunction ;