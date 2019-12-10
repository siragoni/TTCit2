library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity detector is
	port (
		clk: in std_logic;
		enable: in std_logic;
		data: in std_logic;
		detection: out std_logic
	);
end entity;

architecture behavioral of detector is

	constant LENGTH: integer := 4;
	signal history: std_logic_vector(LENGTH-1 downto 0) := (others => '0');

begin

	pHistory: process (clk) is begin
		if rising_edge(clk) then
			if enable = '1' then
				history <= history(LENGTH-2 downto 0)&data;
			end if;
		end if;
	end process;
	
	detection <=
		'1' when history = "0111" else
		'0';

end architecture;