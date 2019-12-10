library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

use work.test_pkg.all;

entity receiver is
	generic (
		CLK_FREQ: integer := 200e6; -- input clk frequency, in Hz
		-- output clk parameters
		MULT: integer := 4;
		DIV: integer:= 4;
		-- other parameters
		ERR_WIDTH: integer := 32
	);
	port (
		clk: in std_logic;
		reset: in std_logic;
		resetPLL: in std_logic;
		clkRx: in std_logic;
		dataRx: in std_logic;
		PLLLocked: out std_logic;
		IOPLLLocked: out std_logic;
		errorSlowToggle: out std_logic;
		startSlowToggle: out std_logic;
		running: out std_logic;
		delay: in unsigned(3 downto 0);
		debug: out std_logic_vector(2 downto 0);
		test: in std_logic_vector(1 downto 0);
		errorCount: out unsigned(ERR_WIDTH - 1 downto 0);
        startCount: out unsigned(ERR_WIDTH - 1 downto 0)
	);
end entity;

architecture ddr of receiver is
	
	-- input data rate 1072 Mb/s
	-- DDR input @ 536 MHz
	-- FIFO 2:16, 536 MHz -> 67 MHz
	-- LFSR pattern generator, 8 bit @ 67 MHz
	
	ATTRIBUTE SYN_BLACK_BOX: BOOLEAN;
	ATTRIBUTE BLACK_BOX_PAD_PIN: STRING;

	component receiverIOPLL
		port (
			clkIn           : in     std_logic;
			clkIO          : out    std_logic;
			clkRxInner: out std_logic;
			reset             : in     std_logic;
			locked            : out    std_logic
		);
	end component;
	ATTRIBUTE SYN_BLACK_BOX OF receiverIOPLL: COMPONENT IS TRUE;
	ATTRIBUTE BLACK_BOX_PAD_PIN OF receiverIOPLL: COMPONENT IS "clkIn,clkIO,reset,locked";

	COMPONENT receiverInputDDR
		PORT (
			data_in_from_pins : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
			clk_in : IN STD_LOGIC;
			io_reset : IN STD_LOGIC;
			data_in_to_device : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
		);
	END COMPONENT;
	
	component receiverPLL
		port (
			clkIn           : in     std_logic;
			clkSlow          : out    std_logic;
			reset             : in     std_logic;
			locked            : out    std_logic
		);
	end component;
	ATTRIBUTE SYN_BLACK_BOX OF receiverPLL: COMPONENT IS TRUE;
	ATTRIBUTE BLACK_BOX_PAD_PIN OF receiverPLL: COMPONENT IS "clkIn,clkSlow,reset,locked";
	
	COMPONENT receiverFIFO
		PORT (
			wr_clk : IN STD_LOGIC;
			rd_clk : IN STD_LOGIC;
			din : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			wr_en : IN STD_LOGIC;
			rd_en : IN STD_LOGIC;
			dout : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			full : OUT STD_LOGIC;
			empty : OUT STD_LOGIC
		);
	END COMPONENT;
	
	type STATE_TYPE is (OU1, OU2, OU3);
	signal outputState: STATE_TYPE := OU1;

	signal resetPLLIO: std_logic;
	signal PLLLockedInner: std_logic;
	signal IOPLLLockedInner, IOPLLLockedInnerDelayed, IOPLLLockedInnerPulseN: std_logic;
	signal dataRxInner: std_logic_vector(1 downto 0);
	signal clkIO, clkRxInner, clkSlow, resetInner, LFSRReset: std_logic;
	signal inputSR: std_logic_vector(15 downto 0) := (others => '0');
	signal data, dataDelayed, localPattern, localPatternDelayed: std_logic_vector(15 downto 0);
	signal start, detection, runningInner: std_logic;
	signal report1, report2: unsigned(ERR_WIDTH-1 downto 0);
	signal scope, scopeLocal: unsigned(31 downto 0);
	signal error, messageEnd: std_logic;
	
begin
	
--	resetPLLIO <= resetPLL or IOPLLLockedInnerPulseN;

--	cPLLIO: receiverIOPLL
--		port map ( 
--			clkIn => clkRx,
--			clkIO => clkIO,
--			clkRxInner => clkRxInner,
--			reset => resetPLLIO,
--			locked => IOPLLLockedInner
--		);
	
--	-- for clock domain synchronization
--	-- clkRx -> clk
--	cDelayIOPLLLockedReset: entity work.delay(Behavioral)
--		generic map (
--			WIDTH => 1,
--			DELAY => 3
--		)
--		port map (
--			clk => clk,
--			dataIn(0) => IOPLLLockedInner,
--			dataOut(0) => IOPLLLockedInnerDelayed
--		);
	
