library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

use work.test_pkg.all;

entity lfsrVector is
	generic (
		WIDTH: natural;
		WIDTHS: INTEGER_ARRAY_TYPE;
		FEEDS: INTEGER_ARRAY_ARRAY_TYPE;
		INIT_VALUES: INTEGER_ARRAY_TYPE
	);
	port (
		clk: in std_logic;
		en: in std_logic;
		reset: in std_logic;
		outputs: out std_logic_vector(WIDTH-1 downto 0)
	);
end entity;

architecture behavioral of lfsrVector is

begin

	gLFSR: for i in 0 to WIDTH-1 generate
		cLFSRTx: entity work.lfsr(behavioral)
			generic map (
				WIDTH => WIDTHS(i),
				FEEDS => FEEDS(i),
				INIT_VALUE => INIT_VALUES(i)
			)
			port map (
				clk => clk,
				en => en,
				reset => reset,
				output => outputs(i),
				value => open
			);
	end generate;

end architecture behavioral;		
