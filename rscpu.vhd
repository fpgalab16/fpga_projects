library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.cpulib.all;

entity rs_cpu is
port(
    ARdata, PCdata  : buffer std_logic_vector(15 downto 0); 
    DRdata, ACdata  : buffer std_logic_vector(7 downto 0); 
    IRdata, TRdata  : buffer std_logic_vector(7 downto 0);
    RRdata          : buffer std_logic_vector(7 downto 0);
    ZRdata          : buffer std_logic; 
    clock, reset    : in std_logic;
    mOP             : buffer std_logic_vector(26 downto 0); 
    addressBus      : buffer std_logic_vector(15 downto 0);
    dataBus         : buffer std_logic_vector(7 downto 0)
);
end rs_cpu;

architecture arc of rs_cpu is

    -- shmeta twn buffers
    signal alus_sig   : std_logic_vector(6 downto 0);
    signal alu_result : std_logic_vector(7 downto 0);
    signal alu_zero   : std_logic;

    -- shmata gia diaulo dedomenwn
    signal AC_out, DR_out, TR_out, R_out, MEM_out : std_logic_vector(7 downto 0);
    signal acbus_sig, drbus_sig, trbus_sig, rbus_sig, membus_sig : std_logic;

    -- shmata ekswterikhs mnhmhs
    signal mem_data : std_logic_vector(7 downto 0);
    signal mem_addr : std_logic_vector(7 downto 0);
    signal mem_we   : std_logic;

begin
-- parakatw uparxoun oles oi aparaithtes arxikopoihseis gia ola ta susthmata tou kuklwmatos 
    data_bus_inst : data_bus
        port map(
            AC     => ACdata,
            DR     => DRdata,
            TR     => TRdata,
            R      => RRdata,
            MEM    => mem_data,
            acbus  => acbus_sig,
            drbus  => drbus_sig,
            trbus  => trbus_sig,
            rbus   => rbus_sig,
            membus => membus_sig,
            dataBus => dataBus
        );
    alus_inst : alus
        port map(
            rbus    => rbus_sig,
            acload  => mOP(0),
            zload   => mOP(1),
            andop   => mOP(2),
            orop    => mOP(3),
            notop   => mOP(4),
            xorop   => mOP(5),
            aczero  => mOP(6),
            acinc   => mOP(7),
            plus    => mOP(8),
            minus   => mOP(9),
            drbus   => drbus_sig,
            alus    => alus_sig
        );

    alu_inst : ALU
        port map(
            A      => ACdata,
            B      => DRdata,
            Op     => alus_sig,
            Result => alu_result,
            Zero   => alu_zero
        );
    process(clock, reset)
    begin
        if reset = '1' then
            ACdata <= (others => '0');
            ZRdata <= '0';
        elsif rising_edge(clock) then
            if mOP(0) = '1' then 
                ACdata <= alu_result;
            end if;
            if mOP(1) = '1' then 
                ZRdata <= alu_zero;
            end if;
        end if;
    end process;
    ext_ram_inst : ext_ram_1port
        port map(
            address => mem_addr,
            clock   => clock,
            wren    => mem_we,
            data    => mem_data
        );
    process(clock)
    begin
        if rising_edge(clock) then
            addressBus <= ARdata;  
        end if;
    end process;
    acbus_sig  <= mOP(10);
    drbus_sig  <= mOP(11);
    trbus_sig  <= mOP(12);
    rbus_sig   <= mOP(13);
    membus_sig <= mOP(14);

    mem_addr   <= std_logic_vector(ARdata(7 downto 0)); 
    mem_we     <= mOP(15); 

end arc;
