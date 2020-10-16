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
use ieee.numeric_std.all;           -- needed for BC counter
use ieee.std_logic_unsigned.all;    -- needed for BC counter

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
--    signal inc_for_cnts : std_logic_vector(47 downto 0);
    signal inc_for_cnts : std_logic_vector(134 downto 0);
    signal rst_ttcit_counters : std_logic;
    --
    --
    --
    signal write_FDReg1  : std_logic:= '0';
    signal write_FDReg2  : std_logic:= '0';
    signal write_CDReg   : std_logic:= '0';
    signal write_Control : std_logic:= '0';
    signal ERDUMP        : std_logic:= '0';
    signal CRDUMP        : std_logic:= '0';
    signal RESET_TTC     : std_logic:= '0';
    --
    signal stat_FDReg1   : ipb_reg_v(0 downto 0);
    signal stat_FDReg2   : ipb_reg_v(0 downto 0);
    signal stat_CDReg    : ipb_reg_v(0 downto 0);
    signal stat_Control  : ipb_reg_v(0 downto 0);
    -- =====================================
    -- TTCit's self-computed BC counter
    -- -------------------------------------
    signal stat_BCcounter: ipb_reg_v(0 downto 0);
    -- =====================================
    -- 
    -- =====================================
    -- Short Broadcast's signals
    -- -------------------------------------
    signal HB            : std_logic_vector(0 downto 0);
    signal HBreject_vec  : std_logic_vector(0 downto 0);
    signal HBreject      : std_logic;
    signal TF            : std_logic_vector(0 downto 0);
    signal PP            : std_logic;
    signal PP_vec        : std_logic_vector(0 downto 0);
    -- =====================================
    --
    --
    --
    signal bc_count      : std_logic_vector(11 downto 0) := (others => '0'); -- 12 bit BC counter
    signal cycle_count   : std_logic_vector(2  downto 0) := (others => '0'); -- 12 bit BC counter
    constant BCMAX       : std_logic_vector(11 downto 0):= x"deb";
    constant cycleMAX    : std_logic_vector(2  downto 0):= "101";
    --

    --
    -- ===============================
    -- Channel A decoding's signals
    -- -------------------------------
    signal L0_signal_proc    : std_logic := '0';            
    signal L1_signal_proc    : std_logic := '0';            
    signal CAL_signal_proc   : std_logic := '0';            
    signal already_accepted_0: std_logic := '0';            
    signal already_accepted_1: std_logic := '0';    
    signal chA_q             : std_logic := '0';          
    signal chA_qq            : std_logic := '0';          
    signal chA_qqq           : std_logic := '0';          
    --
    --
    signal TriggerTypes      : std_logic_vector(31 downto 0);
    signal Orbit_msg         : std_logic_vector(31 downto 0);
    signal BC_ID_msg         : std_logic_vector(11 downto 0);
    signal transmission_0    : std_logic := '0';            
    signal transmission_1    : std_logic := '0';            
    signal transmission_2    : std_logic := '0';            
    signal transmission_3    : std_logic := '0';            
    signal transmission_4    : std_logic := '0';            
    signal transmission_5    : std_logic := '0';            
    signal transmission_6    : std_logic := '0';            
    signal ssm_flag          : std_logic := '0';
    signal ssmflag_q         : std_logic := '0';
    signal ssmflag_qq        : std_logic := '0';
    signal trigger_ssm_flag  : std_logic := '0';
    signal trigger_ssm_vect  : std_logic_vector(31 downto 0) := (others => '0'); 
    signal ssm_vect          : std_logic_vector(31 downto 0) := (others => '0'); 

   
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
    stat(1) <= x"0d000704"; -- FW info: type[31:24] = xD->ttcit_logic, version[23:8] -> .., subversion[7:0] -> .. 
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

--ssm_data_s(127 downto 48) <= x"00000000000000000000"; -- 80 bits




--ssm_data_s(127) <= SSM_flag;

