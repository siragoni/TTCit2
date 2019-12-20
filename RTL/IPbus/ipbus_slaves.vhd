--
-- ipbus_ttcit_logic
--
-- selection of different IPBus slaves


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.ipbus.all;
use work.spi.all;
use work.ipbus_reg_types.all;
use work.ipbus_decode_ttcit_logic.all;
use work.ttc_codec_pkg.all;

entity ipbus_slaves is
	port(
		ipb_clk: in std_logic;
		ipb_rst: in std_logic;
		ipb_in: in ipb_wbus;
		ipb_out: out ipb_rbus;
		nuke: out std_logic;
		soft_rst: out std_logic;
		userled: out std_logic;
		fpga_temperature : in std_logic_vector (15 downto 0);
        fpga_vccaux : in std_logic_vector (15 downto 0);   
        fpga_vccint : in std_logic_vector (15 downto 0);   
        fpga_vccbram : in std_logic_vector (15 downto 0);
        fpga_alarms : in std_logic_vector (15 downto 0);     
		clk_bc: in std_logic;
        rst_bc: in std_logic;
		i2c_scl: inout std_logic;
		i2c_sda: inout std_logic;
		flash_spi_in_0  : in spi_mi;
        flash_spi_out_0 : out spi_mo;
        flash_spi_in_1  : in spi_mi;
        flash_spi_out_1 : out spi_mo;
        bbert_signal_out_sel: out std_logic_vector(7 downto 0);
        bbert_signal_in_sel: out std_logic_vector(7 downto 0);
        bbert_clk_out: out std_logic;
        bbert_signal_out: out std_logic;
        bbert_clk_in: in std_logic;
        bbert_signal_in: in std_logic;
        leds_F: out std_logic_vector(5 downto 1);
        sn: in std_logic_vector (7 downto 0);
        scope_a: out std_logic_vector(31 downto 0);
        scope_b: out std_logic_vector(31 downto 0);
        adc_clk: out std_logic;
        adc_cs: out std_logic_vector;
        adc_sdata: in std_logic;
        SI5345_SCLK: inout std_logic;
        SI5345_SDA_SDIO: inout std_logic;
        SI5345_INTR: in std_logic;
        SI5345_LOL: in std_logic;
        LED_EN                       : out std_logic_vector (31 downto 0); -- 25 LEDs
        SFP_LED_EN                   : out std_logic_vector (31 downto 0); -- 12 x RED, 12 x GREEN
        ADC_test_data                : out std_logic_vector (31 downto 0);
        ttc_data_i                   : in ttc_info_type;  
        ttc_status_i                 : in ttc_stat_type;
        ddr4_0_inst0_c0_ddr4_act_n   : out std_logic;   
        ddr4_0_inst0_c0_ddr4_adr     : out std_logic_vector (16 downto 0);
        ddr4_0_inst0_c0_ddr4_ba      : out std_logic_vector (1 downto 0);
        ddr4_0_inst0_c0_ddr4_bg      : out std_logic_vector (0 downto 0);  
        ddr4_0_inst0_c0_ddr4_ck_c    : out std_logic_vector (0 downto 0);
        ddr4_0_inst0_c0_ddr4_ck_t    : out std_logic_vector (0 downto 0);
        ddr4_0_inst0_c0_ddr4_cke     : out std_logic_vector (0 downto 0);
        ddr4_0_inst0_c0_ddr4_cs_n    : out std_logic_vector (0 downto 0);
        ddr4_0_inst0_c0_ddr4_dm_dbi_n: inout  std_logic_vector (1 downto 0);
        ddr4_0_inst0_c0_ddr4_dq      : inout  std_logic_vector  (15 downto 0);
        ddr4_0_inst0_c0_ddr4_dqs_c   : inout  std_logic_vector  (1 downto 0);
        ddr4_0_inst0_c0_ddr4_dqs_t   : inout  std_logic_vector  (1 downto 0);
        ddr4_0_inst0_c0_ddr4_odt     : out std_logic_vector   (0 downto 0);
        ddr4_0_inst0_c0_ddr4_reset_n : out std_logic; 
        ddr4_0_inst0_c0_sys_clk_n    : in  std_logic; 
        ddr4_0_inst0_c0_sys_clk_p    : in  std_logic;
        ddr4_1_inst0_c0_ddr4_act_n   : out std_logic;   
        ddr4_1_inst0_c0_ddr4_adr     : out std_logic_vector (16 downto 0);
        ddr4_1_inst0_c0_ddr4_ba      : out std_logic_vector (1 downto 0);
        ddr4_1_inst0_c0_ddr4_bg      : out std_logic_vector (0 downto 0);  
        ddr4_1_inst0_c0_ddr4_ck_c    : out std_logic_vector (0 downto 0);
        ddr4_1_inst0_c0_ddr4_ck_t    : out std_logic_vector (0 downto 0);
        ddr4_1_inst0_c0_ddr4_cke     : out std_logic_vector (0 downto 0);
        ddr4_1_inst0_c0_ddr4_cs_n    : out std_logic_vector (0 downto 0);
        ddr4_1_inst0_c0_ddr4_dm_dbi_n: inout  std_logic_vector (1 downto 0);
        ddr4_1_inst0_c0_ddr4_dq      : inout  std_logic_vector  (15 downto 0);
        ddr4_1_inst0_c0_ddr4_dqs_c   : inout  std_logic_vector  (1 downto 0);
        ddr4_1_inst0_c0_ddr4_dqs_t   : inout  std_logic_vector  (1 downto 0);
        ddr4_1_inst0_c0_ddr4_odt     : out std_logic_vector   (0 downto 0);
        ddr4_1_inst0_c0_ddr4_reset_n : out std_logic; 
        ddr4_1_inst0_c0_sys_clk_n    : in  std_logic; 
        ddr4_1_inst0_c0_sys_clk_p    : in  std_logic
	);

