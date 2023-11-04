library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux41 is
    Port (
        A : in STD_LOGIC_VECTOR(7 downto 0);
        B : in STD_LOGIC_VECTOR(7 downto 0);
        C : in STD_LOGIC_VECTOR(7 downto 0);
        D : in STD_LOGIC_VECTOR(7 downto 0);
        sel : in STD_LOGIC_VECTOR(1 downto 0);
        Y : out STD_LOGIC_VECTOR(7 downto 0);
    );
end mux41;

architecture Behavioral of mux41 is
begin
    process(sel)
    begin
        case sel is
            when "00" =>
                Y <= A;
            when "01" =>
                Y <= B;
            when "10" =>
                Y <= C;
            when "11" =>
                Y <= D;
        end case;
    end process;
end Behavioral;