----ssm_data_s(126) <= BC_ID_msg(11)    ; -- and SSM_flag;
----ssm_data_s(125) <= BC_ID_msg(10)    ; -- and SSM_flag;
----ssm_data_s(124) <= BC_ID_msg(9)     ; -- and SSM_flag;
----ssm_data_s(123) <= BC_ID_msg(8)     ; -- and SSM_flag;
----ssm_data_s(122) <= BC_ID_msg(7)     ; -- and SSM_flag;
----ssm_data_s(121) <= BC_ID_msg(6)     ; -- and SSM_flag;
----ssm_data_s(120) <= BC_ID_msg(5)     ; -- and SSM_flag;
----ssm_data_s(119) <= BC_ID_msg(4)     ; -- and SSM_flag;
----ssm_data_s(118) <= BC_ID_msg(3)     ; -- and SSM_flag;
----ssm_data_s(117) <= BC_ID_msg(2)     ; -- and SSM_flag;
----ssm_data_s(116) <= BC_ID_msg(1)     ; -- and SSM_flag;
----ssm_data_s(115) <= BC_ID_msg(0)     ; -- and SSM_flag;
----ssm_data_s(114) <= Orbit_msg(31)    ; -- and SSM_flag;
----ssm_data_s(113) <= Orbit_msg(30)    ; -- and SSM_flag;
----ssm_data_s(112) <= Orbit_msg(29)    ; -- and SSM_flag;
----ssm_data_s(111) <= Orbit_msg(28)    ; -- and SSM_flag;
----ssm_data_s(110) <= Orbit_msg(27)    ; -- and SSM_flag;
----ssm_data_s(109) <= Orbit_msg(26)    ; -- and SSM_flag;
----ssm_data_s(108) <= Orbit_msg(25)    ; -- and SSM_flag;
----ssm_data_s(107) <= Orbit_msg(24)    ; -- and SSM_flag;
----ssm_data_s(106) <= Orbit_msg(23)    ; -- and SSM_flag;
----ssm_data_s(105) <= Orbit_msg(22)    ; -- and SSM_flag;
----ssm_data_s(104) <= Orbit_msg(21)    ; -- and SSM_flag;
----ssm_data_s(103) <= Orbit_msg(20)    ; -- and SSM_flag;
----ssm_data_s(102) <= Orbit_msg(19)    ; -- and SSM_flag;
----ssm_data_s(101) <= Orbit_msg(18)    ; -- and SSM_flag;
----ssm_data_s(100) <= Orbit_msg(17)    ; -- and SSM_flag;
----ssm_data_s(99) <= Orbit_msg(16)    ; -- and SSM_flag;
----ssm_data_s(98) <= Orbit_msg(15)    ; -- and SSM_flag;
----ssm_data_s(97) <= Orbit_msg(14)    ; -- and SSM_flag;
----ssm_data_s(96) <= Orbit_msg(13)    ; -- and SSM_flag;
----ssm_data_s(95) <= Orbit_msg(12)    ; -- and SSM_flag;
----ssm_data_s(94) <= Orbit_msg(11)    ; -- and SSM_flag;
----ssm_data_s(93) <= Orbit_msg(10)    ; -- and SSM_flag;
----ssm_data_s(92) <= Orbit_msg(9)     ; -- and SSM_flag;
----ssm_data_s(91) <= Orbit_msg(8)     ; -- and SSM_flag;
----ssm_data_s(90) <= Orbit_msg(7)     ; -- and SSM_flag;
----ssm_data_s(89) <= Orbit_msg(6)     ; -- and SSM_flag;
----ssm_data_s(88) <= Orbit_msg(5)     ; -- and SSM_flag;
----ssm_data_s(87) <= Orbit_msg(4)     ; -- and SSM_flag;
----ssm_data_s(86) <= Orbit_msg(3)     ; -- and SSM_flag;
----ssm_data_s(85) <= Orbit_msg(2)     ; -- and SSM_flag;
----ssm_data_s(84) <= Orbit_msg(1)     ; -- and SSM_flag;
----ssm_data_s(83) <= Orbit_msg(0)     ; -- and SSM_flag;
----ssm_data_s(82) <= TriggerTypes(31); --  and SSM_flag;
----ssm_data_s(81) <= TriggerTypes(30); --  and SSM_flag;
----ssm_data_s(80) <= TriggerTypes(29); --  and SSM_flag;
----ssm_data_s(79) <= TriggerTypes(28); --  and SSM_flag;
----ssm_data_s(78) <= TriggerTypes(27); --  and SSM_flag;
----ssm_data_s(77) <= TriggerTypes(26); --  and SSM_flag;
----ssm_data_s(76) <= TriggerTypes(25); --  and SSM_flag;
----ssm_data_s(75) <= TriggerTypes(24); --  and SSM_flag;
----ssm_data_s(74) <= TriggerTypes(23); --  and SSM_flag;
----ssm_data_s(73) <= TriggerTypes(22); --  and SSM_flag;
----ssm_data_s(72) <= TriggerTypes(21); --  and SSM_flag;
----ssm_data_s(71) <= TriggerTypes(20); --  and SSM_flag;
----ssm_data_s(70) <= TriggerTypes(19); --  and SSM_flag;
----ssm_data_s(69) <= TriggerTypes(18); --  and SSM_flag;
----ssm_data_s(68) <= TriggerTypes(17); --  and SSM_flag;
----ssm_data_s(67) <= TriggerTypes(16); --  and SSM_flag;
----ssm_data_s(66) <= TriggerTypes(15); --  and SSM_flag;
----ssm_data_s(65) <= TriggerTypes(14); --  and SSM_flag;
----ssm_data_s(64) <= TriggerTypes(13); --  and SSM_flag;
----ssm_data_s(63) <= TriggerTypes(12); --  and SSM_flag;
----ssm_data_s(62) <= TriggerTypes(11); --  and SSM_flag;
----ssm_data_s(61) <= TriggerTypes(10); --  and SSM_flag;
----ssm_data_s(60) <= TriggerTypes(9); --   and SSM_flag;
----ssm_data_s(59) <= TriggerTypes(8); --   and SSM_flag;
----ssm_data_s(58) <= TriggerTypes(7); --   and SSM_flag;
----ssm_data_s(57) <= TriggerTypes(6); --   and SSM_flag;
----ssm_data_s(56) <= TriggerTypes(5); --   and SSM_flag;
----ssm_data_s(55) <= TriggerTypes(4); --   and SSM_flag;
----ssm_data_s(54) <= TriggerTypes(3); --   and SSM_flag;
----ssm_data_s(53) <= TriggerTypes(2); --   and SSM_flag;
----ssm_data_s(52) <= TriggerTypes(1); --   and SSM_flag;
----ssm_data_s(51) <= TriggerTypes(0); --  and SSM_flag;

