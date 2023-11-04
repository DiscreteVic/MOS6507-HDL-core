LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
use IEEE.NUMERIC_STD.ALL ;

ENTITY sevSegCtrl IS
    PORT ( 
        dig : IN STD_LOGIC_VECTOR(3 downto 0);
        dot : IN STD_LOGIC;
        leds : OUT STD_LOGIC_VECTOR(7 downto 0)) ;
END sevSegCtrl ;

ARCHITECTURE LogicFunction OF sevSegCtrl IS
    signal reg_leds : STD_LOGIC_VECTOR(7 downto 0);
BEGIN


    process(dig, dot)
    begin

        if (dig = "0001" or dig = "0100" or dig = "1011" or dig = "1101") then
            reg_leds(0) <= '1';
        else
            reg_leds(0) <= '0';
        end if;
        
        if (dig = "0101" or dig = "0110" or dig = "1011" or dig = "1100" or dig = "1110" or dig = "1111") then
            reg_leds(1) <= '1';
        else
            reg_leds(1) <= '0';
        end if;
        
        if (dig = "0010" or dig = "1100" or dig = "1110" or dig = "1111") then
            reg_leds(2) <= '1';
        else
            reg_leds(2) <= '0';
        end if;
        
        if (dig = "0001" or dig = "0100" or dig = "0111" or dig = "1001" or dig = "1010" or dig = "1111") then
            reg_leds(3) <= '1';
        else
            reg_leds(3) <= '0';
        end if;
        
        if (dig = "0001" or dig = "0011" or dig = "0100" or dig = "0101" or dig = "0111" or dig = "1001") then
            reg_leds(4) <= '1';
        else
            reg_leds(4) <= '0';
        end if;
        
        if (dig = "0001" or dig = "0010" or dig = "0011" or dig = "0111" or dig = "1101") then
            reg_leds(5) <= '1';
        else
            reg_leds(5) <= '0';
        end if;
        
        if (dig = "0000" or dig = "0001" or dig = "0111" or dig = "1100") then
            reg_leds(6) <= '1';
        else
            reg_leds(6) <= '0';
        end if;
        
        if dot = '1' then
            reg_leds(7) <= '0';
        else
            reg_leds(7) <= '1';
        end if;
        
    end process;

    leds <= reg_leds;

END LogicFunction ;