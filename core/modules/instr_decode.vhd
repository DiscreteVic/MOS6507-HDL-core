LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY instr_decode IS
    PORT ( 
        clk : IN STD_LOGIC;
        dbg : OUT STD_LOGIC_VECTOR(7 downto 0);
        ops : OUT STD_LOGIC_VECTOR(7 downto 0);
        ens : OUT STD_LOGIC_VECTOR(7 downto 0));
END instr_decode ;

ARCHITECTURE Behavioral OF instr_decode IS
    -- Internal register
    signal intData : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
BEGIN

    process (clk)
        variable step: INTEGER  := 0;
    begin
        if rising_edge(clk) then
            case step is
            -- P write X reads
                when 0 => 
                -- enable P
                ens <= x"01";
                dbg <= x"00";
                when 1 => 
                -- load X
                ops <= x"02";
                dbg <= x"01";
                -- clean
                when 2 => 
                ops <= x"00";
                ens <= x"00";
                dbg <= x"02";
            -- X write Y reads
                when 3 => 
                ens <= x"02";
                dbg <= x"03";
                when 4 => 
                ops <= x"04";
                dbg <= x"04";
                when 5 => 
                ops <= x"00";
                ens <= x"00";
                dbg <= x"05";
                when others => 
                ops <= x"00";
                ens <= x"00";
                dbg <= x"06";
            end case;
            step := step + 1;
        end if;
    end process;




END Behavioral;