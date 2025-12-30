library ieee;
use ieee.std_logic_1164.all;

entity data_bus is
port(
    -- mesw autwn twn phgwn odhgeite to bus
    AC      : in  std_logic_vector(7 downto 0); -- Accumulator
    DR      : in  std_logic_vector(7 downto 0); -- Data Register
    TR      : in  std_logic_vector(7 downto 0); -- Temporary Register
    R       : in  std_logic_vector(7 downto 0); -- General Purpose Register
    MEM     : in  std_logic_vector(7 downto 0); -- Data ekswterikhs mnhmhs

    --ta buffers pou to energopoioun
    acbus   : in std_logic; -- mesw auto , to AC odhgei to bus 
    drbus   : in std_logic; -- mesw auto , to DR odhgei to bus 
    trbus   : in std_logic; -- mesw auto , to TR odhgei to bus 
    rbus    : in std_logic; --- mesw auto , to R odhgei to bus 
    membus  : in std_logic; -- mesw auto , h mnhmh odhgei to bus 

    -- autos , einai o kentrikos diaulos dedomenwn
    dataBus : inout std_logic_vector(7 downto 0)
);
end data_bus;

architecture rtl of data_bus is
begin
  -- mesw auton pou anaferontai , shmainei oti odhgoun to bus
  -- Ο Accumulato
    dataBus <= AC when acbus = '1' else (others => 'Z');

    -- Ο Data Register 
    dataBus <= DR when drbus = '1' else (others => 'Z');

    -- Ο Temporary Register 
    dataBus <= TR when trbus = '1' else (others => 'Z');

    -- Ο General Purpose Register 
    dataBus <= R  when rbus  = '1' else (others => 'Z');

    -- Data ekswterikhs Mnhmhs
    dataBus <= MEM when membus = '1' else (others => 'Z');

end rtl;
  -- gnwrizoume , oti mono 1 prepei na einai enable .
