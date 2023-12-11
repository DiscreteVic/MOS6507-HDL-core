LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY accumulator IS
    GENERIC(
        N : STD_LOGIC_VECTOR(7 downto 0));
    PORT ( 
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        ld : IN STD_LOGIC;
        en : IN STD_LOGIC;
        dbg : OUT STD_LOGIC_VECTOR(7 downto 0);
        alu_data : INOUT STD_LOGIC_VECTOR(7 downto 0);
        data : INOUT STD_LOGIC_VECTOR(7 downto 0));
END accumulator ;

ARCHITECTURE Behavioral OF accumulator IS
    -- Internal register
    signal intData : STD_LOGIC_VECTOR(7 downto 0) := N;
BEGIN

    process (clk, en, rst, ld, data, intData)
    begin
        if(rst = '1') then
            intData <= (others => '0');

        elsif(rising_edge(clk)) then
            if(ld = '1') then
                intData <= data;
            end if;
        end if;
    end process;

    dbg <= intData;
    alu_data <= intData;
    data <= intData when en = '1' else (others => 'Z');

END Behavioral;