--ssm_data_s(126) <= BC_ID_msg(11)   and SSM_flag;
--ssm_data_s(125) <= BC_ID_msg(10)   and SSM_flag;
--ssm_data_s(124) <= BC_ID_msg(9)    and SSM_flag;
--ssm_data_s(123) <= BC_ID_msg(8)    and SSM_flag;
--ssm_data_s(122) <= BC_ID_msg(7)    and SSM_flag;
--ssm_data_s(121) <= BC_ID_msg(6)    and SSM_flag;
--ssm_data_s(120) <= BC_ID_msg(5)    and SSM_flag;
--ssm_data_s(119) <= BC_ID_msg(4)    and SSM_flag;
--ssm_data_s(118) <= BC_ID_msg(3)    and SSM_flag;
--ssm_data_s(117) <= BC_ID_msg(2)    and SSM_flag;
--ssm_data_s(116) <= BC_ID_msg(1)    and SSM_flag;
--ssm_data_s(115) <= BC_ID_msg(0)    and SSM_flag;
--ssm_data_s(114) <= Orbit_msg(31)   and SSM_flag;
--ssm_data_s(113) <= Orbit_msg(30)   and SSM_flag;
--ssm_data_s(112) <= Orbit_msg(29)   and SSM_flag;
--ssm_data_s(111) <= Orbit_msg(28)   and SSM_flag;
--ssm_data_s(110) <= Orbit_msg(27)   and SSM_flag;
--ssm_data_s(109) <= Orbit_msg(26)   and SSM_flag;
--ssm_data_s(108) <= Orbit_msg(25)   and SSM_flag;
--ssm_data_s(107) <= Orbit_msg(24)   and SSM_flag;
--ssm_data_s(106) <= Orbit_msg(23)   and SSM_flag;
--ssm_data_s(105) <= Orbit_msg(22)   and SSM_flag;
--ssm_data_s(104) <= Orbit_msg(21)   and SSM_flag;
--ssm_data_s(103) <= Orbit_msg(20)   and SSM_flag;
--ssm_data_s(102) <= Orbit_msg(19)   and SSM_flag;
--ssm_data_s(101) <= Orbit_msg(18)   and SSM_flag;
--ssm_data_s(100) <= Orbit_msg(17)   and SSM_flag;
--ssm_data_s(99) <= Orbit_msg(16)    and SSM_flag;
--ssm_data_s(98) <= Orbit_msg(15)    and SSM_flag;
--ssm_data_s(97) <= Orbit_msg(14)    and SSM_flag;
--ssm_data_s(96) <= Orbit_msg(13)    and SSM_flag;
--ssm_data_s(95) <= Orbit_msg(12)    and SSM_flag;
--ssm_data_s(94) <= Orbit_msg(11)    and SSM_flag;
--ssm_data_s(93) <= Orbit_msg(10)    and SSM_flag;
--ssm_data_s(92) <= Orbit_msg(9)     and SSM_flag;
--ssm_data_s(91) <= Orbit_msg(8)     and SSM_flag;
--ssm_data_s(90) <= Orbit_msg(7)     and SSM_flag;
--ssm_data_s(89) <= Orbit_msg(6)     and SSM_flag;
--ssm_data_s(88) <= Orbit_msg(5)     and SSM_flag;
--ssm_data_s(87) <= Orbit_msg(4)     and SSM_flag;
--ssm_data_s(86) <= Orbit_msg(3)     and SSM_flag;
--ssm_data_s(85) <= Orbit_msg(2)     and SSM_flag;
--ssm_data_s(84) <= Orbit_msg(1)     and SSM_flag;
--ssm_data_s(83) <= Orbit_msg(0)     and SSM_flag;
--ssm_data_s(82) <= TriggerTypes(31) and SSM_flag;
--ssm_data_s(81) <= TriggerTypes(30) and SSM_flag;
--ssm_data_s(80) <= TriggerTypes(29) and SSM_flag;
--ssm_data_s(79) <= TriggerTypes(28) and SSM_flag;
--ssm_data_s(78) <= TriggerTypes(27) and SSM_flag;
--ssm_data_s(77) <= TriggerTypes(26) and SSM_flag;
--ssm_data_s(76) <= TriggerTypes(25) and SSM_flag;
--ssm_data_s(75) <= TriggerTypes(24) and SSM_flag;
--ssm_data_s(74) <= TriggerTypes(23) and SSM_flag;
--ssm_data_s(73) <= TriggerTypes(22) and SSM_flag;
--ssm_data_s(72) <= TriggerTypes(21) and SSM_flag;
--ssm_data_s(71) <= TriggerTypes(20) and SSM_flag;
--ssm_data_s(70) <= TriggerTypes(19) and SSM_flag;
--ssm_data_s(69) <= TriggerTypes(18) and SSM_flag;
--ssm_data_s(68) <= TriggerTypes(17) and SSM_flag;
--ssm_data_s(67) <= TriggerTypes(16) and SSM_flag;
--ssm_data_s(66) <= TriggerTypes(15) and SSM_flag;
--ssm_data_s(65) <= TriggerTypes(14) and SSM_flag;
--ssm_data_s(64) <= TriggerTypes(13) and SSM_flag;
--ssm_data_s(63) <= TriggerTypes(12) and SSM_flag;
--ssm_data_s(62) <= TriggerTypes(11) and SSM_flag;
--ssm_data_s(61) <= TriggerTypes(10) and SSM_flag;
--ssm_data_s(60) <= TriggerTypes(9)  and SSM_flag;
--ssm_data_s(59) <= TriggerTypes(8)  and SSM_flag;
--ssm_data_s(58) <= TriggerTypes(7)  and SSM_flag;
--ssm_data_s(57) <= TriggerTypes(6)  and SSM_flag;
--ssm_data_s(56) <= TriggerTypes(5)  and SSM_flag;
--ssm_data_s(55) <= TriggerTypes(4)  and SSM_flag;
--ssm_data_s(54) <= TriggerTypes(3)  and SSM_flag;
--ssm_data_s(53) <= TriggerTypes(2)  and SSM_flag;
--ssm_data_s(52) <= TriggerTypes(1)  and SSM_flag;
--ssm_data_s(51) <= TriggerTypes(0)  and SSM_flag;






