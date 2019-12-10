library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.test_pkg.all;

entity checker is
	generic (
		WIDTH: integer := 32
	);
	port (
		clk: in std_logic;
		reset: in std_logic;
		start: in std_logic;
		pattern: in std_logic_vector(15 downto 0);
		data: in std_logic_vector(15 downto 0);
		error: out std_logic;
		errorCount: out unsigned(WIDTH-1 downto 0);
		startCount: out unsigned(WIDTH-1 downto 0);
		running: out std_logic
	);
end checker;

architecture behavioral of checker is

	signal startDelay, startPulse: std_logic;
	signal errorInner: std_logic;
	signal runningInner: std_logic := '0';

begin

	pStart: process (clk) is begin
		if rising_edge(clk) then
			startDelay <= start;
		end if;
	end process;
	
	startPulse <= startDelay and not start;

	pRunning: process (clk) is begin
		if rising_edge(clk) then
			if reset = '1' then
				runningInner <= '0';
			else
				runningInner <= runningInner or startPulse;
			end if;
		end if;
	end process;
	
	pCheck: process (data, pattern, runningInner) is begin
		if runningInner = '1' and data /= pattern then
			errorInner <= '1';
		else
			errorInner <= '0';
		end if;
	end process;

	cCounterErrors: entity work.counterO(width)
		generic map (
			WIDTH => WIDTH
		)
		port map (
			clk => clk,
			reset => reset,
			enable => errorInner,
			overflow => open,
			value => errorCount
		);

	cCounterStarts: entity work.counterO(width)
		generic map (
			WIDTH => WIDTH
		)
		port map (
			clk => clk,
			reset => reset,
			enable => startPulse,
			overflow => open,
			value => startCount
		);

	error <= errorInner;
	running <= runningInner;

end behavioral;
