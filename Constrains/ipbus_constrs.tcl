## ======================================================================================
## ==     IPbus
## ======================================================================================
proc false_path {patt clk} {
    set p [get_ports -quiet $patt -filter {direction != out}]
    if {[llength $p] != 0} {
        set_input_delay 0 -clock [get_clocks $clk] [get_ports $patt -filter {direction != out}]
        set_false_path -from [get_ports $patt -filter {direction != out}]
    }
    set p [get_ports -quiet $patt -filter {direction != in}]
    if {[llength $p] != 0} {
       	set_output_delay 0 -clock [get_clocks $clk] [get_ports $patt -filter {direction != in}]
	    set_false_path -to [get_ports $patt -filter {direction != in}]
	}
}

# Ethernet RefClk (156.25 MHz)
create_clock -period 6.4 -name eth_refclk [get_ports SI5345_I_OUT8_P]

# System clock (125 MHz)
create_clock -period 8 -name sysclk [get_ports SI5345_I_OUT9_P]

# LHC clock 40 MHz from divider on FMC TTC card
create_clock -period 25 -name lhc_clk_40 -waveform {0.000 12.500} [get_ports FMC_HPC_CLK0_M2C_P]

# LHC clock 160 MHz from ADN2812 CDR on FMC TTC card
create_clock -period 6.25 -name lhc_clk_160 -waveform {0.000 3.125} [get_ports FMC_HPC_CLK1_M2C_P]

## DDR3 memory reset
#set_false_path -from [get_pins ../ddr4_ipbus_interface/rst_mem_out_reg/C]
 
## between DDR3 controller clock and BC
#set_false_path -from [get_clocks clk_pll_i] -to [get_clocks clk_out_40_bc_clock]
#set_false_path -from [get_clocks clk_out_40_bc_clock] -to [get_clocks clk_pll_i]

set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks I] \ 
-group [get_clocks -include_generated_clocks [get_clocks -filter {name =~ txoutclk*}]] \
-group [get_clocks -include_generated_clocks [get_clocks -filter {name =~ ddr4_0_inst0_c0_sys_clk_p}]] \
-group [get_clocks -include_generated_clocks [get_clocks -filter {name =~ ddr4_1_inst0_c0_sys_clk_p}]] \
-group [get_clocks -include_generated_clocks {lhc_clk_40 lhc_clk_160}]
                     
set_property LOC GTHE3_CHANNEL_X0Y15 [get_cells -hier -filter {name=~infra/eth/*/*GTHE3_CHANNEL_PRIM_INST}]

false_path {leds[*]} sysclk

false_path {sn[*]} sysclk