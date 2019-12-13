#--------------------------------------------+
#--------------------------------------------+
#     Pinout for FMC TTC card                +
#                                            +
#--------------------------------------------+
#--------------------------------------------+

#-- 160 Mhz clock from ADN2812 CDR
set_property PACKAGE_PIN H12 [get_ports FMC_HPC_CLK0_M2C_P]
set_property IOSTANDARD LVDS [get_ports FMC_HPC_CLK0_M2C_P]
set_property IOSTANDARD LVDS [get_ports FMC_HPC_CLK0_M2C_N]
set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_CLK0_M2C_P]
##set_property ODT RTT_NONE [get_ports FMC_HPC_CLK0_M2C_P]

#-- 40 Mhz clock from ADN2812 CDR
set_property PACKAGE_PIN E25 [get_ports FMC_HPC_CLK1_M2C_P]
set_property IOSTANDARD LVDS [get_ports FMC_HPC_CLK1_M2C_P]
set_property IOSTANDARD LVDS [get_ports FMC_HPC_CLK1_M2C_N]
set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_CLK1_M2C_P]
##set_property ODT RTT_NONE [get_ports FMC_HPC_CLK1_M2C_P]

#-- data from ADN2812 CDR 
set_property PACKAGE_PIN J9 [get_ports FMC_HPC_LA09_P]
set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA09_P]
set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA09_N]
set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_LA09_P]
##set_property ODT RTT_NONE [get_ports FMC_HPC_LA09_P]

#-- clock divider sy89872 async reset control, used to align the phase of 40mhz clock divider output relative to the input stream 
set_property PACKAGE_PIN L8      [get_ports FMC_HPC_LA10_P]
set_property IOSTANDARD LVCMOS18 [get_ports FMC_HPC_LA10_P]

#-- clock out to FMT TTC card - not used  
#set_property PACKAGE_PIN K8      [get_ports FMC_HPC_LA10_N]
#set_property IOSTANDARD LVCMOS18 [get_ports FMC_HPC_LA10_N]

#-- LOL signal from ADN2812 CDR
set_property PACKAGE_PIN J8      [get_ports FMC_HPC_LA08_P]
set_property IOSTANDARD LVCMOS18 [get_ports FMC_HPC_LA08_P]

#-- LOS signal from ADN2812 CDR 
set_property PACKAGE_PIN H8      [get_ports FMC_HPC_LA08_N]
set_property IOSTANDARD LVCMOS18 [get_ports FMC_HPC_LA08_N]

#-- User LED on FMC TTC card
set_property PACKAGE_PIN K13     [get_ports FMC_HPC_LA05_N]
set_property IOSTANDARD LVCMOS18 [get_ports FMC_HPC_LA05_N]

#-- enable for 160 MHz clock
set_property PACKAGE_PIN G9      [get_ports FMC_HPC_LA01_CC_P]
set_property IOSTANDARD LVCMOS18 [get_ports FMC_HPC_LA01_CC_P]