ssm_data_s(127) <= trigger_ssm_flag;
ssm_data_s(126) <= BC_ID_msg(11)   and trigger_ssm_flag;
ssm_data_s(125) <= BC_ID_msg(10)   and trigger_ssm_flag;
ssm_data_s(124) <= BC_ID_msg(9)    and trigger_ssm_flag;
ssm_data_s(123) <= BC_ID_msg(8)    and trigger_ssm_flag;
ssm_data_s(122) <= BC_ID_msg(7)    and trigger_ssm_flag;
ssm_data_s(121) <= BC_ID_msg(6)    and trigger_ssm_flag;
ssm_data_s(120) <= BC_ID_msg(5)    and trigger_ssm_flag;
ssm_data_s(119) <= BC_ID_msg(4)    and trigger_ssm_flag;
ssm_data_s(118) <= BC_ID_msg(3)    and trigger_ssm_flag;
ssm_data_s(117) <= BC_ID_msg(2)    and trigger_ssm_flag;
ssm_data_s(116) <= BC_ID_msg(1)    and trigger_ssm_flag;
ssm_data_s(115) <= BC_ID_msg(0)    and trigger_ssm_flag;
ssm_data_s(114) <= Orbit_msg(31)   and trigger_ssm_flag;
ssm_data_s(113) <= Orbit_msg(30)   and trigger_ssm_flag;
ssm_data_s(112) <= Orbit_msg(29)   and trigger_ssm_flag;
ssm_data_s(111) <= Orbit_msg(28)   and trigger_ssm_flag;
ssm_data_s(110) <= Orbit_msg(27)   and trigger_ssm_flag;
ssm_data_s(109) <= Orbit_msg(26)   and trigger_ssm_flag;
ssm_data_s(108) <= Orbit_msg(25)   and trigger_ssm_flag;
ssm_data_s(107) <= Orbit_msg(24)   and trigger_ssm_flag;
ssm_data_s(106) <= Orbit_msg(23)   and trigger_ssm_flag;
ssm_data_s(105) <= Orbit_msg(22)   and trigger_ssm_flag;
ssm_data_s(104) <= Orbit_msg(21)   and trigger_ssm_flag;
ssm_data_s(103) <= Orbit_msg(20)   and trigger_ssm_flag;
ssm_data_s(102) <= Orbit_msg(19)   and trigger_ssm_flag;
ssm_data_s(101) <= Orbit_msg(18)   and trigger_ssm_flag;
ssm_data_s(100) <= Orbit_msg(17)   and trigger_ssm_flag;
ssm_data_s(99) <= Orbit_msg(16)    and trigger_ssm_flag;
ssm_data_s(98) <= Orbit_msg(15)    and trigger_ssm_flag;
ssm_data_s(97) <= Orbit_msg(14)    and trigger_ssm_flag;
ssm_data_s(96) <= Orbit_msg(13)    and trigger_ssm_flag;
ssm_data_s(95) <= Orbit_msg(12)    and trigger_ssm_flag;
ssm_data_s(94) <= Orbit_msg(11)    and trigger_ssm_flag;
ssm_data_s(93) <= Orbit_msg(10)    and trigger_ssm_flag;
ssm_data_s(92) <= Orbit_msg(9)     and trigger_ssm_flag;
ssm_data_s(91) <= Orbit_msg(8)     and trigger_ssm_flag;
ssm_data_s(90) <= Orbit_msg(7)     and trigger_ssm_flag;
ssm_data_s(89) <= Orbit_msg(6)     and trigger_ssm_flag;
ssm_data_s(88) <= Orbit_msg(5)     and trigger_ssm_flag;
ssm_data_s(87) <= Orbit_msg(4)     and trigger_ssm_flag;
ssm_data_s(86) <= Orbit_msg(3)     and trigger_ssm_flag;
ssm_data_s(85) <= Orbit_msg(2)     and trigger_ssm_flag;
ssm_data_s(84) <= Orbit_msg(1)     and trigger_ssm_flag;
ssm_data_s(83) <= Orbit_msg(0)     and trigger_ssm_flag;
ssm_data_s(82) <= TriggerTypes(31) and trigger_ssm_flag;
ssm_data_s(81) <= TriggerTypes(30) and trigger_ssm_flag;
ssm_data_s(80) <= TriggerTypes(29) and trigger_ssm_flag;
ssm_data_s(79) <= TriggerTypes(28) and trigger_ssm_flag;
ssm_data_s(78) <= TriggerTypes(27) and trigger_ssm_flag;
ssm_data_s(77) <= TriggerTypes(26) and trigger_ssm_flag;
ssm_data_s(76) <= TriggerTypes(25) and trigger_ssm_flag;
ssm_data_s(75) <= TriggerTypes(24) and trigger_ssm_flag;
ssm_data_s(74) <= TriggerTypes(23) and trigger_ssm_flag;
ssm_data_s(73) <= TriggerTypes(22) and trigger_ssm_flag;
ssm_data_s(72) <= TriggerTypes(21) and trigger_ssm_flag;
ssm_data_s(71) <= TriggerTypes(20) and trigger_ssm_flag;
ssm_data_s(70) <= TriggerTypes(19) and trigger_ssm_flag;
ssm_data_s(69) <= TriggerTypes(18) and trigger_ssm_flag;
ssm_data_s(68) <= TriggerTypes(17) and trigger_ssm_flag;
ssm_data_s(67) <= TriggerTypes(16) and trigger_ssm_flag;
ssm_data_s(66) <= TriggerTypes(15) and trigger_ssm_flag;
ssm_data_s(65) <= TriggerTypes(14) and trigger_ssm_flag;
ssm_data_s(64) <= TriggerTypes(13) and trigger_ssm_flag;
ssm_data_s(63) <= TriggerTypes(12) and trigger_ssm_flag;
ssm_data_s(62) <= TriggerTypes(11) and trigger_ssm_flag;
ssm_data_s(61) <= TriggerTypes(10) and trigger_ssm_flag;
ssm_data_s(60) <= TriggerTypes(9)  and trigger_ssm_flag;
ssm_data_s(59) <= TriggerTypes(8)  and trigger_ssm_flag;
ssm_data_s(58) <= TriggerTypes(7)  and trigger_ssm_flag;
ssm_data_s(57) <= TriggerTypes(6)  and trigger_ssm_flag;
ssm_data_s(56) <= TriggerTypes(5)  and trigger_ssm_flag;
ssm_data_s(55) <= TriggerTypes(4)  and trigger_ssm_flag;
ssm_data_s(54) <= TriggerTypes(3)  and trigger_ssm_flag;
ssm_data_s(53) <= TriggerTypes(2)  and trigger_ssm_flag;
ssm_data_s(52) <= TriggerTypes(1)  and trigger_ssm_flag;
ssm_data_s(51) <= TriggerTypes(0)  and trigger_ssm_flag;