end ipbus_slaves;

architecture rtl of ipbus_slaves is

	signal ipbw: ipb_wbus_array(N_SLAVES - 1 downto 0);
	signal ipbr: ipb_rbus_array(N_SLAVES - 1 downto 0);
	signal stat: ipb_reg_v(7 downto 0);
	signal ctrl: ipb_reg_v(6 downto 0);
	signal scl_pad_0_o, sda_pad_0_o, scl_pad_0_i, sda_pad_0_i, scl_padoen_0_o, sda_padoen_0_o: std_logic;
	signal scl_pad_1_o, sda_pad_1_o, scl_pad_1_i, sda_pad_1_i, scl_padoen_1_o, sda_padoen_1_o: std_logic;
	signal scl_pad_2_o, sda_pad_2_o, scl_pad_2_i, sda_pad_2_i, scl_padoen_2_o, sda_padoen_2_o: std_logic;
	signal spi_0_ss: std_logic_vector (7 downto 0);
--	signal spi_1_ss: std_logic_vector (1 downto 0);
    signal adc_cs_int: std_logic_vector (7 downto 0);
    signal FMC_SFP_SEL: std_logic_vector (31 downto 0);
    --
    signal ssm_status  : ipb_reg_v (2 downto 0);
    signal ssm_control : ipb_reg_v (0 downto 0);
    signal ssm_data_s  : std_logic_vector(127 downto 0);
    signal tdg_status  : ipb_reg_v (2 downto 0);
    signal tdg_control : ipb_reg_v (0 downto 0);
    signal tdg_data_s  : std_logic_vector(127 downto 0);
    --
    signal inc_for_cnts : std_logic_vector(47 downto 0);
    signal rst_ttcit_counters : std_logic;
   
    constant  active_s: boolean := true;  -- Comment: Enabled or disabled the  part of code 
    
begin

