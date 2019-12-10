##==========================================
##== Master SPI configutarion mode
##==========================================
set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES [current_design]
set_property CONFIG_VOLTAGE 1.8 [current_design]
set_property CFGBVS GND [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
set_property BITSTREAM.CONFIG.UNUSEDPIN PULLNONE [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 3 [current_design]
set_property BITSTREAM.CONFIG.PERSIST NO [current_design]
set_property BITSTREAM.STARTUP.MATCH_CYCLE AUTO [current_design]
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]

##=========================================
##==  STARTUPE3 constraints + SPI 0 constraints
##=========================================
# Define a SCK Clock for the SPI_Flash_0. Following command creates a divide by 2 clock.
# It also takes into account the delay added by STARTUP block to route the CCLK
create_generated_clock -name clk_spi_flash_0 -source [get_pins -hierarchical *spi_flash_0/ipbus_clk] -divide_by 2 [get_pins */spi_flash_0/spi_clk_reg/Q]

create_generated_clock -name clk_sck -source [get_pins -hierarchical *spi_flash_0/ipbus_clk] -edges {3 5 7} -edge_shift {6.700 6.700 6.700} [get_pins -hierarchical *USRCCLKO]
set_multicycle_path -setup -from clk_sck -to [get_clocks -of_objects [get_pins -hierarchical *spi_flash_0/ipbus_clk]] 2
set_multicycle_path -hold -end -from clk_sck -to [get_clocks -of_objects [get_pins -hierarchical *spi_flash_0/ipbus_clk]] 1
set_multicycle_path -setup -start -from [get_clocks -of_objects [get_pins -hierarchical *spi_flash_0/ipbus_clk]] -to clk_sck 2
set_multicycle_path -hold -from [get_clocks -of_objects [get_pins -hierarchical *spi_flash_0/ipbus_clk]] -to clk_sck 1

#### Max delay constraints are used to instruct the tool to place IP near to STARTUPE3 primitive.
#### If needed adjust the delays appropriately
set_max_delay -datapath_only -from [get_pins -hier {*STARTUPE3_inst/DI[1]}] 1.000
set_max_delay -datapath_only -from [get_pins ipb_slaves/spi_flash_0/spi_engine/mosi_reg/C] -to [get_pins -hier {*STARTUPE3_inst/DO[0]}] 1.000
set_max_delay -datapath_only -from [get_pins ipb_slaves/spi_flash_0/gen_clock/ClockF_reg/C] -to [get_pins -hier *STARTUPE3_inst/USRCCLKO] 1.000

##=========================================
##==  SPI 1 constraints
##=========================================
create_generated_clock -name clk_spi_flash_1 -source [get_pins -hierarchical *spi_flash_1/ipbus_clk] -divide_by 2 [get_pins */spi_flash_1/spi_clk_reg/Q]
set_multicycle_path -setup -start -from [get_pins -hierarchical -filter {NAME =~*spi_flash_1/spi_control/reg_reg[*][*]/C}] 2
set_multicycle_path -hold -start -from [get_pins -hierarchical -filter {NAME =~*spi_flash_1/spi_control/reg_reg[*][*]/C}] 1


## ==========================================
## ==   IP bus                             ==
## ==========================================
## --     B A N K  227
set_property PACKAGE_PIN M5 [get_ports SI5345_I_OUT0_N]
set_property PACKAGE_PIN M6 [get_ports SI5345_I_OUT0_P]
set_property PACKAGE_PIN F1 [get_ports SFP_RX_N]
set_property PACKAGE_PIN G3 [get_ports SFP_TX_N]
set_property PACKAGE_PIN G4 [get_ports SFP_TX_P]
set_property PACKAGE_PIN F2 [get_ports SFP_RX_P]
## --     B A N K  66
set_property PACKAGE_PIN G10 [get_ports SI5345_I_OUT1_P]
set_property IOSTANDARD LVDS [get_ports SI5345_I_OUT1_P]
#set_property DIFF_TERM_ADV TERM_100 [get_ports SI5345_I_OUT1_P]
##set_property ODT RTT_NONE [get_ports SI5345_I_OUT1_P]
## --     B A N K  48
## set false path !!!
set_property IOSTANDARD LVCMOS18 [get_ports {sn[*]}]
set_property PACKAGE_PIN AD28 [get_ports {sn[0]}]
set_property PACKAGE_PIN AF29 [get_ports {sn[1]}]
set_property PACKAGE_PIN AG29 [get_ports {sn[2]}]
set_property PACKAGE_PIN AD29 [get_ports {sn[3]}]
set_property PACKAGE_PIN AE30 [get_ports {sn[4]}]
set_property PACKAGE_PIN AF30 [get_ports {sn[5]}]
set_property PACKAGE_PIN AG30 [get_ports {sn[6]}]
set_property PACKAGE_PIN AG31 [get_ports {sn[7]}]
## --     B A N K  64
## set false path for all LEDs !!!
set_property PACKAGE_PIN AF12 [get_ports LED_11]
set_property IOSTANDARD LVCMOS33 [get_ports LED_11]
set_property SLEW SLOW [get_ports LED_11]
set_property PACKAGE_PIN AD11 [get_ports LED_12]
set_property IOSTANDARD LVCMOS33 [get_ports LED_12]
set_property SLEW SLOW [get_ports LED_12]
set_property PACKAGE_PIN AE13 [get_ports LED_13]
set_property IOSTANDARD LVCMOS33 [get_ports LED_13]
set_property SLEW SLOW [get_ports LED_13]

## ============================================
##       S Y S  M  O N   I2C
## ============================================
#create_clock -period 31.25 [get_ports dclk_in]
set_property PACKAGE_PIN N21 [get_ports SYSMON_SCL_LS]
set_property IOSTANDARD LVCMOS18 [get_ports SYSMON_SCL_LS]
set_property PACKAGE_PIN M21 [get_ports SYSMON_SDA_LS]
set_property IOSTANDARD LVCMOS18 [get_ports SYSMON_SDA_LS]

## ============================================
## ==   D D R  4   -   B A N K S  44 and 46
## ============================================
set_property SLEW FAST [get_ports ddr4_0_inst0_c0_ddr4_act_n]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_adr[0]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_adr[10]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_adr[11]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_adr[12]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_adr[13]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_adr[14]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_adr[15]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_adr[16]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_adr[1]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_adr[2]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_adr[3]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_adr[4]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_adr[5]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_adr[6]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_adr[7]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_adr[8]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_adr[9]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_ba[0]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_ba[1]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_bg[0]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_ck_c[0]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_ck_t[0]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_cke[0]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_cs_n[0]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_dm_dbi_n[0]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_dm_dbi_n[1]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_dq[0]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_dq[10]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_dq[11]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_dq[12]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_dq[13]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_dq[14]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_dq[15]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_dq[1]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_dq[2]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_dq[3]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_dq[4]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_dq[5]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_dq[6]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_dq[7]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_dq[8]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_dq[9]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_dqs_c[0]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_dqs_c[1]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_dqs_t[0]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_dqs_t[1]}]
set_property SLEW FAST [get_ports {ddr4_0_inst0_c0_ddr4_odt[0]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports ddr4_0_inst0_c0_ddr4_act_n]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_adr[0]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_adr[10]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_adr[11]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_adr[12]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_adr[13]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_adr[14]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_adr[15]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_adr[16]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_adr[1]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_adr[2]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_adr[3]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_adr[4]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_adr[5]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_adr[6]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_adr[7]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_adr[8]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_adr[9]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_ba[0]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_ba[1]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_bg[0]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_ck_c[0]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_ck_t[0]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_cke[0]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_cs_n[0]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_dm_dbi_n[0]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_dm_dbi_n[1]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_dq[0]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_dq[10]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_dq[11]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_dq[12]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_dq[13]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_dq[14]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_dq[15]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_dq[1]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_dq[2]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_dq[3]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_dq[4]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_dq[5]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_dq[6]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_dq[7]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_dq[8]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_dq[9]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_dqs_c[0]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_dqs_c[1]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_dqs_t[0]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_dqs_t[1]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_0_inst0_c0_ddr4_odt[0]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_0_inst0_c0_ddr4_dm_dbi_n[0]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_0_inst0_c0_ddr4_dm_dbi_n[1]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_0_inst0_c0_ddr4_dq[0]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_0_inst0_c0_ddr4_dq[10]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_0_inst0_c0_ddr4_dq[11]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_0_inst0_c0_ddr4_dq[12]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_0_inst0_c0_ddr4_dq[13]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_0_inst0_c0_ddr4_dq[14]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_0_inst0_c0_ddr4_dq[15]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_0_inst0_c0_ddr4_dq[1]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_0_inst0_c0_ddr4_dq[2]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_0_inst0_c0_ddr4_dq[3]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_0_inst0_c0_ddr4_dq[4]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_0_inst0_c0_ddr4_dq[5]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_0_inst0_c0_ddr4_dq[6]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_0_inst0_c0_ddr4_dq[7]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_0_inst0_c0_ddr4_dq[8]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_0_inst0_c0_ddr4_dq[9]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_0_inst0_c0_ddr4_dqs_c[0]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_0_inst0_c0_ddr4_dqs_c[1]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_0_inst0_c0_ddr4_dqs_t[0]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_0_inst0_c0_ddr4_dqs_t[1]}]
set_property PACKAGE_PIN AL33 [get_ports ddr4_0_inst0_c0_ddr4_act_n]
set_property PACKAGE_PIN AH26 [get_ports {ddr4_0_inst0_c0_ddr4_adr[0]}]
set_property PACKAGE_PIN AN26 [get_ports {ddr4_0_inst0_c0_ddr4_adr[10]}]
set_property PACKAGE_PIN AP26 [get_ports {ddr4_0_inst0_c0_ddr4_adr[11]}]
set_property PACKAGE_PIN AP28 [get_ports {ddr4_0_inst0_c0_ddr4_adr[12]}]
set_property PACKAGE_PIN AP29 [get_ports {ddr4_0_inst0_c0_ddr4_adr[13]}]
set_property PACKAGE_PIN AN27 [get_ports {ddr4_0_inst0_c0_ddr4_adr[14]}]
set_property PACKAGE_PIN AN28 [get_ports {ddr4_0_inst0_c0_ddr4_adr[15]}]
set_property PACKAGE_PIN AN29 [get_ports {ddr4_0_inst0_c0_ddr4_adr[16]}]
set_property PACKAGE_PIN AJ26 [get_ports {ddr4_0_inst0_c0_ddr4_adr[1]}]
set_property PACKAGE_PIN AM26 [get_ports {ddr4_0_inst0_c0_ddr4_adr[2]}]
set_property PACKAGE_PIN AM27 [get_ports {ddr4_0_inst0_c0_ddr4_adr[3]}]
set_property PACKAGE_PIN AK26 [get_ports {ddr4_0_inst0_c0_ddr4_adr[4]}]
set_property PACKAGE_PIN AK27 [get_ports {ddr4_0_inst0_c0_ddr4_adr[5]}]
set_property PACKAGE_PIN AH27 [get_ports {ddr4_0_inst0_c0_ddr4_adr[6]}]
set_property PACKAGE_PIN AH28 [get_ports {ddr4_0_inst0_c0_ddr4_adr[7]}]
set_property PACKAGE_PIN AJ28 [get_ports {ddr4_0_inst0_c0_ddr4_adr[8]}]
set_property PACKAGE_PIN AK28 [get_ports {ddr4_0_inst0_c0_ddr4_adr[9]}]
set_property PACKAGE_PIN AP30 [get_ports {ddr4_0_inst0_c0_ddr4_ba[0]}]
set_property PACKAGE_PIN AL30 [get_ports {ddr4_0_inst0_c0_ddr4_ba[1]}]
set_property PACKAGE_PIN AM30 [get_ports {ddr4_0_inst0_c0_ddr4_bg[0]}]
set_property PACKAGE_PIN AL28 [get_ports {ddr4_0_inst0_c0_ddr4_ck_c[0]}]
set_property PACKAGE_PIN AL27 [get_ports {ddr4_0_inst0_c0_ddr4_ck_t[0]}]
set_property PACKAGE_PIN AK30 [get_ports {ddr4_0_inst0_c0_ddr4_cke[0]}]
set_property PACKAGE_PIN AM31 [get_ports {ddr4_0_inst0_c0_ddr4_cs_n[0]}]
set_property PACKAGE_PIN AJ29 [get_ports {ddr4_0_inst0_c0_ddr4_dm_dbi_n[0]}]
set_property PACKAGE_PIN AL32 [get_ports {ddr4_0_inst0_c0_ddr4_dm_dbi_n[1]}]
set_property PACKAGE_PIN AK31 [get_ports {ddr4_0_inst0_c0_ddr4_dq[0]}]
set_property PACKAGE_PIN AN31 [get_ports {ddr4_0_inst0_c0_ddr4_dq[10]}]
set_property PACKAGE_PIN AP31 [get_ports {ddr4_0_inst0_c0_ddr4_dq[11]}]
set_property PACKAGE_PIN AM32 [get_ports {ddr4_0_inst0_c0_ddr4_dq[12]}]
set_property PACKAGE_PIN AN32 [get_ports {ddr4_0_inst0_c0_ddr4_dq[13]}]
set_property PACKAGE_PIN AL34 [get_ports {ddr4_0_inst0_c0_ddr4_dq[14]}]
set_property PACKAGE_PIN AM34 [get_ports {ddr4_0_inst0_c0_ddr4_dq[15]}]
set_property PACKAGE_PIN AK32 [get_ports {ddr4_0_inst0_c0_ddr4_dq[1]}]
set_property PACKAGE_PIN AJ30 [get_ports {ddr4_0_inst0_c0_ddr4_dq[2]}]
set_property PACKAGE_PIN AJ31 [get_ports {ddr4_0_inst0_c0_ddr4_dq[3]}]
set_property PACKAGE_PIN AH31 [get_ports {ddr4_0_inst0_c0_ddr4_dq[4]}]
set_property PACKAGE_PIN AH32 [get_ports {ddr4_0_inst0_c0_ddr4_dq[5]}]
set_property PACKAGE_PIN AH34 [get_ports {ddr4_0_inst0_c0_ddr4_dq[6]}]
set_property PACKAGE_PIN AJ34 [get_ports {ddr4_0_inst0_c0_ddr4_dq[7]}]
set_property PACKAGE_PIN AN33 [get_ports {ddr4_0_inst0_c0_ddr4_dq[8]}]
set_property PACKAGE_PIN AP33 [get_ports {ddr4_0_inst0_c0_ddr4_dq[9]}]
set_property PACKAGE_PIN AH33 [get_ports {ddr4_0_inst0_c0_ddr4_dqs_t[0]}]
set_property PACKAGE_PIN AJ33 [get_ports {ddr4_0_inst0_c0_ddr4_dqs_c[0]}]
set_property PACKAGE_PIN AP34 [get_ports {ddr4_0_inst0_c0_ddr4_dqs_c[1]}]
set_property PACKAGE_PIN AN34 [get_ports {ddr4_0_inst0_c0_ddr4_dqs_t[1]}]
set_property PACKAGE_PIN AH29 [get_ports {ddr4_0_inst0_c0_ddr4_odt[0]}]
set_property PACKAGE_PIN AK33 [get_ports ddr4_0_inst0_c0_ddr4_reset_n]
set_property PACKAGE_PIN AM29 [get_ports ddr4_0_inst0_c0_sys_clk_n]
set_property PACKAGE_PIN AL29 [get_ports ddr4_0_inst0_c0_sys_clk_p]
set_property ODT RTT_48 [get_ports ddr4_0_inst0_c0_sys_clk_p]
set_property IOSTANDARD DIFF_POD12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_dqs_c[0]}]
set_property IOSTANDARD DIFF_POD12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_dqs_c[1]}]
set_property IOSTANDARD DIFF_POD12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_dqs_t[0]}]
set_property IOSTANDARD DIFF_POD12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_dqs_t[1]}]
set_property IOSTANDARD DIFF_SSTL12 [get_ports ddr4_1_inst0_c0_sys_clk_n]
set_property IOSTANDARD DIFF_SSTL12 [get_ports ddr4_1_inst0_c0_sys_clk_p]
set_property IOSTANDARD DIFF_SSTL12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_ck_c[0]}]
set_property IOSTANDARD DIFF_SSTL12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_ck_t[0]}]
set_property IOSTANDARD LVCMOS12 [get_ports ddr4_1_inst0_c0_ddr4_reset_n]
set_property IOSTANDARD POD12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_dm_dbi_n[0]}]
set_property IOSTANDARD POD12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_dm_dbi_n[1]}]
set_property IOSTANDARD POD12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_dq[0]}]
set_property IOSTANDARD POD12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_dq[10]}]
set_property IOSTANDARD POD12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_dq[11]}]
set_property IOSTANDARD POD12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_dq[12]}]
set_property IOSTANDARD POD12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_dq[13]}]
set_property IOSTANDARD POD12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_dq[14]}]
set_property IOSTANDARD POD12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_dq[15]}]
set_property IOSTANDARD POD12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_dq[1]}]
set_property IOSTANDARD POD12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_dq[2]}]
set_property IOSTANDARD POD12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_dq[3]}]
set_property IOSTANDARD POD12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_dq[4]}]
set_property IOSTANDARD POD12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_dq[5]}]
set_property IOSTANDARD POD12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_dq[6]}]
set_property IOSTANDARD POD12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_dq[7]}]
set_property IOSTANDARD POD12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_dq[8]}]
set_property IOSTANDARD POD12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_dq[9]}]
set_property IOSTANDARD SSTL12_DCI [get_ports ddr4_1_inst0_c0_ddr4_act_n]
set_property IOSTANDARD SSTL12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_adr[0]}]
set_property IOSTANDARD SSTL12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_adr[10]}]
set_property IOSTANDARD SSTL12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_adr[11]}]
set_property IOSTANDARD SSTL12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_adr[12]}]
set_property IOSTANDARD SSTL12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_adr[13]}]
set_property IOSTANDARD SSTL12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_adr[14]}]
set_property IOSTANDARD SSTL12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_adr[15]}]
set_property IOSTANDARD SSTL12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_adr[16]}]
set_property IOSTANDARD SSTL12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_adr[1]}]
set_property IOSTANDARD SSTL12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_adr[2]}]
set_property IOSTANDARD SSTL12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_adr[3]}]
set_property IOSTANDARD SSTL12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_adr[4]}]
set_property IOSTANDARD SSTL12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_adr[5]}]
set_property IOSTANDARD SSTL12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_adr[6]}]
set_property IOSTANDARD SSTL12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_adr[7]}]
set_property IOSTANDARD SSTL12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_adr[8]}]
set_property IOSTANDARD SSTL12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_adr[9]}]
set_property IOSTANDARD SSTL12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_ba[0]}]
set_property IOSTANDARD SSTL12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_ba[1]}]
set_property IOSTANDARD SSTL12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_bg[0]}]
set_property IOSTANDARD SSTL12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_cke[0]}]
set_property IOSTANDARD SSTL12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_cs_n[0]}]
set_property IOSTANDARD SSTL12_DCI [get_ports {ddr4_1_inst0_c0_ddr4_odt[0]}]
set_property SLEW FAST [get_ports ddr4_1_inst0_c0_ddr4_act_n]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_adr[0]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_adr[10]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_adr[11]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_adr[12]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_adr[13]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_adr[14]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_adr[15]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_adr[16]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_adr[1]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_adr[2]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_adr[3]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_adr[4]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_adr[5]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_adr[6]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_adr[7]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_adr[8]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_adr[9]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_ba[0]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_ba[1]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_bg[0]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_ck_c[0]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_ck_t[0]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_cke[0]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_cs_n[0]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_dm_dbi_n[0]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_dm_dbi_n[1]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_dq[0]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_dq[10]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_dq[11]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_dq[12]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_dq[13]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_dq[14]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_dq[15]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_dq[1]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_dq[2]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_dq[3]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_dq[4]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_dq[5]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_dq[6]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_dq[7]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_dq[8]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_dq[9]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_dqs_c[0]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_dqs_c[1]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_dqs_t[0]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_dqs_t[1]}]
set_property SLEW FAST [get_ports {ddr4_1_inst0_c0_ddr4_odt[0]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports ddr4_1_inst0_c0_ddr4_act_n]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_adr[0]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_adr[10]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_adr[11]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_adr[12]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_adr[13]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_adr[14]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_adr[15]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_adr[16]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_adr[1]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_adr[2]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_adr[3]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_adr[4]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_adr[5]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_adr[6]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_adr[7]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_adr[8]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_adr[9]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_ba[0]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_ba[1]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_bg[0]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_ck_c[0]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_ck_t[0]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_cke[0]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_cs_n[0]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_dm_dbi_n[0]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_dm_dbi_n[1]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_dq[0]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_dq[10]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_dq[11]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_dq[12]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_dq[13]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_dq[14]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_dq[15]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_dq[1]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_dq[2]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_dq[3]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_dq[4]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_dq[5]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_dq[6]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_dq[7]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_dq[8]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_dq[9]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_dqs_c[0]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_dqs_c[1]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_dqs_t[0]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_dqs_t[1]}]
set_property OUTPUT_IMPEDANCE RDRV_40_40 [get_ports {ddr4_1_inst0_c0_ddr4_odt[0]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_1_inst0_c0_ddr4_dm_dbi_n[0]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_1_inst0_c0_ddr4_dm_dbi_n[1]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_1_inst0_c0_ddr4_dq[0]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_1_inst0_c0_ddr4_dq[10]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_1_inst0_c0_ddr4_dq[11]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_1_inst0_c0_ddr4_dq[12]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_1_inst0_c0_ddr4_dq[13]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_1_inst0_c0_ddr4_dq[14]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_1_inst0_c0_ddr4_dq[15]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_1_inst0_c0_ddr4_dq[1]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_1_inst0_c0_ddr4_dq[2]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_1_inst0_c0_ddr4_dq[3]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_1_inst0_c0_ddr4_dq[4]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_1_inst0_c0_ddr4_dq[5]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_1_inst0_c0_ddr4_dq[6]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_1_inst0_c0_ddr4_dq[7]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_1_inst0_c0_ddr4_dq[8]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_1_inst0_c0_ddr4_dq[9]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_1_inst0_c0_ddr4_dqs_c[0]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_1_inst0_c0_ddr4_dqs_c[1]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_1_inst0_c0_ddr4_dqs_t[0]}]
set_property IBUF_LOW_PWR FALSE [get_ports {ddr4_1_inst0_c0_ddr4_dqs_t[1]}]
set_property PACKAGE_PIN AN21 [get_ports ddr4_1_inst0_c0_ddr4_act_n]
set_property PACKAGE_PIN AD21 [get_ports {ddr4_1_inst0_c0_ddr4_adr[0]}]
set_property PACKAGE_PIN AE25 [get_ports {ddr4_1_inst0_c0_ddr4_adr[10]}]
set_property PACKAGE_PIN AE26 [get_ports {ddr4_1_inst0_c0_ddr4_adr[11]}]
set_property PACKAGE_PIN AF23 [get_ports {ddr4_1_inst0_c0_ddr4_adr[12]}]
set_property PACKAGE_PIN AF24 [get_ports {ddr4_1_inst0_c0_ddr4_adr[13]}]
set_property PACKAGE_PIN AG24 [get_ports {ddr4_1_inst0_c0_ddr4_adr[14]}]
set_property PACKAGE_PIN AG25 [get_ports {ddr4_1_inst0_c0_ddr4_adr[15]}]
set_property PACKAGE_PIN AH24 [get_ports {ddr4_1_inst0_c0_ddr4_adr[16]}]
set_property PACKAGE_PIN AE21 [get_ports {ddr4_1_inst0_c0_ddr4_adr[1]}]
set_property PACKAGE_PIN AF20 [get_ports {ddr4_1_inst0_c0_ddr4_adr[2]}]
set_property PACKAGE_PIN AG20 [get_ports {ddr4_1_inst0_c0_ddr4_adr[3]}]
set_property PACKAGE_PIN AD20 [get_ports {ddr4_1_inst0_c0_ddr4_adr[4]}]
set_property PACKAGE_PIN AE20 [get_ports {ddr4_1_inst0_c0_ddr4_adr[5]}]
set_property PACKAGE_PIN AE22 [get_ports {ddr4_1_inst0_c0_ddr4_adr[6]}]
set_property PACKAGE_PIN AE23 [get_ports {ddr4_1_inst0_c0_ddr4_adr[7]}]
set_property PACKAGE_PIN AF22 [get_ports {ddr4_1_inst0_c0_ddr4_adr[8]}]
set_property PACKAGE_PIN AG22 [get_ports {ddr4_1_inst0_c0_ddr4_adr[9]}]
set_property PACKAGE_PIN AJ25 [get_ports {ddr4_1_inst0_c0_ddr4_ba[0]}]
set_property PACKAGE_PIN AH22 [get_ports {ddr4_1_inst0_c0_ddr4_ba[1]}]
set_property PACKAGE_PIN AH23 [get_ports {ddr4_1_inst0_c0_ddr4_bg[0]}]
set_property PACKAGE_PIN AH21 [get_ports {ddr4_1_inst0_c0_ddr4_ck_c[0]}]
set_property PACKAGE_PIN AG21 [get_ports {ddr4_1_inst0_c0_ddr4_ck_t[0]}]
set_property PACKAGE_PIN AK21 [get_ports {ddr4_1_inst0_c0_ddr4_cke[0]}]
set_property PACKAGE_PIN AF25 [get_ports {ddr4_1_inst0_c0_ddr4_cs_n[0]}]
set_property PACKAGE_PIN AJ21 [get_ports {ddr4_1_inst0_c0_ddr4_dm_dbi_n[0]}]
set_property PACKAGE_PIN AM21 [get_ports {ddr4_1_inst0_c0_ddr4_dm_dbi_n[1]}]
set_property PACKAGE_PIN AK22 [get_ports {ddr4_1_inst0_c0_ddr4_dq[0]}]
set_property PACKAGE_PIN AM24 [get_ports {ddr4_1_inst0_c0_ddr4_dq[10]}]
set_property PACKAGE_PIN AN24 [get_ports {ddr4_1_inst0_c0_ddr4_dq[11]}]
set_property PACKAGE_PIN AP24 [get_ports {ddr4_1_inst0_c0_ddr4_dq[12]}]
set_property PACKAGE_PIN AP25 [get_ports {ddr4_1_inst0_c0_ddr4_dq[13]}]
set_property PACKAGE_PIN AN23 [get_ports {ddr4_1_inst0_c0_ddr4_dq[14]}]
set_property PACKAGE_PIN AP23 [get_ports {ddr4_1_inst0_c0_ddr4_dq[15]}]
set_property PACKAGE_PIN AK23 [get_ports {ddr4_1_inst0_c0_ddr4_dq[1]}]
set_property PACKAGE_PIN AL20 [get_ports {ddr4_1_inst0_c0_ddr4_dq[2]}]
set_property PACKAGE_PIN AM20 [get_ports {ddr4_1_inst0_c0_ddr4_dq[3]}]
set_property PACKAGE_PIN AL22 [get_ports {ddr4_1_inst0_c0_ddr4_dq[4]}]
set_property PACKAGE_PIN AL23 [get_ports {ddr4_1_inst0_c0_ddr4_dq[5]}]
set_property PACKAGE_PIN AL24 [get_ports {ddr4_1_inst0_c0_ddr4_dq[6]}]
set_property PACKAGE_PIN AL25 [get_ports {ddr4_1_inst0_c0_ddr4_dq[7]}]
set_property PACKAGE_PIN AM22 [get_ports {ddr4_1_inst0_c0_ddr4_dq[8]}]
set_property PACKAGE_PIN AN22 [get_ports {ddr4_1_inst0_c0_ddr4_dq[9]}]
set_property PACKAGE_PIN AJ20 [get_ports {ddr4_1_inst0_c0_ddr4_dqs_t[0]}]
set_property PACKAGE_PIN AK20 [get_ports {ddr4_1_inst0_c0_ddr4_dqs_c[0]}]
set_property PACKAGE_PIN AP21 [get_ports {ddr4_1_inst0_c0_ddr4_dqs_c[1]}]
set_property PACKAGE_PIN AP20 [get_ports {ddr4_1_inst0_c0_ddr4_dqs_t[1]}]
set_property PACKAGE_PIN AK25 [get_ports {ddr4_1_inst0_c0_ddr4_odt[0]}]
set_property PACKAGE_PIN AM25 [get_ports ddr4_1_inst0_c0_ddr4_reset_n]
set_property PACKAGE_PIN AJ23 [get_ports ddr4_1_inst0_c0_sys_clk_p]
set_property PACKAGE_PIN AJ24 [get_ports ddr4_1_inst0_c0_sys_clk_n]