ssm_data_s(50) <= CAL_signal_proc;
ssm_data_s(49) <= L1_signal_proc;
ssm_data_s(48) <= L0_signal_proc;


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
            
            
            
            
            
            
            
            
            
            
            
            
            
            
   
            
            
--A_channel_analyser: process (clk_bc, ttc_data_i.l1accept) is
--begin
--if rising_edge(clk_bc) then
--    if   (ttc_data_i.l1accept = '1' and already_accepted_0 = '0') then
----        L0_signal_proc     <= '1';
----        L1_signal_0        <= '0';
--        already_accepted_0   <= '1';
--    elsif(ttc_data_i.l1accept = '0' and already_accepted_0 = '1') then
--        L0_signal_proc       <= '1';
----        L1_signal_0        <= '1';
--        already_accepted_0   <= '0';        
--    elsif(ttc_data_i.l1accept = '1' and already_accepted_0 = '1' and already_accepted_1 = '0') then
----        L0_signal          <= '0';
----        L1_signal_proc     <= '1';
----        already_accepted_0 <= '0';
--        already_accepted_1   <= '1';
--    elsif(ttc_data_i.l1accept = '0' and already_accepted_0 = '1' and already_accepted_1 = '1') then
----        L0_signal          <= '0';
--        L1_signal_proc       <= '1';
--        already_accepted_0   <= '0';
--        already_accepted_1   <= '0'; 
--    elsif(ttc_data_i.l1accept = '1' and already_accepted_0 = '1' and already_accepted_1 = '1') then
----        L0_signal          <= '0';
--        CAL_signal_proc      <= '1';
--        already_accepted_0   <= '0';
--        already_accepted_1   <= '0';                       
--    else
--        L0_signal_proc       <= '0';
--        L1_signal_proc       <= '0';            
--        CAL_signal_proc      <= '0';            
--    end if;       
--end if;
--end process A_channel_analyser;
            


A_channel_analyser: process (clk_bc) is
begin
if rising_edge(clk_bc) then
    chA_q   <= ttc_data_i.l1accept;
    chA_qq  <= chA_q;
    chA_qqq <= chA_qq;
    if   (chA_qq = '0' and chA_q = '1') then  -- rising edge of the pulse
--        L0_signal_proc       <= '1';
--        L1_signal_proc       <= '0';
--        CAL_signal_proc      <= '0';
        already_accepted_0   <= '1';
    elsif(chA_qq = '1' and chA_q = '0' and already_accepted_0 = '1') then
        L0_signal_proc       <= '1';
--        L1_signal_0          <= '1';
        already_accepted_0   <= '0';        
    elsif(chA_qqq = '1' and chA_qq = '1' and chA_q = '1') then
--        L0_signal            <= '0';
        CAL_signal_proc      <= '1';
        already_accepted_0   <= '0';
--        already_accepted_1   <= '1';
    elsif(chA_qq = '1' and chA_q = '1') then
--        L0_signal          <= '0';
        L1_signal_proc       <= '1';
        already_accepted_0   <= '0';
--        already_accepted_1   <= '0'; 
--    elsif(ttc_data_i.l1accept = '1' and already_accepted_0 = '1' and already_accepted_1 = '1') then
--        L0_signal          <= '0';
--        CAL_signal_proc      <= '1';
--        already_accepted_0   <= '0';
--        already_accepted_1   <= '0';                       
    else
        L0_signal_proc       <= '0';
        L1_signal_proc       <= '0';            
        CAL_signal_proc      <= '0';            
    end if;       
end if;
end process A_channel_analyser;
            
            
            
            
--TriggerTypes_string: process(ttc_data_i.adr_e, L1_signal_proc) is begin
--    if    (L1_signal_proc = '1') then
--                TriggerTypes   <= (others => '0');    
--                BC_ID_msg      <= (others => '0');    
--                Orbit_msg      <= (others => '0');
--                ssm_flag       <= '0';    
--                transmission_0 <= '0'; 
--                transmission_1 <= '0'; 
--                transmission_2 <= '0'; 
--                transmission_3 <= '0'; 
--                transmission_4 <= '0'; 
--                transmission_5 <= '0'; 
--                transmission_6 <= '0'; 
--    elsif RISING_EDGE(ttc_data_i.adr_e) then
--           if    (transmission_0 = '0' and transmission_1 = '0' and transmission_2 = '0' and transmission_3 = '0' and transmission_4 = '0' and transmission_5 = '0' and transmission_6 = '0') then
--                TriggerTypes(31 downto 24) <= ttc_data_i.adr_d8(7 downto 0);
--                transmission_0 <= '1';                 
--           elsif (transmission_0 = '1' and transmission_1 = '0' and transmission_2 = '0' and transmission_3 = '0' and transmission_4 = '0' and transmission_5 = '0' and transmission_6 = '0') then
--                TriggerTypes(23 downto 20) <= ttc_data_i.adr_s8(3 downto 0);
--                TriggerTypes(19 downto 12) <= ttc_data_i.adr_d8(7 downto 0);
--                transmission_1 <= '1';
--           elsif (transmission_0 = '1' and transmission_1 = '1' and transmission_2 = '0' and transmission_3 = '0' and transmission_4 = '0' and transmission_5 = '0' and transmission_6 = '0') then
--                TriggerTypes(11 downto 8)  <= ttc_data_i.adr_s8(3 downto 0);
--                TriggerTypes(7  downto 0)  <= ttc_data_i.adr_d8(7 downto 0);
--                transmission_2 <= '1';
--           elsif (transmission_0 = '1' and transmission_1 = '1' and transmission_2 = '1' and transmission_3 = '0' and transmission_4 = '0' and transmission_5 = '0' and transmission_6 = '0') then
--                BC_ID_msg(11 downto 8)     <= ttc_data_i.adr_s8(3 downto 0);
--                BC_ID_msg(7  downto 0)     <= ttc_data_i.adr_d8(7 downto 0);
--                transmission_3 <= '1';
--           elsif (transmission_0 = '1' and transmission_1 = '1' and transmission_2 = '1' and transmission_3 = '1' and transmission_4 = '0' and transmission_5 = '0' and transmission_6 = '0') then
--                Orbit_msg(31 downto 24)    <= ttc_data_i.adr_d8(7 downto 0);
--                transmission_4 <= '1';
--           elsif (transmission_0 = '1' and transmission_1 = '1' and transmission_2 = '1' and transmission_3 = '1' and transmission_4 = '1' and transmission_5 = '0' and transmission_6 = '0') then
--                Orbit_msg(23 downto 20)    <= ttc_data_i.adr_s8(3 downto 0);
--                Orbit_msg(19 downto 12)    <= ttc_data_i.adr_d8(7 downto 0);
--                transmission_5 <= '1';
--           elsif (transmission_0 = '1' and transmission_1 = '1' and transmission_2 = '1' and transmission_3 = '1' and transmission_4 = '1' and transmission_5 = '1' and transmission_6 = '0') then
--                Orbit_msg(11 downto 8)     <= ttc_data_i.adr_s8(3 downto 0);
--                Orbit_msg(7  downto 0)     <= ttc_data_i.adr_d8(7 downto 0);    
--                transmission_6 <= '1';        
--                ssm_flag     <= '1';                                 
--           end if;           
--    end if;
--end process TriggerTypes_string;
            