-- ipbus address decode
		
	fabric: entity work.ipbus_fabric_sel
    generic map(
    	NSLV => N_SLAVES,
    	SEL_WIDTH => IPBUS_SEL_WIDTH)
    port map(
      ipb_in => ipb_in,
      ipb_out => ipb_out,
      sel => ipbus_sel_ttcit_logic(ipb_in.ipb_addr),
      ipb_to_slaves => ipbw,
      ipb_from_slaves => ipbr
    );

-- Fixed Status registers: Board ID nad FW_INFO.
-- Other STAT registers can be changed as necessary
-- Must be the same on all boards in Alice CTP IPbus structure

stat_ctrl_regs: entity work.ipbus_ctrlreg_v
        generic map(N_STAT => 8, N_CTRL => 7, SWAP_ORDER => true)
        port map(
			clk => ipb_clk,
			reset => ipb_rst,
			ipbus_in => ipbw(N_SLV_CTRL),
			ipbus_out => ipbr(N_SLV_CTRL),
			d => stat, -- in
			q => ctrl  -- out
		);

    stat(0) <= x"000000" & sn(7 downto 0); -- Board ID
    stat(1) <= x"0d000301"; -- FW info: type[31:24] = xD->ttcit_logic, version[23:8] -> .., subversion[7:0] -> .. 
    stat(2) <= x"0000000" & '0' & '0' & SI5345_INTR & SI5345_LOL ; -- STARUS reg
    stat(3) <= x"0000" & fpga_temperature;
    stat(4) <= x"0000" & fpga_vccaux;   
    stat(5) <= x"0000" & fpga_vccint;   
    stat(6) <= x"0000" & fpga_vccbram;  
    stat(7) <= x"0000" & fpga_alarms;
	
	soft_rst <= ctrl(0)(0);
	nuke <= ctrl(0)(1);
	rst_ttcit_counters <= ctrl(0)(4);
	scope_a <= ctrl(1);
	scope_b <= ctrl(2);
	FMC_SFP_SEL <= ctrl(3);
	LED_EN <= ctrl(4);
	SFP_LED_EN <= ctrl(5);
	ADC_test_data <= ctrl(6);

-- Slave 2: test RAM 1kword

slave2: entity work.ipbus_ram
		generic map(ADDR_WIDTH => 10)
		port map(
			clk => ipb_clk,
			reset => ipb_rst,
			ipbus_in => ipbw(N_SLV_RAM),
			ipbus_out => ipbr(N_SLV_RAM)
		);

-- Slave 3: test reg

slave3: entity work.ipbus_reg_v
		port map(
			clk => ipb_clk,
			reset => ipb_rst,
			ipbus_in => ipbw(N_SLV_REG),
			ipbus_out => ipbr(N_SLV_REG),
			q => open
		);
	
-- Slave 4: test peephole RAM

slave4: entity work.ipbus_peephole_ram
		generic map(ADDR_WIDTH => 10)
		port map(
			clk => ipb_clk,
			reset => ipb_rst,
			ipbus_in => ipbw(N_SLV_PRAM),
			ipbus_out => ipbr(N_SLV_PRAM)
		);

-- Slave 5: I2C master MAIN

i2c_main: entity work.ipbus_i2c_master
		port map(
			clk => ipb_clk, -- 32 MHz
			rst => ipb_rst,
			ipb_in => ipbw(N_SLV_I2CMAIN),
			ipb_out => ipbr(N_SLV_I2CMAIN),
			scl_pad_i => scl_pad_0_i,
            scl_pad_o => scl_pad_0_o,
            scl_padoen_o => scl_padoen_0_o,
            sda_pad_i => sda_pad_0_i,
            sda_pad_o => sda_pad_0_o,
            sda_padoen_o => sda_padoen_0_o
		);

    i2c_scl <= scl_pad_0_o when (scl_padoen_0_o = '0') else 'Z';
    i2c_sda <= sda_pad_0_o when (sda_padoen_0_o = '0') else 'Z';
    scl_pad_0_i <= i2c_scl;
    sda_pad_0_i <= i2c_sda;

