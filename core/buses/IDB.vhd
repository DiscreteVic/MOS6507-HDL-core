LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY IDB IS
    PORT ( 
        ctrl : IN STD_LOGIC;
        data : INOUT STD_LOGIC_VECTOR(7 downto 0)
        ) ;
END IDB ;

ARCHITECTURE LogicFunction OF IDB IS

    COMPONENT Index_Reg_XY IS
        PORT ( 
            ctrl : IN STD_LOGIC;
            data : INOUT STD_LOGIC_VECTOR(7 downto 0)) ;
    END COMPONENT ;

    COMPONENT Stack_Pointer_Reg IS
    PORT ( 
        ctrl : IN STD_LOGIC;
        addr : OUT STD_LOGIC_VECTOR(7 downto 0);
        data : INOUT STD_LOGIC_VECTOR(7 downto 0)) ;
    END COMPONENT ;

    COMPONENT Input_Latch_Data IS
    PORT ( 
        ctrl : IN STD_LOGIC;
        addr : INOUT STD_LOGIC_VECTOR(15 downto 0);
        data : IN STD_LOGIC_VECTOR(7 downto 0));
    END COMPONENT ;

    COMPONENT Accumulator  IS
    PORT ( 
        ctrl : IN STD_LOGIC;
        dALU : INOUT STD_LOGIC_VECTOR(7 downto 0);
        data : INOUT STD_LOGIC_VECTOR(7 downto 0)) ;
    END COMPONENT ;

    signal data_alu : STD_LOGIC_VECTOR(7 downto 0) := "ZZZZZZZZ";
    signal data_bus : STD_LOGIC_VECTOR(7 downto 0) := "ZZZZZZZZ";
    signal ctrl_irx : STD_LOGIC := 'Z';
    signal ctrl_spr : STD_LOGIC := 'Z';
    signal ctrl_ild : STD_LOGIC := 'Z';
    signal ctrl_acc : STD_LOGIC := 'Z';
    signal addr_bus : STD_LOGIC_VECTOR(15 downto 0) := "ZZZZZZZZZZZZZZZZ";

    alias addrH_bus is addr_bus(15 downto 8);
    alias addrL_bus is addr_bus(7 downto 0);

BEGIN
    


	irx: Index_Reg_XY port map (ctrl_irx, data_bus);
	spr: Stack_Pointer_Reg port map (ctrl_spr, addrL_bus, data_bus);
	ild: Input_Latch_Data port map (ctrl_ild, addr_bus, data_bus);
	acc: Accumulator port map (ctrl_acc, data_alu, data_bus);
 

 

--    testbus : PROCESS BEGIN
--
--    -- 1 Test
--    data_bus <= "01010011";
--    wait for 2 us;
--    ctrl_irx <= '1';
--    wait for 2 us;
--    ctrl_irx <= 'Z';
--    wait for 2 us;
--    data_bus <= "ZZZZZZZZ";
--    wait for 2 us;
--    -- 2 Test
--    ctrl_irx <= '0';
--    wait for 2 us;
--    ctrl_ild <= '1';
--    wait for 2 us;
--    ctrl_irx <= 'Z';
--    ctrl_ild <= 'Z';
--    wait for 2 us;
--    data_bus <= "ZZZZZZZZ";
--    wait for 2 us;
--    
--
--    END PROCESS testbus;


END LogicFunction ;