set_property ODT RTT_48 [get_ports ddr4_1_inst0_c0_sys_clk_p]
### ----------------------------------------------------------------------
##set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets DDR4_1_PAR_IBUF_inst/O]
###                    +------------------------------+
###==================  |---     B A N K  4 5       ---| ==================##
###                    +------------------------------+
set_property PACKAGE_PIN AN14 [get_ports DDR4_0_PAR]
set_property IOSTANDARD SSTL12_DCI [get_ports DDR4_0_PAR]
set_property PACKAGE_PIN AP14 [get_ports DDR4_0_TEN]
set_property IOSTANDARD SSTL12_DCI [get_ports DDR4_0_TEN]
set_property PACKAGE_PIN AN19 [get_ports DDR4_0_ALERT_N]
set_property IOSTANDARD SSTL12_DCI [get_ports DDR4_0_ALERT_N]
set_property PACKAGE_PIN AP18 [get_ports DDR4_1_PAR]
set_property IOSTANDARD SSTL12_DCI [get_ports DDR4_1_PAR]
set_property IOSTANDARD SSTL12_DCI [get_ports DDR4_1_TEN]
set_property PACKAGE_PIN AM17 [get_ports DDR4_1_TEN]
set_property PACKAGE_PIN AN16 [get_ports DDR4_1_ALERT_N]
set_property IOSTANDARD SSTL12_DCI [get_ports DDR4_1_ALERT_N]
###                    +------------------------------+
###==================  |---     B A N K  4 8       ---| ==================##
###                    +------------------------------+
set_property PACKAGE_PIN AA32 [get_ports DATA1_P]
set_property IOSTANDARD LVDS [get_ports DATA1_P]
set_property DIFF_TERM_ADV TERM_100 [get_ports DATA1_P]
##set_property ODT RTT_NONE [get_ports DATA1_P]
# --------------------------------------------------------------------------
set_property PACKAGE_PIN AC34 [get_ports DATA2_P]
set_property IOSTANDARD LVDS [get_ports DATA2_P]
set_property DIFF_TERM_ADV TERM_100 [get_ports DATA2_P]
##set_property ODT RTT_NONE [get_ports DATA2_P]
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN AA34 [get_ports DATA3_P]
set_property IOSTANDARD LVDS [get_ports DATA3_P]
set_property DIFF_TERM_ADV TERM_100 [get_ports DATA3_P]
##set_property ODT RTT_NONE [get_ports DATA3_P]
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN W33 [get_ports DATA4_P]
set_property IOSTANDARD LVDS [get_ports DATA4_P]
set_property DIFF_TERM_ADV TERM_100 [get_ports DATA4_P]
##set_property ODT RTT_NONE [get_ports DATA4_P]
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN V33 [get_ports DATA5_P]
set_property IOSTANDARD LVDS [get_ports DATA5_P]
set_property DIFF_TERM_ADV TERM_100 [get_ports DATA5_P]
##set_property ODT RTT_NONE [get_ports DATA5_P]
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN U34 [get_ports DATA6_P]
set_property IOSTANDARD LVDS [get_ports DATA6_P]
set_property DIFF_TERM_ADV TERM_100 [get_ports DATA6_P]
##set_property ODT RTT_NONE [get_ports DATA6_P]
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN AB30 [get_ports DATA7_P]
set_property IOSTANDARD LVDS [get_ports DATA7_P]
set_property DIFF_TERM_ADV TERM_100 [get_ports DATA7_P]
##set_property ODT RTT_NONE [get_ports DATA7_P]
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN AA29 [get_ports DATA8_P]
set_property IOSTANDARD LVDS [get_ports DATA8_P]
set_property DIFF_TERM_ADV TERM_100 [get_ports DATA8_P]
##set_property ODT RTT_NONE [get_ports DATA8_P]
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN AC33 [get_ports DATA9_P]
set_property IOSTANDARD LVDS [get_ports DATA9_P]
set_property DIFF_TERM_ADV TERM_100 [get_ports DATA9_P]
##set_property ODT RTT_NONE [get_ports DATA9_P]
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN W30 [get_ports DATA10_P]
set_property IOSTANDARD LVDS [get_ports DATA10_P]
set_property DIFF_TERM_ADV TERM_100 [get_ports DATA10_P]
##set_property ODT RTT_NONE [get_ports DATA10_P]
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN Y31 [get_ports DATA11_P]
set_property IOSTANDARD LVDS [get_ports DATA11_P]
set_property DIFF_TERM_ADV TERM_100 [get_ports DATA11_P]
##set_property ODT RTT_NONE [get_ports DATA11_P]
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN V31 [get_ports DATA12_P]
set_property IOSTANDARD LVDS [get_ports DATA12_P]
set_property DIFF_TERM_ADV TERM_100 [get_ports DATA12_P]
##set_property ODT RTT_NONE [get_ports DATA12_P]
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN AC32 [get_ports SI5345_OUT5_N]
set_property PACKAGE_PIN AC31 [get_ports SI5345_OUT5_P]
set_property IOSTANDARD LVDS [get_ports SI5345_OUT5_P]
set_property DIFF_TERM_ADV TERM_100 [get_ports SI5345_OUT5_P]
##set_property ODT RTT_NONE [get_ports SI5345_OUT5_P]

### =============================================================================
### ===          B A N K   6 4                                                ===
### =============================================================================
set_property PACKAGE_PIN AP11 [get_ports LED_1]
set_property IOSTANDARD LVCMOS33 [get_ports LED_1]
set_property SLEW SLOW [get_ports LED_1]
set_property PACKAGE_PIN AP10 [get_ports LED_2]
set_property IOSTANDARD LVCMOS33 [get_ports LED_2]
set_property SLEW SLOW [get_ports LED_2]
set_property PACKAGE_PIN AE11 [get_ports LED_3]
set_property IOSTANDARD LVCMOS33 [get_ports LED_3]
set_property SLEW SLOW [get_ports LED_3]
set_property PACKAGE_PIN AJ13 [get_ports LED_4]
set_property IOSTANDARD LVCMOS33 [get_ports LED_4]
set_property SLEW SLOW [get_ports LED_4]
set_property PACKAGE_PIN AM11 [get_ports LED_5]
set_property IOSTANDARD LVCMOS33 [get_ports LED_5]
set_property SLEW SLOW [get_ports LED_5]
set_property PACKAGE_PIN AN11 [get_ports LED_6]
set_property IOSTANDARD LVCMOS33 [get_ports LED_6]
set_property SLEW SLOW [get_ports LED_6]
set_property PACKAGE_PIN AM12 [get_ports LED_7]
set_property IOSTANDARD LVCMOS33 [get_ports LED_7]
set_property SLEW SLOW [get_ports LED_7]
set_property PACKAGE_PIN AN12 [get_ports LED_8]
set_property IOSTANDARD LVCMOS33 [get_ports LED_8]
set_property SLEW SLOW [get_ports LED_8]
set_property PACKAGE_PIN AK12 [get_ports LED_9]
set_property IOSTANDARD LVCMOS33 [get_ports LED_9]
set_property SLEW SLOW [get_ports LED_9]
set_property PACKAGE_PIN AE12 [get_ports LED_10]
set_property IOSTANDARD LVCMOS33 [get_ports LED_10]
set_property SLEW SLOW [get_ports LED_10]
set_property PACKAGE_PIN AF13 [get_ports LED_14]
set_property IOSTANDARD LVCMOS33 [get_ports LED_14]
set_property SLEW SLOW [get_ports LED_14]
set_property PACKAGE_PIN AH13 [get_ports LED_15]
set_property IOSTANDARD LVCMOS33 [get_ports LED_15]
set_property SLEW SLOW [get_ports LED_15]
set_property PACKAGE_PIN AP13 [get_ports LED_16]
set_property IOSTANDARD LVCMOS33 [get_ports LED_16]
set_property SLEW SLOW [get_ports LED_16]
set_property PACKAGE_PIN AL12 [get_ports LED_17]
set_property IOSTANDARD LVCMOS33 [get_ports LED_17]
set_property SLEW SLOW [get_ports LED_17]
set_property PACKAGE_PIN AK13 [get_ports LED_18]
set_property IOSTANDARD LVCMOS33 [get_ports LED_18]
set_property SLEW SLOW [get_ports LED_18]
set_property PACKAGE_PIN AL13 [get_ports LED_19]
set_property IOSTANDARD LVCMOS33 [get_ports LED_19]
set_property SLEW SLOW [get_ports LED_19]
set_property PACKAGE_PIN AN13 [get_ports LED_20]
set_property IOSTANDARD LVCMOS33 [get_ports LED_20]
set_property SLEW SLOW [get_ports LED_20]

### ----------------------------------------------------------------------------
set_property PACKAGE_PIN AH12 [get_ports SI5345_I_OUT6_N]
set_property PACKAGE_PIN AG12 [get_ports SI5345_I_OUT6_P]
set_property IOSTANDARD LVDS_25 [get_ports SI5345_I_OUT6_P]
###set_property DIFF_TERM_ADV TERM_100 [get_ports SI5345_I_OUT6_P]
###set_property ODT RTT_NONE [get_ports SI5345_I_OUT6_P]
### -----------------------------------------------------------------------------
set_property PACKAGE_PIN AH11 [get_ports SI5345_OUT6_N]
set_property PACKAGE_PIN AG11 [get_ports SI5345_OUT6_P]
set_property IOSTANDARD LVDS_25 [get_ports SI5345_OUT6_P]
###set_property DIFF_TERM_ADV TERM_100 [get_ports SI5345_OUT6_P]
### ---------------------------------------------------------------------------------
set_property PACKAGE_PIN AF10 [get_ports ORBIT_P]
set_property IOSTANDARD LVDS_25 [get_ports ORBIT_P]
###set_property DIFF_TERM_ADV TERM_100 [get_ports ORBIT_P]
## ---------------------------------------------------------------------------------
## Front panel IOs
## ---------------------------------------------------------------------------------
set_property PACKAGE_PIN AD9 [get_ports LM0_OUT1]
set_property IOSTANDARD LVCMOS33 [get_ports LM0_OUT1]
set_property PACKAGE_PIN AD8 [get_ports LM0_OUT2]
set_property IOSTANDARD LVCMOS33 [get_ports LM0_OUT2]
set_property PACKAGE_PIN AH9 [get_ports BUSY_IN]
set_property IOSTANDARD LVCMOS33 [get_ports BUSY_IN]
set_property PACKAGE_PIN AH8 [get_ports BUSY_OUT]
set_property IOSTANDARD LVCMOS33 [get_ports BUSY_OUT]
set_property PACKAGE_PIN AL10 [get_ports FASTLM_IN]
set_property IOSTANDARD LVCMOS33 [get_ports FASTLM_IN]
# BC
# OBRIT
set_property PACKAGE_PIN AF9 [get_ports SCOPE_A_FP]
set_property IOSTANDARD LVCMOS33 [get_ports SCOPE_A_FP]
set_property PACKAGE_PIN AG9 [get_ports SCOPE_B_FP]
set_property IOSTANDARD LVCMOS33 [get_ports SCOPE_B_FP]
set_property PACKAGE_PIN AE8 [get_ports TTC_A_OUT]
set_property IOSTANDARD LVCMOS33 [get_ports TTC_A_OUT]
set_property PACKAGE_PIN AF8 [get_ports TTC_B_OUT]
set_property IOSTANDARD LVCMOS33 [get_ports TTC_B_OUT]
set_property PACKAGE_PIN AD10 [get_ports PULSER_IN]
set_property IOSTANDARD LVCMOS33 [get_ports PULSER_IN]
set_property PACKAGE_PIN AE10 [get_ports SPARE_IN]
set_property IOSTANDARD LVCMOS33 [get_ports SPARE_IN]
set_property PACKAGE_PIN AM10 [get_ports SPARE_OUT]
set_property IOSTANDARD LVCMOS33 [get_ports SPARE_OUT]

