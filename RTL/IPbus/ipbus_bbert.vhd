
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.ipbus.all;
use work.ipbus_reg_types.all;

entity ipbus_bbert is
	generic(
		N_REG: positive := 3
	);
	port(
		clk: in std_logic; -- 32 MHz clk
		reset: in std_logic;
		ipbus_in: in ipb_wbus;
		ipbus_out: out ipb_rbus;
		q: out ipb_reg_v(N_REG - 1 downto 0);
        qmask: in ipb_reg_v(N_REG - 1 downto 0) := (others => (others => '1'));
		bbert_signal_in_sel: out std_logic_vector(7 downto 0); -- all input pins 2^8=256 
        bbert_signal_out_sel: out std_logic_vector(7 downto 0); -- all output pins 2^8=256
        bbert_clk_out: out std_logic; 
        bbert_signal_out: out std_logic;
        bbert_clk_in: in std_logic;
        bbert_signal_in: in std_logic;
        leds_F: out std_logic_vector(5 downto 1)
	);
	
end ipbus_bbert;

architecture rtl of ipbus_bbert is

    constant ADDR_WIDTH: integer := calc_width(N_REG);
    constant CLK_FREQ: integer := 200e6; -- in Hz
    constant MULT: integer := 4;
    constant DIV: integer := 16;
     
	signal reg: ipb_reg_v(N_REG - 1 downto 0);
	signal ri: ipb_reg_v(2 ** ADDR_WIDTH - 1 downto 0);
	signal sel: integer range 0 to 2 ** ADDR_WIDTH - 1 := 0;
	
	signal resetPLL, resetTransmitter, resetReceiver: std_logic;
	signal delay: unsigned(3 downto 0);
	signal errorCount, startCount: unsigned(31 downto 0); 

begin
--======================================================================================================
-- IPbus reg
--======================================================================================================
	sel <= to_integer(unsigned(ipbus_in.ipb_addr(ADDR_WIDTH - 1 downto 0))) when ADDR_WIDTH > 0 else 0;
	
	process(clk)
	begin
		if rising_edge(clk) then
			if reset = '1' then
				reg(0) <= (others => '0');
			elsif ipbus_in.ipb_strobe = '1' and ipbus_in.ipb_write = '1' and sel = 0 then
				reg(0) <= ipbus_in.ipb_wdata and qmask(sel);
			end if;
		end if;
	end process;
	
	ri(N_REG - 1 downto 0) <= reg;
	ri(2 ** ADDR_WIDTH - 1 downto N_REG) <= (others => (others => '0'));
	
	ipbus_out.ipb_rdata <= ri(sel);
	ipbus_out.ipb_ack <= ipbus_in.ipb_strobe;
	ipbus_out.ipb_err <= '0';

	q <= reg;
--======================================================================================================
	
	bbert_signal_in_sel <= reg(0)(7 downto 0);
	bbert_signal_out_sel <= reg(0)(15 downto 8);
	delay <= unsigned(reg(0) (19 downto 16));
	resetTransmitter <= reg(0)(20);
    resetReceiver <= reg(0)(21);
    resetPLL <= reg(0)(22);
    
    reg(1) <= std_logic_vector(errorCount);
    reg(2) <= std_logic_vector(startCount);
    
--        cTransmitter: entity work.transmitter(ddr)
--            generic map (
--                CLK_FREQ => CLK_FREQ,
--                MULT => MULT,
--                DIV => DIV
--            )
--            port map (
--                clk => clk, -- 32 MHz, original was clk200
--                reset => resetTransmitter,
--                resetPLL => resetPLL,
--                PLLLocked => leds_F(1),
--                clkTx => bbert_clk_out, --sma_p,
--                dataTx => bbert_signal_out, --sma_n
--                debug => open
--            );
    
--        gReceiver: entity work.receiver(ddr)
--                generic map (
--                    CLK_FREQ => CLK_FREQ,
--                    MULT => MULT,
--                    DIV => DIV,
--                    ERR_WIDTH => 32
--                )
--                port map (
--                    clk => clk, --32 MHz, original was clk200
--                    reset => resetReceiver,
--                    resetPLL => resetPLL,
--                    clkRx => bbert_clk_in, --sma_clk_p,
--                    dataRx => bbert_signal_in, --sma_clk_n,
--                    PLLLocked => leds_F(2), 
--                    errorSlowToggle => leds_F(5), 
--                    startSlowToggle => leds_F(4), 
--                    running => leds_F(3), 
--                    delay => delay,
--                    test => "00", 
--                    errorCount => errorCount,
--                    startCount => startCount
--                );
	 
	
end rtl;

