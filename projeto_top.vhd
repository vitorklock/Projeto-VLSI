LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_arith.ALL;

entity projeto_top is
    port (
        clk   : in std_logic;
        rst_n : in std_logic;
        btn_n : in std_logic;
        led_n  : out std_logic_vector(3 downto 0);
        saida_buzzer : out std_logic
    );
end entity;

architecture rtl of projeto_top is

    signal btn_n_sync : std_logic;
    signal rst : std_logic;
    signal btn_sync : std_logic;
    signal led : std_logic_vector(3 downto 0);
    signal btn_deb : std_logic;
    signal buz_en : std_logic;
    signal buz_out : std_logic;
    
begin

    rst <= not rst_n;
    btn_sync <= not btn_n_sync;
    led_n <= not led;
    buz_en <= '1' when led = "1111" else '0';

    synchro : entity work.synchro
    port map(
        clk => clk,
        async_i => btn_n,
        sync_o => btn_n_sync  
    );

    projeto : entity work.projeto
    port map( 
        clk => clk,
        rst => rst,
        btn => btn_deb,
        led => led 
    );

    debounce : entity work.debounce
    port map(
        clk => clk,
        rst => rst,
        bounce_i => btn_sync,
        debounce_o => btn_deb
    );

    buzzer_alarme : entity work.buzzer_alarme
    port map(
        clk => clk,
        rst => rst,
        en => buz_en,
        buzz => saida_buzzer
    ); 
    
end architecture;