LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
use ieee.numeric_std.all;

ENTITY prog_counter IS
    PORT ( 
        clk : IN STD_LOGIC;
        op : IN STD_LOGIC;
        en : IN STD_LOGIC;
        data : INOUT STD_LOGIC_VECTOR(15 downto 0));
END prog_counter ;

ARCHITECTURE Behavioral OF prog_counter IS
    -- Internal register
    signal pcVal : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
BEGIN

    process (clk)
    begin
        if rising_edge(clk) then
            pcVal <= std_logic_vector(unsigned(pcVal) + 1); 
        end if;
    end process;

    data <= pcVal;


END Behavioral;