set_property PACKAGE_PIN AN9 [get_ports ADC_IN]
set_property IOSTANDARD LVCMOS33 [get_ports ADC_IN]
set_property PACKAGE_PIN AP9 [get_ports ADC_CLK]
set_property IOSTANDARD LVCMOS33 [get_ports ADC_CLK]
set_property PACKAGE_PIN AK10 [get_ports {ADC_CS[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ADC_CS[0]}]
set_property PACKAGE_PIN AL9 [get_ports ADC_SDATA]
set_property IOSTANDARD LVCMOS33 [get_ports ADC_SDATA]

set_property PACKAGE_PIN AN8 [get_ports FMC_HPAC_PG_M2C]
set_property IOSTANDARD LVCMOS33 [get_ports FMC_HPAC_PG_M2C]
set_property PACKAGE_PIN AP8 [get_ports FMC_HPC_PRSNT_M2C_B]
set_property IOSTANDARD LVCMOS33 [get_ports FMC_HPC_PRSNT_M2C_B]
set_property PACKAGE_PIN AJ9 [get_ports VADJ1V8_PGOOD]
set_property IOSTANDARD LVCMOS33 [get_ports VADJ1V8_PGOOD]

#set_property IOSTANDARD LVCMOS33 [get_ports IIC_MUX_RESET_B]
#set_property SLEW SLOW [get_ports IIC_MUX_RESET_B]
#set_property PACKAGE_PIN AJ8 [get_ports IIC_MUX_RESET_B]
set_property IOSTANDARD LVCMOS33 [get_ports IIC_MUX_SCL_MAIN]
set_property SLEW SLOW [get_ports IIC_MUX_SCL_MAIN]
set_property PACKAGE_PIN AK8 [get_ports IIC_MUX_SCL_MAIN]
set_property IOSTANDARD LVCMOS33 [get_ports IIC_MUX_SDA_MAIN]
set_property SLEW SLOW [get_ports IIC_MUX_SDA_MAIN]
set_property PACKAGE_PIN AL8 [get_ports IIC_MUX_SDA_MAIN]

###                    +----------------------------------+
###==================  |  B A N K s  224 225 226 227    --| ==================##
###                    +----------------------------------+
### =======================
### == C h a n n e l  0  ==
### =======================
#set_property PACKAGE_PIN AP2 [get_ports SFP_9_RX_P]
#set_property PACKAGE_PIN AP1 [get_ports SFP_9_RX_P_N]
#set_property PACKAGE_PIN AN4 [get_ports SFP_9_TX_P]
#set_property PACKAGE_PIN AN3 [get_ports SFP_9_TX_P_N]

### =======================
### == C h a n n e l  1  ==
### =======================
#set_property PACKAGE_PIN AM2 [get_ports SFP_10_RX_P]
#set_property PACKAGE_PIN AM1 [get_ports SFP_10_RX_P_N]
#set_property PACKAGE_PIN AM6 [get_ports SFP_10_TX_p]
#set_property PACKAGE_PIN AM5 [get_ports SFP_10_TX_p_N]

### =======================
### == C h a n n e l  2  ==
### =======================
#set_property PACKAGE_PIN AK2 [get_ports SFP_11_RX_P]
#set_property PACKAGE_PIN AK1 [get_ports SFP_11_RX_P_N]
#set_property PACKAGE_PIN AL4 [get_ports SFP_11_TX_P]
#set_property PACKAGE_PIN AL3 [get_ports SFP_11_TX_P_N]

### =======================
### == C h a n n e l  3  ==
### =======================
#set_property PACKAGE_PIN AJ4 [get_ports SFP_12_RX_P]
#set_property PACKAGE_PIN AJ3 [get_ports SFP_12_RX_P_N]
#set_property PACKAGE_PIN AK6 [get_ports SFP_12_TX_P]
#set_property PACKAGE_PIN AK5 [get_ports SFP_12_TX_P_N]

### =======================
### == C h a n n e l  4  ==
### =======================
#set_property PACKAGE_PIN AH2 [get_ports SFP_5_RX_P]
#set_property PACKAGE_PIN AH1 [get_ports SFP_5_RX_P_N]
#set_property PACKAGE_PIN AH6 [get_ports SFP_5_TX_P]
#set_property PACKAGE_PIN AH5 [get_ports SFP_5_TX_P_N]

### =======================
### == C h a n n e l  5  ==
### =======================
#set_property PACKAGE_PIN AF2 [get_ports SFP_6_RX_P]
#set_property PACKAGE_PIN AF1 [get_ports SFP_6_RX_P_N]
#set_property PACKAGE_PIN AG4 [get_ports SFP_6_TX_P]
#set_property PACKAGE_PIN AG3 [get_ports SFP_6_TX_P_N]

### =======================
### == C h a n n e l  6  ==
### =======================
#set_property PACKAGE_PIN AD2 [get_ports SFP_7_RX_P]
#set_property PACKAGE_PIN AD1 [get_ports SFP_7_RX_P_N]
#set_property PACKAGE_PIN AE4 [get_ports SFP_TX_7_P]
#set_property PACKAGE_PIN AE3 [get_ports SFP_TX_7_P_N]

### =======================
### == C h a n n e l  7 ==
### =======================
#set_property PACKAGE_PIN AB2 [get_ports SFP_8_RX_P]
#set_property PACKAGE_PIN AB1 [get_ports SFP_8_RX_P_N]
#set_property PACKAGE_PIN AC4 [get_ports SFP_8_TX_P]
#set_property PACKAGE_PIN AC3 [get_ports SFP_8_TX_P_N]


### =======================
### == C h a n n e l  8 ==
### =======================
#set_property PACKAGE_PIN Y2 [get_ports SFP_1_RX_P]
#set_property PACKAGE_PIN Y1 [get_ports SFP_1_RX_P_N]
#set_property PACKAGE_PIN AA4 [get_ports SFP_1_TX_P]
#set_property PACKAGE_PIN AA3 [get_ports SFP_1_TX_P_N]

### =======================
### == C h a n n e l  9 ==
### =======================
#set_property PACKAGE_PIN V2 [get_ports SFP_2_RX_P]
#set_property PACKAGE_PIN V1 [get_ports SFP_2_RX_P_N]
#set_property PACKAGE_PIN W4 [get_ports SFP_2_TX_P]
#set_property PACKAGE_PIN W3 [get_ports SFP_2_TX_P_N]

### =======================
### == C h a n n e l  10 ==
### =======================
#set_property PACKAGE_PIN T2 [get_ports SFP_3_RX_P]
#set_property PACKAGE_PIN T1 [get_ports SFP_3_RX_P_N]
#set_property PACKAGE_PIN U4 [get_ports SFP_3_TX_P]
#set_property PACKAGE_PIN U3 [get_ports SFP_3_TX_P_N]

### =======================
### == C h a n n e l  11 ==
### =======================
#set_property PACKAGE_PIN P2 [get_ports SFP_4_RX_P]
#set_property PACKAGE_PIN P1 [get_ports SFP_4_RX_P_N]
#set_property PACKAGE_PIN R4 [get_ports SFP_4_TX_P]
#set_property PACKAGE_PIN R3 [get_ports SFP_4_TX_P_N]

### =======================
### == C h a n n e l  12 ==
### =======================

### =======================
### == C h a n n e l  13 ==
### =======================
#set_property PACKAGE_PIN K2 [get_ports FMC_HPC_DP5_M2C_P]
#set_property PACKAGE_PIN K1 [get_ports FMC_HPC_DP5_M2C_P_N]
#set_property PACKAGE_PIN L4 [get_ports FMC_HPC_DP5_C2M_P]
#set_property PACKAGE_PIN L3 [get_ports FMC_HPC_DP5_C2M_P_N]

### =======================
### == C h a n n e l  14 ==
### =======================
#set_property PACKAGE_PIN H2 [get_ports FMC_HPC_DP6_M2C_P]
#set_property PACKAGE_PIN H1 [get_ports FMC_HPC_DP6_M2C_P_N]
#set_property PACKAGE_PIN J4 [get_ports FMC_HPC_DP6_C2M_P]
#set_property PACKAGE_PIN J3 [get_ports FMC_HPC_DP6_C2M_P_N]

### =======================
### == C h a n n e l  15 ==
### =======================


### =======================
### == C h a n n e l  16 ==
### =======================

### =======================
### == C h a n n e l  17 ==
### =======================
#set_property PACKAGE_PIN D2 [get_ports FMC_HPC_DP1_M2C_P]
#set_property PACKAGE_PIN D1 [get_ports FMC_HPC_DP1_M2C_P_N]
#set_property PACKAGE_PIN D6 [get_ports FMC_HPC_DP1_C2M_P]
#set_property PACKAGE_PIN D5 [get_ports FMC_HPC_DP1_C2M_P_N]

### =======================
### == C h a n n e l  18 ==
### =======================
#set_property PACKAGE_PIN B2 [get_ports FMC_HPC_DP2_M2C_P]
#set_property PACKAGE_PIN B1 [get_ports FMC_HPC_DP2_M2C_P_N]
#set_property PACKAGE_PIN C4 [get_ports FMC_HPC_DP2_C2M_P]
#set_property PACKAGE_PIN C3 [get_ports FMC_HPC_DP2_C2M_P_N]

### =======================
### == C h a n n e l  19 ==
### =======================
#set_property PACKAGE_PIN A4 [get_ports FMC_HPC_DP3_M2C_P]
#set_property PACKAGE_PIN A3 [get_ports FMC_HPC_DP3_M2C_P_N]
#set_property PACKAGE_PIN B6 [get_ports FMC_HPC_DP3_C2M_P]
#set_property PACKAGE_PIN B5 [get_ports FMC_HPC_DP3_C2M_P_N]


### ==================================
### ==     C L O C K S              ==
### ?=================================
#set_property PACKAGE_PIN AF5 [get_ports SI5345_OUT4_P_N]
#set_property PACKAGE_PIN AF6 [get_ports SI5345_OUT4_P]
#set_property PACKAGE_PIN AB5 [get_ports SI5345_OUT3_P_N]
#set_property PACKAGE_PIN AB6 [get_ports SI5345_OUT3_P]
#set_property PACKAGE_PIN V5 [get_ports SI5345_OUT2_P_N]
#set_property PACKAGE_PIN V6 [get_ports SI5345_OUT2_P]
#set_property PACKAGE_PIN P5 [get_ports SI5345_OUT0_P_N]
#set_property PACKAGE_PIN P6 [get_ports SI5345_OUT0_P]

#create_clock -period 4.166 -name clk_mgtrefclk0_x0y0_p [get_ports SI5345_OUT4_P]
#create_clock -period 4.166 -name clk_mgtrefclk0_x0y1_p [get_ports SI5345_OUT3_P]
#create_clock -period 4.166 -name clk_mgtrefclk0_x0y2_p [get_ports SI5345_OUT2_P]
#create_clock -period 4.166 -name clk_mgtrefclk0_x0y3_p [get_ports SI5345_OUT0_P]
#create_clock -period 4.166 -name clk_mgtrefclk0_x0y4_p [get_ports FMC_HPC_GBTCLK0_M2C_P]

###                    +------------------------------+
###==================  |---     B A N K  226       ---| ==================##
###                    |------------------------------|
#set_property PACKAGE_PIN T5 [get_ports SI5345_I_OUT2_N]
#set_property PACKAGE_PIN T6 [get_ports SI5345_I_OUT2_P]
#create_clock -period 4.166 -name SI5345_I_OUT2_P [get_ports SI5345_I_OUT2_P]

###                    +------------------------------+
###==================  |---     B A N K  225       ---| ==================##
###                    |------------------------------|
#set_property PACKAGE_PIN Y5 [get_ports SI5345_I_OUT3_N]
#set_property PACKAGE_PIN Y6 [get_ports SI5345_I_OUT3_P]
#create_clock -period 4.166 -name SI5345_I_OUT3_P [get_ports SI5345_I_OUT3_P]

###                    +------------------------------+
###==================  |---     B A N K  224       ---| ==================##
###                    |------------------------------|
#set_property PACKAGE_PIN AD5 [get_ports SI5345_I_OUT4_N]
#set_property PACKAGE_PIN AD6 [get_ports SI5345_I_OUT4_P]
#create_clock -period 4.166 -name SI5345_I_OUT4_P [get_ports SI5345_I_OUT4_P]

###                    +------------------------------+
###==================  |---     B A N K  228       ---| ==================##
###                    |------------------------------|
#set_property PACKAGE_PIN K6 [get_ports FMC_HPC_GBTCLK0_M2C_P]
#set_property PACKAGE_PIN K5 [get_ports FMC_HPC_GBTCLK0_M2C_N]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_GBTCLK0_M2C_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_GBTCLK0_M2C_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_GBTCLK0_M2C_P]

#set_property PACKAGE_PIN H5 [get_ports FMC_HPC_GBTCLK1_M2C_N]
#set_property PACKAGE_PIN H6 [get_ports FMC_HPC_GBTCLK1_M2C_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_GBTCLK1_M2C_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_GBTCLK1_M2C_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_GBTCLK1_M2C_P]

#create_clock -period 4.166 -name FMC_HPC_GBTCLK1_M2C_C_P [get_ports FMC_HPC_GBTCLK1_M2C_P]

##set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
##set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
##set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
##connect_debug_port dbg_hub/clk [get_nets ddr4_1_inst0_dbg_clk_OBUF]


### =========================================
### ==   B A N K  4 7                      ==
### == ------------------------------------==
### ==  Check LVDS  Standard               ==
### == ----------------------------------- ==
###  BC_P_ONU        --> *                 ==
###  SI5345_I_OUT_P  --> *                 ==
###  SI5345_OUT_8_P  --> *                 ==
### =========================================
#set_property IOSTANDARD LVCMOS18 [get_ports SI5345_I_INSEL0]
#set_property DRIVE 12 [get_ports SI5345_I_INSEL0]
#set_property SLEW FAST [get_ports SI5345_I_INSEL0]
#set_property PACKAGE_PIN Y26 [get_ports SI5345_I_INSEL0]
#set_property IOSTANDARD LVCMOS18 [get_ports SI5345_I_INSEL1]
#set_property DRIVE 12 [get_ports SI5345_I_INSEL1]
#set_property SLEW FAST [get_ports SI5345_I_INSEL1]
#set_property PACKAGE_PIN Y27 [get_ports SI5345_I_INSEL1]
#set_property IOSTANDARD LVCMOS18 [get_ports SI5345_I_12C_SEL]
#set_property DRIVE 12 [get_ports SI5345_I_12C_SEL]
#set_property SLEW FAST [get_ports SI5345_I_12C_SEL]
#set_property PACKAGE_PIN AD25 [get_ports SI5345_I_12C_SEL]
#set_property IOSTANDARD LVCMOS18 [get_ports SI5345_I_A0_CSB]
#set_property DRIVE 12 [get_ports SI5345_I_A0_CSB]
#set_property SLEW FAST [get_ports SI5345_I_A0_CSB]
#set_property PACKAGE_PIN AD26 [get_ports SI5345_I_A0_CSB]
##-------------------------------------------------------------
#set_property IOSTANDARD LVCMOS18 [get_ports SI5345_I_SDA_SDIO]
#set_property DRIVE 12 [get_ports SI5345_I_SDA_SDIO]
#set_property SLEW FAST [get_ports SI5345_I_SDA_SDIO]
#set_property PACKAGE_PIN AB24 [get_ports SI5345_I_SDA_SDIO]

### -----------------------------------------------------------------
#set_property IOSTANDARD LVCMOS18 [get_ports SI5345_I_A1_SD0]
#set_property DRIVE 12 [get_ports SI5345_I_A1_SD0]
#set_property SLEW FAST [get_ports SI5345_I_A1_SD0]
#set_property PACKAGE_PIN AC24 [get_ports SI5345_I_A1_SD0]

### -------------------------------------------------------------------
#set_property IOSTANDARD LVCMOS18 [get_ports SI5345_I_SCLK]
#set_property DRIVE 12 [get_ports SI5345_I_SCLK]
#set_property SLEW FAST [get_ports SI5345_I_SCLK]
#set_property PACKAGE_PIN AC26 [get_ports SI5345_I_SCLK]
#set_property IOSTANDARD LVCMOS18 [get_ports SI5345_I_RST]
#set_property DRIVE 12 [get_ports SI5345_I_RST]
#set_property SLEW FAST [get_ports SI5345_I_RST]
#set_property PACKAGE_PIN AC27 [get_ports SI5345_I_RST]
### ----------------------------------------------------------------------#
#set_property PACKAGE_PIN AA27 [get_ports SI5345_I_INTR]
#set_property IOSTANDARD LVCMOS18 [get_ports SI5345_I_INTR]
###set_property DRIVE 12 [get_ports SI5345_I_INTR]
###set_property SLEW FAST [get_ports SI5345_I_INTR]

### -----------------------------------------------------------------------#
#set_property PACKAGE_PIN AB27 [get_ports SI5345_I_LOL]
#set_property IOSTANDARD LVCMOS18 [get_ports SI5345_I_LOL]
###set_property DRIVE 12 [get_ports SI5345_I_LOL]
###set_property SLEW FAST [get_ports SI5345_I_LOL]


### ---------------------------------------------------------------------#
set_property PACKAGE_PIN AB25 [get_ports SI5345_INSEL0]
set_property IOSTANDARD LVCMOS18 [get_ports SI5345_INSEL0]
set_property PACKAGE_PIN AB26 [get_ports SI5345_INSEL1]
set_property IOSTANDARD LVCMOS18 [get_ports SI5345_INSEL1]
set_property PACKAGE_PIN AA22 [get_ports SI5345_I2C_SEL]
set_property IOSTANDARD LVCMOS18 [get_ports SI5345_I2C_SEL]
set_property PACKAGE_PIN AB22 [get_ports SI5345_AO_CSB]
set_property IOSTANDARD LVCMOS18 [get_ports SI5345_AO_CSB]
set_property PACKAGE_PIN AC22 [get_ports SI5345_SDA_SDIO]
set_property IOSTANDARD LVCMOS18 [get_ports SI5345_SDA_SDIO]
set_property PACKAGE_PIN AC23 [get_ports SI5345_A1_SDO]
set_property IOSTANDARD LVCMOS18 [get_ports SI5345_A1_SDO]
set_property PACKAGE_PIN AA20 [get_ports SI5345_SCLK]
set_property IOSTANDARD LVCMOS18 [get_ports SI5345_SCLK]
set_property PACKAGE_PIN AB20 [get_ports SI5345_RST]
set_property IOSTANDARD LVCMOS18 [get_ports SI5345_RST]
set_property PACKAGE_PIN AA28 [get_ports SI5345_INTR]
set_property IOSTANDARD LVCMOS18 [get_ports SI5345_INTR]
set_property PACKAGE_PIN Y22 [get_ports SI5345_LOL]
set_property IOSTANDARD LVCMOS18 [get_ports SI5345_LOL]
###-----------------------------------------------------------------------#
set_property PACKAGE_PIN AB21 [get_ports BC_P_ONU]
set_property PACKAGE_PIN AC21 [get_ports BC_N_ONU]
set_property IOSTANDARD LVDS [get_ports BC_P_ONU]
### -----------------------------------------------------------------------#
set_property PACKAGE_PIN Y23 [get_ports SI5345_I_OUT7_P]
set_property PACKAGE_PIN AA23 [get_ports SI5345_I_OUT7_N]
set_property IOSTANDARD LVDS [get_ports SI5345_I_OUT7_P]
set_property DIFF_TERM_ADV TERM_100 [get_ports SI5345_I_OUT7_P]
####-------------------------------------------------------------------------#
set_property IOSTANDARD LVCMOS18 [get_ports SFP_TX_DISABLE]
set_property PACKAGE_PIN U29 [get_ports SFP_TX_DISABLE]
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_1_MOD_DETECT_LS]
#set_property DRIVE 12 [get_ports SFP_1_MOD_DETECT_LS]
#set_property SLEW SLOW [get_ports SFP_1_MOD_DETECT_LS]
#set_property PACKAGE_PIN W23 [get_ports SFP_1_MOD_DETECT_LS]
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_1_PDOWN_TRI_TR_LS]
#set_property DRIVE 12 [get_ports SFP_1_PDOWN_TRI_TR_LS]
#set_property SLEW SLOW [get_ports SFP_1_PDOWN_TRI_TR_LS]
#set_property PACKAGE_PIN W24 [get_ports SFP_1_PDOWN_TRI_TR_LS]
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_2_MOD_DETECT_LS]
#set_property DRIVE 12 [get_ports SFP_2_MOD_DETECT_LS]
#set_property SLEW SLOW [get_ports SFP_2_MOD_DETECT_LS]
#set_property PACKAGE_PIN W25 [get_ports SFP_2_MOD_DETECT_LS]
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_2_PDOWN_TRI_TR_LS]
#set_property DRIVE 12 [get_ports SFP_2_PDOWN_TRI_TR_LS]
#set_property SLEW SLOW [get_ports SFP_2_PDOWN_TRI_TR_LS]
#set_property PACKAGE_PIN Y25 [get_ports SFP_2_PDOWN_TRI_TR_LS]
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_3_MOD_DETECT_LS]
#set_property DRIVE 12 [get_ports SFP_3_MOD_DETECT_LS]
#set_property SLEW SLOW [get_ports SFP_3_MOD_DETECT_LS]
#set_property PACKAGE_PIN U21 [get_ports SFP_3_MOD_DETECT_LS]
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_3_PDOWN_TRI_TR_LS]
#set_property DRIVE 12 [get_ports SFP_3_PDOWN_TRI_TR_LS]
#set_property SLEW SLOW [get_ports SFP_3_PDOWN_TRI_TR_LS]
#set_property PACKAGE_PIN U22 [get_ports SFP_3_PDOWN_TRI_TR_LS]
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_4_MOD_DETECT_LS]
#set_property DRIVE 12 [get_ports SFP_4_MOD_DETECT_LS]
#set_property SLEW SLOW [get_ports SFP_4_MOD_DETECT_LS]
#set_property PACKAGE_PIN V22 [get_ports SFP_4_MOD_DETECT_LS]
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_4_PDOWN_TRI_TR_LS]
#set_property DRIVE 12 [get_ports SFP_4_PDOWN_TRI_TR_LS]
#set_property SLEW SLOW [get_ports SFP_4_PDOWN_TRI_TR_LS]
#set_property PACKAGE_PIN V23 [get_ports SFP_4_PDOWN_TRI_TR_LS]
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_5_MOD_DETECT_LS]
#set_property DRIVE 12 [get_ports SFP_5_MOD_DETECT_LS]
#set_property SLEW SLOW [get_ports SFP_5_MOD_DETECT_LS]
#set_property PACKAGE_PIN T22 [get_ports SFP_5_MOD_DETECT_LS]
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_5_PDOWN_TRI_TR_LS]
#set_property DRIVE 12 [get_ports SFP_5_PDOWN_TRI_TR_LS]
#set_property SLEW SLOW [get_ports SFP_5_PDOWN_TRI_TR_LS]
#set_property PACKAGE_PIN T23 [get_ports SFP_5_PDOWN_TRI_TR_LS]
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_6_MOD_DETECT_LS]
#set_property DRIVE 12 [get_ports SFP_6_MOD_DETECT_LS]
#set_property SLEW SLOW [get_ports SFP_6_MOD_DETECT_LS]
#set_property PACKAGE_PIN V21 [get_ports SFP_6_MOD_DETECT_LS]
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_6_DOWN_TRI_TR_LS]
#set_property DRIVE 12 [get_ports SFP_6_DOWN_TRI_TR_LS]
#set_property SLEW SLOW [get_ports SFP_6_DOWN_TRI_TR_LS]
#set_property PACKAGE_PIN W21 [get_ports SFP_6_DOWN_TRI_TR_LS]
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_7_MOD_DETECT_LS]
#set_property DRIVE 12 [get_ports SFP_7_MOD_DETECT_LS]
#set_property SLEW SLOW [get_ports SFP_7_MOD_DETECT_LS]
#set_property PACKAGE_PIN V27 [get_ports SFP_7_MOD_DETECT_LS]
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_7_PDOWN_TRI_TR_LS]
#set_property DRIVE 12 [get_ports SFP_7_PDOWN_TRI_TR_LS]
#set_property SLEW SLOW [get_ports SFP_7_PDOWN_TRI_TR_LS]
#set_property PACKAGE_PIN V28 [get_ports SFP_7_PDOWN_TRI_TR_LS]
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_8_MOD_DETECT_LS]
#set_property DRIVE 12 [get_ports SFP_8_MOD_DETECT_LS]
#set_property SLEW SLOW [get_ports SFP_8_MOD_DETECT_LS]
#set_property PACKAGE_PIN U24 [get_ports SFP_8_MOD_DETECT_LS]
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_8_PDOWN_TRI_TR_LS]
#set_property DRIVE 12 [get_ports SFP_8_PDOWN_TRI_TR_LS]
#set_property SLEW SLOW [get_ports SFP_8_PDOWN_TRI_TR_LS]
#set_property PACKAGE_PIN U25 [get_ports SFP_8_PDOWN_TRI_TR_LS]
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_9_MOD_DETECT_LS]
#set_property DRIVE 12 [get_ports SFP_9_MOD_DETECT_LS]
#set_property SLEW SLOW [get_ports SFP_9_MOD_DETECT_LS]
#set_property PACKAGE_PIN W28 [get_ports SFP_9_MOD_DETECT_LS]
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_9_PDOWN_TRI_TR_LS]
#set_property DRIVE 12 [get_ports SFP_9_PDOWN_TRI_TR_LS]
#set_property SLEW SLOW [get_ports SFP_9_PDOWN_TRI_TR_LS]
#set_property PACKAGE_PIN Y28 [get_ports SFP_9_PDOWN_TRI_TR_LS]
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_10_MOD_DETECT_LS]
#set_property DRIVE 12 [get_ports SFP_10_MOD_DETECT_LS]
#set_property SLEW SLOW [get_ports SFP_10_MOD_DETECT_LS]
#set_property PACKAGE_PIN U26 [get_ports SFP_10_MOD_DETECT_LS]
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_10_PDOWN_TRI_TR_LS]
#set_property DRIVE 12 [get_ports SFP_10_PDOWN_TRI_TR_LS]
#set_property SLEW SLOW [get_ports SFP_10_PDOWN_TRI_TR_LS]
#set_property PACKAGE_PIN U27 [get_ports SFP_10_PDOWN_TRI_TR_LS]
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_11_MOD_DETECT_LS]
#set_property DRIVE 12 [get_ports SFP_11_MOD_DETECT_LS]
#set_property SLEW SLOW [get_ports SFP_11_MOD_DETECT_LS]
#set_property PACKAGE_PIN V29 [get_ports SFP_11_MOD_DETECT_LS]
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_11_PDOWN_TRI_TR_LS]
#set_property DRIVE 12 [get_ports SFP_11_PDOWN_TRI_TR_LS]
#set_property SLEW SLOW [get_ports SFP_11_PDOWN_TRI_TR_LS]
#set_property PACKAGE_PIN W29 [get_ports SFP_11_PDOWN_TRI_TR_LS]
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_12_MOD_DETECT_LS]
#set_property DRIVE 12 [get_ports SFP_12_MOD_DETECT_LS]
#set_property SLEW SLOW [get_ports SFP_12_MOD_DETECT_LS]
#set_property PACKAGE_PIN V26 [get_ports SFP_12_MOD_DETECT_LS]
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_12_PDOWN_TRI_TR_LS]
#set_property DRIVE 12 [get_ports SFP_12_PDOWN_TRI_TR_LS]
#set_property SLEW SLOW [get_ports SFP_12_PDOWN_TRI_TR_LS]
#set_property PACKAGE_PIN W26 [get_ports SFP_12_PDOWN_TRI_TR_LS]

