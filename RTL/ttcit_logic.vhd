---------------------------------------------------------------
--      TTCit_logic
--
--> use with FMC TTC card
--> 
---
---   author: Marian Krivda, Simone Ragoni
----------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

library UNISIM;
use UNISIM.vcomponents.all;
use work.ipbus.all;
use work.spi.all;
use work.ttc_codec_pkg.all;

entity ttcit_logic is
              
    port(
--==========================================
--  IP bus
--==========================================
        SI5345_I_OUT8_P   : in   std_logic;  --  Comment: 156.25 MHz MGT clock (eth clk), bank 227
        SI5345_I_OUT8_N   : in   std_logic; 
        SI5345_I_OUT9_P   : in   std_logic;  --  Comment: Sys clk 125 MHz, bank 66
        SI5345_I_OUT9_N   : in   std_logic;
		SFP_RX_P          : in    std_logic; --  Comment: Ethernet MGT input
        SFP_RX_N          : in    std_logic; 
        SFP_TX_P          : out   std_logic; --  Comment: Ethernet MGT output
        SFP_TX_N          : out   std_logic;
        LED_14            : out std_logic;   --  Comment: LED IPB_PKT (indicate data transfer)
        LED_15            : out std_logic;   --  Comment: LED IPB_LOCK (flashing one Hertz)
		sn                : in  std_logic_vector (7 downto 0);  -- Comment:  serial number of the board
--==========================================
--  DDR4  0
--==========================================
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
--==========================================
--  DDR4  1                     
--==========================================
        ddr4_1_inst0_c0_ddr4_act_n   : out std_logic; 
        ddr4_1_inst0_c0_ddr4_adr     : out std_logic_vector (16 downto 0); 
        ddr4_1_inst0_c0_ddr4_ba      : out std_logic_vector (1 downto 0);
        ddr4_1_inst0_c0_ddr4_bg      : out std_logic_vector (0 downto 0);
        ddr4_1_inst0_c0_ddr4_ck_c    : out std_logic_vector (0 downto 0);
        ddr4_1_inst0_c0_ddr4_ck_t    : out std_logic_vector (0 downto 0); 
        ddr4_1_inst0_c0_ddr4_cke     : out std_logic_vector (0 downto 0); 
        ddr4_1_inst0_c0_ddr4_cs_n    : out std_logic_vector (0 downto 0); 
        ddr4_1_inst0_c0_ddr4_dm_dbi_n: inout std_logic_vector(1 downto 0);
        ddr4_1_inst0_c0_ddr4_dq      : inout std_logic_vector(15 downto 0);
        ddr4_1_inst0_c0_ddr4_dqs_c   : inout std_logic_vector(1 downto 0);
        ddr4_1_inst0_c0_ddr4_dqs_t   : inout std_logic_vector(1 downto 0);
        ddr4_1_inst0_c0_ddr4_odt     : out   std_logic_vector (0 downto 0);
        ddr4_1_inst0_c0_ddr4_reset_n : out std_logic;
        ddr4_1_inst0_c0_sys_clk_n    : in  std_logic;
        ddr4_1_inst0_c0_sys_clk_p    : in  std_logic;
--===========================================
        DDR4_0_ALERT_N: in  std_logic;
        DDR4_0_PAR: out std_logic;
        DDR4_0_TEN: out std_logic;
        DDR4_1_ALERT_N: in std_logic;
        DDR4_1_PAR :out std_logic; 
        DDR4_1_TEN :out std_logic;
--==================================================
--  external bus using FireFly cable
--==================================================
        DATA1_P  : inout std_logic;    --  
        DATA1_N  : inout std_logic;    -- 
        DATA2_P  : inout std_logic;    -- 
        DATA2_N  : inout std_logic;    -- 
        DATA3_P  : inout std_logic;    -- 
        DATA3_N  : inout std_logic;    -- 
        DATA4_P  : inout std_logic;    -- 
        DATA4_N  : inout std_logic;    -- 
        DATA5_P  : inout std_logic;    -- 
        DATA5_N  : inout std_logic;    -- 
        DATA6_P  : inout std_logic;    -- 
        DATA6_N  : inout std_logic;    -- 
        DATA7_P  : inout std_logic;    -- 
        DATA7_N  : inout std_logic;    -- 
        DATA8_P  : inout std_logic;    -- 
        DATA8_N  : inout std_logic;    -- 
        DATA9_P  : inout std_logic;    -- 
        DATA9_N  : inout std_logic;    -- 
        DATA10_P : inout std_logic;    -- 
        DATA10_N : inout std_logic;    -- 
        DATA11_P : inout std_logic;    -- 
        DATA11_N : inout std_logic;    -- 
        DATA12_P : inout std_logic;    -- 
        DATA12_N : inout std_logic;    -- 
--=================================================
--  FMC board IOs
--=================================================
        FMC_HPAC_PG_M2C        : in std_logic; 
        FMC_HPC_PRSNT_M2C_B    : in std_logic; 
        VADJ1V8_PGOOD          : in std_logic;
        FMC_HPC_CLK0_M2C_P     : in std_logic; 
        FMC_HPC_CLK0_M2C_N     : in std_logic;   
        FMC_HPC_CLK1_M2C_P     : in std_logic; 
        FMC_HPC_CLK1_M2C_N     : in std_logic; 
        FMC_HPC_LA05_N         : out std_logic; -- User LED on FMC TTC card
        FMC_HPC_LA08_P         : in std_logic;
        FMC_HPC_LA08_N         : in std_logic;
        FMC_HPC_LA09_P         : inout std_logic;
        FMC_HPC_LA09_N         : inout std_logic;
        FMC_HPC_LA10_P         : out std_logic;
        FMC_HPC_LA01_CC_P      : out std_logic;
--===============================================
--  LEDs  Front Pannel 
--================================================
        LED_1        : out std_logic; -- Comment: LM/L0 OUT1
        LED_2        : out std_logic; -- Comment: LM/L0 OUT2
        LED_3        : out std_logic; -- Comment: BUSY IN
        LED_4        : out std_logic; -- Comment: BUSY OUT
        LED_5        : out std_logic; -- Comment: FAST LM IN
        LED_6        : out std_logic; -- Comment: BC IN
        LED_7        : out std_logic; -- Comment: ORBIT IN
        LED_8        : out std_logic; -- Comment: SCOPE-A OUT
        LED_9        : out std_logic; -- Comment: SCOPE-B OUT
        LED_10       : out std_logic; -- Comment: TTC-A OUT
        LED_11       : out std_logic; -- Comment: TTC-B OUT
        LED_12       : out std_logic; -- Comment: PULSER IN
        LED_13       : out std_logic; -- Comment: SPARE IN/OUT
--  Comment:  Important LED 14,15 are defined at IPbus section
        LED_16       : out std_logic; -- F!
        LED_17       : out std_logic; -- F2
        LED_18       : out std_logic; -- F3 
        LED_19       : out std_logic; -- F4
        LED_20       : out std_logic; -- F5
        LED_21_LS    : out std_logic; -- F6
        LED_22_LS    : out std_logic; -- F7
        LED_23_LS    : out std_logic; -- F8
        LED_24_LS    : out std_logic; -- F9
        LED_25_LS    : out std_logic; -- F10
 -- ===============================================
 -- ==  LEDs  SFP Cage  (6 x 2)                  ==
 -- ===============================================
        SFP1_LED_GR  : out std_logic; 
        SFP1_LED_RD  : out std_logic; 
        SFP2_LED_GR  : out std_logic; 
        SFP2_LED_RD  : out std_logic; 
        SFP3_LED_GR  : out std_logic; 
        SFP3_LED_RD  : out std_logic; 
        SFP4_LED_GR  : out std_logic; 
        SFP4_LED_RD  : out std_logic; 
        SFP5_LED_GR  : out std_logic; 
        SFP5_LED_RD  : out std_logic; 
        SFP6_LED_GR  : out std_logic; 
        SFP6_LED_RD  : out std_logic; 
        SFP7_LED_GR  : out std_logic; 
        SFP7_LED_RD  : out std_logic; 
        SFP8_LED_GR  : out std_logic; 
        SFP8_LED_RD  : out std_logic; 
        SFP9_LED_GR  : out std_logic; 
        SFP9_LED_RD  : out std_logic;
        SFP10_LED_GR : out std_logic; 
        SFP10_LED_RD : out std_logic; 
        SFP11_LED_GR : out std_logic; 
        SFP11_LED_RD : out std_logic; 
        SFP12_LED_GR : out std_logic; 
        SFP12_LED_RD : out std_logic; 
--===========================================
-- == I2C  Master  Control                 == 
-- ==========================================
        IIC_MUX_SCL_MAIN : inout std_logic;
		IIC_MUX_SDA_MAIN : inout std_logic;
--===========================================
-- Clocks
--===========================================
--     SI5345_I_OUT0_P : in std_logic; --> ddr4_0_inst0_c0_sys_clk, 300 MHz clock for DDR4_1 
--     SI5345_I_OUT0_N : in std_logic;
--     SI5345_I_OUT1_P : in std_logic; --> ddr4_1_inst0_c0_sys_clk, 300 MHz clock for DDR4_2
--     SI5345_I_OUT1_N : in std_logic;
       SI5345_I_OUT2_P : in std_logic; -- 40 MHz clock bank 48 for test purposes
       SI5345_I_OUT2_N : in std_logic;
       SI5345_I_OUT3_P : in std_logic; -- 40 MHz clock for test purposes
       SI5345_I_OUT3_N : in std_logic;
       SI5345_I_OUT4_P : in std_logic; -- 200 MHz stanalone clock used for OLT usr
       SI5345_I_OUT4_N : in std_logic;
--       SI5345_I_OUT5_P : in std_logic; -- ref clk 1 for bank 224 (240 MHz standalone clock for OLT)
--       SI5345_I_OUT5_N : in std_logic;
--       SI5345_I_OUT6_P : in std_logic; -- ref clk 1 for bank 225 (240 MHz standalone clock for ONU)
--       SI5345_I_OUT6_N : in std_logic;
--     SI5345_I_OUT7_P : in std_logic; -- ref clk 1 for bank 226 (stanalone clock - not used)
--     SI5345_I_OUT7_N : in std_logic;
-----------------------------------------------------------------------------------------------------------------
--     SI5345_OUT0 goes to SMA connectors   
--       SI5345_OUT1_P :  in std_logic; -- LHC clk for future LLI part of FPGA code, bank 48
--       SI5345_OUT1_N :  in std_logic;
--       SI5345_OUT2_P :  in std_logic; -- LHC clk, bank 47
--       SI5345_OUT2_N :  in std_logic; 
--       SI5345_OUT3_P :  in std_logic; -- clk_bc used in CTP emulator, ........, bank 64
--       SI5345_OUT3_N :  in std_logic;
--       SI5345_OUT4_P : in std_logic; -- LHC clk for FMC part of FPGA code, bank 67
--       SI5345_OUT4_N : in std_logic;
--       SI5345_OUT5_P : in std_logic; -- ref clk 0 for bank 224 (not used), bank 224
--       SI5345_OUT5_N : in std_logic;
--       SI5345_OUT6_P : in std_logic; -- ref clk 0 for bank 225 (240.471 MHz for OLT), bank 225
--       SI5345_OUT6_N : in std_logic;
--       SI5345_OUT7_P : in std_logic; -- ref clk 0 for bank 226 (240.471 MHz for ONU)
--       SI5345_OUT7_N : in std_logic;
--     SI5345_OUT8_P : in std_logic; -- ref clk 0 for bank 227 (not used)
--     SI5345_OUT8_N : in std_logic;
       BC_P_ONU :  out std_logic; -- LHC clk reconstructed from ONU
       BC_N_ONU :  out std_logic;
--==========================================
-- Front panel IOs
--==========================================        
        LM0_OUT1   : out std_logic;
        LM0_OUT2   : out std_logic;  
        BUSY_IN    : in  std_logic;
        BUSY_OUT   : out std_logic;
        FASTLM_IN  : in  std_logic;
        ORBIT_P    : in std_logic; -- LHC Orbit
        ORBIT_N    : in std_logic;
        SCOPE_A_FP : out std_logic;
        SCOPE_B_FP : out std_logic;
        TTC_A_OUT  : out std_logic;
        TTC_B_OUT  : out std_logic;
        PULSER_IN  : in  std_logic;
        SPARE_IN   : in  std_logic;
        SPARE_OUT  : out std_logic;
-- ====================================================================
-- QSPI Flash memory 0 - FPGA configuration storage                 ==
-- programmed through STARTUPE3 primitive (Ultrascale feature)      ==
-- ====================================================================
--        QSPI_0_CLK        : out std_logic;
--        QSPI_0_CS_B       : out std_logic;
--        QSPI_0_D0         : out std_logic;
--        QSPI_0_D1         : in std_logic;
--        QSPI_0_D2         : out std_logic;
--        QSPI_0_D3         : out std_logic;

-- ===================================================================
-- = QSPI Flash memory 1 - Xilinx SEM IP core for CRAM scubbing    ===
-- ===================================================================
        QSPI_1_CLK        : out std_logic;
        QSPI_1_CS_B       : out std_logic;
        QSPI_1_D0         : out std_logic;
        QSPI_1_D1         : in std_logic;
--        QSPI_1_D2         : out std_logic;
--        QSPI_1_D3         : out std_logic;
--===========================================
        vp         : in std_logic;           
        vn         : in std_logic;
        SYSMON_SCL_LS : inout std_logic;
        SYSMON_SDA_LS : inout std_logic;
--===========================================
--  I B E R T 
--===========================================
--  Comment:  Big Cage ... Verify Cage 
----  RX Rate Select must be '1'   "RS0 Control"
  SFP_1_TXSD_RXRESET_TR_LS : out std_logic; 
  SFP_2_TXSD_RXRESET_TR_LS : out std_logic; 
  SFP_3_TXSD_RXRESET_TR_LS : out std_logic; 
  SFP_4_TXSD_RXRESET_TR_LS : out std_logic; 
  SFP_5_TXSD_RXRESET_TR_LS : out std_logic; 
  SFP_6_TXSD_RXRESET_TR_LS : out std_logic; 
  SFP_7_TXSD_RXRESET_TR_LS : out std_logic; 
  SFP_8_TXSD_RXRESET_TR_LS : out std_logic; 
  SFP_9_TXSD_RXRESET_TR_LS : out std_logic; 
  SFP_10_TXSD_RXRESET_TR_LS : out std_logic; 
  SFP_11_TXSD_RXRESET_TR_LS : out std_logic; 
  SFP_12_TXSD_RXRESET_TR_LS : out std_logic;
  
  ----  RX Rate Select must be '1'   "RS1 Control"
  SFP_1_PDOWN_TRI_TR : out std_logic;
  SFP_2_PDOWN_TRI_TR : out std_logic;
  SFP_3_PDOWN_TRI_TR : out std_logic;
  SFP_4_PDOWN_TRI_TR : out std_logic;
  SFP_5_PDOWN_TRI_TR : out std_logic;
  SFP_6_PDOWN_TRI_TR : out std_logic;
  SFP_7_PDOWN_TRI_TR : out std_logic;
  SFP_8_PDOWN_TRI_TR : out std_logic;
  SFP_9_PDOWN_TRI_TR : out std_logic;
  SFP_10_PDOWN_TRI_TR : out std_logic;
  SFP_11_PDOWN_TRI_TR : out std_logic;
  SFP_12_PDOWN_TRI_TR : out std_logic; 

  SFP_TX_DISABLE         :  out   std_logic;
  SFP_1_TXBURST_TXDIS_TR :  out   std_logic;
  SFP_2_TXBURST_TXDIS_TR :  out   std_logic;
  SFP_3_TXBURST_TXDIS_TR :  out   std_logic;
  SFP_4_TXBURST_TXDIS_TR :  out   std_logic;
  SFP_5_TXBURST_TXDIS_TR :  out   std_logic;
  SFP_6_TXBURST_TXDIS_TR :  out   std_logic;
  SFP_7_TXBURST_TXDIS_TR :  out   std_logic;
  SFP_8_TXBURST_TXDIS_TR :  out   std_logic;
  SFP_9_TXBURST_TXDIS_TR :  out   std_logic;
  SFP_10_TXBURST_TXDIS_TR :  out   std_logic;
  SFP_11_TXBURST_TXDIS_TR :  out   std_logic;
  SFP_12_TXBURST_TXDIS_TR :  out   std_logic;
--==============================================
-- ADC for clock/signal phase measurement
--==============================================         
  ADC_IN : out std_logic;
  ADC_CLK : out std_logic;
  ADC_CS : out std_logic_vector (0 downto 0);
  ADC_SDATA : in std_logic;
--==============================================
-- Control for Si5345 for LHC clock
--==============================================
  SI5345_INSEL0     : out  std_logic; 
  SI5345_INSEL1     : out  std_logic;
  SI5345_I2C_SEL    : out  std_logic; 
  SI5345_AO_CSB     : out  std_logic;  
  SI5345_SDA_SDIO   : inout std_logic; 
  SI5345_A1_SDO     : out   std_logic;
  SI5345_SCLK       : inout  std_logic;  
  SI5345_RST        : out  std_logic; 
  SI5345_INTR       : in   std_logic;
  SI5345_LOL        : in   std_logic 
  );
        
