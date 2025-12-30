library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- cpu package
package cpulib is
-- data tupoi
    subtype byte  is std_logic_vector(7 downto 0);
    subtype word  is std_logic_vector(15 downto 0);
-- ta constants
    constant DATA_WIDTH  : integer := 8;
    constant ADDR_WIDTH  : integer := 16;

    -- ALU
    component ALU
        port(
            A, B   : in  byte;
            Op     : in  std_logic_vector(6 downto 0);
            Result : out byte;
            Zero   : out std_logic
        );
    end component;

    -- ALU Control Unit 
    component alus
        port(
            rbus, acload, zload, andop   : in std_logic;
            orop, notop, xorop, aczero   : in std_logic;
            acinc, plus, minus, drbus    : in std_logic;
            alus                          : out std_logic_vector(6 downto 0)
        );
    end component;

    -- kataxwrhtes
    component Register
        generic(
            WIDTH : integer := 8
        );
        port(
            D      : in  std_logic_vector(WIDTH-1 downto 0);
            CLK    : in  std_logic;
            Reset  : in  std_logic;
            Q      : out std_logic_vector(WIDTH-1 downto 0)
        );
    end component;

    -- Data Bus me buffr
    component data_bus
        port(
            AC, DR, TR, R, MEM : in  byte;
            acbus, drbus, trbus, rbus, membus : in std_logic;
            dataBus : inout byte
        );
    end component;

    -- Extroneport
    component ext_ram_1port
        port(
            address : in  std_logic_vector(7 downto 0);
            clock   : in  std_logic;
            wren    : in  std_logic;
            data    : inout std_logic_vector(7 downto 0)
        );
    end component;

end package cpulib;

package body cpulib is
    -- Συναρτήσεις βοήθειας για ALU
    function ADD(A, B: byte) return byte is
    begin
        return std_logic_vector(unsigned(A) + unsigned(B));
    end function;

    function SUB(A, B: byte) return byte is
    begin
        return std_logic_vector(unsigned(A) - unsigned(B));
    end function;
end package body cpulib;
