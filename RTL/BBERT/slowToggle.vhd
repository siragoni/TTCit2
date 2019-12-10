--
-- SlowToggle - slowly toggling signal(s)
-- v.2
-- by Jan Pospisil, j.pospisil@cern.ch, 2015
--
-- based on code
--   LED display driver - a parametrized function
--   by P. Jovanovic, 7.12.2005
--
-- Used mainly for visual LED indication of signal activity
-- Usage:
--   - generics:
--     WIDTH: number of signals (inputs/outputs)
--     TICKS: number of clk period in one period of output change
--            (f=50MHz, T=20ns, desired output period t=100ms =>
--             TICKS=t/T=100ms/20ns=5000000)
--   - ports:
--     'clk' - main clock
--     'reset' - synchronous reset
--     'test' - when asserted, all outputs are toggling
--     'signalIn' - input for observed signals
--     'signalOut' - output
--           - when there were any transition on input signal in last time t (last
--             TICKS period of 'clk') the output is toggling
--           - when there weren't any transition, output is the same as input (thus
--             signalling actual state of input)
--


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity slowToggle is
	generic (
		WIDTH: in positive := 8;
		TICKS: in positive := 256 -- output pulse width
	);
	port (
		clk: in std_logic;
		reset: in std_logic;
		test: in std_logic;
		signalIn: in std_logic_vector(WIDTH-1 downto 0);
		signalOut: out std_logic_vector(WIDTH-1 downto 0)
	);
end entity slowToggle;

architecture behavioral of slowToggle is

	-- http://stackoverflow.com/a/12751341/615627
	function f_log2(x: positive) return natural is
		variable i: natural;
	begin
		i := 0;
		while (2**i < x) loop
			i := i + 1;
		end loop;
		return i;
	end function;	

	signal counter: std_logic_vector(f_log2(TICKS)-1 downto 0) := (others => '0');
	signal signalInDelayed: std_logic_vector(WIDTH-1 downto 0) := (others => '0');
	signal edges, testVector: std_logic_vector(WIDTH-1 downto 0) := (others => '0');
	signal edgeReset: std_logic := '0';
	signal signalOutInner: std_logic_vector(WIDTH-1 downto 0) := (others => '0');
	signal changeOutput: std_logic := '0';

begin

	edgeReset <= changeOutput or reset;
	testVector <= (others => test);

	pDelay: process (clk) is begin
		if rising_edge(clk) then
			signalInDelayed <= signalIn;
		end if;
	end process pDelay;

	pEdgeAccumulator: process (clk) is begin
		if rising_edge(clk) then
			if edgeReset = '1' then
				edges <= (others => '0');
			else
				edges <= edges or (signalIn xor signalInDelayed); -- latch positive or negative edges
			end if;
		end if;
	end process pEdgeAccumulator;

	pCounter: process (clk) is begin
		if rising_edge(clk) then
			if reset = '1' then
				counter <= (others => '0');
				changeOutput <= '0';
			else
				counter <= counter + 1;
				changeOutput <= '0';
				if counter = std_logic_vector(to_unsigned(TICKS-1, counter'length)) then
					changeOutput <= '1';
					counter <= (others => '0');
				end if;
			end if;
		end if;
	end process pCounter;

	pSignalOut: process (clk) is begin
		if rising_edge(clk) then
			if reset = '1' then
				signalOutInner <= (others => '0');
			elsif changeOutput = '1' then
				-- toggle if edge was present or test is asserted
				-- otherwise sample signal
				signalOutInner <= 
	                ((edges or testVector) and not signalOutInner)
	                or
					(not (edges or testVector) and  signalIn);
			end if;
		end if;
	end process pSignalOut;

	signalOut <= signalOutInner;

end architecture behavioral;