LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY Index_Reg_XY_tb IS
END Index_Reg_XY_tb ;

ARCHITECTURE LogicFunction OF Index_Reg_XY_tb IS

COMPONENT Index_Reg_XY IS
    PORT ( 
        ctrl : IN STD_LOGIC;
        data : INOUT STD_LOGIC_VECTOR(7 downto 0)) ;
END COMPONENT ;
    signal data_bus : STD_LOGIC_VECTOR(7 downto 0);
    signal ctrl : STD_LOGIC := 'Z';
    signal testData : STD_LOGIC_VECTOR(7 downto 0);
BEGIN

    data_bus <= testData;

	tb: Index_Reg_XY port map (ctrl,data_bus);
 
    stimulus: PROCESS BEGIN 
    -- Frist Value to write
    testData <= "01010011";
    wait for 2 us;
    -- Write in register
    ctrl <= '1';
    wait for 2 us;
    ctrl <= '0';
    wait for 4 us;
    -- Set register in high impedance and set other value in bus
    ctrl <= 'Z';
    testData <= "10101010";
    wait for 4 us;
    -- Set bus in high impedance 
    testData <= "ZZZZZZZZ";
    wait for 1 us;
    -- Show register value
    ctrl <= '0';
    wait for 1 us;
    -- Set register in high impedance and set other value in bus
    ctrl <= 'Z';
    testData <= "11110000";
    wait for 1 us;
    -- Write in register
    ctrl <= '1';
    wait for 1 us;
    -- Set register and bus in high impedance 
    ctrl <= 'Z';
    wait for 1 us;
    testData <= "ZZZZZZZZ";
    wait for 1 us;
    -- Show register value
    ctrl <= '0';
    wait for 5 us;
    wait;

    END PROCESS stimulus;

END LogicFunction ;