end entity ttcit_logic;
 ---------------------------------------------------------------------------------------------
--                  A   R   C   H   I   T   E    C   T    U   R   E                        ---
---------------------------------------------------------------------------------------------- 
    architecture rtl of ttcit_logic is
-- ==========================================
-- ==   IPbus                             == 
-- ==========================================
	signal ipb_clk, ipb_rst, nuke, soft_rst, userled: std_logic;
	signal mac_addr: std_logic_vector(47 downto 0);
	signal ip_addr: std_logic_vector(31 downto 0);
	signal ipb_out: ipb_wbus;
	signal ipb_in: ipb_rbus;
--==================================================
--  external bus using FireFly cable
--==================================================
    signal DATA1_S       : std_logic := '0'; 
    signal DATA2_S       : std_logic := '0'; 
    signal DATA3_S       : std_logic := '0'; 
    signal DATA4_S       : std_logic := '0'; 
    signal DATA5_S       : std_logic := '0'; 
    signal DATA6_S       : std_logic := '0'; 
    signal DATA7_S       : std_logic := '0'; 
    signal DATA8_S       : std_logic := '0'; 
    signal DATA9_S       : std_logic := '0'; 
    signal DATA10_S      : std_logic := '0'; 
    signal DATA11_S      : std_logic := '0'; 
    signal DATA12_S      : std_logic := '0';
--==================================================
-- test clock 40 MHz
--==================================================
--    signal test_clk_1      : std_logic := '0';
--    signal test_clk_2      : std_logic := '0';
--    signal test_clk_3      : std_logic := '0';
--    signal test_clk_4      : std_logic := '0';
    signal test_clk_i_1      : std_logic := '0';
    signal test_clk_i_2      : std_logic := '0';
    signal test_clk_i_3      : std_logic := '0';
--==================================================
--  FMC card
--==================================================
--    signal FMC_HPC_GBTCLK0_M2C : std_logic := '0';
--    signal FMC_HPC_GBTCLK1_M2C : std_logic := '0';
    signal FMC_HPC_CLK0_M2C: std_logic := '0';
    signal FMC_HPC_CLK1_M2C: std_logic := '0';
----------------------------------------------------
    signal FMC_HPC_LA09    : std_logic := '0'; 
--========================================================    
    signal SI5345_I_OUT1   : std_logic := '0'; 
    signal SI5345_OUT1     : std_logic := '0';     
--========================================================
-- QSPI memory 0 -> FPGA configuration
--========================================================
    signal qspi_0_io0_i : STD_LOGIC;
--    signal qspi_0_io0_o : STD_LOGIC; --> flash_o_int_0.mosi
    signal qspi_0_io0_t : STD_LOGIC;
--    signal qspi_0_io1_i : STD_LOGIC; --> replaced by flash_i_int_0.miso
    signal qspi_0_io1_o : STD_LOGIC;
    signal qspi_0_io1_t : STD_LOGIC;
    signal qspi_0_io2_i : STD_LOGIC;
    signal qspi_0_io2_o : STD_LOGIC;
    signal qspi_0_io2_t : STD_LOGIC;
    signal qspi_0_io3_i : STD_LOGIC;
    signal qspi_0_io3_o : STD_LOGIC;
    signal qspi_0_io3_t : STD_LOGIC;
    signal qspi_0_io_i : STD_LOGIC_VECTOR(3 downto 0);
    signal qspi_0_io_o : STD_LOGIC_VECTOR(3 downto 0);
    signal qspi_0_io_t : STD_LOGIC_VECTOR(3 downto 0);
--========================================================  
-- System monitor
--========================================================
    signal channel_out          : std_logic_vector (5 downto 0):=(others => '0');
    signal ot_out               : std_logic := '0'; 
    signal eoc_out              : std_logic := '0'; 
    signal eos_out              : std_logic := '0';
    signal fpga_temperature     : std_logic_vector (15 downto 0):=(others => '0');
    signal fpga_vccaux          : std_logic_vector (15 downto 0):=(others => '0'); 
    signal fpga_vccint          : std_logic_vector (15 downto 0):=(others => '0');
    signal fpga_vccbram         : std_logic_vector (15 downto 0):=(others => '0');
    signal fpga_alarms          : std_logic_vector (15 downto 0):=(others => '0');
--========================================================
    
    signal bbert_signal_out_sel, bbert_signal_in_sel: std_logic_vector(7 downto 0);
    signal bbert_clk_out, bbert_signal_out, bbert_clk_in, bbert_signal_in: std_logic := '0';
    signal leds_F          : std_logic_vector(5 downto 1);
    signal scope_a         : std_logic_vector (31 downto 0):=(others => '0');
    signal scope_b         : std_logic_vector (31 downto 0):=(others => '0');
    signal clk_bc, orbit  : std_logic;
    signal FMC_SFP_0_SCL, FMC_SFP_1_SCL, FMC_SFP_2_SCL, FMC_SFP_3_SCL,
           FMC_SFP_4_SCL, FMC_SFP_5_SCL, FMC_SFP_6_SCL: std_logic := '1';
    signal FMC_SFP_0_SDA, FMC_SFP_1_SDA, FMC_SFP_2_SDA, FMC_SFP_3_SDA,
           FMC_SFP_4_SDA, FMC_SFP_5_SDA, FMC_SFP_6_SDA: std_logic := '1';
    signal LED_EN          : std_logic_vector (31 downto 0):=(others => '1');
    signal SFP_LED_EN      : std_logic_vector (31 downto 0):=(others => '1');

	signal flash_o_int_0: spi_mo;
    signal flash_i_int_0: spi_mi;
    signal flash_o_int_1: spi_mo;
    signal flash_i_int_1: spi_mi;
-- ==========================================================
--    ADC signals
-- ========================================================== 
signal ADC_s     : std_logic; 
signal ADC_test_data : std_logic_vector(31 downto 0); -- 32-bit register set via IPbus (ctrl.ctrl(6))
signal ADC_shift : std_logic_vector(31 downto 0);
signal ADC_count : std_logic_vector(4 downto 0) := "00000";