-- Slave 6: SPI master for R/W Flash memory 0 (FPGA bank 0)

spi_flash_0: entity work.ipbus_spi32
	         generic map (BYTE_SPI => TRUE, ADDR_WIDTH => 9)
             port map (
		          ipbus_clk => ipb_clk, -- 32 MHz
		          reset => ipb_rst,
		          ipb_in => ipbw(N_SLV_FLASH_SPI_RAM_0),
		          ipb_out => ipbr(N_SLV_FLASH_SPI_RAM_0),
		          spi_in => flash_spi_in_0, -- in
		          spi_out => flash_spi_out_0, -- out
		          selreg => open -- out (up to 2 slaves)
                );

-- Slave 7: SPI master for R/W Flash memory 1 (FPGA bank 48)

spi_flash_1: entity work.ipbus_spi32
	         generic map (BYTE_SPI => TRUE, ADDR_WIDTH => 9)
             port map (
		          ipbus_clk => ipb_clk, -- 32 MHz
		          reset => ipb_rst,
		          ipb_in => ipbw(N_SLV_FLASH_SPI_RAM_1),
		          ipb_out => ipbr(N_SLV_FLASH_SPI_RAM_1),
		          spi_in => flash_spi_in_1, -- in
		          spi_out => flash_spi_out_1, -- out
		          selreg => open -- out (up to 2 slaves)
                );

-- Slave 8: BBERT

bbert: entity work.ipbus_bbert
		port map(   
            clk => ipb_clk, -- 32 MHz 
            reset => ipb_rst, 
        	ipbus_in => ipbw(N_SLV_BBERT),
            ipbus_out => ipbr(N_SLV_BBERT),
            q => open,
            bbert_signal_out_sel => bbert_signal_out_sel, -- 160 input pins
            bbert_signal_in_sel => bbert_signal_in_sel, -- 160 output pins
            bbert_clk_out => bbert_clk_out, -- CLK going out with PRBS signal in order to compensate signal delay
            bbert_signal_out => bbert_signal_out, -- PRBS signal going to selected test channel
            bbert_clk_in => bbert_clk_in,
        	bbert_signal_in => bbert_signal_in, -- input signal which should be checked
        	leds_F => leds_F
        );

-- Slave 9: SPI master for ADC reading

spi_adc: entity work.ipbus_spi
		port map(
            clk => ipb_clk, -- 32 MHz
            rst => ipb_rst,
            ipb_in => ipbw(N_SLV_SPIADC),
            ipb_out => ipbr(N_SLV_SPIADC),
            ss =>  adc_cs_int, -- out (up to 8 slaves)
            mosi => open, -- out
            miso => adc_sdata, -- in
            sclk => adc_clk   -- out 
        );

    adc_cs <= adc_cs_int(0 downto 0);
    
-- Slave 10: I2C master for Si5345 for LHC clock
    
i2c_si5345: entity work.ipbus_i2c_master
        port map(
            clk => ipb_clk, -- 32 MHz
            rst => ipb_rst,
            ipb_in => ipbw(N_SLV_I2CPLL),
            ipb_out => ipbr(N_SLV_I2CPLL),
            scl_pad_i => scl_pad_1_i,
            scl_pad_o => scl_pad_1_o,
            scl_padoen_o => scl_padoen_1_o,
            sda_pad_i => sda_pad_1_i,
            sda_pad_o => sda_pad_1_o,
            sda_padoen_o => sda_padoen_1_o
        );
    
        SI5345_SCLK <= scl_pad_1_o when (scl_padoen_1_o = '0') else 'Z';
        SI5345_SDA_SDIO <= sda_pad_1_o when (sda_padoen_1_o = '0') else 'Z';
        scl_pad_1_i <= SI5345_SCLK;
        sda_pad_1_i <= SI5345_SDA_SDIO;

