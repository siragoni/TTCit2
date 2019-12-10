library ieee;
use ieee.std_logic_1164.all;

package test_pkg is

	type INTEGER_ARRAY_TYPE is array (natural range <>) of integer;
	type INTEGER_ARRAY_ARRAY_TYPE is array (natural range<>) of INTEGER_ARRAY_TYPE;
	type SLV_ARRAY_TYPE is array (natural range <>) of std_logic_vector;

	constant LFSR_WIDTH: natural := 4;
	constant LFSR_WIDTHS: INTEGER_ARRAY_TYPE := (
		4,
		4,
		4,
		4
	);
	constant LFSR_FEEDS: INTEGER_ARRAY_ARRAY_TYPE := (
		(4, 3),
		(4, 3),
		(4, 3),
		(4, 3)
	);
	constant LFSR_INIT_VALUES: INTEGER_ARRAY_TYPE := (
		1,
		2,
		3,
		4
	);

end test_pkg;

package body test_pkg is

end package body test_pkg;
