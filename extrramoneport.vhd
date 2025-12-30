library ieee;
use ieee.std_logic_1164.all;

entity ext_ram_1port is
port(
    address : in  std_logic_vector(7 downto 0); -- mnhmh apo 0-255
    clock   : in  std_logic;                    -- Ρclock
    wren    : in  std_logic;                    -- mesa apo ayto , ginetai to enable
    data    : inout std_logic_vector(7 downto 0) -- auto einai o diaulos twn dedomenwn
);
end ext_ram_1port;

architecture rtl of ext_ram_1port is

    -- dhlwnw to oneport sto quartus
    component ram1port
        port(
            address : in  std_logic_vector(7 downto 0); -- RAM
            clock   : in  std_logic;                    -- clk
            data    : in  std_logic_vector(7 downto 0); -- data reg
            wren    : in  std_logic;                    -- enable reg
            q       : out std_logic_vector(7 downto 0)  -- dedomena anagnwshs (q)
        );
    end component;

    -- Εσωτερικό σήμα για την έξοδο της RAM
    signal ram_q : std_logic_vector(7 downto 0);

begin
    -- etsi ginetai h sundesh ekswterikhs ram
    RAM0 : ram1port
        port map(
            address => address, -- connect addr
            clock   => clock,   -- connect clk
            data    => data,    -- data eggrafhs
            wren    => wren,    -- Write enable
            q       => ram_q    -- data anagnwshs
        );

    data <= ram_q when wren = '0' else (others => 'Z');

end rtl;