ssm_ctrl: entity work.ipbus_syncreg_v
		generic map(N_CTRL => 1, N_STAT => 3)
        port map (
             clk    => ipb_clk, 
             rst    => ipb_rst,
             ipb_in   => ipbw(N_SLV_SSMCTRL),
             ipb_out  => ipbr(N_SLV_SSMCTRL),
             -------------------------------
             slv_clk => clk_bc,
             d => ssm_status, -- in
             q => ssm_control -- out
                );

ssm_data_s(127 downto 48) <= x"00000000000000000000"; -- 80 bits
ssm_data_s(47) <= ttc_status_i.ready;
ssm_data_s(46) <= ttc_status_i.err_sng;
ssm_data_s(45) <= ttc_status_i.err_dbl;
ssm_data_s(44) <= ttc_status_i.err_comm;
ssm_data_s(43) <= ttc_status_i.div_nrst;

ssm_data_s(42) <= ttc_data_i.l1accept;   
ssm_data_s(41) <= ttc_data_i.brc_strobe; 
ssm_data_s(40 downto 39) <= ttc_data_i.brc_t2; -- 2 bits     
ssm_data_s(38 downto 35) <= ttc_data_i.brc_d4; -- 4 bits     
ssm_data_s(34) <= ttc_data_i.brc_e;      
ssm_data_s(33) <= ttc_data_i.brc_b;      
ssm_data_s(32) <= ttc_data_i.adr_strobe; 
ssm_data_s(31 downto 18) <= ttc_data_i.adr_a14;    
ssm_data_s(17) <= ttc_data_i.adr_e;      
ssm_data_s(16 downto 9) <= ttc_data_i.adr_s8;     
ssm_data_s(8 downto 1) <= ttc_data_i.adr_d8;     
ssm_data_s(0) <= ttc_data_i.clk40_gated;

ssm: entity work.ipbus_ssm_clkbc
		port map(
			clk => ipb_clk,
			reset => ipb_rst,
			ipbus_in => ipbw(N_SLV_SSM),
			ipbus_out => ipbr(N_SLV_SSM),
			q => open,
			-- 40 Mhz clock domain ----------------------------------
			clk_bc => clk_bc,
            rst_bc => rst_bc,
            ssm_data_i => ssm_data_s,
            ssm_status => ssm_status, -- out, 3 register
            ssm_control => ssm_control, -- in, 1 registers
            --------------------------------------------------------
			ddr4_0_inst0_c0_ddr4_act_n => ddr4_0_inst0_c0_ddr4_act_n,   
            ddr4_0_inst0_c0_ddr4_adr => ddr4_0_inst0_c0_ddr4_adr,     
            ddr4_0_inst0_c0_ddr4_ba => ddr4_0_inst0_c0_ddr4_ba,      
            ddr4_0_inst0_c0_ddr4_bg => ddr4_0_inst0_c0_ddr4_bg,
            ddr4_0_inst0_c0_ddr4_ck_c => ddr4_0_inst0_c0_ddr4_ck_c,
            ddr4_0_inst0_c0_ddr4_ck_t => ddr4_0_inst0_c0_ddr4_ck_t,
            ddr4_0_inst0_c0_ddr4_cke => ddr4_0_inst0_c0_ddr4_cke,     
            ddr4_0_inst0_c0_ddr4_cs_n => ddr4_0_inst0_c0_ddr4_cs_n,
            ddr4_0_inst0_c0_ddr4_dm_dbi_n => ddr4_0_inst0_c0_ddr4_dm_dbi_n,
            ddr4_0_inst0_c0_ddr4_dq => ddr4_0_inst0_c0_ddr4_dq,
            ddr4_0_inst0_c0_ddr4_dqs_c => ddr4_0_inst0_c0_ddr4_dqs_c,
            ddr4_0_inst0_c0_ddr4_dqs_t => ddr4_0_inst0_c0_ddr4_dqs_t,
            ddr4_0_inst0_c0_ddr4_odt => ddr4_0_inst0_c0_ddr4_odt,
            ddr4_0_inst0_c0_ddr4_reset_n => ddr4_0_inst0_c0_ddr4_reset_n,
            ddr4_0_inst0_c0_sys_clk_n => ddr4_0_inst0_c0_sys_clk_n,
            ddr4_0_inst0_c0_sys_clk_p => ddr4_0_inst0_c0_sys_clk_p,
            ssm_data_o   => open, -- 128 bits
		    ssm_strobe_o => open
		);                

