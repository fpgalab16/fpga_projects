library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.hardwiredlib.all;

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

    signal I        : std_logic_vector(15 downto 0); -- instruction lines
    signal T        : std_logic_vector(7 downto 0);  -- state lines
    signal sc       : std_logic_vector(2 downto 0);
    signal inc_sc   : std_logic;
    signal clr_sc   : std_logic;

begin

    -- Instruction Decoder
    ID : instr_decoder
        port map(ir, I);

    -- State Counter
    SC : counter3
        port map(clock, clr_sc, inc_sc, sc);

    -- State Decoder
    SD : state_decoder
        port map(sc, T);

    ------------------------------------------------
    -- Counter control
    ------------------------------------------------
    -- clr στην τελευταία κατάσταση κάθε εντολής
    clr_sc <= T(7);

    -- inc σε όλες τις άλλες
    inc_sc <= not clr_sc;

    ------------------------------------------------
    -- FETCH
    ------------------------------------------------
    -- FETCH1 = T0
    -- FETCH2 = T1
    -- FETCH3 = T2

    ------------------------------------------------
    -- Control Signals (ενδεικτικά – σωστή λογική)
    ------------------------------------------------
    mOPs <= (others => '0');

    -- PCBUS
    mOPs(0) <= T(0) or T(2);

    -- READ
    mOPs(1) <= T(1);

    -- IRLOAD
    mOPs(2) <= T(2);

    -- LDAC1
    mOPs(3) <= I(1) and T(3);

    -- STAC1
    mOPs(4) <= I(2) and T(3);

    -- ADD1
    mOPs(5) <= I(8) and T(3);

    -- SUB1
    mOPs(6) <= I(9) and T(3);

    -- NOT1
    mOPs(7) <= I(15) and T(3);

    -- (συμπληρώνεις όλα τα υπόλοιπα bits από τον Πίνακα 2)

end arc;