###                    +------------------------------+
###==================  |---     B A N K  4 8       ---| ==================##
###                    +------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports OTEST_C1]
#set_property DRIVE 12 [get_ports OTEST_C1]
#set_property SLEW SLOW [get_ports OTEST_C1]
#set_property PACKAGE_PIN AE27 [get_ports OTEST_C1]
#set_property IOSTANDARD LVCMOS18 [get_ports OTEST_C2]
#set_property DRIVE 12 [get_ports OTEST_C2]
#set_property SLEW SLOW [get_ports OTEST_C2]
#set_property PACKAGE_PIN AF27 [get_ports OTEST_C2]
#set_property IOSTANDARD LVCMOS18 [get_ports TEST_C3]
#set_property DRIVE 12 [get_ports TEST_C3]
#set_property SLEW SLOW [get_ports TEST_C3]
#set_property PACKAGE_PIN AE28 [get_ports TEST_C3]
#set_property IOSTANDARD LVCMOS18 [get_ports TEST_C4]
#set_property DRIVE 12 [get_ports TEST_C4]
#set_property SLEW SLOW [get_ports TEST_C4]
#set_property PACKAGE_PIN AF28 [get_ports TEST_C4]
#set_property IOSTANDARD LVCMOS18 [get_ports TEST_C5]
#set_property DRIVE 12 [get_ports TEST_C5]
#set_property SLEW SLOW [get_ports TEST_C5]
#set_property PACKAGE_PIN AC28 [get_ports TEST_C5]
### ------------------------------------------------------------------ #
#set_property IOSTANDARD LVCMOS18 [get_ports SM_FAN_PWM]
#set_property DRIVE 12 [get_ports SM_FAN_PWM]
#set_property SLEW SLOW [get_ports SM_FAN_PWM]
#set_property PACKAGE_PIN AE31 [get_ports SM_FAN_PWM]

#set_property IOSTANDARD LVCMOS18 [get_ports SM_FAN_TACH]
#set_property PACKAGE_PIN AA33 [get_ports SM_FAN_TACH]

set_property PACKAGE_PIN AE33 [get_ports QSPI_1_CS_B]
set_property IOSTANDARD LVCMOS18 [get_ports QSPI_1_CS_B]
set_property SLEW SLOW [get_ports QSPI_1_CS_B]

set_property PACKAGE_PIN AG32 [get_ports QSPI_1_D0]
set_property IOSTANDARD LVCMOS18 [get_ports QSPI_1_D0]
set_property SLEW SLOW [get_ports QSPI_1_D0]

set_property PACKAGE_PIN AF33 [get_ports QSPI_1_D1]
set_property IOSTANDARD LVCMOS18 [get_ports QSPI_1_D1]
set_property SLEW SLOW [get_ports QSPI_1_D1]

#set_property PACKAGE_PIN AG34 [get_ports QSPI_1_D2]
#set_property IOSTANDARD LVCMOS18 [get_ports QSPI_1_D2]
#set_property SLEW SLOW [get_ports QSPI_1_D2]

#set_property PACKAGE_PIN AE32 [get_ports QSPI_1_D3]
#set_property IOSTANDARD LVCMOS18 [get_ports QSPI_1_D3]
#set_property SLEW SLOW [get_ports QSPI_1_D3]

set_property PACKAGE_PIN AF32 [get_ports QSPI_1_CLK]
set_property IOSTANDARD LVCMOS18 [get_ports QSPI_1_CLK]
set_property SLEW SLOW [get_ports QSPI_1_CLK]

### ++ ***********************************************************************+
set_property PACKAGE_PIN AD30 [get_ports SI5345_I_OUT5_P]
set_property PACKAGE_PIN AD31 [get_ports SI5345_I_OUT5_N]
set_property IOSTANDARD LVDS [get_ports SI5345_I_OUT5_P]
set_property DIFF_TERM_ADV TERM_100 [get_ports SI5345_I_OUT5_P]
###set_property ODT RTT_NONE [get_ports SI5345_I_OUT5_P]
### ++ *********************************************************************+
set_property PACKAGE_PIN AA24 [get_ports SI5345_OUT8_P]
set_property PACKAGE_PIN AA25 [get_ports SI5345_OUT8_N]
set_property IOSTANDARD LVDS [get_ports SI5345_OUT8_P]
set_property DIFF_TERM_ADV TERM_100 [get_ports SI5345_OUT8_P]
###set_property ODT RTT_NONE [get_ports SI5345_OUT8_P]
### ++ ***********************************************************************

### -----------------------------------------------------------------------#
###                    +------------------------------+
###==================  |---     B A N K  4 5       ---| ==================##
###                    +------------------------------+
## --------------------------------------------------------------------#
set_property PACKAGE_PIN AN18 [get_ports LED_21_LS]
set_property IOSTANDARD LVCMOS12 [get_ports LED_21_LS]
set_property SLEW SLOW [get_ports LED_21_LS]
## -------------------------------------------------------------------#
set_property PACKAGE_PIN AN17 [get_ports LED_22_LS]
set_property IOSTANDARD LVCMOS12 [get_ports LED_22_LS]
set_property SLEW SLOW [get_ports LED_22_LS]
## -------------------------------------------------------------------#
set_property PACKAGE_PIN AM16 [get_ports LED_23_LS]
set_property IOSTANDARD LVCMOS12 [get_ports LED_23_LS]
set_property SLEW SLOW [get_ports LED_23_LS]
## --------------------------------------------------------------------#
set_property PACKAGE_PIN AM15 [get_ports LED_24_LS]
set_property IOSTANDARD LVCMOS12 [get_ports LED_24_LS]
set_property SLEW SLOW [get_ports LED_24_LS]
## ---------------------------------------------------------------------#
set_property PACKAGE_PIN AP16 [get_ports LED_25_LS]
set_property IOSTANDARD LVCMOS12 [get_ports LED_25_LS]
set_property SLEW SLOW [get_ports LED_25_LS]
##------------------------------------------------------------------------#
set_property PACKAGE_PIN AP15 [get_ports SFP1_LED_GR]
set_property IOSTANDARD LVCMOS12 [get_ports SFP1_LED_GR]
set_property SLEW SLOW [get_ports SFP1_LED_GR]
# ------------------------------------------------------------------------#
set_property PACKAGE_PIN AL14 [get_ports SFP1_LED_RD]
set_property IOSTANDARD LVCMOS12 [get_ports SFP1_LED_RD]
set_property SLEW SLOW [get_ports SFP1_LED_RD]
# ------------------------------------------------------------------------#
set_property PACKAGE_PIN AM14 [get_ports SFP2_LED_GR]
set_property IOSTANDARD LVCMOS12 [get_ports SFP2_LED_GR]
set_property SLEW SLOW [get_ports SFP2_LED_GR]
# ------------------------------------------------------------------------#
set_property PACKAGE_PIN AL19 [get_ports SFP2_LED_RD]
set_property IOSTANDARD LVCMOS12 [get_ports SFP2_LED_RD]
set_property SLEW SLOW [get_ports SFP2_LED_RD]
# ------------------------------------------------------------------------#
set_property PACKAGE_PIN AM19 [get_ports SFP3_LED_GR]
set_property IOSTANDARD LVCMOS12 [get_ports SFP3_LED_GR]
set_property SLEW SLOW [get_ports SFP3_LED_GR]
# ------------------------------------------------------------------------#
set_property PACKAGE_PIN AK15 [get_ports SFP3_LED_RD]
set_property IOSTANDARD LVCMOS12 [get_ports SFP3_LED_RD]
set_property SLEW SLOW [get_ports SFP3_LED_RD]
# ------------------------------------------------------------------------#
set_property PACKAGE_PIN AL15 [get_ports SFP4_LED_GR]
set_property IOSTANDARD LVCMOS12 [get_ports SFP4_LED_GR]
set_property SLEW SLOW [get_ports SFP4_LED_GR]
# ------------------------------------------------------------------------#
set_property PACKAGE_PIN AL18 [get_ports SFP4_LED_RD]
set_property IOSTANDARD LVCMOS12 [get_ports SFP4_LED_RD]
set_property SLEW SLOW [get_ports SFP4_LED_RD]
# ------------------------------------------------------------------------#
set_property PACKAGE_PIN AL17 [get_ports SFP5_LED_GR]
set_property IOSTANDARD LVCMOS12 [get_ports SFP5_LED_GR]
set_property SLEW SLOW [get_ports SFP5_LED_GR]
# ------------------------------------------------------------------------#
set_property PACKAGE_PIN AJ18 [get_ports SFP5_LED_RD]
set_property IOSTANDARD LVCMOS12 [get_ports SFP5_LED_RD]
set_property SLEW SLOW [get_ports SFP5_LED_RD]
# ------------------------------------------------------------------------#
set_property PACKAGE_PIN AK18 [get_ports SFP6_LED_GR]
set_property IOSTANDARD LVCMOS12 [get_ports SFP6_LED_GR]
set_property SLEW SLOW [get_ports SFP6_LED_GR]
# ------------------------------------------------------------------------#
set_property PACKAGE_PIN AK17 [get_ports SFP6_LED_RD]
set_property IOSTANDARD LVCMOS12 [get_ports SFP6_LED_RD]
set_property SLEW SLOW [get_ports SFP6_LED_RD]
# ------------------------------------------------------------------------#
set_property PACKAGE_PIN AK16 [get_ports SFP7_LED_GR]
set_property IOSTANDARD LVCMOS12 [get_ports SFP7_LED_GR]
set_property SLEW SLOW [get_ports SFP7_LED_GR]
# ------------------------------------------------------------------------#
set_property PACKAGE_PIN AH18 [get_ports SFP7_LED_RD]
set_property IOSTANDARD LVCMOS12 [get_ports SFP7_LED_RD]
set_property SLEW SLOW [get_ports SFP7_LED_RD]
# ------------------------------------------------------------------------#
set_property PACKAGE_PIN AH17 [get_ports SFP8_LED_GR]
set_property IOSTANDARD LVCMOS12 [get_ports SFP8_LED_GR]
set_property SLEW SLOW [get_ports SFP8_LED_GR]
# ------------------------------------------------------------------------#
set_property PACKAGE_PIN AH16 [get_ports SFP8_LED_RD]
set_property IOSTANDARD LVCMOS12 [get_ports SFP8_LED_RD]
set_property SLEW SLOW [get_ports SFP8_LED_RD]
# ------------------------------------------------------------------------#
set_property PACKAGE_PIN AJ16 [get_ports SFP9_LED_GR]
set_property IOSTANDARD LVCMOS12 [get_ports SFP9_LED_GR]
set_property SLEW SLOW [get_ports SFP9_LED_GR]
# ------------------------------------------------------------------------#
set_property PACKAGE_PIN AG17 [get_ports SFP9_LED_RD]
set_property IOSTANDARD LVCMOS12 [get_ports SFP9_LED_RD]
set_property SLEW SLOW [get_ports SFP9_LED_RD]
# ------------------------------------------------------------------------#
set_property PACKAGE_PIN AG16 [get_ports SFP10_LED_GR]
set_property IOSTANDARD LVCMOS12 [get_ports SFP10_LED_GR]
set_property SLEW SLOW [get_ports SFP10_LED_GR]
# ------------------------------------------------------------------------#
set_property PACKAGE_PIN AJ15 [get_ports SFP10_LED_RD]
set_property IOSTANDARD LVCMOS12 [get_ports SFP10_LED_RD]
set_property SLEW SLOW [get_ports SFP10_LED_RD]
# ------------------------------------------------------------------------#
set_property PACKAGE_PIN AJ14 [get_ports SFP11_LED_GR]
set_property IOSTANDARD LVCMOS12 [get_ports SFP11_LED_GR]
set_property SLEW SLOW [get_ports SFP11_LED_GR]
# ------------------------------------------------------------------------#
set_property PACKAGE_PIN AG19 [get_ports SFP11_LED_RD]
set_property IOSTANDARD LVCMOS12 [get_ports SFP11_LED_RD]
set_property SLEW SLOW [get_ports SFP11_LED_RD]
# ------------------------------------------------------------------------#
set_property PACKAGE_PIN AH19 [get_ports SFP12_LED_GR]
set_property IOSTANDARD LVCMOS12 [get_ports SFP12_LED_GR]
set_property SLEW SLOW [get_ports SFP12_LED_GR]
# ------------------------------------------------------------------------#
set_property PACKAGE_PIN AG15 [get_ports SFP12_LED_RD]
set_property IOSTANDARD LVCMOS12 [get_ports SFP12_LED_RD]
set_property SLEW SLOW [get_ports SFP12_LED_RD]
# ------------------------------------------------------------------------#

