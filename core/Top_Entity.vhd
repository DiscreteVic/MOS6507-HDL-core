LIBRARY ieee ;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

ENTITY Top_Entity IS
    PORT ( 
        ADC_CLK_10 : IN STD_LOGIC ;
        MAX10_CLK1_50 : IN STD_LOGIC ;
        ARDUINO_IO : INOUT STD_LOGIC_VECTOR(15 downto 0) ;
        VGA_R : OUT STD_LOGIC_VECTOR(3 downto 0) ;
        VGA_G : OUT STD_LOGIC_VECTOR(3 downto 0) ;
        VGA_B : OUT STD_LOGIC_VECTOR(3 downto 0) ;
        VGA_HS : OUT STD_LOGIC ;
        VGA_VS : OUT STD_LOGIC ;
        SW : IN STD_LOGIC_VECTOR(9 downto 0) ;
        KEY : IN STD_LOGIC_VECTOR(1 downto 0) ;
        LEDR : OUT STD_LOGIC_VECTOR(9 downto 0);
        HEX0 : OUT STD_LOGIC_VECTOR(7 downto 0);
        HEX1 : OUT STD_LOGIC_VECTOR(7 downto 0);
        HEX2 : OUT STD_LOGIC_VECTOR(7 downto 0);
        HEX3 : OUT STD_LOGIC_VECTOR(7 downto 0);
        HEX4 : OUT STD_LOGIC_VECTOR(7 downto 0);
        HEX5 : OUT STD_LOGIC_VECTOR(7 downto 0));
END Top_Entity ;

ARCHITECTURE LogicFunction OF Top_Entity IS

 
    COMPONENT Prescaler is
       GENERIC(
            N : INTEGER);
        PORT ( 
            clk_in : IN STD_LOGIC;
            clk_out : OUT STD_LOGIC) ;
    END COMPONENT;

    COMPONENT sevSegCtrl is
        PORT ( 
            dig : IN STD_LOGIC_VECTOR(3 downto 0);
            dot : IN STD_LOGIC;
            leds : OUT STD_LOGIC_VECTOR(7 downto 0)) ;
    END COMPONENT;

    COMPONENT alu is
        PORT ( 
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            op : IN STD_LOGIC;
            carry : IN STD_LOGIC;
            iData : IN STD_LOGIC_VECTOR(7 downto 0);
            accData : IN STD_LOGIC_VECTOR(7 downto 0);
            oData : OUT STD_LOGIC_VECTOR(7 downto 0)) ;
    END COMPONENT;

    COMPONENT generic_register is
        GENERIC(
            N : STD_LOGIC_VECTOR(7 downto 0));
        PORT ( 
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            ld : IN STD_LOGIC;
            en : IN STD_LOGIC;
            dbg : OUT STD_LOGIC_VECTOR(7 downto 0);
            data : INOUT STD_LOGIC_VECTOR(7 downto 0));
    END COMPONENT;

    COMPONENT prog_counter is
        PORT ( 
            clk : IN STD_LOGIC;
            op : IN STD_LOGIC;
            en : IN STD_LOGIC;
            data : INOUT STD_LOGIC_VECTOR(15 downto 0));
    END COMPONENT;
    
    COMPONENT instr_decode IS
        PORT ( 
            clk : IN STD_LOGIC;
            dbg : OUT STD_LOGIC_VECTOR(7 downto 0);
            ops : OUT STD_LOGIC_VECTOR(7 downto 0);
            ens : OUT STD_LOGIC_VECTOR(7 downto 0));
    END COMPONENT ;

    signal disp0 : STD_LOGIC_VECTOR(3 downto 0); 
    signal disp1 : STD_LOGIC_VECTOR(3 downto 0); 
    signal disp2 : STD_LOGIC_VECTOR(3 downto 0); 
    signal disp3 : STD_LOGIC_VECTOR(3 downto 0); 
    signal disp4 : STD_LOGIC_VECTOR(3 downto 0); 
    signal disp5 : STD_LOGIC_VECTOR(3 downto 0); 

    signal byte0 : STD_LOGIC_VECTOR(7 downto 0); 
    signal byte1 : STD_LOGIC_VECTOR(7 downto 0); 
    signal byte2 : STD_LOGIC_VECTOR(7 downto 0); 

    signal pcVal : STD_LOGIC_VECTOR(7 downto 0) := x"00"; -- Inicializar con '0'
    
    signal constValue : STD_LOGIC_VECTOR(7 downto 0) := x"03"; -- Inicializar con '0'
    signal dot : STD_LOGIC; -- Inicializar con '0'
    signal clk_sys : STD_LOGIC; 

    signal dataBus : STD_LOGIC_VECTOR(7 downto 0);

    signal busLd : STD_LOGIC_VECTOR(7 downto 0);
    signal busEn : STD_LOGIC_VECTOR(7 downto 0);

BEGIN

    PresA: Prescaler generic map (25) port map (MAX10_CLK1_50, clk_sys);

	D0: sevSegCtrl port map (disp0,dot, HEX0);
	D1: sevSegCtrl port map (disp1,dot, HEX1);
	D2: sevSegCtrl port map (disp2,dot, HEX2);
	D3: sevSegCtrl port map (disp3,dot, HEX3);
	D4: sevSegCtrl port map (disp4,dot, HEX4);
	D5: sevSegCtrl port map (disp5,dot, HEX5);

    --PC: prog_counter port map (clk_sys, '0', '0', pcVal);

    ID: instr_decode port map (clk_sys, pcVal, busLd, busEn);

	P: generic_register generic map (x"5A") port map (clk_sys, '0', busLd(0), busEn(0), open, dataBus);
	X: generic_register generic map (x"00") port map (clk_sys, '0', busLd(1), busEn(1), byte0, dataBus);
	Y: generic_register generic map (x"00") port map (clk_sys, '0', busLd(2), busEn(2), byte1, dataBus);
	--Y: generic_register port map (clk_sys, not KEY(0), '0',  constValue, byte1);
	--ACC: generic_register port map (clk_sys, not KEY(1), '0',  constValue, byte1);
    
    -- ALU IFC          clk,    rst, op, carry, iData, accData, oData 
	--ALU0: alu port map (clk_sys, '0', '1' , '0', byte0, byte1, byte2);



    byte2 <= pcVal(7 downto 0);


    -- Displaying debug bytes
    dot <= '0';
    disp0 <= byte0(3 downto 0);
    disp1 <= byte0(7 downto 4);
    disp2 <= byte1(3 downto 0);
    disp3 <= byte1(7 downto 4);
    disp4 <= byte2(3 downto 0);
    disp5 <= byte2(7 downto 4);


 
END LogicFunction ;