library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity projeto is
    port (
        clk : in std_logic;
        rst : in std_logic;
        btn : in std_logic;
        led : out std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of projeto is

    signal pressed : std_logic;
    signal cnt : std_logic_vector(3 downto 0);
    
begin
    
    led <= cnt;

    process(clk, rst)
    begin
        if (rst = '1') then 
            cnt <= (others => '0');
            pressed <= '0';
        elsif(rising_edge(clk)) then
            if(btn = '1' and pressed = '0') then
                cnt <= cnt + '1';
                pressed <= '1';
            elsif(btn = '0' and pressed = '1') then 
                pressed <= '0';
            end if;
        end if;   
    end process;
end architecture;