TriggerTypes_string: process(ttc_data_i.adr_e) is begin
--    if    (L1_signal_proc = '1') then
--                TriggerTypes   <= (others => '0');    
--                BC_ID_msg      <= (others => '0');    
--                Orbit_msg      <= (others => '0');
--                ssm_flag       <= '0';    
--                transmission_0 <= '0'; 
--                transmission_1 <= '0'; 
--                transmission_2 <= '0'; 
--                transmission_3 <= '0'; 
--                transmission_4 <= '0'; 
--                transmission_5 <= '0'; 
--                transmission_6 <= '0'; 
    if RISING_EDGE(ttc_data_i.adr_e) then
           if    (ttc_data_i.adr_s8(7) = '0' and ttc_data_i.adr_s8(6) = '0' and ttc_data_i.adr_s8(5) = '0' and ttc_data_i.adr_s8(4) = '1') then
                TriggerTypes(31 downto 24) <= ttc_data_i.adr_d8(7 downto 0);
                TriggerTypes(23 downto 0) <= (others => '0');    
                BC_ID_msg      <= (others => '0');    
                Orbit_msg      <= (others => '0');
                ssm_flag       <= '0';    
                transmission_0 <= '1'; 
                transmission_1 <= '0'; 
                transmission_2 <= '0'; 
                transmission_3 <= '0'; 
                transmission_4 <= '0'; 
                transmission_5 <= '0'; 
                transmission_6 <= '0'; 
--                        trigger_ssm_flag   <= '0';
--                        trigger_ssm_vect   <= (others => '0'); 
                        ssm_vect   <= (others => '0'); 

--           if    (transmission_0 = '0' and transmission_1 = '0' and transmission_2 = '0' and transmission_3 = '0' and transmission_4 = '0' and transmission_5 = '0' and transmission_6 = '0') then
--                TriggerTypes(31 downto 24) <= ttc_data_i.adr_d8(7 downto 0);
--                transmission_0 <= '1';                 
           elsif (transmission_0 = '1' and transmission_1 = '0' and transmission_2 = '0' and transmission_3 = '0' and transmission_4 = '0' and transmission_5 = '0' and transmission_6 = '0') then
                TriggerTypes(23 downto 20) <= ttc_data_i.adr_s8(3 downto 0);
                TriggerTypes(19 downto 12) <= ttc_data_i.adr_d8(7 downto 0);
                transmission_1 <= '1';
           elsif (transmission_0 = '1' and transmission_1 = '1' and transmission_2 = '0' and transmission_3 = '0' and transmission_4 = '0' and transmission_5 = '0' and transmission_6 = '0') then
                TriggerTypes(11 downto 8)  <= ttc_data_i.adr_s8(3 downto 0);
                TriggerTypes(7  downto 0)  <= ttc_data_i.adr_d8(7 downto 0);
                transmission_2 <= '1';
           elsif (transmission_0 = '1' and transmission_1 = '1' and transmission_2 = '1' and transmission_3 = '0' and transmission_4 = '0' and transmission_5 = '0' and transmission_6 = '0') then
                BC_ID_msg(11 downto 8)     <= ttc_data_i.adr_s8(3 downto 0);
                BC_ID_msg(7  downto 0)     <= ttc_data_i.adr_d8(7 downto 0);
                transmission_3 <= '1';
           elsif (transmission_0 = '1' and transmission_1 = '1' and transmission_2 = '1' and transmission_3 = '1' and transmission_4 = '0' and transmission_5 = '0' and transmission_6 = '0') then
                Orbit_msg(31 downto 24)    <= ttc_data_i.adr_d8(7 downto 0);
                transmission_4 <= '1';
           elsif (transmission_0 = '1' and transmission_1 = '1' and transmission_2 = '1' and transmission_3 = '1' and transmission_4 = '1' and transmission_5 = '0' and transmission_6 = '0') then
                Orbit_msg(23 downto 20)    <= ttc_data_i.adr_s8(3 downto 0);
                Orbit_msg(19 downto 12)    <= ttc_data_i.adr_d8(7 downto 0);
                transmission_5 <= '1';
           elsif (transmission_0 = '1' and transmission_1 = '1' and transmission_2 = '1' and transmission_3 = '1' and transmission_4 = '1' and transmission_5 = '1' and transmission_6 = '0') then
                Orbit_msg(11 downto 8)     <= ttc_data_i.adr_s8(3 downto 0);
                Orbit_msg(7  downto 0)     <= ttc_data_i.adr_d8(7 downto 0);    
                transmission_6 <= '1';        
                ssm_flag     <= '1';   
                   ssm_vect   <= (others => '1'); 
                              
           end if;           
    end if;
