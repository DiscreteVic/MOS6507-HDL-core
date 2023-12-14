-- Archivo de entidad (memory.vhd)
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity memory is
    GENERIC(
        SIZE_BYTES : INTEGER);
    Port ( clk : in STD_LOGIC;
           address : in STD_LOGIC_VECTOR (15 downto 0);
           data : inout STD_LOGIC_VECTOR (7 downto 0);
           rw : in STD_LOGIC;
           dbe : in STD_LOGIC);
end memory;

architecture Behavioral of memory is
    type memory_array is array (0 to SIZE_BYTES-1) of STD_LOGIC_VECTOR(7 downto 0);
    signal mem : memory_array := (others => (others => '0'));
begin
    process(clk, dbe)
    begin
        if rising_edge(clk) and dbe = '1' then
            if rw = '0' then
                mem(to_integer(unsigned(address))) <= data;
            elsif rw = '1' then
                data <= mem(to_integer(unsigned(address)));
            end if;
        end if;
    end process;
end Behavioral;