--===========================================================
-- TTC FMC signals
--===========================================================
signal FMC_HPC_LA10_P_s : std_logic;
signal FMC_HPC_LA05_N_s : std_logic;
signal ttc_data         : ttc_info_type;
signal ttc_status       : ttc_stat_type;
        
       
begin

--==========================================
--==   IPbus                             == 
--==========================================

    infra: entity work.kcu105_basex_infra
        port map ( 
            sysclk_p  => SI5345_I_OUT9_P,
            sysclk_n  => SI5345_I_OUT9_N,
            eth_clk_p => SI5345_I_OUT8_P,
            eth_clk_n => SI5345_I_OUT8_N,
            eth_tx_p  => SFP_TX_P,
            eth_tx_n  => SFP_TX_N,
            eth_rx_p  => SFP_RX_P, 
            eth_rx_n  => SFP_RX_N,
            sfp_los   =>  '0', 
            ipb_clk_o => ipb_clk, 
            rst_ipb_o => ipb_rst, 
            nuke      => nuke,
            soft_rst  => soft_rst,
            leds(0)   => LED_15, 
            leds(1)   => LED_14,            -- Comment Check the LEDS declaration in kcu105
            mac_addr  => mac_addr,
            ip_addr   => ip_addr,
            ipb_in    => ipb_in, 
            ipb_out   => ipb_out 
                    ); 
		
	mac_addr <= x"080030002a"  & sn (7 downto 0 );  -- Careful here, arbitrary addresses do not always work
    ip_addr <= x"c0a8c8" & sn(7 downto 0 ); -- 192.168.200.16+n

-- ipbus slaves live in the entity below, and can expose top-level ports
-- The ipbus fabric is instantiated within.

	ipb_slaves: entity work.ipbus_slaves
		port map(
			ipb_clk => ipb_clk,
			ipb_rst => ipb_rst,
			ipb_in => ipb_out,
			ipb_out => ipb_in,
			nuke => nuke,
			soft_rst => soft_rst,
			userled => open,
			fpga_temperature => fpga_temperature,
            fpga_vccaux => fpga_vccaux,
            fpga_vccint => fpga_vccint,
            fpga_vccbram => fpga_vccbram,
            fpga_alarms => fpga_alarms,
			clk_bc => clk_bc,
            rst_bc => '0', --> I should generate reset pulse for 40 MHz domain 
			i2c_scl => IIC_MUX_SCL_MAIN,
			i2c_sda => IIC_MUX_SDA_MAIN,
			flash_spi_in_0  => flash_i_int_0, -- in: miso
            flash_spi_out_0 => flash_o_int_0, -- out: clk, mosi, le
            flash_spi_in_1  => flash_i_int_1, -- in: miso
            flash_spi_out_1 => flash_o_int_1, -- out: clk, mosi, le
            bbert_signal_out_sel => bbert_signal_out_sel,
            bbert_signal_in_sel => bbert_signal_in_sel,
            bbert_clk_out => bbert_clk_out,
            bbert_signal_out => bbert_signal_out,
            bbert_clk_in => bbert_clk_in,
            bbert_signal_in => bbert_signal_in,
            leds_F => leds_F,
            sn => sn,
            scope_a => scope_a,
            scope_b => scope_b,
            adc_clk => ADC_CLK,
            adc_cs => ADC_CS,
            adc_sdata => ADC_SDATA,
            SI5345_SCLK => SI5345_SCLK,
            SI5345_SDA_SDIO => SI5345_SDA_SDIO,
            SI5345_INTR => SI5345_INTR,
            SI5345_LOL => SI5345_LOL,
            LED_EN => LED_EN, -- 25 LEDs
            SFP_LED_EN => SFP_LED_EN, -- 12 x RED, 12 x GREEN
            ADC_test_data => ADC_test_data,
            ttc_data_i => ttc_data,
            ttc_status_i => ttc_status,
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
            ddr4_1_inst0_c0_sys_clk_p => ddr4_1_inst0_c0_sys_clk_p
		);

-- Flash SPI selection logic
    QSPI_1_CLK <= flash_o_int_1.clk;
    QSPI_1_CS_B <= flash_o_int_1.le;                    
    QSPI_1_D0  <= flash_o_int_1.mosi;
    flash_i_int_1.miso <= QSPI_1_D1;

-- ADC input signal
ADC : process(ipb_clk) is begin
      if rising_edge(ipb_clk) then
        if(ADC_count = "0000") then
            ADC_shift <= ADC_test_data(30 downto 0)& '0';
            ADC_count <= ADC_count + 1;
            ADC_s <= ADC_test_data(31);
        else
            ADC_shift <= ADC_shift(30 downto 0) & '0';
            ADC_count <= ADC_count + 1;
            ADC_s <= ADC_shift(31);
        end if;
      end if;
    end process; 
  
    ADC_IN <= ADC_s; -- output going to ADC input
  
-- PLL Si5345 signals  
    SI5345_INSEL0 <= '1'; -- selection of clock input for Si5345
    SI5345_INSEL1 <= '1'; -- (00->IN0, 01->IN1, 10->IN2, 11->IN3)
    SI5345_I2C_SEL <= '1'; -- selection of serial interface for Si5345, 1 = I2C, 0 = SPI
    SI5345_AO_CSB <= '0'; -- for I2C it is A0, for SPI it is CSB(active low) 
    SI5345_A1_SDO <= '0'; -- for I2C it is A1, for SPI it is SDO 
    SI5345_RST <= '1'; -- RST is active in 0

-- TTC FMC card  
TTC_FMC: entity work.ttc_fmc_wrapper
port map (
--== ttc fmc interface ==--
   cdrclk_in     => FMC_HPC_CLK1_M2C, -- ADN2812 CDR 160MHz clock output
   cdrdata_in    => FMC_HPC_LA09,     -- ADN2812 CDR Serial Data output
   ttc_los       => FMC_HPC_LA08_N,   -- ADN2812 CDR Loss Of Sync flag. Active high.
   ttc_lol       => FMC_HPC_LA08_P,   -- ADN2812 CDR Loss Of Sync flag. Active high.
   div_nrst      => FMC_HPC_LA10_P_s,   -- clock divider sy89872 async reset control, used to align the phase of 40mhz clock divider output relative to the input stream
   info_o        => ttc_data,     
   stat_o        => ttc_status,
   --== auxiliary outputs ===--
   cdrclk_out    => open,    
   ready         => FMC_HPC_LA05_N_s, -- out, User LED on FMC TTC card     
   ttc_clk_gated => open          -- out, gated 40MHz clock, for comparison only
);

FMC_HPC_LA01_CC_P <= '1';               -- enable for 160 MHz clock
FMC_HPC_LA10_P <= FMC_HPC_LA10_P_s;
FMC_HPC_LA05_N <= not FMC_HPC_LA05_N_s; -- LED on in '0' because there is inverted on FMC TTC card

--======================================================
-- ALL outputs with test clock
--======================================================
    LM0_OUT1 <= test_clk_i_3;
    LM0_OUT2 <= test_clk_i_3;
    BUSY_OUT <= test_clk_i_3;
    TTC_A_OUT <= test_clk_i_3;
    TTC_B_OUT <= test_clk_i_3;
    SPARE_OUT <= test_clk_i_3;
        
--======================================================