tdg_ctrl: entity work.ipbus_syncreg_v
		generic map(N_CTRL => 1, N_STAT => 3)
        port map (
             clk    => ipb_clk, 
             rst    => ipb_rst,
             ipb_in   => ipbw(N_SLV_TDGCTRL),
             ipb_out  => ipbr(N_SLV_TDGCTRL),
             -------------------------------
             slv_clk => clk_bc,
             d => tdg_status, -- in
             q => tdg_control -- out
                );

tdg: entity work.ipbus_tdg_clkbc
		port map(
			clk => ipb_clk,
			reset => ipb_rst,
			ipbus_in => ipbw(N_SLV_TDG),
			ipbus_out => ipbr(N_SLV_TDG),
		    q => open,
			-- 40 Mhz clock domain ----------------------------------
		    clk_bc => clk_bc,
            rst_bc => rst_bc,
            tdg_data_i => ssm_data_s,
            tdg_status => tdg_status, -- out, 3 register
            tdg_control => tdg_control, -- in, 1 register
            ---------------------------------------------------------
		    ddr4_1_inst0_c0_ddr4_act_n => ddr4_1_inst0_c0_ddr4_act_n,   
            ddr4_1_inst0_c0_ddr4_adr => ddr4_1_inst0_c0_ddr4_adr,     
            ddr4_1_inst0_c0_ddr4_ba => ddr4_1_inst0_c0_ddr4_ba,      
            ddr4_1_inst0_c0_ddr4_bg => ddr4_1_inst0_c0_ddr4_bg,
            ddr4_1_inst0_c0_ddr4_ck_c => ddr4_1_inst0_c0_ddr4_ck_c,
            ddr4_1_inst0_c0_ddr4_ck_t => ddr4_1_inst0_c0_ddr4_ck_t,
            ddr4_1_inst0_c0_ddr4_cke => ddr4_1_inst0_c0_ddr4_cke,     
            ddr4_1_inst0_c0_ddr4_cs_n => ddr4_1_inst0_c0_ddr4_cs_n,
            ddr4_1_inst0_c0_ddr4_dm_dbi_n => ddr4_1_inst0_c0_ddr4_dm_dbi_n,
            ddr4_1_inst0_c0_ddr4_dq => ddr4_1_inst0_c0_ddr4_dq,
            ddr4_1_inst0_c0_ddr4_dqs_c => ddr4_1_inst0_c0_ddr4_dqs_c,
            ddr4_1_inst0_c0_ddr4_dqs_t => ddr4_1_inst0_c0_ddr4_dqs_t,
            ddr4_1_inst0_c0_ddr4_odt => ddr4_1_inst0_c0_ddr4_odt,
            ddr4_1_inst0_c0_ddr4_reset_n => ddr4_1_inst0_c0_ddr4_reset_n,
            ddr4_1_inst0_c0_sys_clk_n => ddr4_1_inst0_c0_sys_clk_n,
            ddr4_1_inst0_c0_sys_clk_p => ddr4_1_inst0_c0_sys_clk_p,
            tdg_data_o   => open, -- 128 bits
		    tdg_strobe_o => open
            );
            
--======================================
--        Trigger counters
--======================================

inc_for_cnts(47) <= ttc_status_i.ready;
inc_for_cnts(46) <= ttc_status_i.err_sng;
inc_for_cnts(45) <= ttc_status_i.err_dbl;
inc_for_cnts(44) <= ttc_status_i.err_comm;
inc_for_cnts(43) <= ttc_status_i.div_nrst;

