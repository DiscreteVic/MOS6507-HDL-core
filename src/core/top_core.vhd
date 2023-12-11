LIBRARY ieee ;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

ENTITY top_core IS
    PORT (
        clk_sys : IN STD_LOGIC;
        dbg : OUT STD_LOGIC_VECTOR(23 downto 0));
END top_core ;

ARCHITECTURE LogicFunction OF top_core IS

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

    COMPONENT accumulator is
        GENERIC(
            N : STD_LOGIC_VECTOR(7 downto 0));
        PORT ( 
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            ld : IN STD_LOGIC;
            en : IN STD_LOGIC;
            dbg : OUT STD_LOGIC_VECTOR(7 downto 0);
            alu_data : OUT STD_LOGIC_VECTOR(7 downto 0);
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


    signal byte0 : STD_LOGIC_VECTOR(7 downto 0); 
    signal byte1 : STD_LOGIC_VECTOR(7 downto 0); 
    signal byte2 : STD_LOGIC_VECTOR(7 downto 0); 

    signal pcVal : STD_LOGIC_VECTOR(7 downto 0) := x"00"; -- Inicializar con '0'
    

    signal dataBus : STD_LOGIC_VECTOR(7 downto 0);

    signal busLd : STD_LOGIC_VECTOR(7 downto 0) := x"00";
    signal busEn : STD_LOGIC_VECTOR(7 downto 0) := x"00";

    signal alu_acc : STD_LOGIC_VECTOR(7 downto 0);

BEGIN


    --PC: prog_counter port map (clk_sys, '0', '0', pcVal);

    ID: instr_decode port map (clk_sys, pcVal, busLd, busEn);

	P: generic_register generic map (x"5A") port map (clk_sys, '0', busLd(0), busEn(0), open, dataBus);
	X: generic_register generic map (x"00") port map (clk_sys, '0', busLd(1), busEn(1), open, dataBus);
	Y: generic_register generic map (x"68") port map (clk_sys, '0', busLd(2), busEn(2), open, dataBus);
	ACC: accumulator generic map (x"00") port map (clk_sys, '0', busLd(3), busEn(3), byte0, alu_acc, dataBus);
    
    -- ALU IFC          clk,    rst, op, carry, iData, accData, oData 
	ALU0: alu port map (clk_sys, not busEn(4), '0' , '0', dataBus, alu_acc, byte2);


    byte1 <= dataBus;

    -- Displaying debug bytes
    dbg(7 downto 0) <= byte0;
    dbg(15 downto 8) <= byte1;
    dbg(23 downto 16) <= byte2;


 
END LogicFunction ;