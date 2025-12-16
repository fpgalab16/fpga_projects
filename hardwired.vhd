library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.hardwired_lib.all;

entity hardwired is
    port(
        ir     : in  std_logic_vector(3 downto 0);
        clock  : in  std_logic;
        reset  : in  std_logic;
        z      : in  std_logic;
        mOPs   : out std_logic_vector(26 downto 0)
    );
end hardwired;

architecture arc of hardwired is

    signal I : std_logic_vector(15 downto 0);

    signal T : std_logic_vector(7 downto 0);

    signal sc     : std_logic_vector(2 downto 0);
    signal inc_sc : std_logic;
    signal clr_sc : std_logic;

begin

    ID : instr_decoder
        port map(
            Din  => ir,
            Dout => I
        );

    CNT : counter3_bit
        port map(
            clock => clock,
            rst   => clr_sc,
            inc   => inc_sc,
            count => sc
        );

    SD : state_decoder
        port map(
            Din  => sc,
            Dout => T
        );

    clr_sc <=
        T(2) when (T(0) or T(1) or T(2)) = '1' else   
        T(7);                                      
    inc_sc <= not clr_sc;



    mOPs <= (others => '0');


mOPs <= (others => '0');

-- 0 ARLOAD
mOPs(0) <= T(0) or T(2) or
           (I(1) and T(5)) or
           (I(2) and T(5));

-- 1 ARINC
mOPs(1) <= (I(1) and T(3)) or
           (I(2) and T(3)) or
           (I(6) and T(3)) or
           (I(7) and T(3));

-- 2 PCLOAD
mOPs(2) <= (I(5) and T(5)) or
           (I(6) and z and T(5)) or
           (I(7) and not z and T(5));

-- 3 PCINC
mOPs(3) <= T(1) or
           (I(1) and T(3)) or
           (I(1) and T(4)) or
           (I(2) and T(3)) or
           (I(2) and T(4)) or
           (I(6) and not z and T(3)) or
           (I(6) and not z and T(4)) or
           (I(7) and z and T(3)) or
           (I(7) and z and T(4));

-- 4 DRLOAD
mOPs(4) <= T(1) or
           (I(1) and T(3)) or
           (I(1) and T(4)) or
           (I(1) and T(6)) or
           (I(2) and T(3)) or
           (I(2) and T(4)) or
           (I(2) and T(6)) or
           (I(5) and T(3)) or
           (I(5) and T(4)) or
           (I(6) and T(3)) or
           (I(6) and T(4)) or
           (I(7) and T(3)) or
           (I(7) and T(4));

-- 5 TRLOAD
mOPs(5) <= (I(1) and T(4)) or
           (I(2) and T(4)) or
           (I(5) and T(4)) or
           (I(6) and T(4)) or
           (I(7) and T(4));

-- 6 IRLOAD
mOPs(6) <= T(2);

-- 7 RLOAD
mOPs(7) <= (I(3) and T(3));

-- 8 ACLOAD
mOPs(8) <= (I(1) and T(7)) or
           (I(3) and T(3)) or
           (I(8) and T(3)) or
           (I(9) and T(3)) or
           (I(10) and T(3)) or
           (I(11) and T(3)) or
           (I(12) and T(3)) or
           (I(13) and T(3)) or
           (I(14) and T(3)) or
           (I(15) and T(3));

-- 9 ZLOAD
mOPs(9) <= mOPs(8);

-- 10 READ
mOPs(10) <= T(1) or
            (I(1) and T(3)) or
            (I(1) and T(4)) or
            (I(1) and T(6)) or
            (I(2) and T(3)) or
            (I(2) and T(4)) or
            (I(5) and T(3)) or
            (I(5) and T(4)) or
            (I(6) and T(3)) or
            (I(6) and T(4)) or
            (I(7) and T(3)) or
            (I(7) and T(4));

-- 11 WRITE
mOPs(11) <= (I(2) and T(7));

-- 12 MEMBUS
mOPs(12) <= mOPs(10);

-- 13 BUSMEM
mOPs(13) <= (I(2) and T(7));

-- 14 PCBUS
mOPs(14) <= T(0) or T(2);

-- 15 DRBUS
mOPs(15) <= (I(1) and T(4)) or
            (I(1) and T(5)) or
            (I(1) and T(7)) or
            (I(2) and T(4)) or
            (I(2) and T(5)) or
            (I(2) and T(7)) or
            (I(5) and T(4)) or
            (I(5) and T(5)) or
            (I(6) and T(4)) or
            (I(6) and T(5)) or
            (I(7) and T(4)) or
            (I(7) and T(5));

-- 16 TRBUS
mOPs(16) <= (I(1) and T(5)) or
            (I(2) and T(5)) or
            (I(5) and T(5)) or
            (I(6) and T(5)) or
            (I(7) and T(5));

-- 17 RBUS
mOPs(17) <= (I(4) and T(3)) or
            (I(8) and T(3)) or
            (I(9) and T(3)) or
            (I(12) and T(3)) or
            (I(13) and T(3)) or
            (I(14) and T(3));

-- 18 ACBUS
mOPs(18) <= (I(2) and T(6)) or
            (I(1) and T(3));

-- 19 ANDOP
mOPs(19) <= (I(12) and T(3));

-- 20 OROP
mOPs(20) <= (I(13) and T(3));

-- 21 XOROP
mOPs(21) <= (I(14) and T(3));

-- 22 NOTOP
mOPs(22) <= (I(15) and T(3));

-- 23 ACINC
mOPs(23) <= (I(10) and T(3));

-- 24 ACZERO
mOPs(24) <= (I(11) and T(3));

-- 25 PLUS
mOPs(25) <= (I(8) and T(3));

-- 26 MINUS
mOPs(26) <= (I(9) and T(3));