###                    +------------------------------+
###==================  |---     B A N K  6 5       ---| ==================##
###                    +------------------------------+
set_property PACKAGE_PIN H27 [get_ports SFP_1_TXBURST_TXDIS_TR]
set_property IOSTANDARD LVCMOS18 [get_ports SFP_1_TXBURST_TXDIS_TR]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_1_TXFAUL]
#set_property DRIVE 12 [get_ports SFP_1_TXFAUL]
#set_property SLEW FAST [get_ports SFP_1_TXFAUL]
#set_property PACKAGE_PIN G27 [get_ports SFP_1_TXFAUL]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_1_TXSD_RXRESET_TR]
#set_property DRIVE 12 [get_ports SFP_1_TXSD_RXRESET_TR]
#set_property SLEW FAST [get_ports SFP_1_TXSD_RXRESET_TR]
#set_property PACKAGE_PIN G25 [get_ports SFP_1_TXSD_RXRESET_TR]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_1_RXLOS_RXSD]
#set_property DRIVE 12 [get_ports SFP_1_RXLOS_RXSD]
#set_property SLEW FAST [get_ports SFP_1_RXLOS_RXSD]
#set_property PACKAGE_PIN G26 [get_ports SFP_1_RXLOS_RXSD]
### +------------------------------------------------------------------+
set_property IOSTANDARD LVCMOS18 [get_ports SFP_2_TXBURST_TXDIS_TR]
set_property PACKAGE_PIN K26 [get_ports SFP_2_TXBURST_TXDIS_TR]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_2_TXFAULT]
#set_property DRIVE 12 [get_ports SFP_2_TXFAULT]
#set_property SLEW FAST [get_ports SFP_2_TXFAULT]
#set_property PACKAGE_PIN K27 [get_ports SFP_2_TXFAULT]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_2_TXSD_RXRESET_TR]
#set_property DRIVE 12 [get_ports SFP_2_TXSD_RXRESET_TR]
#set_property SLEW FAST [get_ports SFP_2_TXSD_RXRESET_TR]
#set_property PACKAGE_PIN J24 [get_ports SFP_2_TXSD_RXRESET_TR]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_2_RXLOS_RXSD]
#set_property DRIVE 12 [get_ports SFP_2_RXLOS_RXSD]
#set_property SLEW FAST [get_ports SFP_2_RXLOS_RXSD]
#set_property PACKAGE_PIN J25 [get_ports SFP_2_RXLOS_RXSD]
### +------------------------------------------------------------------+
set_property IOSTANDARD LVCMOS18 [get_ports SFP_3_TXBURST_TXDIS_TR]
set_property PACKAGE_PIN J26 [get_ports SFP_3_TXBURST_TXDIS_TR]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_3_TXFAULT]
#set_property DRIVE 12 [get_ports SFP_3_TXFAULT]
#set_property SLEW FAST [get_ports SFP_3_TXFAULT]
#set_property PACKAGE_PIN H26 [get_ports SFP_3_TXFAULT]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_3_TXSD_RXRESET_TR]
#set_property DRIVE 12 [get_ports SFP_3_TXSD_RXRESET_TR]
#set_property SLEW FAST [get_ports SFP_3_TXSD_RXRESET_TR]
#set_property PACKAGE_PIN J23 [get_ports SFP_3_TXSD_RXRESET_TR]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_3_RSLOS_RSXD]
#set_property DRIVE 12 [get_ports SFP_3_RSLOS_RSXD]
#set_property SLEW FAST [get_ports SFP_3_RSLOS_RSXD]
#set_property PACKAGE_PIN H24 [get_ports SFP_3_RSLOS_RSXD]
### +------------------------------------------------------------------+
set_property IOSTANDARD LVCMOS18 [get_ports SFP_4_TXBURST_TXDIS_TR]
set_property PACKAGE_PIN M27 [get_ports SFP_4_TXBURST_TXDIS_TR]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_4_TXFAULT]
#set_property DRIVE 12 [get_ports SFP_4_TXFAULT]
#set_property SLEW FAST [get_ports SFP_4_TXFAULT]
#set_property PACKAGE_PIN L27 [get_ports SFP_4_TXFAULT]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_4_TXSD_RXRESET_TR]
#set_property DRIVE 12 [get_ports SFP_4_TXSD_RXRESET_TR]
#set_property SLEW FAST [get_ports SFP_4_TXSD_RXRESET_TR]
#set_property PACKAGE_PIN L23 [get_ports SFP_4_TXSD_RXRESET_TR]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_4_RXLOS_RXSD]
#set_property DRIVE 12 [get_ports SFP_4_RXLOS_RXSD]
#set_property SLEW FAST [get_ports SFP_4_RXLOS_RXSD]
#set_property PACKAGE_PIN L24 [get_ports SFP_4_RXLOS_RXSD]
### +------------------------------------------------------------------+
set_property IOSTANDARD LVCMOS18 [get_ports SFP_5_TXBURST_TXDIS_TR]
set_property PACKAGE_PIN L25 [get_ports SFP_5_TXBURST_TXDIS_TR]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_5_TXFAULT]
#set_property DRIVE 12 [get_ports SFP_5_TXFAULT]
#set_property SLEW FAST [get_ports SFP_5_TXFAULT]
#set_property PACKAGE_PIN K25 [get_ports SFP_5_TXFAULT]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_5_TXSD_RXRESET_TR]
#set_property DRIVE 12 [get_ports SFP_5_TXSD_RXRESET_TR]
#set_property SLEW FAST [get_ports SFP_5_TXSD_RXRESET_TR]
#set_property PACKAGE_PIN L22 [get_ports SFP_5_TXSD_RXRESET_TR]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_5_RXLOS_RXSD]
#set_property DRIVE 12 [get_ports SFP_5_RXLOS_RXSD]
#set_property SLEW FAST [get_ports SFP_5_RXLOS_RXSD]
#set_property PACKAGE_PIN K23 [get_ports SFP_5_RXLOS_RXSD]
### +------------------------------------------------------------------+
set_property IOSTANDARD LVCMOS18 [get_ports SFP_6_TXBURST_TXDIS_TR]
set_property PACKAGE_PIN M25 [get_ports SFP_6_TXBURST_TXDIS_TR]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_6_TXFAULT]
#set_property DRIVE 12 [get_ports SFP_6_TXFAULT]
#set_property SLEW FAST [get_ports SFP_6_TXFAULT]
#set_property PACKAGE_PIN M26 [get_ports SFP_6_TXFAULT]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_6_TXSD_RXRESET_TR]
#set_property DRIVE 12 [get_ports SFP_6_TXSD_RXRESET_TR]
#set_property SLEW FAST [get_ports SFP_6_TXSD_RXRESET_TR]
#set_property PACKAGE_PIN N24 [get_ports SFP_6_TXSD_RXRESET_TR]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_6_RXLOS_RXSD]
#set_property DRIVE 12 [get_ports SFP_6_RXLOS_RXSD]
#set_property SLEW FAST [get_ports SFP_6_RXLOS_RXSD]
#set_property PACKAGE_PIN M24 [get_ports SFP_6_RXLOS_RXSD]
### +------------------------------------------------------------------+
set_property IOSTANDARD LVCMOS18 [get_ports SFP_7_TXBURST_TXDIS_TR]
set_property PACKAGE_PIN H23 [get_ports SFP_7_TXBURST_TXDIS_TR]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_7_TXFAULT]
#set_property DRIVE 12 [get_ports SFP_7_TXFAULT]
#set_property SLEW FAST [get_ports SFP_7_TXFAULT]
#set_property PACKAGE_PIN N23 [get_ports SFP_7_TXFAULT]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_7_TXSD_RXRESET_TR]
#set_property DRIVE 12 [get_ports SFP_7_TXSD_RXRESET_TR]
#set_property SLEW FAST [get_ports SFP_7_TXSD_RXRESET_TR]
#set_property PACKAGE_PIN N27 [get_ports SFP_7_TXSD_RXRESET_TR]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_7_RXLOS_RXSD]
#set_property DRIVE 12 [get_ports SFP_7_RXLOS_RXSD]
#set_property SLEW FAST [get_ports SFP_7_RXLOS_RXSD]
#set_property PACKAGE_PIN K22 [get_ports SFP_7_RXLOS_RXSD]
### +------------------------------------------------------------------+
### +---------------> CLOCKS  MOVED TO  BANK 65  <---------------------+
### +------------------------------------------------------------------+
set_property IOSTANDARD LVCMOS18 [get_ports SFP_8_TXBURST_TXDIS_TR]
set_property PACKAGE_PIN P26 [get_ports SFP_8_TXBURST_TXDIS_TR]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_8_TXFAULT]
#set_property DRIVE 12 [get_ports SFP_8_TXFAULT]
#set_property SLEW FAST [get_ports SFP_8_TXFAULT]
#set_property PACKAGE_PIN N26 [get_ports SFP_8_TXFAULT]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_8_TXSD_RXRESET_TR]
#set_property DRIVE 12 [get_ports SFP_8_TXSD_RXRESET_TR]
#set_property SLEW FAST [get_ports SFP_8_TXSD_RXRESET_TR]
#set_property PACKAGE_PIN P24 [get_ports SFP_8_TXSD_RXRESET_TR]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_8_RXLOS_RXSD]
#set_property DRIVE 12 [get_ports SFP_8_RXLOS_RXSD]
#set_property SLEW FAST [get_ports SFP_8_RXLOS_RXSD]
#set_property PACKAGE_PIN P25 [get_ports SFP_8_RXLOS_RXSD]
### +------------------------------------------------------------------+
set_property IOSTANDARD LVCMOS18 [get_ports SFP_9_TXBURST_TXDIS_TR]
set_property PACKAGE_PIN T27 [get_ports SFP_9_TXBURST_TXDIS_TR]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_9_TXFAULT]
#set_property DRIVE 12 [get_ports SFP_9_TXFAULT]
#set_property SLEW FAST [get_ports SFP_9_TXFAULT]
#set_property PACKAGE_PIN R27 [get_ports SFP_9_TXFAULT]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_9_TXSD_RXRESET_TR]
#set_property DRIVE 12 [get_ports SFP_9_TXSD_RXRESET_TR]
#set_property SLEW FAST [get_ports SFP_9_TXSD_RXRESET_TR]
#set_property PACKAGE_PIN T24 [get_ports SFP_9_TXSD_RXRESET_TR]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_9_RXLOS_RXSD]
#set_property DRIVE 12 [get_ports SFP_9_RXLOS_RXSD]
#set_property SLEW FAST [get_ports SFP_9_RXLOS_RXSD]
#set_property PACKAGE_PIN T25 [get_ports SFP_9_RXLOS_RXSD]
### +------------------------------------------------------------------+
set_property IOSTANDARD LVCMOS18 [get_ports SFP_10_TXBURST_TXDIS_TR]
set_property PACKAGE_PIN R25 [get_ports SFP_10_TXBURST_TXDIS_TR]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_10_TXFAULT]
#set_property DRIVE 12 [get_ports SFP_10_TXFAULT]
#set_property SLEW FAST [get_ports SFP_10_TXFAULT]
#set_property PACKAGE_PIN R26 [get_ports SFP_10_TXFAULT]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_10_TXSD_RXRESET_TR]
#set_property DRIVE 12 [get_ports SFP_10_TXSD_RXRESET_TR]
#set_property SLEW FAST [get_ports SFP_10_TXSD_RXRESET_TR]
#set_property PACKAGE_PIN R23 [get_ports SFP_10_TXSD_RXRESET_TR]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_10_RXLOS_RXSD]
#set_property DRIVE 12 [get_ports SFP_10_RXLOS_RXSD]
#set_property SLEW FAST [get_ports SFP_10_RXLOS_RXSD]
#set_property PACKAGE_PIN P23 [get_ports SFP_10_RXLOS_RXSD]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_11_TXFAULT]
#set_property DRIVE 12 [get_ports SFP_11_TXFAULT]
#set_property SLEW FAST [get_ports SFP_11_TXFAULT]
#set_property PACKAGE_PIN M22 [get_ports SFP_11_TXFAULT]
### +------------------------------------------------------------------+
set_property IOSTANDARD LVCMOS18 [get_ports SFP_11_TXBURST_TXDIS_TR]
set_property PACKAGE_PIN N22 [get_ports SFP_11_TXBURST_TXDIS_TR]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_11_TXSD_RXRESET_TR]
#set_property DRIVE 12 [get_ports SFP_11_TXSD_RXRESET_TR]
#set_property SLEW FAST [get_ports SFP_11_TXSD_RXRESET_TR]
#set_property PACKAGE_PIN P20 [get_ports SFP_11_TXSD_RXRESET_TR]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_11_RXLOS_RXSD]
#set_property DRIVE 12 [get_ports SFP_11_RXLOS_RXSD]
#set_property SLEW FAST [get_ports SFP_11_RXLOS_RXSD]
#set_property PACKAGE_PIN P21 [get_ports SFP_11_RXLOS_RXSD]
### +------------------------------------------------------------------+
set_property IOSTANDARD LVCMOS18 [get_ports SFP_12_TXBURST_TXDIS_TR]
set_property PACKAGE_PIN R21 [get_ports SFP_12_TXBURST_TXDIS_TR]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_12_TXFAULT]
#set_property DRIVE 12 [get_ports SFP_12_TXFAULT]
#set_property SLEW FAST [get_ports SFP_12_TXFAULT]
#set_property PACKAGE_PIN R22 [get_ports SFP_12_TXFAULT]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_12_TXSD_RXRESET_TR]
#set_property DRIVE 12 [get_ports SFP_12_TXSD_RXRESET_TR]
#set_property SLEW FAST [get_ports SFP_12_TXSD_RXRESET_TR]
#set_property PACKAGE_PIN M20 [get_ports SFP_12_TXSD_RXRESET_TR]
### +------------------------------------------------------------------+
#set_property IOSTANDARD LVCMOS18 [get_ports SFP_12_RXLOS_RXSD]
#set_property DRIVE 12 [get_ports SFP_12_RXLOS_RXSD]
#set_property SLEW FAST [get_ports SFP_12_RXLOS_RXSD]
#set_property PACKAGE_PIN L20 [get_ports SFP_12_RXLOS_RXSD]

##################################################
##  RATE   SEL
###################################################
##  FMC_CH0
#*****************
#set_property PACKAGE_PIN D8 [get_ports FMC_HPC_LA15_P]
#set_property IOSTANDARD LVCMOS18 [get_ports FMC_HPC_LA15_P]
##*****************
###  FMC_CH1
##*****************
#set_property PACKAGE_PIN J11 [get_ports FMC_HPC_LA11_N]
#set_property IOSTANDARD LVCMOS18 [get_ports FMC_HPC_LA11_N]
##*****************
###  FMC_CH2
##*****************
#set_property PACKAGE_PIN J8 [get_ports FMC_HPC_LA08_P]
#set_property IOSTANDARD LVCMOS18 [get_ports FMC_HPC_LA08_P]
##***************
###  FMC_CH3
##*****************
#set_property PACKAGE_PIN K12 [get_ports FMC_HPC_LA04_N]
#set_property IOSTANDARD LVCMOS18 [get_ports FMC_HPC_LA04_N]
#***************
##  FMC_CH5
#*****************
#set_property PACKAGE_PIN G21 [get_ports FMC_HPC_LA27_N]
#set_property IOSTANDARD LVCMOS18 [get_ports FMC_HPC_LA27_N]
#***************
##  FMC_CH6
#*****************
#set_property PACKAGE_PIN E20 [get_ports FMC_HPC_LA24_P]
#set_property IOSTANDARD LVCMOS18 [get_ports FMC_HPC_LA24_P]
#***************
##  FMC_CH7
#*****************
#set_property PACKAGE_PIN A24 [get_ports FMC_HPC_LA20_N]
#set_property IOSTANDARD LVCMOS18 [get_ports FMC_HPC_LA20_N]
#***************
###########################################################
## RS0  Control   BIG CAGE                               ##
###########################################################
# *****************************************
set_property PACKAGE_PIN G25 [get_ports SFP_1_TXSD_RXRESET_TR_LS]
set_property IOSTANDARD LVCMOS18 [get_ports SFP_1_TXSD_RXRESET_TR_LS]
# ****************************************
# *****************************************
set_property PACKAGE_PIN J24 [get_ports SFP_2_TXSD_RXRESET_TR_LS]
set_property IOSTANDARD LVCMOS18 [get_ports SFP_2_TXSD_RXRESET_TR_LS]
# ****************************************
# *****************************************
set_property PACKAGE_PIN J23 [get_ports SFP_3_TXSD_RXRESET_TR_LS]
set_property IOSTANDARD LVCMOS18 [get_ports SFP_3_TXSD_RXRESET_TR_LS]
# ****************************************
# *****************************************
set_property PACKAGE_PIN L23 [get_ports SFP_4_TXSD_RXRESET_TR_LS]
set_property IOSTANDARD LVCMOS18 [get_ports SFP_4_TXSD_RXRESET_TR_LS]
# ****************************************
# *****************************************
set_property PACKAGE_PIN L22 [get_ports SFP_5_TXSD_RXRESET_TR_LS]
set_property IOSTANDARD LVCMOS18 [get_ports SFP_5_TXSD_RXRESET_TR_LS]
# ****************************************
# *****************************************
set_property PACKAGE_PIN N24 [get_ports SFP_6_TXSD_RXRESET_TR_LS]
set_property IOSTANDARD LVCMOS18 [get_ports SFP_6_TXSD_RXRESET_TR_LS]
# ****************************************
# *****************************************
set_property PACKAGE_PIN N27 [get_ports SFP_7_TXSD_RXRESET_TR_LS]
set_property IOSTANDARD LVCMOS18 [get_ports SFP_7_TXSD_RXRESET_TR_LS]
# ****************************************
# *****************************************
set_property PACKAGE_PIN P24 [get_ports SFP_8_TXSD_RXRESET_TR_LS]
set_property IOSTANDARD LVCMOS18 [get_ports SFP_8_TXSD_RXRESET_TR_LS]
# ****************************************
# *****************************************
set_property PACKAGE_PIN T24 [get_ports SFP_9_TXSD_RXRESET_TR_LS]
set_property IOSTANDARD LVCMOS18 [get_ports SFP_9_TXSD_RXRESET_TR_LS]
# ****************************************
# *****************************************
set_property PACKAGE_PIN R23 [get_ports SFP_10_TXSD_RXRESET_TR_LS]
set_property IOSTANDARD LVCMOS18 [get_ports SFP_10_TXSD_RXRESET_TR_LS]
# ****************************************
# *****************************************
set_property PACKAGE_PIN P20 [get_ports SFP_11_TXSD_RXRESET_TR_LS]
set_property IOSTANDARD LVCMOS18 [get_ports SFP_11_TXSD_RXRESET_TR_LS]
# ****************************************
# *****************************************
set_property PACKAGE_PIN M20 [get_ports SFP_12_TXSD_RXRESET_TR_LS]
set_property IOSTANDARD LVCMOS18 [get_ports SFP_12_TXSD_RXRESET_TR_LS]
# ****************************************
###########################################################
## RS1  Control   BIG CAGE                               ##
###########################################################
# *****************************************
set_property PACKAGE_PIN W24 [get_ports SFP_1_PDOWN_TRI_TR]
set_property IOSTANDARD LVCMOS18 [get_ports SFP_1_PDOWN_TRI_TR]
# ****************************************
# *****************************************
set_property PACKAGE_PIN Y25 [get_ports SFP_2_PDOWN_TRI_TR]
set_property IOSTANDARD LVCMOS18 [get_ports SFP_2_PDOWN_TRI_TR]
# ****************************************
# *****************************************
set_property PACKAGE_PIN U22 [get_ports SFP_3_PDOWN_TRI_TR]
set_property IOSTANDARD LVCMOS18 [get_ports SFP_3_PDOWN_TRI_TR]
# ****************************************
# *****************************************
set_property PACKAGE_PIN V23 [get_ports SFP_4_PDOWN_TRI_TR]
set_property IOSTANDARD LVCMOS18 [get_ports SFP_4_PDOWN_TRI_TR]
# ****************************************
# *****************************************
set_property PACKAGE_PIN T23 [get_ports SFP_5_PDOWN_TRI_TR]
set_property IOSTANDARD LVCMOS18 [get_ports SFP_5_PDOWN_TRI_TR]
# ****************************************
# *****************************************
set_property PACKAGE_PIN W21 [get_ports SFP_6_PDOWN_TRI_TR]
set_property IOSTANDARD LVCMOS18 [get_ports SFP_6_PDOWN_TRI_TR]
# ****************************************
# *****************************************
set_property PACKAGE_PIN V28 [get_ports SFP_7_PDOWN_TRI_TR]
set_property IOSTANDARD LVCMOS18 [get_ports SFP_7_PDOWN_TRI_TR]
# ****************************************
# *****************************************
set_property PACKAGE_PIN U25 [get_ports SFP_8_PDOWN_TRI_TR]
set_property IOSTANDARD LVCMOS18 [get_ports SFP_8_PDOWN_TRI_TR]
# ***************************************
# *****************************************
set_property PACKAGE_PIN Y28 [get_ports SFP_9_PDOWN_TRI_TR]
set_property IOSTANDARD LVCMOS18 [get_ports SFP_9_PDOWN_TRI_TR]
# ***************************************
# *****************************************
set_property PACKAGE_PIN U27 [get_ports SFP_10_PDOWN_TRI_TR]
set_property IOSTANDARD LVCMOS18 [get_ports SFP_10_PDOWN_TRI_TR]
# ***************************************
# *****************************************
set_property PACKAGE_PIN W29 [get_ports SFP_11_PDOWN_TRI_TR]
set_property IOSTANDARD LVCMOS18 [get_ports SFP_11_PDOWN_TRI_TR]
# ***************************************
# *****************************************
set_property PACKAGE_PIN W26 [get_ports SFP_12_PDOWN_TRI_TR]
set_property IOSTANDARD LVCMOS18 [get_ports SFP_12_PDOWN_TRI_TR]
# ***************************************

###                    +------------------------------+
###==================  |---     B A N K  6 6       ---| ==================##
###                    +------------------------------+
#set_property PACKAGE_PIN F8 [get_ports FMC_HPC_LA07_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA07_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA07_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_LA07_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_LA07_P]
### +------------------------------------------------------------------+
#set_property PACKAGE_PIN B9 [get_ports FMC_HPC_LA16_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA16_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA16_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_LA16_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_LA16_P]
### +------------------------------------------------------------------+
#set_property PACKAGE_PIN D8 [get_ports FMC_HPC_LA15_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA15_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA15_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_LA15_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_LA15_P]
### +------------------------------------------------------------------+
#set_property PACKAGE_PIN B10 [get_ports FMC_HPC_LA14_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA14_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA14_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_LA14_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_LA14_P]
### +------------------------------------------------------------------+
#set_property PACKAGE_PIN D9 [get_ports FMC_HPC_LA13_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA13_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA13_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_LA13_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_LA13_P]
### +------------------------------------------------------------------+
#set_property PACKAGE_PIN E10 [get_ports FMC_HPC_LA12_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA12_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA12_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_LA12_P]
##set_property ODT RTT_NONE [get_ports FMC_HPC_LA12_P]
## +------------------------------------------------------------------+
#set_property PACKAGE_PIN L8 [get_ports FMC_HPC_LA10_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA10_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA10_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_LA10_P]
##set_property ODT RTT_NONE [get_ports FMC_HPC_LA10_P]
## +------------------------------------------------------------------+
#set_property PACKAGE_PIN J8 [get_ports FMC_HPC_LA08_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA08_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA08_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_LA08_P]
##set_property ODT RTT_NONE [get_ports FMC_HPC_LA08_P]
## +------------------------------------------------------------------+
#set_property PACKAGE_PIN K10 [get_ports FMC_HPC_LA02_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA02_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA02_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_LA02_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_LA02_P]
### +------------------------------------------------------------------+
#set_property PACKAGE_PIN G9 [get_ports FMC_HPC_LA01_CC_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA01_CC_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA01_CC_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_LA01_CC_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_LA01_CC_P]
### +------------------------------------------------------------------+
### ++ ***********************************************************************+
#set_property PACKAGE_PIN H11 [get_ports FMC_HPC_LA00_CC_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA00_CC_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA00_CC_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_LA00_CC_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_LA00_CC_P]
### +------------------------------------------------------------------+
### ++ ***********************************************************************+
#set_property PACKAGE_PIN H12 [get_ports FMC_HPC_CLK0_M2C_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_CLK0_M2C_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_CLK0_M2C_N]
##set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_CLK0_M2C_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_CLK0_M2C_P]
### +-------------------------------------------------------------------+
#set_property PACKAGE_PIN K11 [get_ports FMC_HPC_LA11_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA11_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA11_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_LA11_P]
##set_property ODT RTT_NONE [get_ports FMC_HPC_LA11_P]
## +------------------------------------------------------------------+
#set_property PACKAGE_PIN L13 [get_ports FMC_HPC_LA05_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA05_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA05_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_LA05_P]
##set_property ODT RTT_NONE [get_ports FMC_HPC_LA05_P]
## +------------------------------------------------------------------+
#set_property PACKAGE_PIN L12 [get_ports FMC_HPC_LA04_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA04_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA04_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_LA04_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_LA04_P]
### +------------------------------------------------------------------+
#set_property PACKAGE_PIN A13 [get_ports FMC_HPC_LA03_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA03_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA03_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_LA03_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_LA03_P]
### +------------------------------------------------------------------+
#set_property PACKAGE_PIN D13 [get_ports FMC_HPC_LA06_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA06_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA06_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_LA06_P]
##set_property ODT RTT_NONE [get_ports FMC_HPC_LA06_P]
## +------------------------------------------------------------------+
##                    +------------------------------+
##==================  |---     B A N K  6 8       ---| ==================##
##                    +------------------------------+

#set_property PACKAGE_PIN B14 [get_ports FMC_HPC_HA13_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA13_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA13_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_HA13_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_HA13_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN A19 [get_ports FMC_HPC_HA16_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA16_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA16_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_HA16_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_HA16_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN B15 [get_ports FMC_HPC_HA23_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA23_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA23_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_HA23_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_HA23_P]
### +------------------------------------------------------------------+


