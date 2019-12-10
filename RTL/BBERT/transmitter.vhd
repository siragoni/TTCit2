library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

library unisim;
use unisim.vcomponents.all;

use work.test_pkg.all;

entity transmitter is
	generic (
		CLK_FREQ: integer; -- input clk frequency, in Hz
		-- output clk parameters
		MULT: integer;
		DIV: integer
	);
	port (
		clk: in std_logic;
		reset: in std_logic;
		resetPLL: in std_logic;
		PLLLocked: out std_logic;
		clkTx: out std_logic;
		dataTx: out std_logic;
		debug: out std_logic
	);
end entity;

architecture rtl of transmitter is

	signal resetInner: std_logic;
	signal clkTxInner, clkIO, fb, PLLLockedInner: std_logic;
	signal resetTx: std_logic;
	signal dataTxInner: std_logic_vector(LFSR_WIDTH-1 downto 0);
	signal oSerDesInput: std_logic_vector(7 downto 0) := (others => '0');

begin

	assert (LFSR_WIDTH = 4) or (LFSR_WIDTH = 8)
		report "Incorrect LFSR_WIDTH - should be 4 or 8"
		severity failure;

	cPLL: PLLE2_BASE
		generic map (
			BANDWIDTH => "OPTIMIZED",
			CLKFBOUT_MULT => MULT,
			CLKIN1_PERIOD => 1.0e9/real(CLK_FREQ),
			CLKOUT0_DIVIDE => DIV,
			CLKOUT1_DIVIDE => DIV/(LFSR_WIDTH/2)
		)
		port map (
			CLKOUT0 => clkTxInner,
			CLKOUT1 => clkIO,
			CLKFBOUT => fb,
			LOCKED => PLLLockedInner,
			CLKIN1 => clk,
			PWRDWN => '0',
			RST => resetPLL,
			CLKFBIN => fb
		);

	cResetSyncerMain: entity work.resetSyncer(behavioral)
		port map (
			clk => clkTxInner,
			areset => reset,
			reset => resetInner
		);

	resetTx <= resetInner or not PLLLockedInner;
		
	cLFSRTx: entity work.lfsrVector(behavioral)
		generic map (
			WIDTH => LFSR_WIDTH,
			WIDTHS => LFSR_WIDTHS,
			FEEDS => LFSR_FEEDS,
			INIT_VALUES => LFSR_INIT_VALUES
		)
		port map (
			clk => clkTxInner,
			en => '1',
			reset => resetTx,
			outputs => dataTxInner
		);
	
	oSerDesInput(LFSR_WIDTH-1 downto 0) <= dataTxInner;
	
	cOSerDes: OSERDESE2
		generic map (
			DATA_RATE_OQ => "DDR",   -- DDR, SDR
			DATA_WIDTH => LFSR_WIDTH,         -- Parallel data width (2-8,10,14)
			INIT_OQ => '0',          -- Initial value of OQ output (1'b0,1'b1)
			SERDES_MODE => "MASTER", -- MASTER, SLAVE
			SRVAL_OQ => '0'         -- OQ output value when SR is used (1'b0,1'b1)
		)
		port map (
			OFB => open,             -- 1-bit output: Feedback path for data
			OQ => dataTx,               -- 1-bit output: Data path output
			-- SHIFTOUT1 / SHIFTOUT2: 1-bit (each) output: Data output expansion (1-bit each)
			SHIFTOUT1 => open,
			SHIFTOUT2 => open,
			TBYTEOUT => open,   -- 1-bit output: Byte group tristate
			TFB => open,             -- 1-bit output: 3-state control
			TQ => open,               -- 1-bit output: 3-state control
			CLK => clkIO,             -- 1-bit input: High speed clock
			CLKDIV => clkTxInner,       -- 1-bit input: Divided clock
			-- D1 - D8: 1-bit (each) input: Parallel data inputs (1-bit each)
			D1 => oSerDesInput(0),
			D2 => oSerDesInput(1),
			D3 => oSerDesInput(2),
			D4 => oSerDesInput(3),
			D5 => oSerDesInput(4),
			D6 => oSerDesInput(5),
			D7 => oSerDesInput(6),
			D8 => oSerDesInput(7),
			OCE => '1',             -- 1-bit input: Output data clock enable
			RST => resetTx,             -- 1-bit input: Reset
			-- SHIFTIN1 / SHIFTIN2: 1-bit (each) input: Data input expansion (1-bit each)
			SHIFTIN1 => '0',
			SHIFTIN2 => '0',
			-- T1 - T4: 1-bit (each) input: Parallel 3-state inputs
			T1 => '0',
			T2 => '0',
			T3 => '0',
			T4 => '0',
			TBYTEIN => '0',     -- 1-bit input: Byte group tristate
			TCE => '0'              -- 1-bit input: 3-state clock enable
		);

	clkTx <= clkTxInner;
	PLLLocked <= PLLLockedInner;

end architecture;