inc_for_cnts(42) <= ttc_data_i.l1accept;   
inc_for_cnts(41) <= ttc_data_i.brc_strobe; 
inc_for_cnts(40 downto 39) <= ttc_data_i.brc_t2; -- 2 bits     
inc_for_cnts(38 downto 35) <= ttc_data_i.brc_d4; -- 4 bits     
inc_for_cnts(34) <= ttc_data_i.brc_e;      
inc_for_cnts(33) <= ttc_data_i.brc_b;      
inc_for_cnts(32) <= ttc_data_i.adr_strobe; 
inc_for_cnts(31 downto 18) <= ttc_data_i.adr_a14;    
inc_for_cnts(17) <= ttc_data_i.adr_e;      
inc_for_cnts(16 downto 9) <= ttc_data_i.adr_s8;     
inc_for_cnts(8 downto 1) <= ttc_data_i.adr_d8;     
inc_for_cnts(0) <= ttc_data_i.clk40_gated;
    
ttcit_counters: entity work.ipbus_ctrs_v
	generic map(N_CTRS => 48, CTR_WDS => 1, LIMIT => FALSE)
	port map(
		ipb_clk  => ipb_clk, 
        ipb_rst  => ipb_rst,
        ipb_in   => ipbw(N_SLV_CNTS),
        ipb_out  => ipbr(N_SLV_CNTS),
		clk      => clk_bc,
		rst      => rst_ttcit_counters,
		inc      => inc_for_cnts,
		dec      => (others => '0'), -- decrement not used
		q        => open -- out std_logic_vector(N_CTRS * CTR_WDS * 32 - 1 downto 0)
	);
            
  -- =====================================================================
  -- == Slave 11  -- Comment: Second version  Xilinx Example           ==
  -- =====================================================================        
     icap2: entity  work.ipb_slave_icap_2
         port map (
                  clk       => ipb_clk, 
                  reset     => ipb_rst, 
                  ipbus_in  => ipbw(N_SLV_ICAP), 
                  ipbus_out => ipbr(N_SLV_ICAP)
              );    
          
                 
-- Slave ICAP    
-- ICAPE3: Internal Configuration Access Port
-- To see ICAPE3: IPROG code, go to the function HwIcapLowLevelIPROG in the vcu108_emc_rw.c
-- IPROG is To see than internal programming of the FPGA commanded by a series of register
-- writes through the internal configuration access port (ICAP)
-- After IPROG commences, the FPGA erases all of the current configuration except for 
-- the Warm Boot Start Address Register (also called WBSTAR). This register can contain
-- a non-zero address where the FPGA begins loading the configuration image. 
    
--   ICAPE3_inst : ICAPE3
--   generic map (
--      DEVICE_ID => X"03628093",      -- Specifies the pre-programmed Device ID value to be used for simulation
--                                     -- purposes.
--      ICAP_AUTO_SWITCH => "DISABLE", -- Enable switch ICAP using sync word
--      SIM_CFG_FILE_NAME => "NONE"    -- Specifies the Raw Bitstream (RBT) file to be parsed by the simulation
--                                     -- model
--   )
--   port map (
--      AVAIL => open,     -- 1-bit output: Availability status of ICAP
--      O => O,             -- 32-bit output: Configuration data output bus
--      PRDONE => open,   -- 1-bit output: Indicates completion of Partial Reconfiguration
--      PRERROR => open, -- 1-bit output: Indicates Error during Partial Reconfiguration
--      CLK => CLK,         -- 1-bit input: Clock input
--      CSIB => CSIB,       -- 1-bit input: Active-Low ICAP enable
--      I => I,             -- 32-bit input: Configuration data input bus
--      RDWRB => RDWRB      -- 1-bit input: Read/Write Select input
--   );
    
end rtl;
