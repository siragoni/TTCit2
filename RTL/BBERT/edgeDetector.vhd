library ieee;
use ieee.std_logic_1164.all;

entity edgeDetector is
	port (
		clk: in std_logic;
		signalIn: in std_logic;
		edge: out std_logic
	);
end edgeDetector;

architecture rising of edgeDetector is

	signal history: std_logic := '0';

begin
	
	pDelay: process (clk) is begin
		if rising_edge(clk) then
			history <= signalIn;
		end if;
	end process;
	
	edge <= signalIn and not history;

end rising;

architecture falling of edgeDetector is
	
	signal history: std_logic := '0';
	
begin
	
	pDelay: process (clk) is begin
		if rising_edge(clk) then
			history <= signalIn;
		end if;
	end process;
	
	edge <= not signalIn and history;
	
end falling;