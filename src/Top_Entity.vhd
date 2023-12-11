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

    COMPONENT top_core is
        PORT ( 
            clk_sys : IN STD_LOGIC;
            dbg : OUT STD_LOGIC_VECTOR(23 downto 0));
    END COMPONENT;
 

    COMPONENT sevSegCtrl is
        PORT ( 
            dig : IN STD_LOGIC_VECTOR(3 downto 0);
            dot : IN STD_LOGIC;
            leds : OUT STD_LOGIC_VECTOR(7 downto 0)) ;
    END COMPONENT;

    COMPONENT Prescaler is
       GENERIC(
            N : INTEGER);
        PORT ( 
            clk_in : IN STD_LOGIC;
            clk_out : OUT STD_LOGIC) ;
    END COMPONENT;

    signal disp0 : STD_LOGIC_VECTOR(3 downto 0); 
    signal disp1 : STD_LOGIC_VECTOR(3 downto 0); 
    signal disp2 : STD_LOGIC_VECTOR(3 downto 0); 
    signal disp3 : STD_LOGIC_VECTOR(3 downto 0); 
    signal disp4 : STD_LOGIC_VECTOR(3 downto 0); 
    signal disp5 : STD_LOGIC_VECTOR(3 downto 0); 

    signal bytes : STD_LOGIC_VECTOR(23 downto 0); 

    signal dot : STD_LOGIC; -- Inicializar con '0'
    signal clk_sys : STD_LOGIC; 


BEGIN

    PresA: Prescaler generic map (25) port map (MAX10_CLK1_50, clk_sys);

    core: top_core  port map (clk_sys, bytes);

	D0: sevSegCtrl port map (disp0, dot, HEX0);
	D1: sevSegCtrl port map (disp1, dot, HEX1);
	D2: sevSegCtrl port map (disp2, dot, HEX2);
	D3: sevSegCtrl port map (disp3, dot, HEX3);
	D4: sevSegCtrl port map (disp4, dot, HEX4);
	D5: sevSegCtrl port map (disp5, dot, HEX5);

    -- Displaying debug bytes
    dot <= '0';
    disp0 <= bytes(3 downto 0);
    disp1 <= bytes(7 downto 4);
    disp2 <= bytes(11 downto 8);
    disp3 <= bytes(15 downto 12);
    disp4 <= bytes(19 downto 16);
    disp5 <= bytes(23 downto 20);


 
END LogicFunction ;