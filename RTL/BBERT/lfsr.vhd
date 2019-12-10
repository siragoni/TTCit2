library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

use work.test_pkg.all;

entity lfsr is
	generic (
		WIDTH: natural;
		FEEDS: INTEGER_ARRAY_TYPE;
		INIT_VALUE: integer
	);
	port (
		clk: in std_logic;
		en: in std_logic;
		reset: in std_logic;
		output: out std_logic;
		value: out std_logic_vector(WIDTH-1 downto 0)
	);
end entity;

architecture behavioral of lfsr is

	signal data: std_logic_vector(WIDTH-1 downto 0) := conv_std_logic_vector(INIT_VALUE, WIDTH);

begin

	pShift: process (clk) is
		variable tmp: std_logic;
	begin
		if rising_edge(clk) then
			if reset = '1' then
				data <= conv_std_logic_vector(INIT_VALUE, WIDTH);
			else
				if en = '1' then
					data(WIDTH-1 downto 1) <= data(WIDTH-2 downto 0);
					tmp := '0';
					for i in FEEDS'range loop
						tmp := tmp xor data(FEEDS(i)-1);
					end loop;
					data(0) <= tmp; 
				end if;
			end if;
		end if;
	end process pShift;

	output <= data(WIDTH-1);
	value <= data;

end architecture behavioral;		
		