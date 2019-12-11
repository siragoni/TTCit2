library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

use work.ttc_codec_pkg.all;

entity ttc_fmc_wrapper is
port (
--== ttc fmc interface ==--
 cdrclk_in     : in  std_logic;     -- ADN2812 CDR 160MHz clock output
 cdrdata_in    : in  std_logic;     -- ADN2812 CDR Serial Data output
 ttc_los       : in  std_logic;     -- ADN2812 CDR Loss Of Sync flag. Active high.
 ttc_lol       : in  std_logic;     -- ADN2812 CDR Loss Of Sync flag. Active high.
 div_nrst      : out std_logic;     -- clock divider sy89872 async reset control, used to align the phase of 40mhz clock divider output relative to the input stream
 info_o        : out ttc_info_type;  
 stat_o        : out ttc_stat_type;
 
 --== auxiliary outputs ===-- 
 ready         : out std_logic;    
 ttc_clk_gated : out std_logic     -- gated 40MHz clock, for comparison only
);
end ttc_fmc_wrapper;



architecture top of ttc_fmc_wrapper is

 signal cdrbad     : std_logic; 
 signal info       : ttc_info_type;  
 signal stat       : ttc_stat_type;

begin  

cdrbad     <= ttc_lol or ttc_los;

--=====================================--
dec: entity work.ttc_decoder
--=====================================--
port map 
(
  rst_i                  => not cdrbad,
  clk160_i               => cdrclk_in,  
  data_i                 => cdrdata_in, 
  info_o                 => info,  
  stat_o                 => stat
);
--=====================================--

--=====================================--
-- IO mapping
--=====================================--
div_nrst      <= stat.div_nrst;
ready         <= stat.ready;
ttc_clk_gated <= info.clk40_gated;

stat_o        <= stat;
info_o        <= info;
--=====================================--

end architecture;