#set_property PACKAGE_PIN C19 [get_ports FMC_HPC_HA20_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA20_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA20_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_HA20_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_HA20_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN B17 [get_ports FMC_HPC_HA18_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA18_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA18_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_HA18_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_HA18_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN C18 [get_ports FMC_HPC_HA22_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA22_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA22_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_HA22_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_HA22_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN D14 [get_ports FMC_HPC_HA15_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA15_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA15_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_HA15_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_HA15_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN E15 [get_ports FMC_HPC_HA21_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA21_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA21_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_HA21_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_HA21_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN F15 [get_ports FMC_HPC_HA14_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA14_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA14_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_HA14_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_HA14_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN D19 [get_ports FMC_HPC_HA19_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA19_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA19_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_HA19_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_HA19_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN E16 [get_ports FMC_HPC_HA01_CC_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA01_CC_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA01_CC_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_HA01_CC_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_HA01_CC_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN E18 [get_ports FMC_HPC_HA17_CC_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA17_CC_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA17_CC_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_HA17_CC_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_HA17_CC_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN G17 [get_ports FMC_HPC_HA00_CC_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA00_CC_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA00_CC_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_HA00_CC_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_HA00_CC_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN F18 [get_ports FMC_HPC_HA09_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA09_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA09_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_HA09_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_HA09_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN G15 [get_ports FMC_HPC_HA03_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA03_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA03_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_HA03_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_HA03_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN G19 [get_ports FMC_HPC_HA04_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA04_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA04_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_HA04_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_HA04_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN H17 [get_ports FMC_HPC_HA10_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA10_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA10_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_HA10_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_HA10_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN H19 [get_ports FMC_HPC_HA02_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA02_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA02_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_HA02_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_HA02_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN J15 [get_ports FMC_HPC_HA05_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA05_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA05_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_HA05_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_HA05_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN K18 [get_ports FMC_HPC_HA08_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA08_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA08_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_HA08_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_HA08_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN L15 [get_ports FMC_HPC_HA06_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA06_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA06_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_HA06_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_HA06_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN J19 [get_ports FMC_HPC_HA11_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA11_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA11_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_HA11_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_HA11_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN K16 [get_ports FMC_HPC_HA12_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA12_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA12_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_HA12_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_HA12_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN L19 [get_ports FMC_HPC_HA07_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA07_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HA07_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_HA07_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_HA07_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN C11 [get_ports FMC_HPC_HB00_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HB00_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HB00_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_HB00_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_HB00_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN C12 [get_ports FMC_HPC_HB01_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HB01_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HB01_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_HB01_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_HB01_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN B29 [get_ports FMC_HPC_HB02_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HB02_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HB02_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_HB02_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_HB02_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN E28 [get_ports FMC_HPC_HB03_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HB03_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HB03_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_HB03_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_HB03_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN C27 [get_ports FMC_HPC_HB04_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HB04_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HB04_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_HB04_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_HB04_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN D28 [get_ports FMC_HPC_HB05_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HB05_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HB05_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_HB05_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_HB05_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN E11 [get_ports FMC_HPC_HB08_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HB08_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HB08_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_HB08_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_HB08_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN F13 [get_ports FMC_HPC_HB09_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HB09_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HB09_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_HB09_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_HB09_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN F27 [get_ports FMC_HPC_HB17_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HB17_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HB17_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_HB17_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_HB17_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN J13 [get_ports FMC_HPC_HB20_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HB20_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_HB20_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_HB20_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_HB20_P]
### +------------------------------------------------------------------+

##                    +------------------------------+
##==================  |---     B A N K  6 7       ---| ==================##
##                    +------------------------------+

#set_property PACKAGE_PIN A27 [get_ports FMC_HPC_LA33_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA33_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA33_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_LA33_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_LA33_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN E26 [get_ports FMC_HPC_LA32_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA32_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA32_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_LA32_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_LA32_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN B25 [get_ports FMC_HPC_LA31_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA31_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA31_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_LA31_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_LA31_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN C26 [get_ports FMC_HPC_LA30_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA30_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA30_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_LA30_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_LA30_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN B24 [get_ports FMC_HPC_LA20_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA20_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA20_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_LA20_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_LA20_P]
### +------------------------------------------------------------------+
#set_property PACKAGE_PIN D24 [get_ports FMC_HPC_LA17_CC_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA17_CC_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA17_CC_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_LA17_CC_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_LA17_CC_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN E22 [get_ports FMC_HPC_LA18_CC_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA18_CC_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA18_CC_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_LA18_CC_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_LA18_CC_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN B21 [get_ports FMC_HPC_LA28_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA28_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA28_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_LA28_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_LA28_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN C21 [get_ports FMC_HPC_LA19_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA19_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA19_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_LA19_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_LA19_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN B20 [get_ports FMC_HPC_LA29_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA29_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA29_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_LA29_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_LA29_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN D20 [get_ports FMC_HPC_LA25_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA25_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA25_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_LA25_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_LA25_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN G24 [get_ports FMC_HPC_LA22_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA22_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA22_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_LA22_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_LA22_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN E20 [get_ports FMC_HPC_LA24_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA24_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA24_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_LA24_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_LA24_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN F23 [get_ports FMC_HPC_LA21_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA21_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA21_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_LA21_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_LA21_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN G20 [get_ports FMC_HPC_LA26_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA26_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA26_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_LA26_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_LA26_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN G22 [get_ports FMC_HPC_LA23_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA23_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA23_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_LA23_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_LA23_P]
### +------------------------------------------------------------------+

#set_property PACKAGE_PIN H21 [get_ports FMC_HPC_LA27_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA27_P]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_LA27_N]
#set_property DIFF_TERM_ADV TERM_100 [get_ports FMC_HPC_LA27_P]
###set_property ODT RTT_NONE [get_ports FMC_HPC_LA27_P]
### +------------------------------------------------------------------+

set_property PACKAGE_PIN D23 [get_ports SI5345_OUT1_P]
set_property PACKAGE_PIN C23 [get_ports SI5345_OUT1_N]
set_property IOSTANDARD LVDS [get_ports SI5345_OUT1_P]
##set_property DIFF_TERM_ADV TERM_100 [get_ports SI5345_OUT1_P]
##set_property ODT RTT_NONE [get_ports SI5345_OUT1_P]
## +------------------------------------------------------------------+

#set_property LOC GTHE3_CHANNEL_X0Y12 [get_cells {gth1_example_top_inst/example_wrapper_inst/gth1_inst/inst/gen_gtwizard_gthe3_top.gth1_gtwizard_gthe3_inst/gen_gtwizard_gthe3.gen_channel_container[3].gen_enabled_channel.gthe3_channel_wrapper_inst/channel_inst/gthe3_channel_gen.gen_gthe3_channel_inst[0].GTHE3_CHANNEL_PRIM_INST}]
#set_property PACKAGE_PIN N4 [get_ports FMC_HPC_DP4_C2M_P]
#set_property PACKAGE_PIN M2 [get_ports FMC_HPC_DP4_M2C_P]
#set_property PACKAGE_PIN M1 [get_ports FMC_HPC_DP4_M2C_P_N]
#set_property PACKAGE_PIN N3 [get_ports FMC_HPC_DP4_C2M_P_N]

#set_property LOC GTHE3_CHANNEL_X0Y16 [get_cells {gth1_example_top_inst/example_wrapper_inst/gth1_inst/inst/gen_gtwizard_gthe3_top.gth1_gtwizard_gthe3_inst/gen_gtwizard_gthe3.gen_channel_container[4].gen_enabled_channel.gthe3_channel_wrapper_inst/channel_inst/gthe3_channel_gen.gen_gthe3_channel_inst[0].GTHE3_CHANNEL_PRIM_INST}]
#set_property PACKAGE_PIN F6 [get_ports FMC_HPC_DP0_C2M_P]
#set_property PACKAGE_PIN E4 [get_ports FMC_HPC_DP0_M2C_P]
#set_property PACKAGE_PIN E3 [get_ports FMC_HPC_DP0_M2C_P_N]
#set_property PACKAGE_PIN F5 [get_ports FMC_HPC_DP0_C2M_P_N]

###########################################################
### IBERT constraints
###########################################################
##  Comment:  Moved to   ipbus_contrs.tcl
##create_clock -name D_CLK -period 4.167 [get_ports SI5345_I_OUT7_P]
##gth_sysclkp_i]
##  Comment:  Moved to   ipbus_contrs.tcl
##set_clock_groups -group [get_clocks D_CLK -include_generated_clocks] -asynchronous
#set_property C_CLK_INPUT_FREQ_HZ 240000000 [get_debug_cores dbg_hub]
#set_property C_ENABLE_CLK_DIVIDER true [get_debug_cores dbg_hub]
###
###Eye scan
###
#set_property ES_EYE_SCAN_EN TRUE [get_cells ibert_all_gth_ch/inst/QUAD[*].u_q/CH[*].u_ch/u_gthe3_channel]
###
###gth_refclk lock constraints
###
#set_property PACKAGE_PIN AF6 [get_ports gth_refclk0p_i[0]]
#set_property PACKAGE_PIN AF5 [get_ports gth_refclk0n_i[0]]
#set_property PACKAGE_PIN AD6 [get_ports gth_refclk1p_i[0]]
#set_property PACKAGE_PIN AD5 [get_ports gth_refclk1n_i[0]]
#set_property PACKAGE_PIN AB6 [get_ports gth_refclk0p_i[1]]
#set_property PACKAGE_PIN AB5 [get_ports gth_refclk0n_i[1]]
#set_property PACKAGE_PIN Y6 [get_ports gth_refclk1p_i[1]]
#set_property PACKAGE_PIN Y5 [get_ports gth_refclk1n_i[1]]
##set_property PACKAGE_PIN V6 [get_ports gth_refclk0p_i[2]]
##set_property PACKAGE_PIN V5 [get_ports gth_refclk0n_i[2]]
##set_property PACKAGE_PIN T6 [get_ports gth_refclk1p_i[2]]
##set_property PACKAGE_PIN T5 [get_ports gth_refclk1n_i[2]]
#=====================================================================
##  Comment: Just becacuse  we have only 16 Links                    =
## ===================================================================
##set_property PACKAGE_PIN P6 [get_ports gth_refclk0p_i[3]]
##set_property PACKAGE_PIN P5 [get_ports gth_refclk0n_i[3]]
##set_property PACKAGE_PIN M6 [get_ports gth_refclk1p_i[3]]
##set_property PACKAGE_PIN M5 [get_ports gth_refclk1n_i[3]]
## ======================================================================
#set_property PACKAGE_PIN K6 [get_ports gth_refclk0p_i[2]]
#set_property PACKAGE_PIN K5 [get_ports gth_refclk0n_i[2]]
#set_property PACKAGE_PIN H6 [get_ports gth_refclk1p_i[2]]
#set_property PACKAGE_PIN H5 [get_ports gth_refclk1n_i[2]]
###
### Refclk constraints
###
## =====================================================================
##  Comment:  Moved to   ipbus_contrs.tcl
## =====================================================================
##create_clock -name gth_refclk0_0 -period 4.167 [get_ports gth_refclk0p_i[0]]
##create_clock -name gth_refclk1_0 -period 4.167 [get_ports gth_refclk1p_i[0]]
##set_clock_groups -group [get_clocks gth_refclk0_0 -include_generated_clocks] -asynchronous
##set_clock_groups -group [get_clocks gth_refclk1_0 -include_generated_clocks] -asynchronous
##
##create_clock -name gth_refclk0_1 -period 4.167 [get_ports gth_refclk0p_i[1]]
##create_clock -name gth_refclk1_1 -period 4.167 [get_ports gth_refclk1p_i[1]]
##set_clock_groups -group [get_clocks gth_refclk0_1 -include_generated_clocks] -asynchronous
##set_clock_groups -group [get_clocks gth_refclk1_1 -include_generated_clocks] -asynchronous
##
##create_clock -name gth_refclk0_2 -period 4.167 [get_ports gth_refclk0p_i[2]]
##create_clock -name gth_refclk1_2 -period 4.167 [get_ports gth_refclk1p_i[2]]
##set_clock_groups -group [get_clocks gth_refclk0_2 -include_generated_clocks] -asynchronous
##set_clock_groups -group [get_clocks gth_refclk1_2 -include_generated_clocks] -asynchronous
##
##create_clock -name gth_refclk0_3 -period 3.994 [get_ports gth_refclk0p_i[3]]
##create_clock -name gth_refclk1_3 -period 3.994 [get_ports gth_refclk1p_i[3]]
##set_clock_groups -group [get_clocks gth_refclk0_3 -include_generated_clocks] -asynchronous
##set_clock_groups -group [get_clocks gth_refclk1_3 -include_generated_clocks] -asynchronous

#======================================================================
##  Comment: Just becacuse  we have only 16 Links  (4 Quads)          =
## ====================================================================
#create_clock -name gth_refclk0_4 -period 4.167 [get_ports gth_refclk0p_i[4]]
#create_clock -name gth_refclk1_4 -period 4.167 [get_ports gth_refclk1p_i[4]]
#set_clock_groups -group [get_clocks gth_refclk0_4 -include_generated_clocks] -asynchronous
#set_clock_groups -group [get_clocks gth_refclk1_4 -include_generated_clocks] -asynchronous
###
### System clock pin locs and timing constraints
###
### used clock Si5345_I_OUT7
##set_property PACKAGE_PIN AK17 [get_ports gth_sysclkp_i]
##set_property IOSTANDARD DIFF_SSTL15 [get_ports gth_sysclkp_i]
###
### TX/RX out clock clock constraints
###
#### GT X0Y0
##set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[0].u_q/CH[0].u_ch/u_gthe3_channel/RXOUTCLK}] -include_generated_clocks]
##set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[0].u_q/CH[0].u_ch/u_gthe3_channel/TXOUTCLK}] -include_generated_clocks]
#### GT X0Y1
##set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[0].u_q/CH[1].u_ch/u_gthe3_channel/RXOUTCLK}] -include_generated_clocks]
##set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[0].u_q/CH[1].u_ch/u_gthe3_channel/TXOUTCLK}] -include_generated_clocks]
#### GT X0Y2
##set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[0].u_q/CH[2].u_ch/u_gthe3_channel/RXOUTCLK}] -include_generated_clocks]
##set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[0].u_q/CH[2].u_ch/u_gthe3_channel/TXOUTCLK}] -include_generated_clocks]
#### GT X0Y3
##set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[0].u_q/CH[3].u_ch/u_gthe3_channel/RXOUTCLK}] -include_generated_clocks]
##set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[0].u_q/CH[3].u_ch/u_gthe3_channel/TXOUTCLK}] -include_generated_clocks]
#### GT X0Y4
##set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[1].u_q/CH[0].u_ch/u_gthe3_channel/RXOUTCLK}] -include_generated_clocks]
##set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[1].u_q/CH[0].u_ch/u_gthe3_channel/TXOUTCLK}] -include_generated_clocks]
#### GT X0Y5
##set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[1].u_q/CH[1].u_ch/u_gthe3_channel/RXOUTCLK}] -include_generated_clocks]
##set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[1].u_q/CH[1].u_ch/u_gthe3_channel/TXOUTCLK}] -include_generated_clocks]
#### GT X0Y6
##set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[1].u_q/CH[2].u_ch/u_gthe3_channel/RXOUTCLK}] -include_generated_clocks]
##set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[1].u_q/CH[2].u_ch/u_gthe3_channel/TXOUTCLK}] -include_generated_clocks]
#### GT X0Y7
##set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[1].u_q/CH[3].u_ch/u_gthe3_channel/RXOUTCLK}] -include_generated_clocks]
##set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[1].u_q/CH[3].u_ch/u_gthe3_channel/TXOUTCLK}] -include_generated_clocks]
#### GT X0Y8
##set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[2].u_q/CH[0].u_ch/u_gthe3_channel/RXOUTCLK}] -include_generated_clocks]
##set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[2].u_q/CH[0].u_ch/u_gthe3_channel/TXOUTCLK}] -include_generated_clocks]
#### GT X0Y9
##set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[2].u_q/CH[1].u_ch/u_gthe3_channel/RXOUTCLK}] -include_generated_clocks]
##set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[2].u_q/CH[1].u_ch/u_gthe3_channel/TXOUTCLK}] -include_generated_clocks]
#### GT X0Y10
##set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[2].u_q/CH[2].u_ch/u_gthe3_channel/RXOUTCLK}] -include_generated_clocks]
##set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[2].u_q/CH[2].u_ch/u_gthe3_channel/TXOUTCLK}] -include_generated_clocks]
#### GT X0Y11
##set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[2].u_q/CH[3].u_ch/u_gthe3_channel/RXOUTCLK}] -include_generated_clocks]
##set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[2].u_q/CH[3].u_ch/u_gthe3_channel/TXOUTCLK}] -include_generated_clocks]
##
#### GT X0Y12
###set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[3].u_q/CH[0].u_ch/u_gthe3_channel/RXOUTCLK}] -include_generated_clocks]
###set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[3].u_q/CH[0].u_ch/u_gthe3_channel/TXOUTCLK}] -include_generated_clocks]
#### GT X0Y13
###set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[3].u_q/CH[1].u_ch/u_gthe3_channel/RXOUTCLK}] -include_generated_clocks]
###set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[3].u_q/CH[1].u_ch/u_gthe3_channel/TXOUTCLK}] -include_generated_clocks]
#### GT X0Y14
###set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[3].u_q/CH[2].u_ch/u_gthe3_channel/RXOUTCLK}] -include_generated_clocks]
###set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[3].u_q/CH[2].u_ch/u_gthe3_channel/TXOUTCLK}] -include_generated_clocks]
#### GT X0Y15
###set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[3].u_q/CH[3].u_ch/u_gthe3_channel/RXOUTCLK}] -include_generated_clocks]
###set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[3].u_q/CH[3].u_ch/u_gthe3_channel/TXOUTCLK}] -include_generated_clocks]
##
#### GT X0Y16
##set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[3].u_q/CH[0].u_ch/u_gthe3_channel/RXOUTCLK}] -include_generated_clocks]
##set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[3].u_q/CH[0].u_ch/u_gthe3_channel/TXOUTCLK}] -include_generated_clocks]
#### GT X0Y17
##set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[3].u_q/CH[1].u_ch/u_gthe3_channel/RXOUTCLK}] -include_generated_clocks]
##set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[3].u_q/CH[1].u_ch/u_gthe3_channel/TXOUTCLK}] -include_generated_clocks]
#### GT X0Y18
##set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[3].u_q/CH[2].u_ch/u_gthe3_channel/RXOUTCLK}] -include_generated_clocks]
##set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[3].u_q/CH[2].u_ch/u_gthe3_channel/TXOUTCLK}] -include_generated_clocks]
#### GT X0Y19
##set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[3].u_q/CH[3].u_ch/u_gthe3_channel/RXOUTCLK}] -include_generated_clocks]
##set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins {ibert_all_gth_ch/inst/QUAD[3].u_q/CH[3].u_ch/u_gthe3_channel/TXOUTCLK}] -include_generated_clocks]
###=====================================================================================


##=====================================================================================#
##    I  L   A       F  O  R       D D R 4                                         #
##=====================================================================================#

#create_debug_core u_ila_4 ila
#set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_4]
#set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_4]
#set_property C_ADV_TRIGGER false [get_debug_cores u_ila_4]
#set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_4]
#set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_4]
#set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_4]
#set_property C_TRIGIN_EN false [get_debug_cores u_ila_4]
#set_property C_TRIGOUT_EN false [get_debug_cores u_ila_4]
#set_property port_width 1 [get_debug_ports u_ila_4/clk]
#connect_debug_port u_ila_4/clk [get_nets [list slaves/ssm/clk_ipb]]
###connect_debug_port u_ila_4/clk [get_nets [list slaves/ssm/CLK]]


#set_property port_width 1 [get_debug_ports u_ila_4/probe0]
#connect_debug_port u_ila_4/probe0 [get_nets [list slaves/ssm/ddr4_buf_read]]

#create_debug_port u_ila_4 probe
#set_property port_width 1 [get_debug_ports u_ila_4/probe1]
#connect_debug_port u_ila_4/probe1 [get_nets [list slaves/ssm/ddr4_buf_write]]

#create_debug_port u_ila_4 probe
#set_property port_width 1 [get_debug_ports u_ila_4/probe2]
#connect_debug_port u_ila_4/probe2 [get_nets [list slaves/ssm/ddr4_config_reg_read]]

#create_debug_port u_ila_4 probe
#set_property port_width 1 [get_debug_ports u_ila_4/probe3]
#connect_debug_port u_ila_4/probe3 [get_nets [list slaves/ssm/ddr4_config_reg_write]]


#create_debug_port u_ila_4 probe
#set_property port_width 1 [get_debug_ports u_ila_4/probe4]
#connect_debug_port u_ila_4/probe4 [get_nets [list slaves/ssm/ddr4_ipbus_interface_0/pop_data]]

#create_debug_port u_ila_4 probe
#set_property port_width 1 [get_debug_ports u_ila_4/probe5]
#connect_debug_port u_ila_4/probe5 [get_nets [list slaves/ssm/ddr4_ipbus_interface_0/rdi_fifo_rden]]

#create_debug_port u_ila_4 probe
#set_property port_width 1 [get_debug_ports u_ila_4/probe6]
#connect_debug_port u_ila_4/probe6 [get_nets [list slaves/ssm/ddr4_ipbus_interface_0/rd_done]]

