library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity synchro is
    port (
        clk: in std_logic;
        async_i : in std_logic;
        sync_o : out std_logic
    );
end entity;

architecture rtl of synchro is

    signal sig : std_logic;
    
begin

    process(clk)
    begin
        if (rising_edge(clk)) then 
            sig <= async_i;
            sync_o <= sig;
        end if;    
    end process;
end architecture;