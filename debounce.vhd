LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_arith.ALL;

entity debounce is
    port (
        clk         : in std_logic;
        rst         : in std_logic;
        bounce_i    : in std_logic;
        debounce_o  : out std_logic
    );
end entity;

architecture rtl of debounce is

    signal timer : std_logic_vector(21 downto 0);
    signal state : std_logic;
    
begin
    
    debounce_o <= state;

    process(clk, rst)
    begin
        if (rst = '1') then 
            timer <= (0 => '1', others => '0');
            state <= '0';
        elsif(rising_edge(clk)) then
            if(bounce_i /= state and timer = (timer'range => '0')) then
                state <= bounce_i;
                timer <= (0 => '1', others => '0');
            elsif(timer /= (timer'range => '0')) then 
                timer <= timer + 1;
            end if;
        end if;   
    end process;
    
    
end architecture;