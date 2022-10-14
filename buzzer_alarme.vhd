library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity buzzer_alarme is
    port (
        clk : in std_logic;
        rst : in std_logic;

        en : in std_logic;
        buzz : out std_logic
    );
end entity;

architecture rtl of buzzer_alarme is

    signal cnt : std_logic_vector(15 downto 0);
    signal square : std_logic;
    
begin
    
    buzz <= en and square;

    process(clk, rst)
    begin
        if (rst = '1') then 
            cnt <= (others => '0');
        elsif(rising_edge(clk)) then
            cnt <= cnt + '1';
        end if; 
    end process;

    process(clk, rst)
    begin
        if (rst = '1') then 
            square <= '0';
        elsif(rising_edge(clk)) then
            if(cnt = (cnt'range => '0')) then
                square <= not square;
            end if;
        end if; 
    end process;
end architecture;