#create_debug_port u_ila_4 probe
#set_property port_width 1 [get_debug_ports u_ila_4/probe7]
#connect_debug_port u_ila_4/probe7 [get_nets [list slaves/ssm/ddr4_ipbus_interface_0/rqst_data]]


#create_debug_port u_ila_4 probe
#set_property port_width 1 [get_debug_ports u_ila_4/probe8]
#connect_debug_port u_ila_4/probe8 [get_nets [list slaves/ssm/ddr4_ipbus_interface_0/rst_logic_i]]

#create_debug_port u_ila_4 probe
#set_property port_width 1 [get_debug_ports u_ila_4/probe9]
#connect_debug_port u_ila_4/probe9 [get_nets [list slaves/ssm/ddr4_ipbus_interface_0/new_wr]]

#create_debug_port u_ila_4 probe
#set_property port_width 1 [get_debug_ports u_ila_4/probe10]
#connect_debug_port u_ila_4/probe10 [get_nets [list slaves/ssm/ddr4_ipbus_interface_0/new_rd]]

#create_debug_port u_ila_4 probe
#set_property port_width 1 [get_debug_ports u_ila_4/probe11]
#connect_debug_port u_ila_4/probe11 [get_nets [list slaves/ssm/ddr4_ipbus_interface_0/rst]]

#create_debug_port u_ila_4 probe
#set_property port_width 32 [get_debug_ports u_ila_4/probe12]
#connect_debug_port u_ila_4/probe12 [get_nets [list {slaves/ssm/ddr4_ipbus_interface_0/vme_addr[0]} {slaves/ssm/ddr4_ipbus_interface_0/vme_addr[1]} {slaves/ssm/ddr4_ipbus_interface_0/vme_addr[2]} {slaves/ssm/ddr4_ipbus_interface_0/vme_addr[3]} {slaves/ssm/ddr4_ipbus_interface_0/vme_addr[4]} {slaves/ssm/ddr4_ipbus_interface_0/vme_addr[5]} {slaves/ssm/ddr4_ipbus_interface_0/vme_addr[6]} {slaves/ssm/ddr4_ipbus_interface_0/vme_addr[7]} {slaves/ssm/ddr4_ipbus_interface_0/vme_addr[8]} {slaves/ssm/ddr4_ipbus_interface_0/vme_addr[9]} {slaves/ssm/ddr4_ipbus_interface_0/vme_addr[10]} {slaves/ssm/ddr4_ipbus_interface_0/vme_addr[11]} {slaves/ssm/ddr4_ipbus_interface_0/vme_addr[12]} {slaves/ssm/ddr4_ipbus_interface_0/vme_addr[13]} {slaves/ssm/ddr4_ipbus_interface_0/vme_addr[14]} {slaves/ssm/ddr4_ipbus_interface_0/vme_addr[15]} {slaves/ssm/ddr4_ipbus_interface_0/vme_addr[16]} {slaves/ssm/ddr4_ipbus_interface_0/vme_addr[17]} {slaves/ssm/ddr4_ipbus_interface_0/vme_addr[18]} {slaves/ssm/ddr4_ipbus_interface_0/vme_addr[19]} {slaves/ssm/ddr4_ipbus_interface_0/vme_addr[20]} {slaves/ssm/ddr4_ipbus_interface_0/vme_addr[21]} {slaves/ssm/ddr4_ipbus_interface_0/vme_addr[22]} {slaves/ssm/ddr4_ipbus_interface_0/vme_addr[23]} {slaves/ssm/ddr4_ipbus_interface_0/vme_addr[24]} {slaves/ssm/ddr4_ipbus_interface_0/vme_addr[25]} {slaves/ssm/ddr4_ipbus_interface_0/vme_addr[26]} {slaves/ssm/ddr4_ipbus_interface_0/vme_addr[27]} {slaves/ssm/ddr4_ipbus_interface_0/vme_addr[28]} {slaves/ssm/ddr4_ipbus_interface_0/vme_addr[29]} {slaves/ssm/ddr4_ipbus_interface_0/vme_addr[30]} {slaves/ssm/ddr4_ipbus_interface_0/vme_addr[31]}]]


#create_debug_port u_ila_4 probe
#set_property port_width 32 [get_debug_ports u_ila_4/probe13]
#connect_debug_port u_ila_4/probe13 [get_nets [list {slaves/ssm/ddr4_ipbus_interface_0/vme_din[0]} {slaves/ssm/ddr4_ipbus_interface_0/vme_din[1]} {slaves/ssm/ddr4_ipbus_interface_0/vme_din[2]} {slaves/ssm/ddr4_ipbus_interface_0/vme_din[3]} {slaves/ssm/ddr4_ipbus_interface_0/vme_din[4]} {slaves/ssm/ddr4_ipbus_interface_0/vme_din[5]} {slaves/ssm/ddr4_ipbus_interface_0/vme_din[6]} {slaves/ssm/ddr4_ipbus_interface_0/vme_din[7]} {slaves/ssm/ddr4_ipbus_interface_0/vme_din[8]} {slaves/ssm/ddr4_ipbus_interface_0/vme_din[9]} {slaves/ssm/ddr4_ipbus_interface_0/vme_din[10]} {slaves/ssm/ddr4_ipbus_interface_0/vme_din[11]} {slaves/ssm/ddr4_ipbus_interface_0/vme_din[12]} {slaves/ssm/ddr4_ipbus_interface_0/vme_din[13]} {slaves/ssm/ddr4_ipbus_interface_0/vme_din[14]} {slaves/ssm/ddr4_ipbus_interface_0/vme_din[15]} {slaves/ssm/ddr4_ipbus_interface_0/vme_din[16]} {slaves/ssm/ddr4_ipbus_interface_0/vme_din[17]} {slaves/ssm/ddr4_ipbus_interface_0/vme_din[18]} {slaves/ssm/ddr4_ipbus_interface_0/vme_din[19]} {slaves/ssm/ddr4_ipbus_interface_0/vme_din[20]} {slaves/ssm/ddr4_ipbus_interface_0/vme_din[21]} {slaves/ssm/ddr4_ipbus_interface_0/vme_din[22]} {slaves/ssm/ddr4_ipbus_interface_0/vme_din[23]} {slaves/ssm/ddr4_ipbus_interface_0/vme_din[24]} {slaves/ssm/ddr4_ipbus_interface_0/vme_din[25]} {slaves/ssm/ddr4_ipbus_interface_0/vme_din[26]} {slaves/ssm/ddr4_ipbus_interface_0/vme_din[27]} {slaves/ssm/ddr4_ipbus_interface_0/vme_din[28]} {slaves/ssm/ddr4_ipbus_interface_0/vme_din[29]} {slaves/ssm/ddr4_ipbus_interface_0/vme_din[30]} {slaves/ssm/ddr4_ipbus_interface_0/vme_din[31]}]]

#create_debug_port u_ila_4 probe
#set_property port_width 32 [get_debug_ports u_ila_4/probe14]
#connect_debug_port u_ila_4/probe14 [get_nets [list {slaves/ssm/ddr4_ipbus_interface_0/vme_rd_out[0]} {slaves/ssm/ddr4_ipbus_interface_0/vme_rd_out[1]} {slaves/ssm/ddr4_ipbus_interface_0/vme_rd_out[2]} {slaves/ssm/ddr4_ipbus_interface_0/vme_rd_out[3]} {slaves/ssm/ddr4_ipbus_interface_0/vme_rd_out[4]} {slaves/ssm/ddr4_ipbus_interface_0/vme_rd_out[5]} {slaves/ssm/ddr4_ipbus_interface_0/vme_rd_out[6]} {slaves/ssm/ddr4_ipbus_interface_0/vme_rd_out[7]} {slaves/ssm/ddr4_ipbus_interface_0/vme_rd_out[8]} {slaves/ssm/ddr4_ipbus_interface_0/vme_rd_out[9]} {slaves/ssm/ddr4_ipbus_interface_0/vme_rd_out[10]} {slaves/ssm/ddr4_ipbus_interface_0/vme_rd_out[11]} {slaves/ssm/ddr4_ipbus_interface_0/vme_rd_out[12]} {slaves/ssm/ddr4_ipbus_interface_0/vme_rd_out[13]} {slaves/ssm/ddr4_ipbus_interface_0/vme_rd_out[14]} {slaves/ssm/ddr4_ipbus_interface_0/vme_rd_out[15]} {slaves/ssm/ddr4_ipbus_interface_0/vme_rd_out[16]} {slaves/ssm/ddr4_ipbus_interface_0/vme_rd_out[17]} {slaves/ssm/ddr4_ipbus_interface_0/vme_rd_out[18]} {slaves/ssm/ddr4_ipbus_interface_0/vme_rd_out[19]} {slaves/ssm/ddr4_ipbus_interface_0/vme_rd_out[20]} {slaves/ssm/ddr4_ipbus_interface_0/vme_rd_out[21]} {slaves/ssm/ddr4_ipbus_interface_0/vme_rd_out[22]} {slaves/ssm/ddr4_ipbus_interface_0/vme_rd_out[23]} {slaves/ssm/ddr4_ipbus_interface_0/vme_rd_out[24]} {slaves/ssm/ddr4_ipbus_interface_0/vme_rd_out[25]} {slaves/ssm/ddr4_ipbus_interface_0/vme_rd_out[26]} {slaves/ssm/ddr4_ipbus_interface_0/vme_rd_out[27]} {slaves/ssm/ddr4_ipbus_interface_0/vme_rd_out[28]} {slaves/ssm/ddr4_ipbus_interface_0/vme_rd_out[29]} {slaves/ssm/ddr4_ipbus_interface_0/vme_rd_out[30]} {slaves/ssm/ddr4_ipbus_interface_0/vme_rd_out[31]}]]

#create_debug_port u_ila_4 probe
#set_property port_width 32 [get_debug_ports u_ila_4/probe15]
#connect_debug_port u_ila_4/probe15 [get_nets [list {slaves/ssm/ddr4_ipbus_interface_0/num_rd_i[0]} {slaves/ssm/ddr4_ipbus_interface_0/num_rd_i[1]} {slaves/ssm/ddr4_ipbus_interface_0/num_rd_i[2]} {slaves/ssm/ddr4_ipbus_interface_0/num_rd_i[3]} {slaves/ssm/ddr4_ipbus_interface_0/num_rd_i[4]} {slaves/ssm/ddr4_ipbus_interface_0/num_rd_i[5]} {slaves/ssm/ddr4_ipbus_interface_0/num_rd_i[6]} {slaves/ssm/ddr4_ipbus_interface_0/num_rd_i[7]} {slaves/ssm/ddr4_ipbus_interface_0/num_rd_i[8]} {slaves/ssm/ddr4_ipbus_interface_0/num_rd_i[9]} {slaves/ssm/ddr4_ipbus_interface_0/num_rd_i[10]} {slaves/ssm/ddr4_ipbus_interface_0/num_rd_i[11]} {slaves/ssm/ddr4_ipbus_interface_0/num_rd_i[12]} {slaves/ssm/ddr4_ipbus_interface_0/num_rd_i[13]} {slaves/ssm/ddr4_ipbus_interface_0/num_rd_i[14]} {slaves/ssm/ddr4_ipbus_interface_0/num_rd_i[15]} {slaves/ssm/ddr4_ipbus_interface_0/num_rd_i[16]} {slaves/ssm/ddr4_ipbus_interface_0/num_rd_i[17]} {slaves/ssm/ddr4_ipbus_interface_0/num_rd_i[18]} {slaves/ssm/ddr4_ipbus_interface_0/num_rd_i[19]} {slaves/ssm/ddr4_ipbus_interface_0/num_rd_i[20]} {slaves/ssm/ddr4_ipbus_interface_0/num_rd_i[21]} {slaves/ssm/ddr4_ipbus_interface_0/num_rd_i[22]} {slaves/ssm/ddr4_ipbus_interface_0/num_rd_i[23]} {slaves/ssm/ddr4_ipbus_interface_0/num_rd_i[24]} {slaves/ssm/ddr4_ipbus_interface_0/num_rd_i[25]} {slaves/ssm/ddr4_ipbus_interface_0/num_rd_i[26]} {slaves/ssm/ddr4_ipbus_interface_0/num_rd_i[27]} {slaves/ssm/ddr4_ipbus_interface_0/num_rd_i[28]} {slaves/ssm/ddr4_ipbus_interface_0/num_rd_i[29]} {slaves/ssm/ddr4_ipbus_interface_0/num_rd_i[30]} {slaves/ssm/ddr4_ipbus_interface_0/num_rd_i[31]}]]

#create_debug_port u_ila_4 probe
#set_property port_width 128 [get_debug_ports u_ila_4/probe16]
#connect_debug_port u_ila_4/probe16 [get_nets [list {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[0]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[1]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[2]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[3]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[4]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[5]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[6]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[7]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[8]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[9]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[10]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[11]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[12]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[13]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[14]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[15]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[16]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[17]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[18]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[19]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[20]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[21]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[22]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[23]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[24]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[25]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[26]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[27]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[28]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[29]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[30]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[31]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[32]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[33]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[34]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[35]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[36]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[37]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[38]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[39]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[40]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[41]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[42]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[43]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[44]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[45]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[46]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[47]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[48]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[49]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[50]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[51]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[52]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[53]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[54]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[55]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[56]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[57]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[58]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[59]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[60]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[61]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[62]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[63]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[64]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[65]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[66]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[67]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[68]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[69]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[70]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[71]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[72]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[73]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[74]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[75]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[76]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[77]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[78]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[79]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[80]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[81]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[82]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[83]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[84]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[85]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[86]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[87]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[88]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[89]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[90]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[91]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[92]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[93]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[94]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[95]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[96]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[97]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[98]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[99]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[100]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[101]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[102]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[103]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[104]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[105]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[106]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[107]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[108]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[109]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[110]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[111]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[112]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[113]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[114]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[115]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[116]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[117]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[118]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[119]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[120]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[121]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[122]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[123]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[124]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[125]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[126]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data[127]}]]

#create_debug_port u_ila_4 probe
#set_property port_width 1 [get_debug_ports u_ila_4/probe17]
#connect_debug_port u_ila_4/probe17 [get_nets [list slaves/ssm/ddr4_ipbus_interface_0/wr_done]]

#create_debug_port u_ila_4 probe
#set_property port_width 3 [get_debug_ports u_ila_4/probe18]
#connect_debug_port u_ila_4/probe18 [get_nets [list {slaves/ssm/ddr4_ipbus_interface_0/monitor_state[0]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_state[1]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_state[2]}]]


#create_debug_port u_ila_4 probe
#set_property port_width 32 [get_debug_ports u_ila_4/probe19]
#connect_debug_port u_ila_4/probe19 [get_nets [list {slaves/ssm/ddr4_ipbus_interface_0/data_count_aux[0]} {slaves/ssm/ddr4_ipbus_interface_0/data_count_aux[1]} {slaves/ssm/ddr4_ipbus_interface_0/data_count_aux[2]} {slaves/ssm/ddr4_ipbus_interface_0/data_count_aux[3]} {slaves/ssm/ddr4_ipbus_interface_0/data_count_aux[4]} {slaves/ssm/ddr4_ipbus_interface_0/data_count_aux[5]} {slaves/ssm/ddr4_ipbus_interface_0/data_count_aux[6]} {slaves/ssm/ddr4_ipbus_interface_0/data_count_aux[7]} {slaves/ssm/ddr4_ipbus_interface_0/data_count_aux[8]} {slaves/ssm/ddr4_ipbus_interface_0/data_count_aux[9]} {slaves/ssm/ddr4_ipbus_interface_0/data_count_aux[10]} {slaves/ssm/ddr4_ipbus_interface_0/data_count_aux[11]} {slaves/ssm/ddr4_ipbus_interface_0/data_count_aux[12]} {slaves/ssm/ddr4_ipbus_interface_0/data_count_aux[13]} {slaves/ssm/ddr4_ipbus_interface_0/data_count_aux[14]} {slaves/ssm/ddr4_ipbus_interface_0/data_count_aux[15]} {slaves/ssm/ddr4_ipbus_interface_0/data_count_aux[16]} {slaves/ssm/ddr4_ipbus_interface_0/data_count_aux[17]} {slaves/ssm/ddr4_ipbus_interface_0/data_count_aux[18]} {slaves/ssm/ddr4_ipbus_interface_0/data_count_aux[19]} {slaves/ssm/ddr4_ipbus_interface_0/data_count_aux[20]} {slaves/ssm/ddr4_ipbus_interface_0/data_count_aux[21]} {slaves/ssm/ddr4_ipbus_interface_0/data_count_aux[22]} {slaves/ssm/ddr4_ipbus_interface_0/data_count_aux[23]} {slaves/ssm/ddr4_ipbus_interface_0/data_count_aux[24]} {slaves/ssm/ddr4_ipbus_interface_0/data_count_aux[25]} {slaves/ssm/ddr4_ipbus_interface_0/data_count_aux[26]} {slaves/ssm/ddr4_ipbus_interface_0/data_count_aux[27]} {slaves/ssm/ddr4_ipbus_interface_0/data_count_aux[28]} {slaves/ssm/ddr4_ipbus_interface_0/data_count_aux[29]} {slaves/ssm/ddr4_ipbus_interface_0/data_count_aux[30]} {slaves/ssm/ddr4_ipbus_interface_0/data_count_aux[31]}]]

#create_debug_port u_ila_4 probe
#set_property port_width 128 [get_debug_ports u_ila_4/probe20]
#connect_debug_port u_ila_4/probe20 [get_nets [list {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[0]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[1]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[2]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[3]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[4]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[5]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[6]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[7]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[8]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[9]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[10]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[11]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[12]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[13]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[14]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[15]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[16]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[17]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[18]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[19]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[20]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[21]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[22]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[23]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[24]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[25]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[26]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[27]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[28]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[29]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[30]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[31]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[32]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[33]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[34]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[35]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[36]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[37]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[38]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[39]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[40]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[41]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[42]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[43]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[44]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[45]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[46]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[47]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[48]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[49]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[50]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[51]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[52]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[53]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[54]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[55]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[56]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[57]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[58]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[59]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[60]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[61]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[62]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[63]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[64]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[65]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[66]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[67]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[68]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[69]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[70]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[71]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[72]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[73]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[74]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[75]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[76]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[77]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[78]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[79]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[80]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[81]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[82]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[83]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[84]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[85]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[86]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[87]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[88]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[89]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[90]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[91]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[92]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[93]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[94]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[95]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[96]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[97]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[98]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[99]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[100]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[101]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[102]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[103]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[104]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[105]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[106]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[107]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[108]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[109]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[110]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[111]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[112]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[113]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[114]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[115]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[116]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[117]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[118]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[119]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[120]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[121]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[122]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[123]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[124]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[125]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[126]} {slaves/ssm/ddr4_ipbus_interface_0/monitor_data_rd[127]}]]

#create_debug_port u_ila_4 probe
#set_property port_width 1 [get_debug_ports u_ila_4/probe21]
#connect_debug_port u_ila_4/probe21 [get_nets [list slaves/ssm/ddr4_ipbus_interface_0/monitor_wr_trg]]

#create_debug_port u_ila_4 probe
#set_property port_width 32 [get_debug_ports u_ila_4/probe22]
#connect_debug_port u_ila_4/probe22 [get_nets [list {slaves/ssm/ddr4_ipbus_interface_0/data_rd_aux[0]} {slaves/ssm/ddr4_ipbus_interface_0/data_rd_aux[1]} {slaves/ssm/ddr4_ipbus_interface_0/data_rd_aux[2]} {slaves/ssm/ddr4_ipbus_interface_0/data_rd_aux[3]} {slaves/ssm/ddr4_ipbus_interface_0/data_rd_aux[4]} {slaves/ssm/ddr4_ipbus_interface_0/data_rd_aux[5]} {slaves/ssm/ddr4_ipbus_interface_0/data_rd_aux[6]} {slaves/ssm/ddr4_ipbus_interface_0/data_rd_aux[7]} {slaves/ssm/ddr4_ipbus_interface_0/data_rd_aux[8]} {slaves/ssm/ddr4_ipbus_interface_0/data_rd_aux[9]} {slaves/ssm/ddr4_ipbus_interface_0/data_rd_aux[10]} {slaves/ssm/ddr4_ipbus_interface_0/data_rd_aux[11]} {slaves/ssm/ddr4_ipbus_interface_0/data_rd_aux[12]} {slaves/ssm/ddr4_ipbus_interface_0/data_rd_aux[13]} {slaves/ssm/ddr4_ipbus_interface_0/data_rd_aux[14]} {slaves/ssm/ddr4_ipbus_interface_0/data_rd_aux[15]} {slaves/ssm/ddr4_ipbus_interface_0/data_rd_aux[16]} {slaves/ssm/ddr4_ipbus_interface_0/data_rd_aux[17]} {slaves/ssm/ddr4_ipbus_interface_0/data_rd_aux[18]} {slaves/ssm/ddr4_ipbus_interface_0/data_rd_aux[19]} {slaves/ssm/ddr4_ipbus_interface_0/data_rd_aux[20]} {slaves/ssm/ddr4_ipbus_interface_0/data_rd_aux[21]} {slaves/ssm/ddr4_ipbus_interface_0/data_rd_aux[22]} {slaves/ssm/ddr4_ipbus_interface_0/data_rd_aux[23]} {slaves/ssm/ddr4_ipbus_interface_0/data_rd_aux[24]} {slaves/ssm/ddr4_ipbus_interface_0/data_rd_aux[25]} {slaves/ssm/ddr4_ipbus_interface_0/data_rd_aux[26]} {slaves/ssm/ddr4_ipbus_interface_0/data_rd_aux[27]} {slaves/ssm/ddr4_ipbus_interface_0/data_rd_aux[28]} {slaves/ssm/ddr4_ipbus_interface_0/data_rd_aux[29]} {slaves/ssm/ddr4_ipbus_interface_0/data_rd_aux[30]} {slaves/ssm/ddr4_ipbus_interface_0/data_rd_aux[31]}]]