--	cIOResetEdgeDetector: entity work.edgeDetector(falling)
--		port map (
--			clk => clk,
--			signalIn => IOPLLLockedInnerDelayed,
--			edge => IOPLLLockedInnerPulseN
--		);
	
	
--	 cIDDRE1 : IDDRE1
--          generic map (
--             DDR_CLK_EDGE => "OPPOSITE_EDGE", -- IDDRE1 mode (OPPOSITE_EDGE, SAME_EDGE, SAME_EDGE_PIPELINED)
--             IS_CB_INVERTED => '0',           -- Optional inversion for CB
--             IS_C_INVERTED => '0'             -- Optional inversion for C
--          )
--          port map (
--             Q1 => dataRxInner(0), -- 1-bit output: Registered parallel output 1
--             Q2 => dataRxInner(1), -- 1-bit output: Registered parallel output 2
--             C => clkIO,           -- 1-bit input: High-speed clock
--             CB => '0', -- 1-bit input: Inversion of High-speed clock C
--             D => dataRx,   -- 1-bit input: Serial Data Input
--             R => '0'    -- 1-bit input: Active High Async Reset
--          );
	
-- ==========================================================
-- Original IDDR was IP core
--===========================================================	
--	cDDR: receiverInputDDR
--		port map (
--			data_in_from_pins(0) => dataRx,
--			clk_in => clkIO,
--			io_reset => '0',
--			data_in_to_device => dataRxInner
--		);
	
--	pInputSR: process (clkIO) is begin
--		if rising_edge(clkIO) then
--			inputSR(1 downto 0) <= dataRxInner(0)&dataRxInner(1);
--			for i in 1 to 7 loop
--				inputSR(2*i+1 downto 2*i) <= inputSR(2*i-1 downto 2*i-2);
--			end loop;
--		end if;
--	end process;

--	cPLL: receiverPLL
--		port map ( 
--			clkIn => clk,
--			clkSlow => clkSlow,
--			reset => resetPLL,
--			locked => PLLLockedInner
--		);
	
--	cResetSyncerMain: entity work.resetSyncer(behavioral)
--		port map (
--			clk => clkSlow,
--			areset => reset,
--			reset => resetInner
--		);
	
--	cFIFO: receiverFIFO
--		PORT MAP (
--			wr_clk => clkRxInner,
--			rd_clk => clkSlow,
--			din => inputSR,
--			wr_en => IOPLLLockedInner,
--			rd_en => PLLLockedInner,
--			dout => data,
--			full => open,
--			empty => open
--		);
	
	cDetector: entity work.detector(behavioral)
		port map (
			clk => clkSlow,
			enable => PLLLockedInner,
			data => data(0),
			detection => detection
		);
	
	start <= detection and not runningInner and PLLLockedInner;
	LFSRReset <= start or resetInner;
	
	cLFSRRx: entity work.lfsrVector(behavioral)
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
			clk => clkSlow,
			en => PLLLockedInner,
			reset => LFSRReset,
			outputs => localPattern
		);

--	cPatternDelay: entity work.delay(Behavioral)
--		generic map (
--			WIDTH => 16,
--			DELAY => 8
--		)
--		port map (
--			clk => clkSlow,
--			dataIn => localPattern,
--			dataOut => localPatternDelayed
--		);
	
--	cDataDelay: entity work.delayS(Behavioral)
--		generic map (
--			WIDTH => 16,
--			SWIDTH => 4
--		)
--		port map (
--			clk => clkSlow,
--			dataIn => data,
--			delaySelect => delay,
--			dataOut => dataDelayed
--		);
	
	debug <=
		dataRx        &localPatternDelayed(0)&dataDelayed(0) when test = "00" else
		dataRxInner(0)&localPatternDelayed(1)&dataDelayed(1) when test = "01" else
		data(0)       &localPatternDelayed(2)&dataDelayed(2);
	
	cChecker: entity work.checker(behavioral)
		generic map (
			WIDTH => ERR_WIDTH
		)
		port map (
			clk => clkSlow,
			reset => resetInner,
			start => start,
			pattern => localPatternDelayed,
			data => dataDelayed,
			error => error,
			errorCount => errorCount,
			startCount => startCount,
			running => runningInner
		);
	
--	pScopes: process (clkSlow) is begin
--		if rising_edge(clkSlow) then
--			scope(15 downto 0) <= unsigned(dataDelayed);
--			scope(31 downto 16) <= scope(15 downto 0);
--			scopeLocal(15 downto 0) <= unsigned(localPatternDelayed);
--			scopeLocal(31 downto 16) <= scopeLocal(15 downto 0);
--		end if;
--	end process;
	
--	cSlowToggle: entity work.slowToggle(behavioral)
--		generic map (
--			WIDTH => 2,
--			TICKS => (280e6/8)/10 -- 1/10 s = 100 ms
--		)
--		port map (
--			clk => clkSlow,
--			reset => resetInner,
--			test => test(0),
--			signalIn(0) => error,
--			signalIn(1) => start,
--			signalOut(0) => errorSlowToggle,
--			signalOut(1) => startSlowToggle
--		);
	
	running <= runningInner;
	PLLLocked <= PLLLockedInner;
	IOPLLLocked <= IOPLLLockedInner;

end architecture;