end process TriggerTypes_string;

  
  
----======================================
---- Initialise Trigger SSM flag
----======================================
--TriggerSSMflagprocess: process(clk_bc) is begin
--if rising_edge(clk_bc) then
--    ssmflag_q   <= ssm_flag;
--    ssmflag_qq  <= ssmflag_q;
--    chA_qqq <= chA_qq;
--    if     (ssmflag_qq = '0' and ssmflag_q = '1') then  -- rising edge of the pulse
--        trigger_ssm_flag <= '1';
--    else
--        trigger_ssm_flag <= '0';
--        ssmflag_q   <= '0';
--        ssmflag_qq  <= '0';
--    end if;
--end if;
--end process TriggerSSMflagprocess;            

  
--======================================
-- Initialise Trigger SSM flag
--======================================
TriggerSSMflagprocess: process(clk_bc) is begin
if (rising_edge(clk_bc)) then
--    if (trigger_ssm_flag = '0' and transmission_6 = '1') then
--    if ( transmission_6 = '1') then
--    if ( ssm_flag = '1') then
--        trigger_ssm_flag   <= '1';
--        trigger_ssm_vect   <= (others => '1'); 
        trigger_ssm_flag   <= ssm_flag;
        trigger_ssm_vect   <= (others => ssm_flag); 

--    else
--        trigger_ssm_flag   <= '0';
--        trigger_ssm_vect   <= (others => '0'); 
--    end if;
end if;
end process TriggerSSMflagprocess;            

            
            
--======================================
--        Trigger counters
--======================================


-- Broadcast user message
HB(0)           <= ttc_data_i.brc_d4(0) and ttc_data_i.brc_strobe;
HBreject        <= ttc_data_i.brc_d4(1) and ttc_data_i.brc_strobe;
HBreject_vec(0) <= ttc_data_i.brc_d4(1) and ttc_data_i.brc_strobe;
TF(0)           <= ttc_data_i.brc_d4(2) and ttc_data_i.brc_strobe;
PP              <= ttc_data_i.brc_d4(3) and ttc_data_i.brc_strobe;


--inc_for_cnts(134 downto 123)<= BC_ID_msg(11    downto 0);    
--inc_for_cnts(122 downto 91)<= Orbit_msg(31    downto 0);    
--inc_for_cnts(90  downto 59)<= TriggerTypes(31 downto 0);     

--inc_for_cnts(134 downto 123)<= BC_ID_msg(11    downto 0) and trigger_ssm_vect(11    downto 0);    
--inc_for_cnts(122 downto 91) <= Orbit_msg(31    downto 0) and trigger_ssm_vect(31    downto 0);    
--inc_for_cnts(90  downto 59) <= TriggerTypes(31 downto 0) and trigger_ssm_vect(31    downto 0);     

inc_for_cnts(134 downto 123)<= BC_ID_msg(11    downto 0) and (trigger_ssm_vect(11    downto 0) xor ssm_vect(11    downto 0));    
inc_for_cnts(122 downto 91) <= Orbit_msg(31    downto 0) and (trigger_ssm_vect(31    downto 0) xor ssm_vect(31    downto 0));      
inc_for_cnts(90  downto 59) <= TriggerTypes(31 downto 0) and (trigger_ssm_vect(31    downto 0) xor ssm_vect(31    downto 0));      


--inc_for_cnts(58)           <= ssm_flag;
inc_for_cnts(58)           <= ssm_flag and (trigger_ssm_flag xor ssm_flag);
inc_for_cnts(57)           <= CAL_signal_proc;
inc_for_cnts(56)           <= L1_signal_proc;
inc_for_cnts(55)           <= L0_signal_proc;

inc_for_cnts(54)           <= ttc_status_i.err_sng  and (ttc_data_i.adr_strobe or ttc_data_i.brc_strobe); -- Single Error
inc_for_cnts(53)           <= ttc_status_i.err_dbl  and (ttc_data_i.adr_strobe or ttc_data_i.brc_strobe); -- Double Error
inc_for_cnts(52)           <= ttc_status_i.err_comm and (ttc_data_i.adr_strobe or ttc_data_i.brc_strobe); -- Single Error
inc_for_cnts(51)           <= PP;
inc_for_cnts(50)           <= TF(0);
inc_for_cnts(49)           <= HBreject_vec(0);
inc_for_cnts(48)           <= HB(0);
inc_for_cnts(47)           <= ttc_status_i.ready;
inc_for_cnts(46)           <= ttc_status_i.err_sng;
inc_for_cnts(45)           <= ttc_status_i.err_dbl;
inc_for_cnts(44)           <= ttc_status_i.err_comm;
inc_for_cnts(43)           <= ttc_status_i.div_nrst;

inc_for_cnts(42)           <= ttc_data_i.l1accept;   
inc_for_cnts(41)           <= ttc_data_i.brc_strobe; 
inc_for_cnts(40 downto 39) <= ttc_data_i.brc_t2; -- 2 bits     
inc_for_cnts(38 downto 35) <= ttc_data_i.brc_d4; -- 4 bits     
inc_for_cnts(34)           <= ttc_data_i.brc_e;      
inc_for_cnts(33)           <= ttc_data_i.brc_b;      
inc_for_cnts(32)           <= ttc_data_i.adr_strobe; 
inc_for_cnts(31 downto 18) <= ttc_data_i.adr_a14;    
inc_for_cnts(17)           <= ttc_data_i.adr_e;      
inc_for_cnts(16 downto 9)  <= ttc_data_i.adr_s8;     
inc_for_cnts(8  downto 1)  <= ttc_data_i.adr_d8;     
inc_for_cnts(0)            <= ttc_data_i.clk40_gated;
    
