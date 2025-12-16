library ieee;
use ieee.std_logic_1164.all;

entity instr_dec is
    port(
        din  : in  std_logic_vector(3 downto 0);
        dout : out std_logic_vector(15 downto 0)
    );
end instr_decoder;

architecture rtl of instr_dec is
begin
    process(din)
    begin
        dout <= (others => '0');
        case din is
            when "0000" => dout(0)  <= '1'; -- INOP
            when "0001" => dout(1)  <= '1'; -- ILDAC
            when "0010" => dout(2)  <= '1'; -- ISTAC
            when "0011" => dout(3)  <= '1'; --IMVAC
            when "0100" => dout(4)  <= '1'; -- IMOVR
            when "0101" => dout(5)  <= '1'; -- IJUMP
            when "0110" => dout(6)  <= '1'; -- IJMPZ
            when "0111" => dout(7)  <= '1'; -- IJPNZ
            when "1000" => dout(8)  <= '1'; -- IADD
            when "1001" => dout(9)  <= '1'; -- SUB
            when "1010" => dout(10) <= '1'; -- INAC
            when "1011" => dout(11) <= '1'; -- IICLAC
            when "1100" => dout(12) <= '1'; -- IAND
            when "1101" => dout(13) <= '1'; -- IOR
            when "1110" => dout(14) <= '1'; -- IXOR
            when "1111" => dout(15) <= '1'; -- INOT
            when others => null;
        end case;
    end process;
end architecture;
