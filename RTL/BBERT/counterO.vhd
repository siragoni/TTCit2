--
-- counter with overflow
-- Jan Pospisil
--   2010; KP, FEL, CVUT
--   2015; CTP, ALICE, CERN
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counterO is
	generic (
		WIDTH: natural := 32
	);
	port (
		clk: in std_logic;
		reset: in std_logic;
			-- synchronous reset
		enable: in std_logic;
			-- counts
		overflow: out std_logic := '0';
			-- '1' for 1 T_CLK when overflowed
		value: out unsigned
	);
end entity counterO;

architecture width of counterO is

	signal valueInner: unsigned(WIDTH-1 downto 0) := (others => '0');
	
begin

	pCounter: process (clk) is
		variable newValue: unsigned(WIDTH-1 downto 0) := (others => '0');
	begin
		if rising_edge(clk) then
			if reset = '1' then
				newValue := (others => '0');
				overflow <= '0';
			else
				overflow <= '0';
				if enable = '1' then
					newValue := valueInner + 1;
					if to_integer(newValue) = 0 then
						overflow <= '1';
					end if;
				end if;
			end if;
			valueInner <= newValue;
		end if;
	end process pCounter;

	value <= valueInner;

end architecture width;