--=======================================================
--==   STARTUPE3: STARTUP Block for Kintex UltraScale  == 
--=======================================================
-- MK -- I didn`t remove auxiliary nets as in future we can try to use QUAD SPI
-- where we need tri-state control for each pin 

    qspi_0_io_o <= qspi_0_io3_o & qspi_0_io2_o & qspi_0_io1_o & flash_o_int_0.mosi;
    
    qspi_0_io0_t <= '0';
    qspi_0_io1_t <= '1';
    qspi_0_io2_t <= '1';
    qspi_0_io3_t <= '1';
    qspi_0_io_t <= qspi_0_io3_t & qspi_0_io2_t & qspi_0_io1_t & qspi_0_io0_t;
    
    qspi_0_io0_i <= qspi_0_io_i(0);
    flash_i_int_0.miso <= qspi_0_io_i(1);
    qspi_0_io2_i <= qspi_0_io_i(2);
    qspi_0_io3_i <= qspi_0_io_i(3);

STARTUPE3_inst: STARTUPE3 
    generic map (PROG_USR => "FALSE",  -- Activate program event security feature. Requires encrypted bitstreams.
                 SIM_CCLK_FREQ => 0.0  -- Set the Configuration Clock Frequency (ns) for simulation
    )    
    port map (
        CFGCLK           => open,            -- 1-bit output: Configuration main clock output
        CFGMCLK          => open,            -- 1-bit output: Configuration internal oscillator clock output
        DI               => qspi_0_io_i,     -- 4-bit output: Allow receiving on the D input pin
        EOS              => open,            -- 1-bit output: Active-High output signal indicating the End Of Startup
        PREQ             => open,            -- 1-bit output: PROGRAM request to fabric output
        DO               => qspi_0_io_o,     -- 4-bit input: Allows control of the D pin output
        DTS              => qspi_0_io_t, -- 4-bit input: Allows tristate of the D pin (active low)
        FCSBO            => flash_o_int_0.le,  -- 1-bit input: Controls the FCS_B pin for flash access
        FCSBTS           => '0',     -- 1-bit input: Tristate the FCS_B pin (active low)
        GSR              => '0',             -- 1-bit input: Global Set/Reset input (GSR cannot be used for the port)
        GTS              => '0',             -- 1-bit input: Global 3-state input (GTS cannot be used for the port name)
        KEYCLEARB        => '1',             -- 1-bit input: Clear AES Decrypter Key input from Battery-Backed RAM (BBRAM)
        PACK             => '1',             -- 1-bit input: PROGRAM acknowledge input
        USRCCLKO         => flash_o_int_0.clk,    -- 1-bit input: User CCLK input
        USRCCLKTS        => '0', -- 1-bit input: User CCLK 3-state enable input (active low)
        USRDONEO         => '1',             -- 1-bit input: User DONE pin output control
        USRDONETS        => '1'              -- 1-bit input: User DONE 3-state enable output
   );

 --=========================================================================================
-- IBERT  GTH channels
--========================================================================================
    SFP_TX_DISABLE <= '0';
    SFP_1_TXBURST_TXDIS_TR <= '1';
    SFP_2_TXBURST_TXDIS_TR <= '1';
    SFP_3_TXBURST_TXDIS_TR <= '1';
    SFP_4_TXBURST_TXDIS_TR <= '1';
    SFP_5_TXBURST_TXDIS_TR <= '1';
    SFP_6_TXBURST_TXDIS_TR <= '1';
    SFP_7_TXBURST_TXDIS_TR <= '1';
    SFP_8_TXBURST_TXDIS_TR <= '1';
    SFP_9_TXBURST_TXDIS_TR <= '1';
    SFP_10_TXBURST_TXDIS_TR <= '1';
    SFP_11_TXBURST_TXDIS_TR <= '1';
    SFP_12_TXBURST_TXDIS_TR <= '1';

--=========================================================================================
-- System monitor
--=========================================================================================

sysmon: entity work.ug580
port map (
          -- inputs
          DCLK                  => ipb_clk,       -- Clock input for the dynamic reconfiguration port  
          RESET                 => ipb_rst,       -- Reset signal for the System Monitor control logic 
          VP                    => '0', --VP,            -- input wire vp                                     
          VN                    => '0', --VN,            -- input wire vn
          VAUXP0                => '0', --VAUXP0,        -- input wire vauxp 
          VAUXN0                => '0', --VAUXN0 ,       -- input wire vauxn
          VAUXP8                => '0', --VAUXP8,        -- input wire vauxp 
          VAUXN8                => '0', --VAUXN8 ,       -- input wire vauxn                       
          I2C_SCLK              => SYSMON_SCL_LS,  
          I2C_SDA               => SYSMON_SDA_LS,    
          -- outputs                                                     
          MEASURED_TEMP         => fpga_temperature,  -- out 15..0                                 
          MEASURED_VCCAUX       => fpga_vccaux,   -- out 15..0                                 
          MEASURED_VCCINT       => fpga_vccint,   -- out 15..0                   
          MEASURED_VCCBRAM      => fpga_vccbram,  -- out 15..0                      
          MEASURED_AUX0         => open,     -- out 15..0                      
          MEASURED_AUX1         => open,     -- out 15..0                
          MEASURED_AUX2         => open,          -- out 15..0      
          MEASURED_AUX3         => open,          -- out 15..0         
          ALM                   => fpga_alarms,   -- out 15..0                               
          CHANNEL               => channel_out,   -- out 5..0 - not used                     
          OT                    => ot_out,        -- out - not used                     
          EOC                   => eoc_out,       -- out - not used      
          EOS                   => eos_out        -- out - not used             
         );
                    
-- ============================================================ 
-- ==   Temporary assigned all inputs !!!                    == 
-- ============================================================
    with scope_a select
    SCOPE_A_FP  <= FMC_HPC_CLK1_M2C when x"00000001",  -- ADN2812 CDR 160MHz clock output
                   FMC_HPC_CLK0_M2C when x"00000002",  -- 40MHz clock from FMC TTC divider
                   FMC_HPC_LA09 when x"00000003",      -- ADN2812 CDR Serial Data output
                   FMC_HPC_LA08_N when x"00000004",    -- ADN2812 CDR Loss Of Sync flag. Active high.
                   FMC_HPC_LA08_P when x"00000005",    -- ADN2812 CDR Loss Of Sync flag. Active high.
                   FMC_HPC_LA10_P_s when x"00000006",  -- clock divider sy89872 async reset control, used to align the phase of 40mhz clock divider output relative to the input stream
                   FMC_HPC_LA05_N_s when x"00000007",  -- user LED -> connected signal READY from TTC_FMC module
                    '0' when others;
                    
    with scope_b select 
    SCOPE_B_FP  <=  clk_bc   when x"00000001", 
                    orbit     when x"00000002",
                    BUSY_IN   when x"00000003",
                    FASTLM_IN when x"00000004",
                    PULSER_IN when x"00000005",
                    SPARE_IN  when x"00000006",
--                    SPARE_OUT  when x"00000007",
                    FMC_HPAC_PG_M2C     when x"00000008", -- no loop-back on XM107
                    FMC_HPC_PRSNT_M2C_B when x"00000009", -- no loop-back on XM107
                    VADJ1V8_PGOOD       when x"0000000A", -- no loop-back on XM107
--                    FMC_HPC_GBTCLK0_M2C when x"0000000D", -- there is clock on KAYA, XM107, S-18
--                    FMC_HPC_GBTCLK1_M2C when x"0000000E", -- there is clock on KAYA, XM107, S-18
                    FMC_HPC_LA09 when x"0000001F",
                    --
                    test_clk_i_1  when x"00000031", -- free running clk
                    test_clk_i_2  when x"00000032", -- free running clk
                    test_clk_i_3  when x"00000033", -- free running clk
--                    test_clk_1  when x"00000034", -- LHC clock
--                    test_clk_2  when x"00000035", -- LHC clock
--                    test_clk_3  when x"00000036", -- LHC clock
                    DATA1_S when x"00000037",
                    DATA2_S when x"00000038", 
                    DATA3_S when x"00000039", 
                    DATA4_S when x"0000003A", 
                    DATA5_S when x"0000003B", 
                    DATA6_S when x"0000003C", 
                    DATA7_S when x"0000003D", 
                    DATA8_S when x"0000003E", 
                    DATA9_S when x"0000003F", 
                    DATA10_S when x"00000040", 
                    DATA11_S when x"00000041", 
                    DATA12_S when x"00000042",  
                    '0' when others;
    
   LED_1                   <= LED_EN(0);
   LED_2                   <= LED_EN(1);
   LED_3                   <= LED_EN(2); 
   LED_4                   <= LED_EN(3); 
   LED_5                   <= LED_EN(4); 
   LED_6                   <= LED_EN(5); 
   LED_7                   <= LED_EN(6); 
   LED_8                   <= LED_EN(7); 
   LED_9                   <= LED_EN(8);   
   LED_10                  <= LED_EN(9); 
   LED_11                  <= LED_EN(10); 
   LED_12                  <= LED_EN(11);
   LED_13                  <= LED_EN(12);
-- 14,15,16 is connected to IPbus
   LED_16                  <= LED_EN(15);
   LED_17                  <= LED_EN(16);
   LED_18                  <= LED_EN(17);
   LED_19                  <= LED_EN(18);
   LED_20                  <= LED_EN(19);
   LED_21_LS               <= LED_EN(20); 
   LED_22_LS               <= LED_EN(21); 
   LED_23_LS               <= LED_EN(22); 
   LED_24_LS               <= LED_EN(23); 
   LED_25_LS               <= LED_EN(24); 
   SFP1_LED_GR             <= SFP_LED_EN(0); 
   SFP1_LED_RD             <= SFP_LED_EN(1); 
   SFP2_LED_GR             <= SFP_LED_EN(2); 
   SFP2_LED_RD             <= SFP_LED_EN(3); 
   SFP3_LED_GR             <= SFP_LED_EN(4); 
   SFP3_LED_RD             <= SFP_LED_EN(5); 
   SFP4_LED_GR             <= SFP_LED_EN(6); 
   SFP4_LED_RD             <= SFP_LED_EN(7); 
   SFP5_LED_GR             <= SFP_LED_EN(8); 
   SFP5_LED_RD             <= SFP_LED_EN(9); 
   SFP6_LED_GR             <= SFP_LED_EN(10); 
   SFP6_LED_RD             <= SFP_LED_EN(11); 
   SFP7_LED_GR             <= SFP_LED_EN(12); 
   SFP7_LED_RD             <= SFP_LED_EN(13); 
   SFP8_LED_GR             <= SFP_LED_EN(14); 
   SFP8_LED_RD             <= SFP_LED_EN(15); 
   SFP9_LED_GR             <= SFP_LED_EN(16); 
   SFP9_LED_RD             <= SFP_LED_EN(17);
   SFP10_LED_GR            <= SFP_LED_EN(18); 
   SFP10_LED_RD            <= SFP_LED_EN(19); 
   SFP11_LED_GR            <= SFP_LED_EN(20); 
   SFP11_LED_RD            <= SFP_LED_EN(21); 
   SFP12_LED_GR            <= SFP_LED_EN(22); 
   SFP12_LED_RD            <= SFP_LED_EN(23);  

ibuf_c_i_5: IBUFDS
		port map(
			i => Si5345_I_OUT2_P,
			ib => Si5345_I_OUT2_N,
			o => test_clk_i_1
		);

ibuf_c_i_6: IBUFDS
		port map(
			i => Si5345_I_OUT3_P,
			ib => Si5345_I_OUT3_N,
			o => test_clk_i_2
		);

ibuf_c_i_7: IBUFDS
		port map(
		    i => Si5345_I_OUT4_P,
			ib => Si5345_I_OUT4_N,
			o => test_clk_i_3
		 );

--ibuf_c_1: IBUFDS
--		port map(
--			i => Si5345_OUT1_P,
--			ib => Si5345_OUT1_N,
--			o => test_clk_1
--		);

--ibuf_c_5: IBUFDS
--		port map(
--			i => Si5345_OUT5_P,
--			ib => Si5345_OUT5_N,
--			o => test_clk_2
--		);
                 
--ibuf_c_6: IBUFDS
--		port map(
--			i => Si5345_OUT6_P,
--			ib => Si5345_OUT6_N,
--			o => test_clk_3
--		);
		
--ibuf_c_8: IBUFDS
--        port map(
--           i => Si5345_OUT8_P,
--           ib => Si5345_OUT8_N,
--           o => test_clk_4
--        );

ibuf_orbit: IBUFDS
		port map(
			i => ORBIT_P,
			ib => ORBIT_N,
			o => orbit
		);

obuf_bc_onu: OBUFDS
		port map(
			o => BC_P_ONU,
			ob => BC_N_ONU,
			i => clk_bc
		);

-- +---------------------------------------------+
 -- |--   In/Out  LVDS   signals              ----|
 -- |---------------------------------------------| 
 -- |     DATA_1  -- Samtec FireFly               |
 -- |---------------------------------------------|
 -- + ------------------------------------------- +
 -- | IOBUFDS: Differential Input/Output Buffer   |
 -- |          Kintex UltraScale                  |
 -- |                                             |  
 -- |----------------------------------------------    
     
  DATA1_inst : IOBUFDS
     port map (
              O   => (DATA1_S),    -- 1-bit output: Buffer output
              I   => '1',       -- 1-bit input: Buffer input
              IO  => (DATA1_P),    -- 1-bit inout: Diff_p inout (connect directly to top-level port)
              IOB => (DATA1_N),    -- 1-bit inout: Diff_n inout (connect directly to top-level port)
              T   => ('0')     -- 1-bit input: 3-state enable input
              );
  
  DATA2_inst : IOBUFDS
      port map (
                O   => (DATA2_S),    -- 1-bit output: Buffer output
                I   => '1',       -- 1-bit input: Buffer input
                IO  => (DATA2_P),    -- 1-bit inout: Diff_p inout (connect directly to top-level port)
                IOB => (DATA2_N),    -- 1-bit inout: Diff_n inout (connect directly to top-level port)
                T   => ('0')     -- 1-bit input: 3-state enable input
                );
  
  DATA3_inst :IOBUFDS
      port map (
                O  => (DATA3_S),    -- 1-bit output: Buffer output
                I  => '1',       -- 1-bit input: Buffer input
                IO => (DATA3_P),    -- 1-bit inout: Diff_p inout (connect directly to top-level port)
                IOB=> (DATA3_N),    -- 1-bit inout: Diff_n inout (connect directly to top-level port)
                T  => ('0')     -- 1-bit input: 3-state enable input
                );    

  DATA4_inst: IOBUFDS 
      port map (
                O   => (DATA4_S),    -- 1-bit output: Buffer output
                I   => '1',       -- 1-bit input: Buffer input
                IO  => (DATA4_P),    -- 1-bit inout: Diff_p inout (connect directly to top-level port)
                IOB => (DATA4_N),    -- 1-bit inout: Diff_n inout (connect directly to top-level port)
                T   => ('0')     -- 1-bit input: 3-state enable input
                );   

  DATA5_inst: IOBUFDS 
      port map (
                O  => (DATA5_S),     -- 1-bit output: Buffer output
                I  => '1',        -- 1-bit input: Buffer input
                IO => (DATA5_P),     -- 1-bit inout: Diff_p inout (connect directly to top-level port)
                IOB=> (DATA5_N),     -- 1-bit inout: Diff_n inout (connect directly to top-level port)
                T  => ('0')      -- 1-bit input: 3-state enable input
               ); 

  DATA6_inst: IOBUFDS 
      port map (
                 O   => (DATA6_S),    -- 1-bit output: Buffer output
                 I   => '1',       -- 1-bit input: Buffer input
                 IO  => (DATA6_P),    -- 1-bit inout: Diff_p inout (connect directly to top-level port)
                 IOB => (DATA6_N),    -- 1-bit inout: Diff_n inout (connect directly to top-level port)
                 T   => ('0')     -- 1-bit input: 3-state enable input
                 );  

  DATA7_inst:  IOBUFDS 
      port map  (
                 O   => (DATA7_S),    -- 1-bit output: Buffer output
                 I   => '1',       -- 1-bit input: Buffer input
                 IO  => (DATA7_P),    -- 1-bit inout: Diff_p inout (connect directly to top-level port)
                 IOB => (DATA7_N),    -- 1-bit inout: Diff_n inout (connect directly to top-level port)
                 T   => ('0')     -- 1-bit input: 3-state enable input
                 );   
 
  DATA8_inst: IOBUFDS
      port map (
                O   => (DATA8_S),   --1-bit output: Buffer output
                I   => '1',      --1-bit input: Buffer input
                IO  => (DATA8_P),   --1-bit inout: Diff_p inout (connect directly to top-level port)
                IOB => (DATA8_N),   --1-bit inout: Diff_n inout (connect directly to top-level port)
                T   => ('0')    --1-bit input: 3-state enable input
     );

  DATA9_inst: IOBUFDS
      port map (
                O  => (DATA9_S),     -- 1-bit output: Buffer output
                I  => '1',        -- 1-bit input: Buffer input
                IO => (DATA9_P),     -- 1-bit inout: Diff_p inout (connect directly to top-level port)
                IOB=> (DATA9_N),     -- 1-bit inout: Diff_n inout (connect directly to top-level port)
                T  => ('0')      -- 1-bit input: 3-state enable input
                 ) ;

  DATA10_inst: IOBUFDS
      port map  (
                  O  => (DATA10_S),   -- 1-bit output: Buffer output
                  I  => '1',       -- 1-bit input: Buffer input
                  IO => (DATA10_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
                  IOB=> (DATA10_N),   -- 1-bit inout: Diff_n inout (connect directly to top-level port)
                  T  => ('0')     -- 1-bit input: 3-state enable input
                );              

  DATA11_inst:IOBUFDS 
      port map (
                 O  => (DATA11_S),   -- 1-bit output: Buffer output
                 I  => '1',       -- 1-bit input: Buffer input
                 IO => (DATA11_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
                 IOB=> (DATA11_N),   -- 1-bit inout: Diff_n inout (connect directly to top-level port)
                 T  => ('0')     -- 1-bit input: 3-state enable input
      ); 
 
  DATA12_inst:IOBUFDS 
      port map  (
                 O   => (DATA12_S),   -- 1-bit output: Buffer output
                 I   => '1',       -- 1-bit input: Buffer input
                 IO  => (DATA12_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
                 IOB => (DATA12_N),   -- 1-bit inout: Diff_n inout (connect directly to top-level port)
                 T   => ('0')     -- 1-bit input: 3-state enable input
                ); 

-- |---------------------------------------------| 
-- |     FMC_HPC_GBTCLK0_M2C                     |
-- |---------------------------------------------|
--IBUFDS_FMC_HPC_GBTCLK0_M2C: IBUFDS
--    generic map (
--                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS") -- Specify the I/O standard    
--    port map (
--                O   => (FMC_HPC_GBTCLK0_M2C),      -- 1-bit output: Buffer output
--                I  => (FMC_HPC_GBTCLK0_M2C_P),      -- 1-bit inout: Diff_p input (connect directly to top-level port)
--                IB => (FMC_HPC_GBTCLK0_M2C_N)      -- 1-bit inout: Diff_n input (connect directly to top-level port)
--              ); 

-- |---------------------------------------------| 
-- |     FMC_HPC_GBTCLK1_M2C                     |
-- |---------------------------------------------|
--IBUFDS_FMC_HPC_GBTCLK1_M2C: IBUFDS
--    generic map (
--                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS") -- Specify the I/O standard
--    port map (
--                O   => (FMC_HPC_GBTCLK1_M2C),      -- 1-bit output: Buffer output
--                I  => (FMC_HPC_GBTCLK1_M2C_P),      -- 1-bit inout: Diff_p input (connect directly to top-level port)
--                IB => (FMC_HPC_GBTCLK1_M2C_N)      -- 1-bit inout: Diff_n input (connect directly to top-level port)
--              ); 

-- |---------------------------------------------| 
-- |    FMC_HPC_CLK1_M2C                         |
-- |---------------------------------------------|
IBUFDS_FMC_HPC_CLK1_M2C: IBUFDS
    generic map (
                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
                   IOSTANDARD => "LVDS") -- Specify the I/O standard 
    port map (
                O  => (FMC_HPC_CLK1_M2C),    -- 1-bit output: Buffer output
                I => (FMC_HPC_CLK1_M2C_P),   -- 1-bit inout: Diff_p input (connect directly to top-level port)
                IB=> (FMC_HPC_CLK1_M2C_N)  -- 1-bit inout: Diff_n input (connect directly to top-level port)         
   );      

-- |---------------------------------------------| 
-- |    FMC_HPC_CLK0_M2C                         |
-- |---------------------------------------------|
IBUFDS_FMC_HPC_CLK0_M2C: IBUFDS
    generic map (
                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
                   IOSTANDARD => "LVDS") -- Specify the I/O standard 
    port map (
                O  => (FMC_HPC_CLK0_M2C),    -- 1-bit output: Buffer output
                I => (FMC_HPC_CLK0_M2C_P),   -- 1-bit inout: Diff_p input (connect directly to top-level port)
                IB=> (FMC_HPC_CLK0_M2C_N)  -- 1-bit inout: Diff_n input (connect directly to top-level port)         
   );

bufg_clk_bc: BUFG 
        port map(
		  i => FMC_HPC_CLK0_M2C,
		  o => clk_bc
	);

-- |---------------------------------------------| 
-- |     FMC_HPC_LA07     --Channel 3  TX_FAULT     |
-- |---------------------------------------------|
--IOBUFDS_FMC_HPC_LA07: IOBUFDS
--        generic map (
--                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate    
--         port map (
--                      O   => (FMC_HPC_LA07),      -- 1-bit output: Buffer output
--                      I   => '1',                -- 1-bit input: Buffer input
--                      IO  => (FMC_HPC_LA07_P),      -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--                      IOB => (FMC_HPC_LA07_N),      -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--                      T   => ('1')              -- 1-bit input: 3-state enable input/
--                    ); 

-- |---------------------------------------------| 
-- |     FMC_HPC_LA16 -- Channel mod_def_2       |
-- |---------------------------------------------|
--IOBUFDS_FMC_HPC_LA16: IOBUFDS 
--    generic map (
--                   DIFF_TERM => FALSE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate    
--       port map  (
--                   O   => (FMC_HPC_LA16),      -- 1-bit output: Buffer output
--                   I   => lhc_clk,             -- 1-bit input: Buffer input
--                   IO  => (FMC_HPC_LA16_P),    -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--                   IOB => (FMC_HPC_LA16_N),    -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--                   T   => ('0')                -- 1-bit input: 3-state enable input
--                  );

-- |---------------------------------------------| 
-- |     FMC_HPC_LA15 -- Channel Mod_def0        |
-- |---------------------------------------------|
--IOBUFDS_FMC_HPC_LA15:IOBUFDS 
--     generic map (
--                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate    

--   port map  (
--              O  => (FMC_HPC_LA15),      -- 1-bit output: Buffer output
--              I  => '1',                -- 1-bit input: Buffer input
--              IO => (FMC_HPC_LA15_P),      -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--              IOB=> (FMC_HPC_LA15_N),      -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--              T  => ('1')              -- 1-bit input: 3-state enable input
--              );   

-- |---------------------------------------------| 
-- |     FMC_HPC_LA14                            |
-- |---------------------------------------------|
--IOBUFDS_FMC_HPC_LA14: IOBUFDS
--    generic map (
--                   DIFF_TERM => FALSE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate    

--    port map (
--               O  => (FMC_HPC_LA14),     -- 1-bit output: Buffer output
--               I  => lhc_clk,               -- 1-bit input: Buffer input
--               IO => (FMC_HPC_LA14_P),     -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--               IOB=> (FMC_HPC_LA14_N),     -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--               T  => ('0')             -- 1-bit input: 3-state enable input   
--              );   

-- |---------------------------------------------| 
-- |     FMC_HPC_LA13                            |
-- |---------------------------------------------|
--IOBUFDS_FMC_HPC_LA13:  IOBUFDS 
--   generic map (
--                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate  
--   port  map (
--               O  => (FMC_HPC_LA13),    -- 1-bit output: Buffer output
--               I  => '1',              -- 1-bit input: Buffer input
--               IO => (FMC_HPC_LA13_P),    -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--               IOB=> (FMC_HPC_LA13_N),    -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--               T  => ('1')            -- 1-bit input: 3-state enable input      
--              );   
  -------------------------------------------
--   FMC_HPC_LA13_N <= '0'; 
  -------------------------------------------
   
-- |---------------------------------------------| 
-- |     FMC_HPC_LA12                            |
-- |---------------------------------------------|
--IOBUFDS_FMC_HPC_LA12: IOBUFDS 
--    generic map (
--                   DIFF_TERM => FALSE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate  
--      port map (
--                O  => (FMC_HPC_LA12),   -- 1-bit output: Buffer output
--                I  => lhc_clk,             -- 1-bit input: Buffer input
--                IO => (FMC_HPC_LA12_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--                IOB=> (FMC_HPC_LA12_N),   -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--                T  => ('0')           -- 1-bit input: 3-state enable input
--                ); 

---- |---------------------------------------------| 
---- |     FMC_HPC_LA10                            |
---- |---------------------------------------------|
----IOBUFDS_FMC_HPC_LA10: IOBUFDS
----     generic map (
----                   DIFF_TERM => FALSE, -- Differential Termination (TRUE/FALSE)
----                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
----                   IOSTANDARD => "LVDS", -- Specify the I/O standard
----                   SLEW => "SLOW")       -- Specify the output slew rate 
----     port map (
----                O  => (FMC_HPC_LA10),     -- 1-bit output: Buffer output
----                I  => lhc_clk,               -- 1-bit input: Buffer input
----                IO => (FMC_HPC_LA10_P),     -- 1-bit inout: Diff_p inout (connect directly to top-level port)
----                IOB=> (FMC_HPC_LA10_N),     -- 1-bit inout: Diff_n inout (connect directly to top-level port)
----                T  => ('0')             -- 1-bit input: 3-state enable input    .T(BUSY_IN)     -- 1-bit input: 3-state enable input 
----            );
--   ------------------------------           
-- |---------------------------------------------| 
-- |     FMC_HPC_LA09                            |
-- |---------------------------------------------|
IOBUFDS_FMC_HPC_LA09: IOBUFDS 
   generic map (
                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
                   IOSTANDARD => "LVDS", -- Specify the I/O standard
                   SLEW => "SLOW")       -- Specify the output slew rate 
    port map(
             O   => (FMC_HPC_LA09),     -- 1-bit output: Buffer output
             I   => '1',               -- 1-bit input: Buffer input
             IO  => (FMC_HPC_LA09_P),     -- 1-bit inout: Diff_p inout (connect directly to top-level port)
             IOB => (FMC_HPC_LA09_N),     -- 1-bit inout: Diff_n inout (connect directly to top-level port)
             T   => ('1')             -- 1-bit input: 3-state enable input
             );   

----  |---------------------------------------------| 
----  |     FMC_HPC_LA08                            |
----  |---------------------------------------------|
----IOBUFDS_FMC_HPC_LA08: IOBUFDS 
----       generic map (
----                   DIFF_TERM => FALSE, -- Differential Termination (TRUE/FALSE)
----                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
----                   IOSTANDARD => "LVDS", -- Specify the I/O standard
----                   SLEW => "SLOW")       -- Specify the output slew rate 
----     port map (
----                O  => (FMC_HPC_LA08),    -- 1-bit output: Buffer output
----                I  => lhc_clk,              -- 1-bit input: Buffer input
----                IO => (FMC_HPC_LA08_P),    -- 1-bit inout: Diff_p inout (connect directly to top-level port)
----                IOB=> (FMC_HPC_LA08_N),    -- 1-bit inout: Diff_n inout (connect directly to top-level port)
----                T  => ( '0')           -- 1-bit input: 3-state enable input
----      );    

----  |---------------------------------------------| 
----  |     FMC_HPC_LA02                            |
----  |---------------------------------------------|
--IOBUFDS_FMC_HPC_LA02: IOBUFDS 
--    generic map (
--                   DIFF_TERM => FALSE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate 
--     port map (
--                O  => (FMC_HPC_LA02),   -- 1-bit output: Buffer output
--                I  => lhc_clk,             -- 1-bit input: Buffer input
--                IO => (FMC_HPC_LA02_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--                IOB=> (FMC_HPC_LA02_N),   -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--                T  => ('0')           -- 1-bit input: 3-state enable input  
--               );

---- |---------------------------------------------| 
---- |     FMC_HPC_LA01_CC                         |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_LA01_CC:IOBUFDS 
--    generic map (
--                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate 
--     port map  (
--                O  => (FMC_HPC_LA01_CC),   -- 1-bit output: Buffer output
--                I  => '1',                -- 1-bit input: Buffer input
--                IO => (FMC_HPC_LA01_CC_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--                IOB=> (FMC_HPC_LA01_CC_N),   -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--                T  => ('1')              -- 1-bit input: 3-state enable input         
--          );  

---- |---------------------------------------------| 
---- |     FMC_HPC_LA00_CC                         |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_LA00_CC: IOBUFDS 
--     generic map (
--                   DIFF_TERM => FALSE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate 
--       port map (
--                  O   => (FMC_HPC_LA00_CC),   -- 1-bit output: Buffer output
--                  I   => lhc_clk,                -- 1-bit input: Buffer input
--                  IO  => (FMC_HPC_LA00_CC_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--                  IOB => (FMC_HPC_LA00_CC_N),   -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--                  T   => ('0')              -- 1-bit input: 3-state enable input         
--      );  

---- |---------------------------------------------| 
---- |    FMC_HPC_LA11                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_LA11: IOBUFDS 
--      generic map (
--                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate 
--     port map (
--                O   => (FMC_HPC_LA11),   -- 1-bit output: Buffer output
--                I   => '1',             -- 1-bit input: Buffer input
--                IO  => (FMC_HPC_LA11_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--                IOB => (FMC_HPC_LA11_N),   -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--                T   => ('1')           -- 1-bit input: 3-state enable input         
--       );    

---- |---------------------------------------------| 
---- |    FMC_HPC_LA05                             |
---- |---------------------------------------------|
----IOBUFDS_FMC_HPC_LA05: IOBUFDS 
----         generic map (
----                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
----                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
----                   IOSTANDARD => "LVDS", -- Specify the I/O standard
----                   SLEW => "SLOW")       -- Specify the output slew rate
   
----   port map(
----           O  => (FMC_HPC_LA05),   -- 1-bit output: Buffer output
----           I  => '1',             -- 1-bit input: Buffer input
----           IO => (FMC_HPC_LA05_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
----           IOB=> (FMC_HPC_LA05_N),   -- 1-bit inout: Diff_n inout (connect directly to top-level port)
----           T  => ('1')           -- 1-bit input: 3-state enable input         
----   );     
    
---- |---------------------------------------------| 
---- |    FMC_HPC_LA04                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_LA04: IOBUFDS
--        generic map (
--                   DIFF_TERM => FALSE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
    
--     port map (
--                O  => (FMC_HPC_LA04),   -- 1-bit output: Buffer output
--                I  => lhc_clk,             -- 1-bit input: Buffer input
--                IO => (FMC_HPC_LA04_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--                IOB=> (FMC_HPC_LA04_N),   -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--                T  => ('0')           -- 1-bit input: 3-state enable input         
--      );       
      
---- |---------------------------------------------| 
---- |    FMC_HPC_LA03                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_LA03: IOBUFDS 
--          generic map (
--                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
--   port map (
--             O   => (FMC_HPC_LA03),  --  1-bit output: Buffer output
--             I   => '1',            --  1-bit input: Buffer input
--             IO  => (FMC_HPC_LA03_P),  --  1-bit inout: Diff_p inout (connect directly to top-level port)
--             IOB => (FMC_HPC_LA03_N),  --  1-bit inout: Diff_n inout (connect directly to top-level port)
--             T   => ('1')          --  1-bit input: 3-state enable input         
--      );      
    
---- |---------------------------------------------| 
---- |    FMC_HPC_LA06                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_LA06: IOBUFDS 
--       generic map (
--                   DIFF_TERM => FALSE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
--    port map (
--              O  => (FMC_HPC_LA06),  -- 1-bit output: Buffer output
--              I  => lhc_clk,            -- 1-bit input: Buffer input
--              IO => (FMC_HPC_LA06_P),  -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--              IOB=> (FMC_HPC_LA06_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--              T  => ('0')          -- 1-bit input: 3-state enable input         
--              );       
--  -----------------------------------
---- FMC_HPC_LA06_N <= '0'; 
-- -----------------------------------

---- |---------------------------------------------| 
---- |    FMC_HPC_HA13                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_HA13: IOBUFDS 
--      generic map (
--                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
--  port map (
--      O  => (FMC_HPC_HA13),    -- 1-bit output: Buffer output
--      I  => '1',        -- 1-bit input: Buffer input
--      IO => (FMC_HPC_HA13_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--      IOB=> (FMC_HPC_HA13_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--      T  => ('1')     -- 1-bit input: 3-state enable input         
--   );       
     
---- |---------------------------------------------| 
---- |    FMC_HPC_HA16                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_HA16: IOBUFDS
--   generic map (
--                   DIFF_TERM => FALSE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
--    port map (
--      O  => (FMC_HPC_HA16),    -- 1-bit output: Buffer output
--      I  => lhc_clk,        -- 1-bit input: Buffer input
--      IO => (FMC_HPC_HA16_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--      IOB=> (FMC_HPC_HA16_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--      T  => ('0')     -- 1-bit input: 3-state enable input         
--   );  

---- |---------------------------------------------| 
---- |    FMC_HPC_HA23                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_HA23: IOBUFDS 
--   generic map (
--                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--   port map (
--       O  => (FMC_HPC_HA23),    -- 1-bit output: Buffer output
--       I  => '1',        -- 1-bit input: Buffer input
--       IO => (FMC_HPC_HA23_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--       IOB=> (FMC_HPC_HA23_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--       T  => ('1')     -- 1-bit input: 3-state enable input         
--   );    

---- |---------------------------------------------| 
---- |    FMC_HPC_HA20                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_HA20: IOBUFDS 
--   generic map (
--                   DIFF_TERM => FALSE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--     port map (
--        O  => (FMC_HPC_HA20),    -- 1-bit output: Buffer output
--        I  => lhc_clk,        -- 1-bit input: Buffer input
--        IO => (FMC_HPC_HA20_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--        IOB=> (FMC_HPC_HA20_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--        T  => ('0')     -- 1-bit input: 3-state enable input         
--   );      
  
---- |---------------------------------------------| 
---- |    FMC_HPC_HA18                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_HA18: IOBUFDS 
--   generic map (
--                   DIFF_TERM => FALSE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--    port map (
--       O  => (FMC_HPC_HA18),    -- 1-bit output: Buffer output
--       I  => lhc_clk,        -- 1-bit input: Buffer input
--       IO => (FMC_HPC_HA18_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--       IOB=> (FMC_HPC_HA18_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--       T  => ('0')     -- 1-bit input: 3-state enable input         
--   );     

---- |---------------------------------------------| 
---- |    FMC_HPC_HA22                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_HA22: IOBUFDS
--   generic map (
--                   DIFF_TERM => FALSE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--   port map (
--      O  => (FMC_HPC_HA22),    -- 1-bit output: Buffer output
--      I  => lhc_clk,        -- 1-bit input: Buffer input
--      IO => (FMC_HPC_HA22_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--      IOB=> (FMC_HPC_HA22_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--      T  => ('0')     -- 1-bit input: 3-state enable input         
--   );     

---- |---------------------------------------------| 
---- |    FMC_HPC_HA15                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_HA15: IOBUFDS 
--   generic map (
--                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--    port map (
--      O  => (FMC_HPC_HA15),    -- 1-bit output: Buffer output
--      I  => '1',        -- 1-bit input: Buffer input
--      IO => (FMC_HPC_HA15_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--      IOB=> (FMC_HPC_HA15_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--      T  => ('1')     -- 1-bit input: 3-state enable input         
--   );     

---- |---------------------------------------------| 
---- |    FMC_HPC_HA21                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_HA21: IOBUFDS
--     generic map (
--                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--     port map (
--        O  => (FMC_HPC_HA21),    -- 1-bit output: Buffer output
--        I  => '1',        -- 1-bit input: Buffer input
--        IO => (FMC_HPC_HA21_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--        IOB=> (FMC_HPC_HA21_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--        T  => ('1')     -- 1-bit input: 3-state enable input         
--   ); 

---- |---------------------------------------------| 
---- |    FMC_HPC_HA14                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_HA14: IOBUFDS 
--     generic map (
--                   DIFF_TERM => FALSE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--    port map (
--      O  => (FMC_HPC_HA14),    -- 1-bit output: Buffer output
--      I  => lhc_clk,        -- 1-bit input: Buffer input
--      IO => (FMC_HPC_HA14_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--      IOB=> (FMC_HPC_HA14_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--      T  => ('0')     -- 1-bit input: 3-state enable input         
--   );

---- |---------------------------------------------| 
---- |    FMC_HPC_HA19                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_HA19: IOBUFDS 
--       generic map (
--                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--    port map (
--       O  => (FMC_HPC_HA19),    -- 1-bit output: Buffer output
--       I  => '1',        -- 1-bit input: Buffer input
--       IO => (FMC_HPC_HA19_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--       IOB=> (FMC_HPC_HA19_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--       T  => ('1')     -- 1-bit input: 3-state enable input         
--   );

---- |---------------------------------------------| 
---- |    FMC_HPC_HA01_CC                          |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_HA01_CC: IOBUFDS 
--         generic map (
--                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--    port map (
--       O  => (FMC_HPC_HA01_CC),    -- 1-bit output: Buffer output
--       I  => '1',        -- 1-bit input: Buffer input
--       IO => (FMC_HPC_HA01_CC_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--       IOB=> (FMC_HPC_HA01_CC_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--       T  => ('1')     -- 1-bit input: 3-state enable input         
--   );

---- |---------------------------------------------| 
---- |    FMC_HPC_HA17_CC                          |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_HA17_CC: IOBUFDS 
--        generic map (
--                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--    port map (
--         O  => (FMC_HPC_HA17_CC),    -- 1-bit output: Buffer output
--         I  => '1',        -- 1-bit input: Buffer input
--         IO => (FMC_HPC_HA17_CC_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--         IOB=> (FMC_HPC_HA17_CC_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--         T  => ('1')     -- 1-bit input: 3-state enable input         
--   );
   
---- |---------------------------------------------| 
---- |    FMC_HPC_HA00_CC                          |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_HA00_CC: IOBUFDS 
--          generic map (
--                   DIFF_TERM => FALSE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--   port map (
--         O  => (FMC_HPC_HA00_CC),    -- 1-bit output: Buffer output
--         I  => lhc_clk,        -- 1-bit input: Buffer input
--         IO => (FMC_HPC_HA00_CC_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--         IOB=> (FMC_HPC_HA00_CC_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--         T  => ('0')     -- 1-bit input: 3-state enable input         
--   );

---- |---------------------------------------------| 
---- |    FMC_HPC_HA09                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_HA09: IOBUFDS 
--           generic map (
--                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--    port map (
--     O   => (FMC_HPC_HA09),    -- 1-bit output: Buffer output
--     I   => '1',        -- 1-bit input: Buffer input
--     IO  => (FMC_HPC_HA09_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--     IOB => (FMC_HPC_HA09_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--     T   => ('1')     -- 1-bit input: 3-state enable input         
--   );
   
---- |---------------------------------------------| 
---- |    FMC_HPC_HA03                            |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_HA03: IOBUFDS 
--           generic map (
--                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--    port map (
--        O  => (FMC_HPC_HA03),    -- 1-bit output: Buffer output
--        I  => '1',        -- 1-bit input: Buffer input
--        IO => (FMC_HPC_HA03_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--        IOB=> (FMC_HPC_HA03_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--        T  => ('1')     -- 1-bit input: 3-state enable input         
--   );

---- |---------------------------------------------| 
---- |    FMC_HPC_HA04                            |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_HA04: IOBUFDS
--       generic map (
--                   DIFF_TERM => FALSE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
  
--    port map (
--           O  => (FMC_HPC_HA04),    -- 1-bit output: Buffer output
--           I  => lhc_clk,        -- 1-bit input: Buffer input
--           IO => (FMC_HPC_HA04_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--           IOB=> (FMC_HPC_HA04_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--           T  => ('0')     -- 1-bit input: 3-state enable input         
--   );
   
---- |---------------------------------------------| 
---- |    FMC_HPC_HA10                            |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_HA10: IOBUFDS
--        generic map (
--                   DIFF_TERM => FALSE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--    port map (
--       O  => (FMC_HPC_HA10),    -- 1-bit output: Buffer output
--       I  => lhc_clk,        -- 1-bit input: Buffer input
--       IO => (FMC_HPC_HA10_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--       IOB=> (FMC_HPC_HA10_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--       T  => ('0')     -- 1-bit input: 3-state enable input         
--   );   
   
---- |---------------------------------------------| 
---- |    FMC_HPC_HA02                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_HA02: IOBUFDS 
--        generic map (
--                   DIFF_TERM => FALSE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--    port map(
--       O  => (FMC_HPC_HA02),    -- 1-bit output: Buffer output
--       I  => lhc_clk,        -- 1-bit input: Buffer input
--       IO => (FMC_HPC_HA02_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--       IOB=> (FMC_HPC_HA02_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--       T  => ('0')     -- 1-bit input: 3-state enable input         
--   );   
      
---- |---------------------------------------------| 
---- |    FMC_HPC_HA05                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_HA05: IOBUFDS 
--        generic map (
--                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--   port map (
--      O  => (FMC_HPC_HA05),    -- 1-bit output: Buffer output
--      I  => '1',        -- 1-bit input: Buffer input
--      IO => (FMC_HPC_HA05_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--      IOB=> (FMC_HPC_HA05_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--      T  => ('1')     -- 1-bit input: 3-state enable input         
--   );   
      
---- |---------------------------------------------| 
---- |    FMC_HPC_HA08                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_HA08: IOBUFDS 
--         generic map (
--                   DIFF_TERM => FALSE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--    port map (
--      O  => (FMC_HPC_HA08),    -- 1-bit output: Buffer output
--      I  => lhc_clk,        -- 1-bit input: Buffer input
--      IO => (FMC_HPC_HA08_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--      IOB=> (FMC_HPC_HA08_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--      T  => ('0')     -- 1-bit input: 3-state enable input         
--   );  

---- |---------------------------------------------| 
---- |    FMC_HPC_HA06                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_HA06: IOBUFDS
--      generic map (
--                   DIFF_TERM => FALSE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate

--    port map (
--      O  => (FMC_HPC_HA06),    -- 1-bit output: Buffer output
--      I  => lhc_clk,        -- 1-bit input: Buffer input
--      IO => (FMC_HPC_HA06_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--      IOB=> (FMC_HPC_HA06_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--      T  => ('0')     -- 1-bit input: 3-state enable input         
--   );  
   
---- |---------------------------------------------| 
---- |    FMC_HPC_HA11                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_HA11: IOBUFDS 
--      generic map (
--                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--    port map (
--       O  => (FMC_HPC_HA11),    -- 1-bit output: Buffer output
--       I  => '1',        -- 1-bit input: Buffer input
--       IO => (FMC_HPC_HA11_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--       IOB=> (FMC_HPC_HA11_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--       T  => ('1')     -- 1-bit input: 3-state enable input         
--   );   
   
---- |---------------------------------------------| 
---- |    FMC_HPC_HA12                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_HA12:IOBUFDS
--       generic map (
--                   DIFF_TERM => FALSE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--    port map (
--       O  => (FMC_HPC_HA12),    -- 1-bit output: Buffer output
--       I  => lhc_clk,        -- 1-bit input: Buffer input
--       IO => (FMC_HPC_HA12_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--       IOB=> (FMC_HPC_HA12_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--       T  => ('0')     -- 1-bit input: 3-state enable input         
--   );     

---- |---------------------------------------------| 
---- |    FMC_HPC_HA07                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_HA07:IOBUFDS 
--      generic map (
--                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--    port map (
--         O  => (FMC_HPC_HA07),    -- 1-bit output: Buffer output
--         I  => '1',        -- 1-bit input: Buffer input
--         IO => (FMC_HPC_HA07_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--         IOB=> (FMC_HPC_HA07_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--         T  => ('1')     -- 1-bit input: 3-state enable input         
--   );     

---- |---------------------------------------------| 
---- |    FMC_HPC_LA33                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_LA33: IOBUFDS 
--       generic map (
--                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--    port map(
--         O  => (FMC_HPC_LA33),    -- 1-bit output: Buffer output
--         I  => '1',        -- 1-bit input: Buffer input
--         IO => (FMC_HPC_LA33_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--         IOB=> (FMC_HPC_LA33_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--         T  => ('1')     -- 1-bit input: 3-state enable input         
--   );     
------------------------------------
----FMC_HPC_LA33_P <= '0';
--------------------------------------
---- |---------------------------------------------| 
---- |    FMC_HPC_LA32                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_LA32: IOBUFDS
--         generic map (
--                   DIFF_TERM => FALSE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--    port map (
--       O  => (FMC_HPC_LA32),    -- 1-bit output: Buffer output
--       I  => lhc_clk,        -- 1-bit input: Buffer input
--       IO => (FMC_HPC_LA32_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--       IOB=> (FMC_HPC_LA32_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--       T  => ('0')     -- 1-bit input: 3-state enable input         
--   ); 
   
---- |---------------------------------------------| 
---- |    FMC_HPC_LA31                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_LA31: IOBUFDS 
--          generic map (
--                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--    port map (
--       O  => (FMC_HPC_LA31),    -- 1-bit output: Buffer output
--       I  => '1',        -- 1-bit input: Buffer input
--       IO => (FMC_HPC_LA31_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--       IOB=> (FMC_HPC_LA31_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--       T  => ('1')     -- 1-bit input: 3-state enable input         
--   );    
   
---- |---------------------------------------------| 
---- |    FMC_HPC_LA30                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_LA30: IOBUFDS 
--          generic map (
--                   DIFF_TERM => FALSE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--    port map (
--       O  => (FMC_HPC_LA30),    -- 1-bit output: Buffer output
--       I  => lhc_clk,        -- 1-bit input: Buffer input
--       IO => (FMC_HPC_LA30_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--       IOB=> (FMC_HPC_LA30_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--       T  => ('0')     -- 1-bit input: 3-state enable input         
--   );     

---- |---------------------------------------------| 
---- |    FMC_HPC_LA20                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_LA20: IOBUFDS 
--           generic map (
--                   DIFF_TERM => FALSE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--    port map (
--        O  => (FMC_HPC_LA20),    -- 1-bit output: Buffer output
--        I  => lhc_clk,        -- 1-bit input: Buffer input
--        IO => (FMC_HPC_LA20_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--        IOB=> (FMC_HPC_LA20_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--        T  => ('0')     -- 1-bit input: 3-state enable input         
--   );      
   
---- |---------------------------------------------| 
---- |    FMC_HPC_LA17_CC                            |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_LA17: IOBUFDS 
--          generic map (
--                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--    port map (
--      O  => (FMC_HPC_LA17_CC),    -- 1-bit output: Buffer output
--      I  => '1',        -- 1-bit input: Buffer input
--      IO => (FMC_HPC_LA17_CC_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--      IOB=> (FMC_HPC_LA17_CC_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--      T  => ('1')     -- 1-bit input: 3-state enable input     
--  );
  
--   ------------------------------------------------
----   FMC_HPC_LA17_CC_P  <= '0'; 
--   --------------------------------------------------

---- |---------------------------------------------| 
---- |    FMC_HPC_LA18_CC                            |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_LA18: IOBUFDS
--         generic map (
--                   DIFF_TERM => FALSE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--    port map (
--        O  => (FMC_HPC_LA18_CC),    -- 1-bit output: Buffer output
--        I  => lhc_clk,        -- 1-bit input: Buffer input
--        IO => (FMC_HPC_LA18_CC_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--        IOB=> (FMC_HPC_LA18_CC_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--        T  => ('0')     -- 1-bit input: 3-state enable input     
--  ); 
  
---- |---------------------------------------------| 
---- |    FMC_HPC_LA28                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_LA28: IOBUFDS 
--         generic map (
--                   DIFF_TERM => FALSE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--     port map (
--       O  => (FMC_HPC_LA28),    -- 1-bit output: Buffer output
--       I  => lhc_clk,        -- 1-bit input: Buffer input
--       IO => (FMC_HPC_LA28_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--       IOB=> (FMC_HPC_LA28_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--       T  => ('0')     -- 1-bit input: 3-state enable input         
--   );      

---- |---------------------------------------------| 
---- |    FMC_HPC_LA19                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_LA19: IOBUFDS 
--         generic map (
--                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--    port map (
--       O  => (FMC_HPC_LA19),    -- 1-bit output: Buffer output
--       I  => '1',        -- 1-bit input: Buffer input
--       IO => (FMC_HPC_LA19_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--       IOB=> (FMC_HPC_LA19_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--       T  => ('1')     -- 1-bit input: 3-state enable input         
--   );      

---- |---------------------------------------------| 
---- |    FMC_HPC_LA29                            |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_LA29: IOBUFDS 
--        generic map (
--                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--    port map (
--      O  => (FMC_HPC_LA29),    -- 1-bit output: Buffer output
--      I  => '1',        -- 1-bit input: Buffer input
--      IO => (FMC_HPC_LA29_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--      IOB=> (FMC_HPC_LA29_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--      T  => ('1')     -- 1-bit input: 3-state enable input         
--   ); 
--    -------------------------
--  -- FMC_HPC_LA29_N <= '0'; 
--   -------------------------
---- |---------------------------------------------| 
---- |    FMC_HPC_LA25                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_LA25: IOBUFDS 
--         generic map (
--                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--    port map (
--      O  => (FMC_HPC_LA25),    -- 1-bit output: Buffer output
--      I  => '1',        -- 1-bit input: Buffer input
--      IO => (FMC_HPC_LA25_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--      IOB=> (FMC_HPC_LA25_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--      T  => ('1')     -- 1-bit input: 3-state enable input         
--   ); 
 
---- |---------------------------------------------| 
---- |    FMC_HPC_LA22                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_LA22: IOBUFDS
--           generic map (
--                   DIFF_TERM => FALSE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--   port map (
--      O  => (FMC_HPC_LA22),    -- 1-bit output: Buffer output
--      I  => lhc_clk,        -- 1-bit input: Buffer input
--      IO => (FMC_HPC_LA22_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--      IOB=> (FMC_HPC_LA22_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--      T  => ('0')     -- 1-bit input: 3-state enable input         
--   ); 
--  ------------------------
-- -- FMC_HPC_LA22_N <= '0';  -- Comment: TX_DISABLE CHANNEL 7 
--  -------------------------
  
---- |---------------------------------------------| 
---- |    FMC_HPC_LA24                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_LA24: IOBUFDS
--        generic map (
--                   DIFF_TERM => FALSE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--   port map (
--       O  => (FMC_HPC_LA24),    -- 1-bit output: Buffer output
--       I  => lhc_clk,        -- 1-bit input: Buffer input
--       IO => (FMC_HPC_LA24_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--       IOB=> (FMC_HPC_LA24_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--       T  => ('0')     -- 1-bit input: 3-state enable input         
--   );  

---- |---------------------------------------------| 
---- |    FMC_HPC_LA21                            |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_LA21: IOBUFDS 
--        generic map (
--                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--  port map (
--      O  => (FMC_HPC_LA21),    -- 1-bit output: Buffer output
--      I  => '1',        -- 1-bit input: Buffer input
--      IO => (FMC_HPC_LA21_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--      IOB=> (FMC_HPC_LA21_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--      T  => ('1')     -- 1-bit input: 3-state enable input         
--   );  

---- |---------------------------------------------| 
---- |    FMC_HPC_LA26                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_LA26: IOBUFDS 
--       generic map (
--                   DIFF_TERM => FALSE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--  port map (
--      O  => (FMC_HPC_LA26),    -- 1-bit output: Buffer output
--      I  => lhc_clk,        -- 1-bit input: Buffer input
--      IO => (FMC_HPC_LA26_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--      IOB=> (FMC_HPC_LA26_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--      T  => ('0')     -- 1-bit input: 3-state enable input         
--   );  
--   -----------------------
--  -- FMC_HPC_LA26_P <= '0';  -- COmment: TX_DISABLE  CHANNEL 6 
--   -----------------------
   
---- |---------------------------------------------| 
---- |    FMC_HPC_LA23                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_LA23: IOBUFDS
--        generic map (
--                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--  port map (
--     O  => (FMC_HPC_LA23),    -- 1-bit output: Buffer output
--     I  => '1',        -- 1-bit input: Buffer input
--     IO => (FMC_HPC_LA23_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--     IOB=> (FMC_HPC_LA23_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--     T  => ('1')     -- 1-bit input: 3-state enable input         
--   ); 
  
---- |---------------------------------------------| 
---- |    FMC_HPC_LA27                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_LA27: IOBUFDS 
--        generic map (
--                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--     port map  (
--      O  => (FMC_HPC_LA27),    -- 1-bit output: Buffer output
--      I  => '1',        -- 1-bit input: Buffer input
--      IO => (FMC_HPC_LA27_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--      IOB=> (FMC_HPC_LA27_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--      T  => ('1')     -- 1-bit input: 3-state enable input         
--   ); 

---- |---------------------------------------------| 
---- |    FMC_HPC_HB00                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_HB00: IOBUFDS
--        generic map (
--                   DIFF_TERM => FALSE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--   port map (
--       O  => (FMC_HPC_HB00),    -- 1-bit output: Buffer output
--       I  => lhc_clk,        -- 1-bit input: Buffer input
--       IO => (FMC_HPC_HB00_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--       IOB=> (FMC_HPC_HB00_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--       T  => ('0')     -- 1-bit input: 3-state enable input         
--   );  

---- |---------------------------------------------| 
---- |    FMC_HPC_HB01                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_HB01: IOBUFDS 
--        generic map (
--                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--     port map  (
--      O  => (FMC_HPC_HB01),    -- 1-bit output: Buffer output
--      I  => '1',        -- 1-bit input: Buffer input
--      IO => (FMC_HPC_HB01_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--      IOB=> (FMC_HPC_HB01_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--      T  => ('1')     -- 1-bit input: 3-state enable input         
--   ); 

---- |---------------------------------------------| 
---- |    FMC_HPC_HB02                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_HB02: IOBUFDS
--        generic map (
--                   DIFF_TERM => FALSE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--   port map (
--       O  => (FMC_HPC_HB02),    -- 1-bit output: Buffer output
--       I  => lhc_clk,        -- 1-bit input: Buffer input
--       IO => (FMC_HPC_HB02_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--       IOB=> (FMC_HPC_HB02_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--       T  => ('0')     -- 1-bit input: 3-state enable input         
--   );  

---- |---------------------------------------------| 
---- |    FMC_HPC_HB03                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_HB03: IOBUFDS 
--        generic map (
--                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--     port map  (
--      O  => (FMC_HPC_HB03),    -- 1-bit output: Buffer output
--      I  => '1',        -- 1-bit input: Buffer input
--      IO => (FMC_HPC_HB03_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--      IOB=> (FMC_HPC_HB03_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--      T  => ('1')     -- 1-bit input: 3-state enable input         
--   ); 

---- |---------------------------------------------| 
---- |    FMC_HPC_HB04                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_HB04: IOBUFDS
--        generic map (
--                   DIFF_TERM => FALSE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--   port map (
--       O  => (FMC_HPC_HB04),    -- 1-bit output: Buffer output
--       I  => lhc_clk,        -- 1-bit input: Buffer input
--       IO => (FMC_HPC_HB04_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--       IOB=> (FMC_HPC_HB04_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--       T  => ('0')     -- 1-bit input: 3-state enable input         
--   );  

---- |---------------------------------------------| 
---- |    FMC_HPC_HB05                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_HB05: IOBUFDS 
--        generic map (
--                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--     port map  (
--      O  => (FMC_HPC_HB05),    -- 1-bit output: Buffer output
--      I  => '1',        -- 1-bit input: Buffer input
--      IO => (FMC_HPC_HB05_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--      IOB=> (FMC_HPC_HB05_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--      T  => ('1')     -- 1-bit input: 3-state enable input         
--   ); 

---- |---------------------------------------------| 
---- |    FMC_HPC_HB08                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_HB08: IOBUFDS
--        generic map (
--                   DIFF_TERM => FALSE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--   port map (
--       O  => (FMC_HPC_HB08),    -- 1-bit output: Buffer output
--       I  => lhc_clk,        -- 1-bit input: Buffer input
--       IO => (FMC_HPC_HB08_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--       IOB=> (FMC_HPC_HB08_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--       T  => ('0')     -- 1-bit input: 3-state enable input         
--   );
   
---- |---------------------------------------------| 
---- |    FMC_HPC_HB09                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_HB09: IOBUFDS 
--        generic map (
--                   DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--     port map  (
--      O  => (FMC_HPC_HB09),    -- 1-bit output: Buffer output
--      I  => '1',        -- 1-bit input: Buffer input
--      IO => (FMC_HPC_HB09_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--      IOB=> (FMC_HPC_HB09_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--      T  => ('1')     -- 1-bit input: 3-state enable input         
--   ); 
   
---- |---------------------------------------------| 
--   -- |    FMC_HPC_HB17                             |
--   -- |---------------------------------------------|
--IOBUFDS_FMC_HPC_HB17: IOBUFDS 
--           generic map (
--                      DIFF_TERM => TRUE, -- Differential Termination (TRUE/FALSE)
--                      IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                      IOSTANDARD => "LVDS", -- Specify the I/O standard
--                      SLEW => "SLOW")       -- Specify the output slew rate
                      
--        port map  (
--         O  => (FMC_HPC_HB17),    -- 1-bit output: Buffer output
--         I  => '1',        -- 1-bit input: Buffer input
--         IO => (FMC_HPC_HB17_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--         IOB=> (FMC_HPC_HB17_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--         T  => ('1')     -- 1-bit input: 3-state enable input         
--      );    

---- |---------------------------------------------| 
---- |    FMC_HPC_HB20                             |
---- |---------------------------------------------|
--IOBUFDS_FMC_HPC_HB20: IOBUFDS
--        generic map (
--                   DIFF_TERM => FALSE, -- Differential Termination (TRUE/FALSE)
--                   IBUF_LOW_PWR => TRUE, -- Low Power = TRUE, High Performance = FALSE
--                   IOSTANDARD => "LVDS", -- Specify the I/O standard
--                   SLEW => "SLOW")       -- Specify the output slew rate
                   
--   port map (
--       O  => (FMC_HPC_HB20),    -- 1-bit output: Buffer output
--       I  => lhc_clk,        -- 1-bit input: Buffer input
--       IO => (FMC_HPC_HB20_P),   -- 1-bit inout: Diff_p inout (connect directly to top-level port)
--       IOB=> (FMC_HPC_HB20_N),  -- 1-bit inout: Diff_n inout (connect directly to top-level port)
--       T  => ('0')     -- 1-bit input: 3-state enable input         
--   );
  
   -- ============================================ 
   --  RATE _SEL --> FMC_CARD S-18 "Must be '1' == 
   -- ============================================
--  FMC_HPC_LA15_P  <= '1';  --  FMC_CH0
--  FMC_HPC_LA11_N  <= '1';  --  FMC_CH1
--  FMC_HPC_LA08_P  <= '1';  --  FMC_CH2
--  FMC_HPC_LA04_N  <= '1';  --  FMC_CH3
--  FMC_HPC_LA27_N  <= '1';  --  FMC_CH5
--  FMC_HPC_LA24_P  <= '1';  --  FMC_CH6
--  FMC_HPC_LA20_N  <= '1';  --  FMC_CH7
   
   ----  RX Rate Select must be '1'   "RS0 Control"
  SFP_1_TXSD_RXRESET_TR_LS   <= '1'; 
  SFP_2_TXSD_RXRESET_TR_LS   <= '1'; 
  SFP_3_TXSD_RXRESET_TR_LS   <= '1'; 
  SFP_4_TXSD_RXRESET_TR_LS   <= '1'; 
  SFP_5_TXSD_RXRESET_TR_LS   <= '1'; 
  SFP_6_TXSD_RXRESET_TR_LS   <= '1'; 
  SFP_7_TXSD_RXRESET_TR_LS   <= '1'; 
  SFP_8_TXSD_RXRESET_TR_LS   <= '1'; 
  SFP_9_TXSD_RXRESET_TR_LS   <= '1'; 
  SFP_10_TXSD_RXRESET_TR_LS  <= '1'; 
  SFP_11_TXSD_RXRESET_TR_LS  <= '1'; 
  SFP_12_TXSD_RXRESET_TR_LS  <= '1'; 
  
  ----  RX Rate Select must be '1'   "RS1 Control"
  SFP_1_PDOWN_TRI_TR   <= '1';
  SFP_2_PDOWN_TRI_TR   <= '1';
  SFP_3_PDOWN_TRI_TR   <= '1';
  SFP_4_PDOWN_TRI_TR   <= '1';
  SFP_5_PDOWN_TRI_TR   <= '1';
  SFP_6_PDOWN_TRI_TR   <= '1';
  SFP_7_PDOWN_TRI_TR   <= '1';
  SFP_8_PDOWN_TRI_TR   <= '1';
  SFP_9_PDOWN_TRI_TR   <= '1';
  SFP_10_PDOWN_TRI_TR  <= '1';
  SFP_11_PDOWN_TRI_TR  <= '1';
  SFP_12_PDOWN_TRI_TR  <= '1';

end rtl;