ttcit_counters: entity work.ipbus_ctrs_v
--	generic map(N_CTRS => 48, CTR_WDS => 1, LIMIT => FALSE)
	generic map(N_CTRS => 135, CTR_WDS => 1, LIMIT => FALSE)
	port map(
		ipb_clk  => ipb_clk, 
        ipb_rst  => ipb_rst,
        ipb_in   => ipbw(N_SLV_TTCITCNTS),
        ipb_out  => ipbr(N_SLV_TTCITCNTS),
		clk      => clk_bc,
		rst      => rst_ttcit_counters,
		inc      => inc_for_cnts,
		dec      => (others => '0'), -- decrement not used
		q        => open -- out std_logic_vector(N_CTRS * CTR_WDS * 32 - 1 downto 0)
	);
	
	
	
	
	
	
	
	
BC_counter : process(clk_bc, HB(0) ) is begin
    if RISING_EDGE(clk_bc) then
--           if(rst_ttcit_counters_l1accept_BCRST = '1') then
           if(HB(0) = '1') then
               bc_count <= (others => '0');
           elsif(bc_count = BCMAX) then
               bc_count <= (others => '0');
           else
               bc_count <= bc_count + '1';
           end if;
    end if;
end process BC_counter;
	
	
ttcit_counter_l1accept_BCRST: entity work.ipbus_ctrlreg_v
--        generic map(N_STAT => 8, N_CTRL => 1, SWAP_ORDER => true)
        generic map(N_STAT => 1, N_CTRL => 1, SWAP_ORDER => true)
		port map(
			clk => ipb_clk,
			reset => ipb_rst,
			ipbus_in => ipbw(N_SLV_TTCITCNTS_CHANNELA_BCRST),
			ipbus_out => ipbr(N_SLV_TTCITCNTS_CHANNELA_BCRST),
--			d => stat, -- in
			d => stat_BCcounter, -- in
			q => open  -- out
		);
		
stat_BCcounter(0) <= bc_count;		
	
	
	
	
-- ====================                
-- Long Messages 
-- ====================


--with ttc_data_i.adr_s8 select
--        write_FDReg1 <=   '1' when "00000000",
--                          '0' when others;
                      
--with ttc_data_i.adr_s8 select
--        write_FDReg2 <=   '1' when "00000001",
--                          '0' when others;
                      
--with ttc_data_i.adr_s8 select
--        write_CDReg <=    '1' when "00000010",
--                          '0' when others;
                      
--with ttc_data_i.adr_s8 select
--        write_Control <=  '1' when "00000011",
--                          '0' when others;
               
--with ttc_data_i.adr_s8 select
--        ERDUMP        <=  '1' when "00000100",
--                          '0' when others;
            
--with ttc_data_i.adr_s8 select
--        CRDUMP        <=  '1' when "00000101",
--                          '0' when others;

--with ttc_data_i.adr_s8 select
--        RESET_TTC     <=  '1' when "00000110",
--                          '0' when others;
                      

---- Fine Delay Register 1

--FDReg_1: entity work.ipbus_ctrlreg_v
----        generic map(N_STAT => 8, N_CTRL => 1, SWAP_ORDER => true)
--        generic map(N_STAT => 1, N_CTRL => 1, SWAP_ORDER => true)
--		port map(
--			clk => ipb_clk,
--			reset => ipb_rst,
--			ipbus_in => ipbw(N_SLV_TTCIT_FINEDELAYR1),
--			ipbus_out => ipbr(N_SLV_TTCIT_FINEDELAYR1),
----			d => stat, -- in
--			d => stat_FDReg1, -- in
--			q => open  -- out
--		);
     
--process(write_FDReg1)
--begin
--    if (rising_edge(write_FDReg1) and rising_edge(ttc_data_i.adr_strobe)) then
--        stat_FDReg1(0) <= ttc_data_i.adr_d8;    
--    end if;
--end process;    
    
   

---- Fine Delay Register 2

--FDReg_2: entity work.ipbus_ctrlreg_v
--        generic map(N_STAT => 1, N_CTRL => 1, SWAP_ORDER => true)
--		port map(
--			clk => ipb_clk,
--			reset => ipb_rst,
--			ipbus_in => ipbw(N_SLV_TTCIT_FINEDELAYR2),
--			ipbus_out => ipbr(N_SLV_TTCIT_FINEDELAYR2),
--			d => stat_FDReg2, -- in
--			q => open  -- out
--		);
		
--process(write_FDReg2)
--begin
--    if (rising_edge(write_FDReg2) and rising_edge(ttc_data_i.adr_strobe)) then
--        stat_FDReg2(0) <= ttc_data_i.adr_d8;    
--    end if;
--end process;    

		
		
---- Coarse Delay Register

--CDReg: entity work.ipbus_ctrlreg_v
--        generic map(N_STAT => 1, N_CTRL => 1, SWAP_ORDER => true)
--		port map(
--			clk => ipb_clk,
--			reset => ipb_rst,
--			ipbus_in => ipbw(N_SLV_TTCIT_COARSEDELAY),
--			ipbus_out => ipbr(N_SLV_TTCIT_COARSEDELAY),
--			d => stat_CDReg, -- in
--			q => open  -- out
--		);


--process(write_CDReg)
--begin
--    if rising_edge(write_CDReg) then
--        stat_CDReg(0) <= ttc_data_i.adr_d8;    
--    end if;
--end process;    

		
---- Control Register

--ControlReg: entity work.ipbus_ctrlreg_v
--        generic map(N_STAT => 1, N_CTRL => 1, SWAP_ORDER => true)
--		port map(
--			clk => ipb_clk,
--			reset => ipb_rst,
--			ipbus_in => ipbw(N_SLV_TTCIT_CONTROLREGISTER),
--			ipbus_out => ipbr(N_SLV_TTCIT_CONTROLREGISTER),
--			d => stat_Control, -- in
--			q => open  -- out
--		);

--process(write_Control)
--begin
--    if (rising_edge(write_Control) and rising_edge(ttc_data_i.adr_strobe))  then
--        stat_Control(0) <= ttc_data_i.adr_d8;    
--    end if;
--end process;    
	
	
            
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
