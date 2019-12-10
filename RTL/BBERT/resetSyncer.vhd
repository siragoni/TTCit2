library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity resetSyncer is
	generic (
		LENGTH: integer := 3
	);
	port (
		clk: in std_logic;
		areset: in std_logic;
		reset: out std_logic
	);
end entity resetSyncer;

architecture behavioral of resetSyncer is

	signal sReg: std_logic_vector(LENGTH-1 downto 0) := (others => '1');

begin

	pSyncer: process (clk, areset) begin
		if areset = '1' then
			sReg <= (others => '1');
		elsif rising_edge(clk) then
			sReg <= sReg(LENGTH-2 downto 0)&'0';
		end if;
	end process pSyncer;
	
	reset <= sReg(LENGTH-1);

end architecture behavioral;
