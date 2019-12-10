library ieee;
use ieee.std_logic_1164.all;

entity delay is
	generic (
		WIDTH: integer := 1;
		DELAY: integer := 5
	);
	port (
		clk: in std_logic;
		dataIn: in std_logic_vector(WIDTH-1 downto 0);
		dataOut: out std_logic_vector(WIDTH-1 downto 0)
	);
end delay;

architecture Behavioral of delay is

	signal delayLine: std_logic_vector((WIDTH*(DELAY+1))-1 downto WIDTH-1) := (others => '0');

begin

--	delayLine(WIDTH-1 downto 0) <= dataIn;
	
	gDelay: if DELAY > 0 generate
		pDelay: process (clk) begin
			if rising_edge(clk) then
				for i in 1 to DELAY loop
					if i = 1 then
						delayLine((WIDTH*(i+1))-1 downto WIDTH*i) <= dataIn;
					else
						delayLine((WIDTH*(i+1))-1 downto WIDTH*i) <= delayLine((WIDTH*i)-1 downto WIDTH*(i-1));
					end if;
				end loop;
			end if;
		end process pDelay;
	end generate gDelay;

	gOutputDelay: if DELAY > 0 generate
		dataOut <= delayLine((WIDTH*(DELAY+1))-1 downto WIDTH*DELAY);
	end generate;
	
	gOutputNoDelay: if DELAY = 0 generate
		dataOut <= dataIn;
	end generate;

end Behavioral;

architecture notWorking of delay is

	signal delayLine: std_logic_vector((WIDTH*(DELAY+1))-1 downto 0);

begin

	delayLine(WIDTH-1 downto 0) <= dataIn;
	
	gDelay: if DELAY > 0 generate
		pDelay: process (clk) begin
			if rising_edge(clk) then
				for i in 1 to DELAY loop
					delayLine((WIDTH*(i+1))-1 downto WIDTH*i) <= delayLine((WIDTH*i)-1 downto WIDTH*(i-1));
				end loop;
			end if;
		end process pDelay;
	end generate gDelay;

	dataOut <= delayLine((WIDTH*(DELAY+1))-1 downto WIDTH*DELAY);

end notWorking;