#create_debug_port u_ila_4 probe
#set_property port_width 32 [get_debug_ports u_ila_4/probe23]
#connect_debug_port u_ila_4/probe23 [get_nets [list {slaves/ssm/ddr4_ipbus_interface_0/cnt_aux[0]} {slaves/ssm/ddr4_ipbus_interface_0/cnt_aux[1]} {slaves/ssm/ddr4_ipbus_interface_0/cnt_aux[2]} {slaves/ssm/ddr4_ipbus_interface_0/cnt_aux[3]} {slaves/ssm/ddr4_ipbus_interface_0/cnt_aux[4]} {slaves/ssm/ddr4_ipbus_interface_0/cnt_aux[5]} {slaves/ssm/ddr4_ipbus_interface_0/cnt_aux[6]} {slaves/ssm/ddr4_ipbus_interface_0/cnt_aux[7]} {slaves/ssm/ddr4_ipbus_interface_0/cnt_aux[8]} {slaves/ssm/ddr4_ipbus_interface_0/cnt_aux[9]} {slaves/ssm/ddr4_ipbus_interface_0/cnt_aux[10]} {slaves/ssm/ddr4_ipbus_interface_0/cnt_aux[11]} {slaves/ssm/ddr4_ipbus_interface_0/cnt_aux[12]} {slaves/ssm/ddr4_ipbus_interface_0/cnt_aux[13]} {slaves/ssm/ddr4_ipbus_interface_0/cnt_aux[14]} {slaves/ssm/ddr4_ipbus_interface_0/cnt_aux[15]} {slaves/ssm/ddr4_ipbus_interface_0/cnt_aux[16]} {slaves/ssm/ddr4_ipbus_interface_0/cnt_aux[17]} {slaves/ssm/ddr4_ipbus_interface_0/cnt_aux[18]} {slaves/ssm/ddr4_ipbus_interface_0/cnt_aux[19]} {slaves/ssm/ddr4_ipbus_interface_0/cnt_aux[20]} {slaves/ssm/ddr4_ipbus_interface_0/cnt_aux[21]} {slaves/ssm/ddr4_ipbus_interface_0/cnt_aux[22]} {slaves/ssm/ddr4_ipbus_interface_0/cnt_aux[23]} {slaves/ssm/ddr4_ipbus_interface_0/cnt_aux[24]} {slaves/ssm/ddr4_ipbus_interface_0/cnt_aux[25]} {slaves/ssm/ddr4_ipbus_interface_0/cnt_aux[26]} {slaves/ssm/ddr4_ipbus_interface_0/cnt_aux[27]} {slaves/ssm/ddr4_ipbus_interface_0/cnt_aux[28]} {slaves/ssm/ddr4_ipbus_interface_0/cnt_aux[29]} {slaves/ssm/ddr4_ipbus_interface_0/cnt_aux[30]} {slaves/ssm/ddr4_ipbus_interface_0/cnt_aux[31]}]]

#create_debug_port u_ila_4 probe
#set_property port_width 28 [get_debug_ports u_ila_4/probe24]
#connect_debug_port u_ila_4/probe24 [get_nets [list {slaves/ssm/ddr4_ipbus_interface_0/rd_addr_r_aux[0]} {slaves/ssm/ddr4_ipbus_interface_0/rd_addr_r_aux[1]} {slaves/ssm/ddr4_ipbus_interface_0/rd_addr_r_aux[2]} {slaves/ssm/ddr4_ipbus_interface_0/rd_addr_r_aux[3]} {slaves/ssm/ddr4_ipbus_interface_0/rd_addr_r_aux[4]} {slaves/ssm/ddr4_ipbus_interface_0/rd_addr_r_aux[5]} {slaves/ssm/ddr4_ipbus_interface_0/rd_addr_r_aux[6]} {slaves/ssm/ddr4_ipbus_interface_0/rd_addr_r_aux[7]} {slaves/ssm/ddr4_ipbus_interface_0/rd_addr_r_aux[8]} {slaves/ssm/ddr4_ipbus_interface_0/rd_addr_r_aux[9]} {slaves/ssm/ddr4_ipbus_interface_0/rd_addr_r_aux[10]} {slaves/ssm/ddr4_ipbus_interface_0/rd_addr_r_aux[11]} {slaves/ssm/ddr4_ipbus_interface_0/rd_addr_r_aux[12]} {slaves/ssm/ddr4_ipbus_interface_0/rd_addr_r_aux[13]} {slaves/ssm/ddr4_ipbus_interface_0/rd_addr_r_aux[14]} {slaves/ssm/ddr4_ipbus_interface_0/rd_addr_r_aux[15]} {slaves/ssm/ddr4_ipbus_interface_0/rd_addr_r_aux[16]} {slaves/ssm/ddr4_ipbus_interface_0/rd_addr_r_aux[17]} {slaves/ssm/ddr4_ipbus_interface_0/rd_addr_r_aux[18]} {slaves/ssm/ddr4_ipbus_interface_0/rd_addr_r_aux[19]} {slaves/ssm/ddr4_ipbus_interface_0/rd_addr_r_aux[20]} {slaves/ssm/ddr4_ipbus_interface_0/rd_addr_r_aux[21]} {slaves/ssm/ddr4_ipbus_interface_0/rd_addr_r_aux[22]} {slaves/ssm/ddr4_ipbus_interface_0/rd_addr_r_aux[23]} {slaves/ssm/ddr4_ipbus_interface_0/rd_addr_r_aux[24]} {slaves/ssm/ddr4_ipbus_interface_0/rd_addr_r_aux[25]} {slaves/ssm/ddr4_ipbus_interface_0/rd_addr_r_aux[26]} {slaves/ssm/ddr4_ipbus_interface_0/rd_addr_r_aux[27]}]]

#create_debug_port u_ila_4 probe
#set_property port_width 28 [get_debug_ports u_ila_4/probe25]
#connect_debug_port u_ila_4/probe25 [get_nets [list {slaves/ssm/ddr4_ipbus_interface_0/wr_addr_r_aux[0]} {slaves/ssm/ddr4_ipbus_interface_0/wr_addr_r_aux[1]} {slaves/ssm/ddr4_ipbus_interface_0/wr_addr_r_aux[2]} {slaves/ssm/ddr4_ipbus_interface_0/wr_addr_r_aux[3]} {slaves/ssm/ddr4_ipbus_interface_0/wr_addr_r_aux[4]} {slaves/ssm/ddr4_ipbus_interface_0/wr_addr_r_aux[5]} {slaves/ssm/ddr4_ipbus_interface_0/wr_addr_r_aux[6]} {slaves/ssm/ddr4_ipbus_interface_0/wr_addr_r_aux[7]} {slaves/ssm/ddr4_ipbus_interface_0/wr_addr_r_aux[8]} {slaves/ssm/ddr4_ipbus_interface_0/wr_addr_r_aux[9]} {slaves/ssm/ddr4_ipbus_interface_0/wr_addr_r_aux[10]} {slaves/ssm/ddr4_ipbus_interface_0/wr_addr_r_aux[11]} {slaves/ssm/ddr4_ipbus_interface_0/wr_addr_r_aux[12]} {slaves/ssm/ddr4_ipbus_interface_0/wr_addr_r_aux[13]} {slaves/ssm/ddr4_ipbus_interface_0/wr_addr_r_aux[14]} {slaves/ssm/ddr4_ipbus_interface_0/wr_addr_r_aux[15]} {slaves/ssm/ddr4_ipbus_interface_0/wr_addr_r_aux[16]} {slaves/ssm/ddr4_ipbus_interface_0/wr_addr_r_aux[17]} {slaves/ssm/ddr4_ipbus_interface_0/wr_addr_r_aux[18]} {slaves/ssm/ddr4_ipbus_interface_0/wr_addr_r_aux[19]} {slaves/ssm/ddr4_ipbus_interface_0/wr_addr_r_aux[20]} {slaves/ssm/ddr4_ipbus_interface_0/wr_addr_r_aux[21]} {slaves/ssm/ddr4_ipbus_interface_0/wr_addr_r_aux[22]} {slaves/ssm/ddr4_ipbus_interface_0/wr_addr_r_aux[23]} {slaves/ssm/ddr4_ipbus_interface_0/wr_addr_r_aux[24]} {slaves/ssm/ddr4_ipbus_interface_0/wr_addr_r_aux[25]} {slaves/ssm/ddr4_ipbus_interface_0/wr_addr_r_aux[26]} {slaves/ssm/ddr4_ipbus_interface_0/wr_addr_r_aux[27]}]]

#create_debug_port u_ila_4 probe
#set_property port_width 1 [get_debug_ports u_ila_4/probe26]
#connect_debug_port u_ila_4/probe26 [get_nets [list slaves/ssm/ddr4_ipbus_interface_0/rdi_fifo_has_space]]

#create_debug_port u_ila_4 probe
#set_property port_width 5 [get_debug_ports u_ila_4/probe27]
#connect_debug_port u_ila_4/probe27 [get_nets [list {slaves/ssm/ddr4_ipbus_interface_0/cnt_rqst[0]} {slaves/ssm/ddr4_ipbus_interface_0/cnt_rqst[1]} {slaves/ssm/ddr4_ipbus_interface_0/cnt_rqst[2]} {slaves/ssm/ddr4_ipbus_interface_0/cnt_rqst[3]} {slaves/ssm/ddr4_ipbus_interface_0/cnt_rqst[4]}]]



## ==========================================================================================

##=====================================================================================#
##    I  L   A       F  O  R       ICAP         Version 1                              #
##=====================================================================================#

##create_debug_core u_ila_5 ila
##set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_5]
##set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_5]
##set_property C_ADV_TRIGGER false [get_debug_cores u_ila_5]
##set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_5]
##set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_5]
##set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_5]
##set_property C_TRIGIN_EN false [get_debug_cores u_ila_5]
##set_property C_TRIGOUT_EN false [get_debug_cores u_ila_5]
##set_property port_width 1 [get_debug_ports u_ila_5/clk]
##connect_debug_port u_ila_5/clk [get_nets [list slaves/icap/CLK]]
##
##
##
##set_property port_width 32 [get_debug_ports u_ila_5/probe0]
##connect_debug_port u_ila_5/probe0 [get_nets [list {slaves/icap/byte_swp_data[0]} {slaves/icap/byte_swp_data[1]} {slaves/icap/byte_swp_data[2]} {slaves/icap/byte_swp_data[3]} {slaves/icap/byte_swp_data[4]} {slaves/icap/byte_swp_data[5]} {slaves/icap/byte_swp_data[6]} {slaves/icap/byte_swp_data[7]} {slaves/icap/byte_swp_data[8]} {slaves/icap/byte_swp_data[9]} {slaves/icap/byte_swp_data[10]} {slaves/icap/byte_swp_data[11]} {slaves/icap/byte_swp_data[12]} {slaves/icap/byte_swp_data[13]} {slaves/icap/byte_swp_data[14]} {slaves/icap/byte_swp_data[15]} {slaves/icap/byte_swp_data[16]} {slaves/icap/byte_swp_data[17]} {slaves/icap/byte_swp_data[18]} {slaves/icap/byte_swp_data[19]} {slaves/icap/byte_swp_data[20]} {slaves/icap/byte_swp_data[21]} {slaves/icap/byte_swp_data[22]} {slaves/icap/byte_swp_data[23]} {slaves/icap/byte_swp_data[24]} {slaves/icap/byte_swp_data[25]} {slaves/icap/byte_swp_data[26]} {slaves/icap/byte_swp_data[27]} {slaves/icap/byte_swp_data[28]} {slaves/icap/byte_swp_data[29]} {slaves/icap/byte_swp_data[30]} {slaves/icap/byte_swp_data[31]}]]
##
##create_debug_port u_ila_5 probe
##set_property port_width 32 [get_debug_ports u_ila_5/probe1]
##connect_debug_port u_ila_5/probe1 [get_nets [list {slaves/icap/in_data[0]} {slaves/icap/in_data[1]} {slaves/icap/in_data[2]} {slaves/icap/in_data[3]} {slaves/icap/in_data[4]} {slaves/icap/in_data[5]} {slaves/icap/in_data[6]} {slaves/icap/in_data[7]} {slaves/icap/in_data[8]} {slaves/icap/in_data[9]} {slaves/icap/in_data[10]} {slaves/icap/in_data[11]} {slaves/icap/in_data[12]} {slaves/icap/in_data[13]} {slaves/icap/in_data[14]} {slaves/icap/in_data[15]} {slaves/icap/in_data[16]} {slaves/icap/in_data[17]} {slaves/icap/in_data[18]} {slaves/icap/in_data[19]} {slaves/icap/in_data[20]} {slaves/icap/in_data[21]} {slaves/icap/in_data[22]} {slaves/icap/in_data[23]} {slaves/icap/in_data[24]} {slaves/icap/in_data[25]} {slaves/icap/in_data[26]} {slaves/icap/in_data[27]} {slaves/icap/in_data[28]} {slaves/icap/in_data[29]} {slaves/icap/in_data[30]} {slaves/icap/in_data[31]}]]
##
##create_debug_port u_ila_5 probe
##set_property port_width 1 [get_debug_ports u_ila_5/probe2]
##connect_debug_port u_ila_5/probe2 [get_nets [list slaves/icap/csib]]
##
##create_debug_port u_ila_5 probe
##set_property port_width 1 [get_debug_ports u_ila_5/probe3]
##connect_debug_port u_ila_5/probe3 [get_nets [list slaves/icap/rdwrb]]
##
##create_debug_port u_ila_5 probe
##set_property port_width 1 [get_debug_ports u_ila_5/probe4]
##connect_debug_port u_ila_5/probe4 [get_nets [list slaves/icap/prdone]]
## ===================================================================================  #
##                                                                                      #
##    I  L   A       F  O  R       ICAP     Version 2                                   #
##===================================================================================== #

##create_debug_core u_ila_5 ila
##set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_5]
##set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_5]
##set_property C_ADV_TRIGGER false [get_debug_cores u_ila_5]
##set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_5]
##set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_5]
##set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_5]
##set_property C_TRIGIN_EN false [get_debug_cores u_ila_5]
##set_property C_TRIGOUT_EN false [get_debug_cores u_ila_5]
##set_property port_width 1 [get_debug_ports u_ila_5/clk]
##connect_debug_port u_ila_5/clk [get_nets [list slaves/icap_2.icap2/CLK]]
##
##
##set_property port_width 1 [get_debug_ports u_ila_5/probe0]
##connect_debug_port u_ila_5/probe0 [get_nets [list slaves/icap_2.icap2/avail]]
##
##create_debug_port u_ila_5 probe
##set_property port_width 32 [get_debug_ports u_ila_5/probe1]
##connect_debug_port u_ila_5/probe1 [get_nets [list {slaves/icap_2.icap2/out_data[0]} {slaves/icap_2.icap2/out_data[1]} {slaves/icap_2.icap2/out_data[2]} {slaves/icap_2.icap2/out_data[3]} {slaves/icap_2.icap2/out_data[4]} {slaves/icap_2.icap2/out_data[5]} {slaves/icap_2.icap2/out_data[6]} {slaves/icap_2.icap2/out_data[7]} {slaves/icap_2.icap2/out_data[8]} {slaves/icap_2.icap2/out_data[9]} {slaves/icap_2.icap2/out_data[10]} {slaves/icap_2.icap2/out_data[11]} {slaves/icap_2.icap2/out_data[12]} {slaves/icap_2.icap2/out_data[13]} {slaves/icap_2.icap2/out_data[14]} {slaves/icap_2.icap2/out_data[15]} {slaves/icap_2.icap2/out_data[16]} {slaves/icap_2.icap2/out_data[17]} {slaves/icap_2.icap2/out_data[18]} {slaves/icap_2.icap2/out_data[19]} {slaves/icap_2.icap2/out_data[20]} {slaves/icap_2.icap2/out_data[21]} {slaves/icap_2.icap2/out_data[22]} {slaves/icap_2.icap2/out_data[23]} {slaves/icap_2.icap2/out_data[24]} {slaves/icap_2.icap2/out_data[25]} {slaves/icap_2.icap2/out_data[26]} {slaves/icap_2.icap2/out_data[27]} {slaves/icap_2.icap2/out_data[28]} {slaves/icap_2.icap2/out_data[29]} {slaves/icap_2.icap2/out_data[30]} {slaves/icap_2.icap2/out_data[31]}]]
##
##create_debug_port u_ila_5 probe
##set_property port_width 1 [get_debug_ports u_ila_5/probe2]
##connect_debug_port u_ila_5/probe2 [get_nets [list slaves/icap_2.icap2/prdone]]
##
##create_debug_port u_ila_5 probe
##set_property port_width 1 [get_debug_ports u_ila_5/probe3]
##connect_debug_port u_ila_5/probe3 [get_nets [list slaves/icap_2.icap2/prerror]]
##
##create_debug_port u_ila_5 probe
##set_property port_width 1 [get_debug_ports u_ila_5/probe4]
##connect_debug_port u_ila_5/probe4 [get_nets [list slaves/icap_2.icap2/icap_cs]]
##
##create_debug_port u_ila_5 probe
##set_property port_width 32 [get_debug_ports u_ila_5/probe5]
##connect_debug_port u_ila_5/probe5 [get_nets [list {slaves/icap_2.icap2/bit_swapped[0]} {slaves/icap_2.icap2/bit_swapped[1]} {slaves/icap_2.icap2/bit_swapped[2]} {slaves/icap_2.icap2/bit_swapped[3]} {slaves/icap_2.icap2/bit_swapped[4]} {slaves/icap_2.icap2/bit_swapped[5]} {slaves/icap_2.icap2/bit_swapped[6]} {slaves/icap_2.icap2/bit_swapped[7]} {slaves/icap_2.icap2/bit_swapped[8]} {slaves/icap_2.icap2/bit_swapped[9]} {slaves/icap_2.icap2/bit_swapped[10]} {slaves/icap_2.icap2/bit_swapped[11]} {slaves/icap_2.icap2/bit_swapped[12]} {slaves/icap_2.icap2/bit_swapped[13]} {slaves/icap_2.icap2/bit_swapped[14]} {slaves/icap_2.icap2/bit_swapped[15]} {slaves/icap_2.icap2/bit_swapped[16]} {slaves/icap_2.icap2/bit_swapped[17]} {slaves/icap_2.icap2/bit_swapped[18]} {slaves/icap_2.icap2/bit_swapped[19]} {slaves/icap_2.icap2/bit_swapped[20]} {slaves/icap_2.icap2/bit_swapped[21]} {slaves/icap_2.icap2/bit_swapped[22]} {slaves/icap_2.icap2/bit_swapped[23]} {slaves/icap_2.icap2/bit_swapped[24]} {slaves/icap_2.icap2/bit_swapped[25]} {slaves/icap_2.icap2/bit_swapped[26]} {slaves/icap_2.icap2/bit_swapped[27]} {slaves/icap_2.icap2/bit_swapped[28]} {slaves/icap_2.icap2/bit_swapped[29]} {slaves/icap_2.icap2/bit_swapped[30]} {slaves/icap_2.icap2/bit_swapped[31]}]]
##
##create_debug_port u_ila_5 probe
##set_property port_width 1 [get_debug_ports u_ila_5/probe6]
##connect_debug_port u_ila_5/probe6 [get_nets [list slaves/icap_2.icap2/icap_rw]]
##
##
##create_debug_port u_ila_5 probe
##set_property port_width 32 [get_debug_ports u_ila_5/probe7]
##connect_debug_port u_ila_5/probe7 [get_nets [list {slaves/icap_2.icap2/d[0]} {slaves/icap_2.icap2/d[1]} {slaves/icap_2.icap2/d[2]} {slaves/icap_2.icap2/d[3]} {slaves/icap_2.icap2/d[4]} {slaves/icap_2.icap2/d[5]} {slaves/icap_2.icap2/d[6]} {slaves/icap_2.icap2/d[7]} {slaves/icap_2.icap2/d[8]} {slaves/icap_2.icap2/d[9]} {slaves/icap_2.icap2/d[10]} {slaves/icap_2.icap2/d[11]} {slaves/icap_2.icap2/d[12]} {slaves/icap_2.icap2/d[13]} {slaves/icap_2.icap2/d[14]} {slaves/icap_2.icap2/d[15]} {slaves/icap_2.icap2/d[16]} {slaves/icap_2.icap2/d[17]} {slaves/icap_2.icap2/d[18]} {slaves/icap_2.icap2/d[19]} {slaves/icap_2.icap2/d[20]} {slaves/icap_2.icap2/d[21]} {slaves/icap_2.icap2/d[22]} {slaves/icap_2.icap2/d[23]} {slaves/icap_2.icap2/d[24]} {slaves/icap_2.icap2/d[25]} {slaves/icap_2.icap2/d[26]} {slaves/icap_2.icap2/d[27]} {slaves/icap_2.icap2/d[28]} {slaves/icap_2.icap2/d[29]} {slaves/icap_2.icap2/d[30]} {slaves/icap_2.icap2/d[31]}]]