architecture ddr of transmitter is
	
	-- LFSR generator, 8 bit @ 67 MHz
	-- FIFO 16:2, 67 MHz -> 536 MHz
	-- DDR output @ 536 MHz
	-- output data rate 1072 Mb/s
	
	component transmitterIOPLL
		port (
			clkIn: in std_logic;
			clkIO: out std_logic;
			clk: out std_logic;
			reset: in std_logic;
			locked: out std_logic
		);
	end component;
	ATTRIBUTE SYN_BLACK_BOX: BOOLEAN;
	ATTRIBUTE SYN_BLACK_BOX OF transmitterIOPLL: COMPONENT IS TRUE;
	ATTRIBUTE BLACK_BOX_PAD_PIN: STRING;
	ATTRIBUTE BLACK_BOX_PAD_PIN OF transmitterIOPLL: COMPONENT IS "clkIn,clkIO,clk,reset,locked";
	
	COMPONENT transmitterFIFO
		PORT (
			wr_clk : IN STD_LOGIC;
			rd_clk : IN STD_LOGIC;
			din : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			wr_en : IN STD_LOGIC;
			rd_en : IN STD_LOGIC;
			dout : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			full : OUT STD_LOGIC;
			empty : OUT STD_LOGIC
		);
	END COMPONENT;

	signal PLLLockedInner, clkIO, clkTxInner: std_logic;
	signal resetInner: std_logic;
	signal data: std_logic_vector(15 downto 0);
	signal dataTxInner: std_logic_vector(1 downto 0);
	signal dataTxUnBuf, clkTxUnbuf: std_logic;
	signal FIFOWriteEnable, FIFOEmpty: std_logic;
	signal transmitting: std_logic := '0';
	signal transmittingDelayed: std_logic;
	
begin
	
	cPLL: transmitterIOPLL
		port map ( 
			clkIn => clk,
			clkIO => clkIO,
			clk => clkTxInner,
			reset => resetPLL,
			locked => PLLLockedInner            
		);
	
	cResetSyncerMain: entity work.resetSyncer(behavioral)
		port map (
			clk => clkTxInner,
			areset => reset,
			reset => resetInner
		);
	
	cLFSRTx: entity work.lfsrVector(behavioral)
		generic map (
			WIDTH => 16,
			WIDTHS => (4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4),
			FEEDS => (
				(4, 3),(4, 3),(4, 3),(4, 3),(4, 3),(4, 3),(4, 3),(4, 3),
				(4, 3),(4, 3),(4, 3),(4, 3),(4, 3),(4, 3),(4, 3),(4, 3)
			),
			INIT_VALUES => (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,1)
		)
		port map (
			clk => clkTxInner,
			en => PLLLockedInner,
			reset => resetInner,
			outputs => data
		);
	
	FIFOWriteEnable <= PLLLockedInner and not resetInner;
	
	cFIFO: transmitterFIFO
		port map (
			wr_clk => clkTxInner,
			rd_clk => clkIO,
			din => data,
			wr_en => FIFOWriteEnable,
			rd_en => transmittingDelayed,
			dout => dataTxInner,
			full => debug,
			empty => FIFOEmpty
		);
	
	-- to synchronize with frame clock (clkTxInner)
	pTransmitting: process (clkTxInner) is begin
		if rising_edge(clkTxInner) then
			if resetInner = '1' then
				transmitting <= '0';
			else
				if PLLLockedInner = '1' then
					transmitting <= transmitting or not FIFOEmpty;
				end if;
			end if;
		end if;
	end process;
	
	cTransmittingDelay: entity work.delay(Behavioral)
		generic map (
			WIDTH => 1,
			DELAY => 5
		)
		port map (
			clk => clkIO,
			dataIn(0) => transmitting,
			dataOut(0) => transmittingDelayed
		);
	
    cODDRE1Data : ODDRE1
           generic map (
              IS_C_INVERTED => '0',  -- Optional inversion for C
              IS_D1_INVERTED => '0', -- Optional inversion for D1
              IS_D2_INVERTED => '0', -- Optional inversion for D2
              SRVAL => '0'           -- Initializes the ODDRE1 Flip-Flops to the specified value ('0', '1')
           )
           port map (
              Q => dataTxUnBuf,     -- 1-bit output: Data output to IOB
              C => clkIO,           -- 1-bit input: High-speed clock input
              D1 => dataTxInner(1), -- 1-bit input: Parallel data input 1
              D2 => dataTxInner(0), -- 1-bit input: Parallel data input 2
              SR => '0'  -- 1-bit input: Active High Async Reset
           );

    cODDRE1Clk : ODDRE1
           generic map (
              IS_C_INVERTED => '0',  -- Optional inversion for C
              IS_D1_INVERTED => '0', -- Optional inversion for D1
              IS_D2_INVERTED => '0', -- Optional inversion for D2
              SRVAL => '0'           -- Initializes the ODDRE1 Flip-Flops to the specified value ('0', '1')
           )
           port map (
              Q => clkTxUnbuf,     -- 1-bit output: Data output to IOB
              C => clkTxInner,           -- 1-bit input: High-speed clock input
              D1 => '1', -- 1-bit input: Parallel data input 1
              D2 => '0', -- 1-bit input: Parallel data input 2
              SR => '0'  -- 1-bit input: Active High Async Reset
           );
	
	cOBUFData: OBUF
		generic map (
			IOSTANDARD => "LVCMOS25"
		)
		port map (
			I => dataTxUnBuf,
			O => dataTx
		);
	
	cOBUFClk: OBUF
		generic map (
			IOSTANDARD => "LVCMOS25"
		)
		port map (
			I => clkTxUnbuf,
			O => clkTx
		);
	
	PLLLocked <= PLLLockedInner;
	
end architecture ddr;