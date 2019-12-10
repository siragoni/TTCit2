library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity delayS is
	generic (
		WIDTH: integer := 1;
		SWIDTH: integer := 5
	);
	port (
		clk: in std_logic;
		dataIn: in std_logic_vector(WIDTH-1 downto 0);
		delaySelect: in unsigned(SWIDTH-1 downto 0);
		dataOut: out std_logic_vector(WIDTH-1 downto 0)
	);
end delayS;

architecture Behavioral of delayS is

	constant MAX_DELAY: integer := (2**SWIDTH)-1;

	signal delayLine: std_logic_vector((WIDTH*(MAX_DELAY+1))-1 downto WIDTH-1) := (others => '0');

begin

	gDelay: if MAX_DELAY > 0 generate
		pDelay: process (clk) begin
			if rising_edge(clk) then
				for i in 1 to MAX_DELAY loop
					if i = 1 then
						delayLine((WIDTH*(i+1))-1 downto WIDTH*i) <= dataIn;
					else
						delayLine((WIDTH*(i+1))-1 downto WIDTH*i) <= delayLine((WIDTH*i)-1 downto WIDTH*(i-1));
					end if;
				end loop;
			end if;
		end process pDelay;
	end generate gDelay;

	pOutput: process (delayLine, delaySelect, dataIn) is
		variable i: integer;
	begin
		i := to_integer(delaySelect);
		if i = 0 then
			dataOut <= dataIn;
		else
			dataOut <= delayLine((WIDTH*(i+1))-1 downto WIDTH*i);
		end if;
	end process;

end Behavioral;

architecture notWorking of delayS is

	constant MAX_DELAY: integer := (2**SWIDTH)-1;

	signal delayLine: std_logic_vector((WIDTH*(MAX_DELAY+1))-1 downto 0);

begin

	delayLine(WIDTH-1 downto 0) <= dataIn;
	
	gDelay: if MAX_DELAY > 0 generate
		pDelay: process (clk) begin
			if rising_edge(clk) then
				for i in 1 to MAX_DELAY loop
					delayLine((WIDTH*(i+1))-1 downto WIDTH*i) <= delayLine((WIDTH*i)-1 downto WIDTH*(i-1));
				end loop;
			end if;
		end process pDelay;
	end generate gDelay;

	pOutput: process (delayLine, delaySelect) is
		variable i: integer;
	begin
		i := to_integer(delaySelect);
		dataOut <= delayLine((WIDTH*(i+1))-1 downto WIDTH*i);
	end process;

end notWorking;
