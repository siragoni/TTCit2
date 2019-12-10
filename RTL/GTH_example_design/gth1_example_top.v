//------------------------------------------------------------------------------
//  (c) Copyright 2013-2015 Xilinx, Inc. All rights reserved.
//
//  This file contains confidential and proprietary information
//  of Xilinx, Inc. and is protected under U.S. and
//  international copyright and other intellectual property
//  laws.
//
//  DISCLAIMER
//  This disclaimer is not a license and does not grant any
//  rights to the materials distributed herewith. Except as
//  otherwise provided in a valid license issued to you by
//  Xilinx, and to the maximum extent permitted by applicable
//  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
//  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
//  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
//  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
//  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
//  (2) Xilinx shall not be liable (whether in contract or tort,
//  including negligence, or under any other theory of
//  liability) for any loss or damage of any kind or nature
//  related to, arising under or in connection with these
//  materials, including for any direct, or any indirect,
//  special, incidental, or consequential loss or damage
//  (including loss of data, profits, goodwill, or any type of
//  loss or damage suffered as a result of any action brought
//  by a third party) even if such damage or loss was
//  reasonably foreseeable or Xilinx had been advised of the
//  possibility of the same.
//
//  CRITICAL APPLICATIONS
//  Xilinx products are not designed or intended to be fail-
//  safe, or for use in any application requiring fail-safe
//  performance, such as life-support or safety devices or
//  systems, Class III medical devices, nuclear facilities,
//  applications related to the deployment of airbags, or any
//  other applications that could lead to death, personal
//  injury, or severe property or environmental damage
//  (individually and collectively, "Critical
//  Applications"). Customer assumes the sole risk and
//  liability of any use of Xilinx products in Critical
//  Applications, subject only to applicable laws and
//  regulations governing limitations on product liability.
//
//  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
//  PART OF THIS FILE AT ALL TIMES.
//------------------------------------------------------------------------------


`timescale 1ps/1ps

// =====================================================================================================================
// This example design top module instantiates the example design wrapper; slices vectored ports for per-channel
// assignment; and instantiates example resources such as buffers, pattern generators, and pattern checkers for core
// demonstration purposes
// =====================================================================================================================

module gth1_example_top (

  // Differential reference clock inputs
  input  wire mgtrefclk0_x0y0_p,
  input  wire mgtrefclk0_x0y0_n,
  input  wire mgtrefclk0_x0y1_p,
  input  wire mgtrefclk0_x0y1_n,
  input  wire mgtrefclk0_x0y2_p,
  input  wire mgtrefclk0_x0y2_n,
  input  wire mgtrefclk0_x0y3_p,
  input  wire mgtrefclk0_x0y3_n,
  input  wire mgtrefclk0_x0y4_p,
  input  wire mgtrefclk0_x0y4_n,
  input  wire mgtrefclk1_x0y0_p,
  input  wire mgtrefclk1_x0y0_n,
  input  wire mgtrefclk1_x0y1_p,
  input  wire mgtrefclk1_x0y1_n,
  input  wire mgtrefclk1_x0y2_p,
  input  wire mgtrefclk1_x0y2_n,
  input  wire mgtrefclk1_x0y3_p,
  input  wire mgtrefclk1_x0y3_n,
  input  wire mgtrefclk1_x0y4_p,
  input  wire mgtrefclk1_x0y4_n,

  // Serial data ports for transceiver channel 0
  input  wire ch0_gthrxn_in,
  input  wire ch0_gthrxp_in,
  output wire ch0_gthtxn_out,
  output wire ch0_gthtxp_out,

  // Serial data ports for transceiver channel 1
  input  wire ch1_gthrxn_in,
  input  wire ch1_gthrxp_in,
  output wire ch1_gthtxn_out,
  output wire ch1_gthtxp_out,

  // Serial data ports for transceiver channel 2
  input  wire ch2_gthrxn_in,
  input  wire ch2_gthrxp_in,
  output wire ch2_gthtxn_out,
  output wire ch2_gthtxp_out,

  // Serial data ports for transceiver channel 3
  input  wire ch3_gthrxn_in,
  input  wire ch3_gthrxp_in,
  output wire ch3_gthtxn_out,
  output wire ch3_gthtxp_out,

  // Serial data ports for transceiver channel 4
  input  wire ch4_gthrxn_in,
  input  wire ch4_gthrxp_in,
  output wire ch4_gthtxn_out,
  output wire ch4_gthtxp_out,

  // Serial data ports for transceiver channel 5
  input  wire ch5_gthrxn_in,
  input  wire ch5_gthrxp_in,
  output wire ch5_gthtxn_out,
  output wire ch5_gthtxp_out,

  // Serial data ports for transceiver channel 6
  input  wire ch6_gthrxn_in,
  input  wire ch6_gthrxp_in,
  output wire ch6_gthtxn_out,
  output wire ch6_gthtxp_out,

  // Serial data ports for transceiver channel 7
  input  wire ch7_gthrxn_in,
  input  wire ch7_gthrxp_in,
  output wire ch7_gthtxn_out,
  output wire ch7_gthtxp_out,

  // Serial data ports for transceiver channel 8
  input  wire ch8_gthrxn_in,
  input  wire ch8_gthrxp_in,
  output wire ch8_gthtxn_out,
  output wire ch8_gthtxp_out,

  // Serial data ports for transceiver channel 9
  input  wire ch9_gthrxn_in,
  input  wire ch9_gthrxp_in,
  output wire ch9_gthtxn_out,
  output wire ch9_gthtxp_out,

  // Serial data ports for transceiver channel 10
  input  wire ch10_gthrxn_in,
  input  wire ch10_gthrxp_in,
  output wire ch10_gthtxn_out,
  output wire ch10_gthtxp_out,

  // Serial data ports for transceiver channel 11
  input  wire ch11_gthrxn_in,
  input  wire ch11_gthrxp_in,
  output wire ch11_gthtxn_out,
  output wire ch11_gthtxp_out,

  // Serial data ports for transceiver channel 12
  input  wire ch12_gthrxn_in,
  input  wire ch12_gthrxp_in,
  output wire ch12_gthtxn_out,
  output wire ch12_gthtxp_out,

  // Serial data ports for transceiver channel 13
  input  wire ch13_gthrxn_in,
  input  wire ch13_gthrxp_in,
  output wire ch13_gthtxn_out,
  output wire ch13_gthtxp_out,

  // Serial data ports for transceiver channel 14
  input  wire ch14_gthrxn_in,
  input  wire ch14_gthrxp_in,
  output wire ch14_gthtxn_out,
  output wire ch14_gthtxp_out,

  // Serial data ports for transceiver channel 15
  input  wire ch15_gthrxn_in,
  input  wire ch15_gthrxp_in,
  output wire ch15_gthtxn_out,
  output wire ch15_gthtxp_out,

  // Serial data ports for transceiver channel 16
  input  wire ch16_gthrxn_in,
  input  wire ch16_gthrxp_in,
  output wire ch16_gthtxn_out,
  output wire ch16_gthtxp_out,

  // Serial data ports for transceiver channel 17
  input  wire ch17_gthrxn_in,
  input  wire ch17_gthrxp_in,
  output wire ch17_gthtxn_out,
  output wire ch17_gthtxp_out,

  // Serial data ports for transceiver channel 18
  input  wire ch18_gthrxn_in,
  input  wire ch18_gthrxp_in,
  output wire ch18_gthtxn_out,
  output wire ch18_gthtxp_out,

  // Serial data ports for transceiver channel 19
  input  wire ch19_gthrxn_in,
  input  wire ch19_gthrxp_in,
  output wire ch19_gthtxn_out,
  output wire ch19_gthtxp_out

  // User-provided ports for reset helper block(s)
//  input  wire hb_gtwiz_reset_clk_freerun_in,
//  input  wire hb_gtwiz_reset_all_in,

  // PRBS-based link status ports
//  input  wire link_down_latched_reset_in,
//  output wire link_status_out,
//  output reg  link_down_latched_out = 1'b1

);


  // ===================================================================================================================
  // PER-CHANNEL SIGNAL ASSIGNMENTS
  // ===================================================================================================================

  // The core and example design wrapper vectorize ports across all enabled transceiver channel and common instances for
  // simplicity and compactness. This example design top module assigns slices of each vector to individual, per-channel
  // signal vectors for use if desired. Signals which connect to helper blocks are prefixed "hb#", signals which connect
  // to transceiver common primitives are prefixed "cm#", and signals which connect to transceiver channel primitives
  // are prefixed "ch#", where "#" is the sequential resource number.

  //--------------------------------------------------------------------------------------------------------------------
  wire hb_gtwiz_reset_clk_freerun_in;
  wire hb_gtwiz_reset_all_in;
  
    // PRBS-based link status ports
  wire link_down_latched_reset_in;
  wire link_status_out;
  reg  link_down_latched_out = 1'b1;


  wire [19:0] gthrxn_int;
  assign gthrxn_int[0:0] = ch0_gthrxn_in;
  assign gthrxn_int[1:1] = ch1_gthrxn_in;
  assign gthrxn_int[2:2] = ch2_gthrxn_in;
  assign gthrxn_int[3:3] = ch3_gthrxn_in;
  assign gthrxn_int[4:4] = ch4_gthrxn_in;
  assign gthrxn_int[5:5] = ch5_gthrxn_in;
  assign gthrxn_int[6:6] = ch6_gthrxn_in;
  assign gthrxn_int[7:7] = ch7_gthrxn_in;
  assign gthrxn_int[8:8] = ch8_gthrxn_in;
  assign gthrxn_int[9:9] = ch9_gthrxn_in;
  assign gthrxn_int[10:10] = ch10_gthrxn_in;
  assign gthrxn_int[11:11] = ch11_gthrxn_in;
  assign gthrxn_int[12:12] = ch12_gthrxn_in;
  assign gthrxn_int[13:13] = ch13_gthrxn_in;
  assign gthrxn_int[14:14] = ch14_gthrxn_in;
  assign gthrxn_int[15:15] = ch15_gthrxn_in;
  assign gthrxn_int[16:16] = ch16_gthrxn_in;
  assign gthrxn_int[17:17] = ch17_gthrxn_in;
  assign gthrxn_int[18:18] = ch18_gthrxn_in;
  assign gthrxn_int[19:19] = ch19_gthrxn_in;

  //--------------------------------------------------------------------------------------------------------------------
  wire [19:0] gthrxp_int;
  assign gthrxp_int[0:0] = ch0_gthrxp_in;
  assign gthrxp_int[1:1] = ch1_gthrxp_in;
  assign gthrxp_int[2:2] = ch2_gthrxp_in;
  assign gthrxp_int[3:3] = ch3_gthrxp_in;
  assign gthrxp_int[4:4] = ch4_gthrxp_in;
  assign gthrxp_int[5:5] = ch5_gthrxp_in;
  assign gthrxp_int[6:6] = ch6_gthrxp_in;
  assign gthrxp_int[7:7] = ch7_gthrxp_in;
  assign gthrxp_int[8:8] = ch8_gthrxp_in;
  assign gthrxp_int[9:9] = ch9_gthrxp_in;
  assign gthrxp_int[10:10] = ch10_gthrxp_in;
  assign gthrxp_int[11:11] = ch11_gthrxp_in;
  assign gthrxp_int[12:12] = ch12_gthrxp_in;
  assign gthrxp_int[13:13] = ch13_gthrxp_in;
  assign gthrxp_int[14:14] = ch14_gthrxp_in;
  assign gthrxp_int[15:15] = ch15_gthrxp_in;
  assign gthrxp_int[16:16] = ch16_gthrxp_in;
  assign gthrxp_int[17:17] = ch17_gthrxp_in;
  assign gthrxp_int[18:18] = ch18_gthrxp_in;
  assign gthrxp_int[19:19] = ch19_gthrxp_in;

  //--------------------------------------------------------------------------------------------------------------------
  wire [19:0] gthtxn_int;
  assign ch0_gthtxn_out = gthtxn_int[0:0];
  assign ch1_gthtxn_out = gthtxn_int[1:1];
  assign ch2_gthtxn_out = gthtxn_int[2:2];
  assign ch3_gthtxn_out = gthtxn_int[3:3];
  assign ch4_gthtxn_out = gthtxn_int[4:4];
  assign ch5_gthtxn_out = gthtxn_int[5:5];
  assign ch6_gthtxn_out = gthtxn_int[6:6];
  assign ch7_gthtxn_out = gthtxn_int[7:7];
  assign ch8_gthtxn_out = gthtxn_int[8:8];
  assign ch9_gthtxn_out = gthtxn_int[9:9];
  assign ch10_gthtxn_out = gthtxn_int[10:10];
  assign ch11_gthtxn_out = gthtxn_int[11:11];
  assign ch12_gthtxn_out = gthtxn_int[12:12];
  assign ch13_gthtxn_out = gthtxn_int[13:13];
  assign ch14_gthtxn_out = gthtxn_int[14:14];
  assign ch15_gthtxn_out = gthtxn_int[15:15];
  assign ch16_gthtxn_out = gthtxn_int[16:16];
  assign ch17_gthtxn_out = gthtxn_int[17:17];
  assign ch18_gthtxn_out = gthtxn_int[18:18];
  assign ch19_gthtxn_out = gthtxn_int[19:19];

  //--------------------------------------------------------------------------------------------------------------------
  wire [19:0] gthtxp_int;
  assign ch0_gthtxp_out = gthtxp_int[0:0];
  assign ch1_gthtxp_out = gthtxp_int[1:1];
  assign ch2_gthtxp_out = gthtxp_int[2:2];
  assign ch3_gthtxp_out = gthtxp_int[3:3];
  assign ch4_gthtxp_out = gthtxp_int[4:4];
  assign ch5_gthtxp_out = gthtxp_int[5:5];
  assign ch6_gthtxp_out = gthtxp_int[6:6];
  assign ch7_gthtxp_out = gthtxp_int[7:7];
  assign ch8_gthtxp_out = gthtxp_int[8:8];
  assign ch9_gthtxp_out = gthtxp_int[9:9];
  assign ch10_gthtxp_out = gthtxp_int[10:10];
  assign ch11_gthtxp_out = gthtxp_int[11:11];
  assign ch12_gthtxp_out = gthtxp_int[12:12];
  assign ch13_gthtxp_out = gthtxp_int[13:13];
  assign ch14_gthtxp_out = gthtxp_int[14:14];
  assign ch15_gthtxp_out = gthtxp_int[15:15];
  assign ch16_gthtxp_out = gthtxp_int[16:16];
  assign ch17_gthtxp_out = gthtxp_int[17:17];
  assign ch18_gthtxp_out = gthtxp_int[18:18];
  assign ch19_gthtxp_out = gthtxp_int[19:19];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_tx_reset_int;
  wire [0:0] hb0_gtwiz_userclk_tx_reset_int;
  assign gtwiz_userclk_tx_reset_int[0:0] = hb0_gtwiz_userclk_tx_reset_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_tx_srcclk_int;
  wire [0:0] hb0_gtwiz_userclk_tx_srcclk_int;
  assign hb0_gtwiz_userclk_tx_srcclk_int = gtwiz_userclk_tx_srcclk_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_tx_usrclk_int;
  wire [0:0] hb0_gtwiz_userclk_tx_usrclk_int;
  assign hb0_gtwiz_userclk_tx_usrclk_int = gtwiz_userclk_tx_usrclk_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_tx_usrclk2_int;
  wire [0:0] hb0_gtwiz_userclk_tx_usrclk2_int;
  assign hb0_gtwiz_userclk_tx_usrclk2_int = gtwiz_userclk_tx_usrclk2_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_tx_active_int;
  wire [0:0] hb0_gtwiz_userclk_tx_active_int;
  assign hb0_gtwiz_userclk_tx_active_int = gtwiz_userclk_tx_active_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_rx_reset_int;
  wire [0:0] hb0_gtwiz_userclk_rx_reset_int;
  assign gtwiz_userclk_rx_reset_int[0:0] = hb0_gtwiz_userclk_rx_reset_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_rx_srcclk_int;
  wire [0:0] hb0_gtwiz_userclk_rx_srcclk_int;
  assign hb0_gtwiz_userclk_rx_srcclk_int = gtwiz_userclk_rx_srcclk_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_rx_usrclk_int;
  wire [0:0] hb0_gtwiz_userclk_rx_usrclk_int;
  assign hb0_gtwiz_userclk_rx_usrclk_int = gtwiz_userclk_rx_usrclk_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_rx_usrclk2_int;
  wire [0:0] hb0_gtwiz_userclk_rx_usrclk2_int;
  assign hb0_gtwiz_userclk_rx_usrclk2_int = gtwiz_userclk_rx_usrclk2_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_rx_active_int;
  wire [0:0] hb0_gtwiz_userclk_rx_active_int;
  assign hb0_gtwiz_userclk_rx_active_int = gtwiz_userclk_rx_active_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_clk_freerun_int;
  wire [0:0] hb0_gtwiz_reset_clk_freerun_int = 1'b0;
  assign gtwiz_reset_clk_freerun_int[0:0] = hb0_gtwiz_reset_clk_freerun_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_all_int;
  wire [0:0] hb0_gtwiz_reset_all_int = 1'b0;
  assign gtwiz_reset_all_int[0:0] = hb0_gtwiz_reset_all_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_tx_pll_and_datapath_int;
  wire [0:0] hb0_gtwiz_reset_tx_pll_and_datapath_int;
  assign gtwiz_reset_tx_pll_and_datapath_int[0:0] = hb0_gtwiz_reset_tx_pll_and_datapath_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_tx_datapath_int;
  wire [0:0] hb0_gtwiz_reset_tx_datapath_int;
  assign gtwiz_reset_tx_datapath_int[0:0] = hb0_gtwiz_reset_tx_datapath_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_rx_pll_and_datapath_int;
  wire [0:0] hb0_gtwiz_reset_rx_pll_and_datapath_int = 1'b0;
  assign gtwiz_reset_rx_pll_and_datapath_int[0:0] = hb0_gtwiz_reset_rx_pll_and_datapath_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_rx_datapath_int;
  wire [0:0] hb0_gtwiz_reset_rx_datapath_int = 1'b0;
  assign gtwiz_reset_rx_datapath_int[0:0] = hb0_gtwiz_reset_rx_datapath_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_rx_cdr_stable_int;
  wire [0:0] hb0_gtwiz_reset_rx_cdr_stable_int;
  assign hb0_gtwiz_reset_rx_cdr_stable_int = gtwiz_reset_rx_cdr_stable_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_tx_done_int;
  wire [0:0] hb0_gtwiz_reset_tx_done_int;
  assign hb0_gtwiz_reset_tx_done_int = gtwiz_reset_tx_done_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_rx_done_int;
  wire [0:0] hb0_gtwiz_reset_rx_done_int;
  assign hb0_gtwiz_reset_rx_done_int = gtwiz_reset_rx_done_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [639:0] gtwiz_userdata_tx_int;
  wire [31:0] hb0_gtwiz_userdata_tx_int;
  wire [31:0] hb1_gtwiz_userdata_tx_int;
  wire [31:0] hb2_gtwiz_userdata_tx_int;
  wire [31:0] hb3_gtwiz_userdata_tx_int;
  wire [31:0] hb4_gtwiz_userdata_tx_int;
  wire [31:0] hb5_gtwiz_userdata_tx_int;
  wire [31:0] hb6_gtwiz_userdata_tx_int;
  wire [31:0] hb7_gtwiz_userdata_tx_int;
  wire [31:0] hb8_gtwiz_userdata_tx_int;
  wire [31:0] hb9_gtwiz_userdata_tx_int;
  wire [31:0] hb10_gtwiz_userdata_tx_int;
  wire [31:0] hb11_gtwiz_userdata_tx_int;
  wire [31:0] hb12_gtwiz_userdata_tx_int;
  wire [31:0] hb13_gtwiz_userdata_tx_int;
  wire [31:0] hb14_gtwiz_userdata_tx_int;
  wire [31:0] hb15_gtwiz_userdata_tx_int;
  wire [31:0] hb16_gtwiz_userdata_tx_int;
  wire [31:0] hb17_gtwiz_userdata_tx_int;
  wire [31:0] hb18_gtwiz_userdata_tx_int;
  wire [31:0] hb19_gtwiz_userdata_tx_int;
  assign gtwiz_userdata_tx_int[31:0] = hb0_gtwiz_userdata_tx_int;
  assign gtwiz_userdata_tx_int[63:32] = hb1_gtwiz_userdata_tx_int;
  assign gtwiz_userdata_tx_int[95:64] = hb2_gtwiz_userdata_tx_int;
  assign gtwiz_userdata_tx_int[127:96] = hb3_gtwiz_userdata_tx_int;
  assign gtwiz_userdata_tx_int[159:128] = hb4_gtwiz_userdata_tx_int;
  assign gtwiz_userdata_tx_int[191:160] = hb5_gtwiz_userdata_tx_int;
  assign gtwiz_userdata_tx_int[223:192] = hb6_gtwiz_userdata_tx_int;
  assign gtwiz_userdata_tx_int[255:224] = hb7_gtwiz_userdata_tx_int;
  assign gtwiz_userdata_tx_int[287:256] = hb8_gtwiz_userdata_tx_int;
  assign gtwiz_userdata_tx_int[319:288] = hb9_gtwiz_userdata_tx_int;
  assign gtwiz_userdata_tx_int[351:320] = hb10_gtwiz_userdata_tx_int;
  assign gtwiz_userdata_tx_int[383:352] = hb11_gtwiz_userdata_tx_int;
  assign gtwiz_userdata_tx_int[415:384] = hb12_gtwiz_userdata_tx_int;
  assign gtwiz_userdata_tx_int[447:416] = hb13_gtwiz_userdata_tx_int;
  assign gtwiz_userdata_tx_int[479:448] = hb14_gtwiz_userdata_tx_int;
  assign gtwiz_userdata_tx_int[511:480] = hb15_gtwiz_userdata_tx_int;
  assign gtwiz_userdata_tx_int[543:512] = hb16_gtwiz_userdata_tx_int;
  assign gtwiz_userdata_tx_int[575:544] = hb17_gtwiz_userdata_tx_int;
  assign gtwiz_userdata_tx_int[607:576] = hb18_gtwiz_userdata_tx_int;
  assign gtwiz_userdata_tx_int[639:608] = hb19_gtwiz_userdata_tx_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [639:0] gtwiz_userdata_rx_int;
  wire [31:0] hb0_gtwiz_userdata_rx_int;
  wire [31:0] hb1_gtwiz_userdata_rx_int;
  wire [31:0] hb2_gtwiz_userdata_rx_int;
  wire [31:0] hb3_gtwiz_userdata_rx_int;
  wire [31:0] hb4_gtwiz_userdata_rx_int;
  wire [31:0] hb5_gtwiz_userdata_rx_int;
  wire [31:0] hb6_gtwiz_userdata_rx_int;
  wire [31:0] hb7_gtwiz_userdata_rx_int;
  wire [31:0] hb8_gtwiz_userdata_rx_int;
  wire [31:0] hb9_gtwiz_userdata_rx_int;
  wire [31:0] hb10_gtwiz_userdata_rx_int;
  wire [31:0] hb11_gtwiz_userdata_rx_int;
  wire [31:0] hb12_gtwiz_userdata_rx_int;
  wire [31:0] hb13_gtwiz_userdata_rx_int;
  wire [31:0] hb14_gtwiz_userdata_rx_int;
  wire [31:0] hb15_gtwiz_userdata_rx_int;
  wire [31:0] hb16_gtwiz_userdata_rx_int;
  wire [31:0] hb17_gtwiz_userdata_rx_int;
  wire [31:0] hb18_gtwiz_userdata_rx_int;
  wire [31:0] hb19_gtwiz_userdata_rx_int;
  assign hb0_gtwiz_userdata_rx_int = gtwiz_userdata_rx_int[31:0];
  assign hb1_gtwiz_userdata_rx_int = gtwiz_userdata_rx_int[63:32];
  assign hb2_gtwiz_userdata_rx_int = gtwiz_userdata_rx_int[95:64];
  assign hb3_gtwiz_userdata_rx_int = gtwiz_userdata_rx_int[127:96];
  assign hb4_gtwiz_userdata_rx_int = gtwiz_userdata_rx_int[159:128];
  assign hb5_gtwiz_userdata_rx_int = gtwiz_userdata_rx_int[191:160];
  assign hb6_gtwiz_userdata_rx_int = gtwiz_userdata_rx_int[223:192];
  assign hb7_gtwiz_userdata_rx_int = gtwiz_userdata_rx_int[255:224];
  assign hb8_gtwiz_userdata_rx_int = gtwiz_userdata_rx_int[287:256];
  assign hb9_gtwiz_userdata_rx_int = gtwiz_userdata_rx_int[319:288];
  assign hb10_gtwiz_userdata_rx_int = gtwiz_userdata_rx_int[351:320];
  assign hb11_gtwiz_userdata_rx_int = gtwiz_userdata_rx_int[383:352];
  assign hb12_gtwiz_userdata_rx_int = gtwiz_userdata_rx_int[415:384];
  assign hb13_gtwiz_userdata_rx_int = gtwiz_userdata_rx_int[447:416];
  assign hb14_gtwiz_userdata_rx_int = gtwiz_userdata_rx_int[479:448];
  assign hb15_gtwiz_userdata_rx_int = gtwiz_userdata_rx_int[511:480];
  assign hb16_gtwiz_userdata_rx_int = gtwiz_userdata_rx_int[543:512];
  assign hb17_gtwiz_userdata_rx_int = gtwiz_userdata_rx_int[575:544];
  assign hb18_gtwiz_userdata_rx_int = gtwiz_userdata_rx_int[607:576];
  assign hb19_gtwiz_userdata_rx_int = gtwiz_userdata_rx_int[639:608];

  //--------------------------------------------------------------------------------------------------------------------
  wire [4:0] gtrefclk01_int;
  wire [0:0] cm0_gtrefclk01_int;
  wire [0:0] cm1_gtrefclk01_int;
  wire [0:0] cm2_gtrefclk01_int;
  wire [0:0] cm3_gtrefclk01_int;
  wire [0:0] cm4_gtrefclk01_int;
  assign gtrefclk01_int[0:0] = cm0_gtrefclk01_int;
  assign gtrefclk01_int[1:1] = cm1_gtrefclk01_int;
  assign gtrefclk01_int[2:2] = cm2_gtrefclk01_int;
  assign gtrefclk01_int[3:3] = cm3_gtrefclk01_int;
  assign gtrefclk01_int[4:4] = cm4_gtrefclk01_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [4:0] qpll1outclk_int;
  wire [0:0] cm0_qpll1outclk_int;
  wire [0:0] cm1_qpll1outclk_int;
  wire [0:0] cm2_qpll1outclk_int;
  wire [0:0] cm3_qpll1outclk_int;
  wire [0:0] cm4_qpll1outclk_int;
  assign cm0_qpll1outclk_int = qpll1outclk_int[0:0];
  assign cm1_qpll1outclk_int = qpll1outclk_int[1:1];
  assign cm2_qpll1outclk_int = qpll1outclk_int[2:2];
  assign cm3_qpll1outclk_int = qpll1outclk_int[3:3];
  assign cm4_qpll1outclk_int = qpll1outclk_int[4:4];

  //--------------------------------------------------------------------------------------------------------------------
  wire [4:0] qpll1outrefclk_int;
  wire [0:0] cm0_qpll1outrefclk_int;
  wire [0:0] cm1_qpll1outrefclk_int;
  wire [0:0] cm2_qpll1outrefclk_int;
  wire [0:0] cm3_qpll1outrefclk_int;
  wire [0:0] cm4_qpll1outrefclk_int;
  assign cm0_qpll1outrefclk_int = qpll1outrefclk_int[0:0];
  assign cm1_qpll1outrefclk_int = qpll1outrefclk_int[1:1];
  assign cm2_qpll1outrefclk_int = qpll1outrefclk_int[2:2];
  assign cm3_qpll1outrefclk_int = qpll1outrefclk_int[3:3];
  assign cm4_qpll1outrefclk_int = qpll1outrefclk_int[4:4];

  //--------------------------------------------------------------------------------------------------------------------
  wire [19:0] drpclk_int;
  wire [0:0] ch0_drpclk_int;
  wire [0:0] ch1_drpclk_int;
  wire [0:0] ch2_drpclk_int;
  wire [0:0] ch3_drpclk_int;
  wire [0:0] ch4_drpclk_int;
  wire [0:0] ch5_drpclk_int;
  wire [0:0] ch6_drpclk_int;
  wire [0:0] ch7_drpclk_int;
  wire [0:0] ch8_drpclk_int;
  wire [0:0] ch9_drpclk_int;
  wire [0:0] ch10_drpclk_int;
  wire [0:0] ch11_drpclk_int;
  wire [0:0] ch12_drpclk_int;
  wire [0:0] ch13_drpclk_int;
  wire [0:0] ch14_drpclk_int;
  wire [0:0] ch15_drpclk_int;
  wire [0:0] ch16_drpclk_int;
  wire [0:0] ch17_drpclk_int;
  wire [0:0] ch18_drpclk_int;
  wire [0:0] ch19_drpclk_int;
  assign drpclk_int[0:0] = ch0_drpclk_int;
  assign drpclk_int[1:1] = ch1_drpclk_int;
  assign drpclk_int[2:2] = ch2_drpclk_int;
  assign drpclk_int[3:3] = ch3_drpclk_int;
  assign drpclk_int[4:4] = ch4_drpclk_int;
  assign drpclk_int[5:5] = ch5_drpclk_int;
  assign drpclk_int[6:6] = ch6_drpclk_int;
  assign drpclk_int[7:7] = ch7_drpclk_int;
  assign drpclk_int[8:8] = ch8_drpclk_int;
  assign drpclk_int[9:9] = ch9_drpclk_int;
  assign drpclk_int[10:10] = ch10_drpclk_int;
  assign drpclk_int[11:11] = ch11_drpclk_int;
  assign drpclk_int[12:12] = ch12_drpclk_int;
  assign drpclk_int[13:13] = ch13_drpclk_int;
  assign drpclk_int[14:14] = ch14_drpclk_int;
  assign drpclk_int[15:15] = ch15_drpclk_int;
  assign drpclk_int[16:16] = ch16_drpclk_int;
  assign drpclk_int[17:17] = ch17_drpclk_int;
  assign drpclk_int[18:18] = ch18_drpclk_int;
  assign drpclk_int[19:19] = ch19_drpclk_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [19:0] gtrefclk0_int;
  wire [0:0] ch0_gtrefclk0_int;
  wire [0:0] ch1_gtrefclk0_int;
  wire [0:0] ch2_gtrefclk0_int;
  wire [0:0] ch3_gtrefclk0_int;
  wire [0:0] ch4_gtrefclk0_int;
  wire [0:0] ch5_gtrefclk0_int;
  wire [0:0] ch6_gtrefclk0_int;
  wire [0:0] ch7_gtrefclk0_int;
  wire [0:0] ch8_gtrefclk0_int;
  wire [0:0] ch9_gtrefclk0_int;
  wire [0:0] ch10_gtrefclk0_int;
  wire [0:0] ch11_gtrefclk0_int;
  wire [0:0] ch12_gtrefclk0_int;
  wire [0:0] ch13_gtrefclk0_int;
  wire [0:0] ch14_gtrefclk0_int;
  wire [0:0] ch15_gtrefclk0_int;
  wire [0:0] ch16_gtrefclk0_int;
  wire [0:0] ch17_gtrefclk0_int;
  wire [0:0] ch18_gtrefclk0_int;
  wire [0:0] ch19_gtrefclk0_int;
  assign gtrefclk0_int[0:0] = ch0_gtrefclk0_int;
  assign gtrefclk0_int[1:1] = ch1_gtrefclk0_int;
  assign gtrefclk0_int[2:2] = ch2_gtrefclk0_int;
  assign gtrefclk0_int[3:3] = ch3_gtrefclk0_int;
  assign gtrefclk0_int[4:4] = ch4_gtrefclk0_int;
  assign gtrefclk0_int[5:5] = ch5_gtrefclk0_int;
  assign gtrefclk0_int[6:6] = ch6_gtrefclk0_int;
  assign gtrefclk0_int[7:7] = ch7_gtrefclk0_int;
  assign gtrefclk0_int[8:8] = ch8_gtrefclk0_int;
  assign gtrefclk0_int[9:9] = ch9_gtrefclk0_int;
  assign gtrefclk0_int[10:10] = ch10_gtrefclk0_int;
  assign gtrefclk0_int[11:11] = ch11_gtrefclk0_int;
  assign gtrefclk0_int[12:12] = ch12_gtrefclk0_int;
  assign gtrefclk0_int[13:13] = ch13_gtrefclk0_int;
  assign gtrefclk0_int[14:14] = ch14_gtrefclk0_int;
  assign gtrefclk0_int[15:15] = ch15_gtrefclk0_int;
  assign gtrefclk0_int[16:16] = ch16_gtrefclk0_int;
  assign gtrefclk0_int[17:17] = ch17_gtrefclk0_int;
  assign gtrefclk0_int[18:18] = ch18_gtrefclk0_int;
  assign gtrefclk0_int[19:19] = ch19_gtrefclk0_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [19:0] rx8b10ben_int;
  wire [0:0] ch0_rx8b10ben_int = 1'b1;
  wire [0:0] ch1_rx8b10ben_int = 1'b1;
  wire [0:0] ch2_rx8b10ben_int = 1'b1;
  wire [0:0] ch3_rx8b10ben_int = 1'b1;
  wire [0:0] ch4_rx8b10ben_int = 1'b1;
  wire [0:0] ch5_rx8b10ben_int = 1'b1;
  wire [0:0] ch6_rx8b10ben_int = 1'b1;
  wire [0:0] ch7_rx8b10ben_int = 1'b1;
  wire [0:0] ch8_rx8b10ben_int = 1'b1;
  wire [0:0] ch9_rx8b10ben_int = 1'b1;
  wire [0:0] ch10_rx8b10ben_int = 1'b1;
  wire [0:0] ch11_rx8b10ben_int = 1'b1;
  wire [0:0] ch12_rx8b10ben_int = 1'b1;
  wire [0:0] ch13_rx8b10ben_int = 1'b1;
  wire [0:0] ch14_rx8b10ben_int = 1'b1;
  wire [0:0] ch15_rx8b10ben_int = 1'b1;
  wire [0:0] ch16_rx8b10ben_int = 1'b1;
  wire [0:0] ch17_rx8b10ben_int = 1'b1;
  wire [0:0] ch18_rx8b10ben_int = 1'b1;
  wire [0:0] ch19_rx8b10ben_int = 1'b1;
  assign rx8b10ben_int[0:0] = ch0_rx8b10ben_int;
  assign rx8b10ben_int[1:1] = ch1_rx8b10ben_int;
  assign rx8b10ben_int[2:2] = ch2_rx8b10ben_int;
  assign rx8b10ben_int[3:3] = ch3_rx8b10ben_int;
  assign rx8b10ben_int[4:4] = ch4_rx8b10ben_int;
  assign rx8b10ben_int[5:5] = ch5_rx8b10ben_int;
  assign rx8b10ben_int[6:6] = ch6_rx8b10ben_int;
  assign rx8b10ben_int[7:7] = ch7_rx8b10ben_int;
  assign rx8b10ben_int[8:8] = ch8_rx8b10ben_int;
  assign rx8b10ben_int[9:9] = ch9_rx8b10ben_int;
  assign rx8b10ben_int[10:10] = ch10_rx8b10ben_int;
  assign rx8b10ben_int[11:11] = ch11_rx8b10ben_int;
  assign rx8b10ben_int[12:12] = ch12_rx8b10ben_int;
  assign rx8b10ben_int[13:13] = ch13_rx8b10ben_int;
  assign rx8b10ben_int[14:14] = ch14_rx8b10ben_int;
  assign rx8b10ben_int[15:15] = ch15_rx8b10ben_int;
  assign rx8b10ben_int[16:16] = ch16_rx8b10ben_int;
  assign rx8b10ben_int[17:17] = ch17_rx8b10ben_int;
  assign rx8b10ben_int[18:18] = ch18_rx8b10ben_int;
  assign rx8b10ben_int[19:19] = ch19_rx8b10ben_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [19:0] tx8b10ben_int;
  wire [0:0] ch0_tx8b10ben_int = 1'b1;
  wire [0:0] ch1_tx8b10ben_int = 1'b1;
  wire [0:0] ch2_tx8b10ben_int = 1'b1;
  wire [0:0] ch3_tx8b10ben_int = 1'b1;
  wire [0:0] ch4_tx8b10ben_int = 1'b1;
  wire [0:0] ch5_tx8b10ben_int = 1'b1;
  wire [0:0] ch6_tx8b10ben_int = 1'b1;
  wire [0:0] ch7_tx8b10ben_int = 1'b1;
  wire [0:0] ch8_tx8b10ben_int = 1'b1;
  wire [0:0] ch9_tx8b10ben_int = 1'b1;
  wire [0:0] ch10_tx8b10ben_int = 1'b1;
  wire [0:0] ch11_tx8b10ben_int = 1'b1;
  wire [0:0] ch12_tx8b10ben_int = 1'b1;
  wire [0:0] ch13_tx8b10ben_int = 1'b1;
  wire [0:0] ch14_tx8b10ben_int = 1'b1;
  wire [0:0] ch15_tx8b10ben_int = 1'b1;
  wire [0:0] ch16_tx8b10ben_int = 1'b1;
  wire [0:0] ch17_tx8b10ben_int = 1'b1;
  wire [0:0] ch18_tx8b10ben_int = 1'b1;
  wire [0:0] ch19_tx8b10ben_int = 1'b1;
  assign tx8b10ben_int[0:0] = ch0_tx8b10ben_int;
  assign tx8b10ben_int[1:1] = ch1_tx8b10ben_int;
  assign tx8b10ben_int[2:2] = ch2_tx8b10ben_int;
  assign tx8b10ben_int[3:3] = ch3_tx8b10ben_int;
  assign tx8b10ben_int[4:4] = ch4_tx8b10ben_int;
  assign tx8b10ben_int[5:5] = ch5_tx8b10ben_int;
  assign tx8b10ben_int[6:6] = ch6_tx8b10ben_int;
  assign tx8b10ben_int[7:7] = ch7_tx8b10ben_int;
  assign tx8b10ben_int[8:8] = ch8_tx8b10ben_int;
  assign tx8b10ben_int[9:9] = ch9_tx8b10ben_int;
  assign tx8b10ben_int[10:10] = ch10_tx8b10ben_int;
  assign tx8b10ben_int[11:11] = ch11_tx8b10ben_int;
  assign tx8b10ben_int[12:12] = ch12_tx8b10ben_int;
  assign tx8b10ben_int[13:13] = ch13_tx8b10ben_int;
  assign tx8b10ben_int[14:14] = ch14_tx8b10ben_int;
  assign tx8b10ben_int[15:15] = ch15_tx8b10ben_int;
  assign tx8b10ben_int[16:16] = ch16_tx8b10ben_int;
  assign tx8b10ben_int[17:17] = ch17_tx8b10ben_int;
  assign tx8b10ben_int[18:18] = ch18_tx8b10ben_int;
  assign tx8b10ben_int[19:19] = ch19_tx8b10ben_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [319:0] txctrl0_int;
  wire [15:0] ch0_txctrl0_int;
  wire [15:0] ch1_txctrl0_int;
  wire [15:0] ch2_txctrl0_int;
  wire [15:0] ch3_txctrl0_int;
  wire [15:0] ch4_txctrl0_int;
  wire [15:0] ch5_txctrl0_int;
  wire [15:0] ch6_txctrl0_int;
  wire [15:0] ch7_txctrl0_int;
  wire [15:0] ch8_txctrl0_int;
  wire [15:0] ch9_txctrl0_int;
  wire [15:0] ch10_txctrl0_int;
  wire [15:0] ch11_txctrl0_int;
  wire [15:0] ch12_txctrl0_int;
  wire [15:0] ch13_txctrl0_int;
  wire [15:0] ch14_txctrl0_int;
  wire [15:0] ch15_txctrl0_int;
  wire [15:0] ch16_txctrl0_int;
  wire [15:0] ch17_txctrl0_int;
  wire [15:0] ch18_txctrl0_int;
  wire [15:0] ch19_txctrl0_int;
  assign txctrl0_int[15:0] = ch0_txctrl0_int;
  assign txctrl0_int[31:16] = ch1_txctrl0_int;
  assign txctrl0_int[47:32] = ch2_txctrl0_int;
  assign txctrl0_int[63:48] = ch3_txctrl0_int;
  assign txctrl0_int[79:64] = ch4_txctrl0_int;
  assign txctrl0_int[95:80] = ch5_txctrl0_int;
  assign txctrl0_int[111:96] = ch6_txctrl0_int;
  assign txctrl0_int[127:112] = ch7_txctrl0_int;
  assign txctrl0_int[143:128] = ch8_txctrl0_int;
  assign txctrl0_int[159:144] = ch9_txctrl0_int;
  assign txctrl0_int[175:160] = ch10_txctrl0_int;
  assign txctrl0_int[191:176] = ch11_txctrl0_int;
  assign txctrl0_int[207:192] = ch12_txctrl0_int;
  assign txctrl0_int[223:208] = ch13_txctrl0_int;
  assign txctrl0_int[239:224] = ch14_txctrl0_int;
  assign txctrl0_int[255:240] = ch15_txctrl0_int;
  assign txctrl0_int[271:256] = ch16_txctrl0_int;
  assign txctrl0_int[287:272] = ch17_txctrl0_int;
  assign txctrl0_int[303:288] = ch18_txctrl0_int;
  assign txctrl0_int[319:304] = ch19_txctrl0_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [319:0] txctrl1_int;
  wire [15:0] ch0_txctrl1_int;
  wire [15:0] ch1_txctrl1_int;
  wire [15:0] ch2_txctrl1_int;
  wire [15:0] ch3_txctrl1_int;
  wire [15:0] ch4_txctrl1_int;
  wire [15:0] ch5_txctrl1_int;
  wire [15:0] ch6_txctrl1_int;
  wire [15:0] ch7_txctrl1_int;
  wire [15:0] ch8_txctrl1_int;
  wire [15:0] ch9_txctrl1_int;
  wire [15:0] ch10_txctrl1_int;
  wire [15:0] ch11_txctrl1_int;
  wire [15:0] ch12_txctrl1_int;
  wire [15:0] ch13_txctrl1_int;
  wire [15:0] ch14_txctrl1_int;
  wire [15:0] ch15_txctrl1_int;
  wire [15:0] ch16_txctrl1_int;
  wire [15:0] ch17_txctrl1_int;
  wire [15:0] ch18_txctrl1_int;
  wire [15:0] ch19_txctrl1_int;
  assign txctrl1_int[15:0] = ch0_txctrl1_int;
  assign txctrl1_int[31:16] = ch1_txctrl1_int;
  assign txctrl1_int[47:32] = ch2_txctrl1_int;
  assign txctrl1_int[63:48] = ch3_txctrl1_int;
  assign txctrl1_int[79:64] = ch4_txctrl1_int;
  assign txctrl1_int[95:80] = ch5_txctrl1_int;
  assign txctrl1_int[111:96] = ch6_txctrl1_int;
  assign txctrl1_int[127:112] = ch7_txctrl1_int;
  assign txctrl1_int[143:128] = ch8_txctrl1_int;
  assign txctrl1_int[159:144] = ch9_txctrl1_int;
  assign txctrl1_int[175:160] = ch10_txctrl1_int;
  assign txctrl1_int[191:176] = ch11_txctrl1_int;
  assign txctrl1_int[207:192] = ch12_txctrl1_int;
  assign txctrl1_int[223:208] = ch13_txctrl1_int;
  assign txctrl1_int[239:224] = ch14_txctrl1_int;
  assign txctrl1_int[255:240] = ch15_txctrl1_int;
  assign txctrl1_int[271:256] = ch16_txctrl1_int;
  assign txctrl1_int[287:272] = ch17_txctrl1_int;
  assign txctrl1_int[303:288] = ch18_txctrl1_int;
  assign txctrl1_int[319:304] = ch19_txctrl1_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [159:0] txctrl2_int;
  wire [7:0] ch0_txctrl2_int;
  wire [7:0] ch1_txctrl2_int;
  wire [7:0] ch2_txctrl2_int;
  wire [7:0] ch3_txctrl2_int;
  wire [7:0] ch4_txctrl2_int;
  wire [7:0] ch5_txctrl2_int;
  wire [7:0] ch6_txctrl2_int;
  wire [7:0] ch7_txctrl2_int;
  wire [7:0] ch8_txctrl2_int;
  wire [7:0] ch9_txctrl2_int;
  wire [7:0] ch10_txctrl2_int;
  wire [7:0] ch11_txctrl2_int;
  wire [7:0] ch12_txctrl2_int;
  wire [7:0] ch13_txctrl2_int;
  wire [7:0] ch14_txctrl2_int;
  wire [7:0] ch15_txctrl2_int;
  wire [7:0] ch16_txctrl2_int;
  wire [7:0] ch17_txctrl2_int;
  wire [7:0] ch18_txctrl2_int;
  wire [7:0] ch19_txctrl2_int;
  assign txctrl2_int[7:0] = ch0_txctrl2_int;
  assign txctrl2_int[15:8] = ch1_txctrl2_int;
  assign txctrl2_int[23:16] = ch2_txctrl2_int;
  assign txctrl2_int[31:24] = ch3_txctrl2_int;
  assign txctrl2_int[39:32] = ch4_txctrl2_int;
  assign txctrl2_int[47:40] = ch5_txctrl2_int;
  assign txctrl2_int[55:48] = ch6_txctrl2_int;
  assign txctrl2_int[63:56] = ch7_txctrl2_int;
  assign txctrl2_int[71:64] = ch8_txctrl2_int;
  assign txctrl2_int[79:72] = ch9_txctrl2_int;
  assign txctrl2_int[87:80] = ch10_txctrl2_int;
  assign txctrl2_int[95:88] = ch11_txctrl2_int;
  assign txctrl2_int[103:96] = ch12_txctrl2_int;
  assign txctrl2_int[111:104] = ch13_txctrl2_int;
  assign txctrl2_int[119:112] = ch14_txctrl2_int;
  assign txctrl2_int[127:120] = ch15_txctrl2_int;
  assign txctrl2_int[135:128] = ch16_txctrl2_int;
  assign txctrl2_int[143:136] = ch17_txctrl2_int;
  assign txctrl2_int[151:144] = ch18_txctrl2_int;
  assign txctrl2_int[159:152] = ch19_txctrl2_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [319:0] rxctrl0_int;
  wire [15:0] ch0_rxctrl0_int;
  wire [15:0] ch1_rxctrl0_int;
  wire [15:0] ch2_rxctrl0_int;
  wire [15:0] ch3_rxctrl0_int;
  wire [15:0] ch4_rxctrl0_int;
  wire [15:0] ch5_rxctrl0_int;
  wire [15:0] ch6_rxctrl0_int;
  wire [15:0] ch7_rxctrl0_int;
  wire [15:0] ch8_rxctrl0_int;
  wire [15:0] ch9_rxctrl0_int;
  wire [15:0] ch10_rxctrl0_int;
  wire [15:0] ch11_rxctrl0_int;
  wire [15:0] ch12_rxctrl0_int;
  wire [15:0] ch13_rxctrl0_int;
  wire [15:0] ch14_rxctrl0_int;
  wire [15:0] ch15_rxctrl0_int;
  wire [15:0] ch16_rxctrl0_int;
  wire [15:0] ch17_rxctrl0_int;
  wire [15:0] ch18_rxctrl0_int;
  wire [15:0] ch19_rxctrl0_int;
  assign ch0_rxctrl0_int = rxctrl0_int[15:0];
  assign ch1_rxctrl0_int = rxctrl0_int[31:16];
  assign ch2_rxctrl0_int = rxctrl0_int[47:32];
  assign ch3_rxctrl0_int = rxctrl0_int[63:48];
  assign ch4_rxctrl0_int = rxctrl0_int[79:64];
  assign ch5_rxctrl0_int = rxctrl0_int[95:80];
  assign ch6_rxctrl0_int = rxctrl0_int[111:96];
  assign ch7_rxctrl0_int = rxctrl0_int[127:112];
  assign ch8_rxctrl0_int = rxctrl0_int[143:128];
  assign ch9_rxctrl0_int = rxctrl0_int[159:144];
  assign ch10_rxctrl0_int = rxctrl0_int[175:160];
  assign ch11_rxctrl0_int = rxctrl0_int[191:176];
  assign ch12_rxctrl0_int = rxctrl0_int[207:192];
  assign ch13_rxctrl0_int = rxctrl0_int[223:208];
  assign ch14_rxctrl0_int = rxctrl0_int[239:224];
  assign ch15_rxctrl0_int = rxctrl0_int[255:240];
  assign ch16_rxctrl0_int = rxctrl0_int[271:256];
  assign ch17_rxctrl0_int = rxctrl0_int[287:272];
  assign ch18_rxctrl0_int = rxctrl0_int[303:288];
  assign ch19_rxctrl0_int = rxctrl0_int[319:304];

  //--------------------------------------------------------------------------------------------------------------------
  wire [319:0] rxctrl1_int;
  wire [15:0] ch0_rxctrl1_int;
  wire [15:0] ch1_rxctrl1_int;
  wire [15:0] ch2_rxctrl1_int;
  wire [15:0] ch3_rxctrl1_int;
  wire [15:0] ch4_rxctrl1_int;
  wire [15:0] ch5_rxctrl1_int;
  wire [15:0] ch6_rxctrl1_int;
  wire [15:0] ch7_rxctrl1_int;
  wire [15:0] ch8_rxctrl1_int;
  wire [15:0] ch9_rxctrl1_int;
  wire [15:0] ch10_rxctrl1_int;
  wire [15:0] ch11_rxctrl1_int;
  wire [15:0] ch12_rxctrl1_int;
  wire [15:0] ch13_rxctrl1_int;
  wire [15:0] ch14_rxctrl1_int;
  wire [15:0] ch15_rxctrl1_int;
  wire [15:0] ch16_rxctrl1_int;
  wire [15:0] ch17_rxctrl1_int;
  wire [15:0] ch18_rxctrl1_int;
  wire [15:0] ch19_rxctrl1_int;
  assign ch0_rxctrl1_int = rxctrl1_int[15:0];
  assign ch1_rxctrl1_int = rxctrl1_int[31:16];
  assign ch2_rxctrl1_int = rxctrl1_int[47:32];
  assign ch3_rxctrl1_int = rxctrl1_int[63:48];
  assign ch4_rxctrl1_int = rxctrl1_int[79:64];
  assign ch5_rxctrl1_int = rxctrl1_int[95:80];
  assign ch6_rxctrl1_int = rxctrl1_int[111:96];
  assign ch7_rxctrl1_int = rxctrl1_int[127:112];
  assign ch8_rxctrl1_int = rxctrl1_int[143:128];
  assign ch9_rxctrl1_int = rxctrl1_int[159:144];
  assign ch10_rxctrl1_int = rxctrl1_int[175:160];
  assign ch11_rxctrl1_int = rxctrl1_int[191:176];
  assign ch12_rxctrl1_int = rxctrl1_int[207:192];
  assign ch13_rxctrl1_int = rxctrl1_int[223:208];
  assign ch14_rxctrl1_int = rxctrl1_int[239:224];
  assign ch15_rxctrl1_int = rxctrl1_int[255:240];
  assign ch16_rxctrl1_int = rxctrl1_int[271:256];
  assign ch17_rxctrl1_int = rxctrl1_int[287:272];
  assign ch18_rxctrl1_int = rxctrl1_int[303:288];
  assign ch19_rxctrl1_int = rxctrl1_int[319:304];

  //--------------------------------------------------------------------------------------------------------------------
  wire [159:0] rxctrl2_int;
  wire [7:0] ch0_rxctrl2_int;
  wire [7:0] ch1_rxctrl2_int;
  wire [7:0] ch2_rxctrl2_int;
  wire [7:0] ch3_rxctrl2_int;
  wire [7:0] ch4_rxctrl2_int;
  wire [7:0] ch5_rxctrl2_int;
  wire [7:0] ch6_rxctrl2_int;
  wire [7:0] ch7_rxctrl2_int;
  wire [7:0] ch8_rxctrl2_int;
  wire [7:0] ch9_rxctrl2_int;
  wire [7:0] ch10_rxctrl2_int;
  wire [7:0] ch11_rxctrl2_int;
  wire [7:0] ch12_rxctrl2_int;
  wire [7:0] ch13_rxctrl2_int;
  wire [7:0] ch14_rxctrl2_int;
  wire [7:0] ch15_rxctrl2_int;
  wire [7:0] ch16_rxctrl2_int;
  wire [7:0] ch17_rxctrl2_int;
  wire [7:0] ch18_rxctrl2_int;
  wire [7:0] ch19_rxctrl2_int;
  assign ch0_rxctrl2_int = rxctrl2_int[7:0];
  assign ch1_rxctrl2_int = rxctrl2_int[15:8];
  assign ch2_rxctrl2_int = rxctrl2_int[23:16];
  assign ch3_rxctrl2_int = rxctrl2_int[31:24];
  assign ch4_rxctrl2_int = rxctrl2_int[39:32];
  assign ch5_rxctrl2_int = rxctrl2_int[47:40];
  assign ch6_rxctrl2_int = rxctrl2_int[55:48];
  assign ch7_rxctrl2_int = rxctrl2_int[63:56];
  assign ch8_rxctrl2_int = rxctrl2_int[71:64];
  assign ch9_rxctrl2_int = rxctrl2_int[79:72];
  assign ch10_rxctrl2_int = rxctrl2_int[87:80];
  assign ch11_rxctrl2_int = rxctrl2_int[95:88];
  assign ch12_rxctrl2_int = rxctrl2_int[103:96];
  assign ch13_rxctrl2_int = rxctrl2_int[111:104];
  assign ch14_rxctrl2_int = rxctrl2_int[119:112];
  assign ch15_rxctrl2_int = rxctrl2_int[127:120];
  assign ch16_rxctrl2_int = rxctrl2_int[135:128];
  assign ch17_rxctrl2_int = rxctrl2_int[143:136];
  assign ch18_rxctrl2_int = rxctrl2_int[151:144];
  assign ch19_rxctrl2_int = rxctrl2_int[159:152];

  //--------------------------------------------------------------------------------------------------------------------
  wire [159:0] rxctrl3_int;
  wire [7:0] ch0_rxctrl3_int;
  wire [7:0] ch1_rxctrl3_int;
  wire [7:0] ch2_rxctrl3_int;
  wire [7:0] ch3_rxctrl3_int;
  wire [7:0] ch4_rxctrl3_int;
  wire [7:0] ch5_rxctrl3_int;
  wire [7:0] ch6_rxctrl3_int;
  wire [7:0] ch7_rxctrl3_int;
  wire [7:0] ch8_rxctrl3_int;
  wire [7:0] ch9_rxctrl3_int;
  wire [7:0] ch10_rxctrl3_int;
  wire [7:0] ch11_rxctrl3_int;
  wire [7:0] ch12_rxctrl3_int;
  wire [7:0] ch13_rxctrl3_int;
  wire [7:0] ch14_rxctrl3_int;
  wire [7:0] ch15_rxctrl3_int;
  wire [7:0] ch16_rxctrl3_int;
  wire [7:0] ch17_rxctrl3_int;
  wire [7:0] ch18_rxctrl3_int;
  wire [7:0] ch19_rxctrl3_int;
  assign ch0_rxctrl3_int = rxctrl3_int[7:0];
  assign ch1_rxctrl3_int = rxctrl3_int[15:8];
  assign ch2_rxctrl3_int = rxctrl3_int[23:16];
  assign ch3_rxctrl3_int = rxctrl3_int[31:24];
  assign ch4_rxctrl3_int = rxctrl3_int[39:32];
  assign ch5_rxctrl3_int = rxctrl3_int[47:40];
  assign ch6_rxctrl3_int = rxctrl3_int[55:48];
  assign ch7_rxctrl3_int = rxctrl3_int[63:56];
  assign ch8_rxctrl3_int = rxctrl3_int[71:64];
  assign ch9_rxctrl3_int = rxctrl3_int[79:72];
  assign ch10_rxctrl3_int = rxctrl3_int[87:80];
  assign ch11_rxctrl3_int = rxctrl3_int[95:88];
  assign ch12_rxctrl3_int = rxctrl3_int[103:96];
  assign ch13_rxctrl3_int = rxctrl3_int[111:104];
  assign ch14_rxctrl3_int = rxctrl3_int[119:112];
  assign ch15_rxctrl3_int = rxctrl3_int[127:120];
  assign ch16_rxctrl3_int = rxctrl3_int[135:128];
  assign ch17_rxctrl3_int = rxctrl3_int[143:136];
  assign ch18_rxctrl3_int = rxctrl3_int[151:144];
  assign ch19_rxctrl3_int = rxctrl3_int[159:152];

  //--------------------------------------------------------------------------------------------------------------------
  wire [19:0] rxpmaresetdone_int;
  wire [0:0] ch0_rxpmaresetdone_int;
  wire [0:0] ch1_rxpmaresetdone_int;
  wire [0:0] ch2_rxpmaresetdone_int;
  wire [0:0] ch3_rxpmaresetdone_int;
  wire [0:0] ch4_rxpmaresetdone_int;
  wire [0:0] ch5_rxpmaresetdone_int;
  wire [0:0] ch6_rxpmaresetdone_int;
  wire [0:0] ch7_rxpmaresetdone_int;
  wire [0:0] ch8_rxpmaresetdone_int;
  wire [0:0] ch9_rxpmaresetdone_int;
  wire [0:0] ch10_rxpmaresetdone_int;
  wire [0:0] ch11_rxpmaresetdone_int;
  wire [0:0] ch12_rxpmaresetdone_int;
  wire [0:0] ch13_rxpmaresetdone_int;
  wire [0:0] ch14_rxpmaresetdone_int;
  wire [0:0] ch15_rxpmaresetdone_int;
  wire [0:0] ch16_rxpmaresetdone_int;
  wire [0:0] ch17_rxpmaresetdone_int;
  wire [0:0] ch18_rxpmaresetdone_int;
  wire [0:0] ch19_rxpmaresetdone_int;
  assign ch0_rxpmaresetdone_int = rxpmaresetdone_int[0:0];
  assign ch1_rxpmaresetdone_int = rxpmaresetdone_int[1:1];
  assign ch2_rxpmaresetdone_int = rxpmaresetdone_int[2:2];
  assign ch3_rxpmaresetdone_int = rxpmaresetdone_int[3:3];
  assign ch4_rxpmaresetdone_int = rxpmaresetdone_int[4:4];
  assign ch5_rxpmaresetdone_int = rxpmaresetdone_int[5:5];
  assign ch6_rxpmaresetdone_int = rxpmaresetdone_int[6:6];
  assign ch7_rxpmaresetdone_int = rxpmaresetdone_int[7:7];
  assign ch8_rxpmaresetdone_int = rxpmaresetdone_int[8:8];
  assign ch9_rxpmaresetdone_int = rxpmaresetdone_int[9:9];
  assign ch10_rxpmaresetdone_int = rxpmaresetdone_int[10:10];
  assign ch11_rxpmaresetdone_int = rxpmaresetdone_int[11:11];
  assign ch12_rxpmaresetdone_int = rxpmaresetdone_int[12:12];
  assign ch13_rxpmaresetdone_int = rxpmaresetdone_int[13:13];
  assign ch14_rxpmaresetdone_int = rxpmaresetdone_int[14:14];
  assign ch15_rxpmaresetdone_int = rxpmaresetdone_int[15:15];
  assign ch16_rxpmaresetdone_int = rxpmaresetdone_int[16:16];
  assign ch17_rxpmaresetdone_int = rxpmaresetdone_int[17:17];
  assign ch18_rxpmaresetdone_int = rxpmaresetdone_int[18:18];
  assign ch19_rxpmaresetdone_int = rxpmaresetdone_int[19:19];

  //--------------------------------------------------------------------------------------------------------------------
  wire [19:0] txpmaresetdone_int;
  wire [0:0] ch0_txpmaresetdone_int;
  wire [0:0] ch1_txpmaresetdone_int;
  wire [0:0] ch2_txpmaresetdone_int;
  wire [0:0] ch3_txpmaresetdone_int;
  wire [0:0] ch4_txpmaresetdone_int;
  wire [0:0] ch5_txpmaresetdone_int;
  wire [0:0] ch6_txpmaresetdone_int;
  wire [0:0] ch7_txpmaresetdone_int;
  wire [0:0] ch8_txpmaresetdone_int;
  wire [0:0] ch9_txpmaresetdone_int;
  wire [0:0] ch10_txpmaresetdone_int;
  wire [0:0] ch11_txpmaresetdone_int;
  wire [0:0] ch12_txpmaresetdone_int;
  wire [0:0] ch13_txpmaresetdone_int;
  wire [0:0] ch14_txpmaresetdone_int;
  wire [0:0] ch15_txpmaresetdone_int;
  wire [0:0] ch16_txpmaresetdone_int;
  wire [0:0] ch17_txpmaresetdone_int;
  wire [0:0] ch18_txpmaresetdone_int;
  wire [0:0] ch19_txpmaresetdone_int;
  assign ch0_txpmaresetdone_int = txpmaresetdone_int[0:0];
  assign ch1_txpmaresetdone_int = txpmaresetdone_int[1:1];
  assign ch2_txpmaresetdone_int = txpmaresetdone_int[2:2];
  assign ch3_txpmaresetdone_int = txpmaresetdone_int[3:3];
  assign ch4_txpmaresetdone_int = txpmaresetdone_int[4:4];
  assign ch5_txpmaresetdone_int = txpmaresetdone_int[5:5];
  assign ch6_txpmaresetdone_int = txpmaresetdone_int[6:6];
  assign ch7_txpmaresetdone_int = txpmaresetdone_int[7:7];
  assign ch8_txpmaresetdone_int = txpmaresetdone_int[8:8];
  assign ch9_txpmaresetdone_int = txpmaresetdone_int[9:9];
  assign ch10_txpmaresetdone_int = txpmaresetdone_int[10:10];
  assign ch11_txpmaresetdone_int = txpmaresetdone_int[11:11];
  assign ch12_txpmaresetdone_int = txpmaresetdone_int[12:12];
  assign ch13_txpmaresetdone_int = txpmaresetdone_int[13:13];
  assign ch14_txpmaresetdone_int = txpmaresetdone_int[14:14];
  assign ch15_txpmaresetdone_int = txpmaresetdone_int[15:15];
  assign ch16_txpmaresetdone_int = txpmaresetdone_int[16:16];
  assign ch17_txpmaresetdone_int = txpmaresetdone_int[17:17];
  assign ch18_txpmaresetdone_int = txpmaresetdone_int[18:18];
  assign ch19_txpmaresetdone_int = txpmaresetdone_int[19:19];


  // ===================================================================================================================
  // BUFFERS
  // ===================================================================================================================

  // Buffer the hb_gtwiz_reset_all_in input and logically combine it with the internal signal from the example
  // initialization block as well as the VIO-sourced reset
  wire hb_gtwiz_reset_all_vio_int;
  wire hb_gtwiz_reset_all_buf_int;
  wire hb_gtwiz_reset_all_init_int;
  wire hb_gtwiz_reset_all_int;

  IBUF ibuf_hb_gtwiz_reset_all_inst (
    .I (hb_gtwiz_reset_all_in),
    .O (hb_gtwiz_reset_all_buf_int)
  );

  assign hb_gtwiz_reset_all_int = hb_gtwiz_reset_all_buf_int || hb_gtwiz_reset_all_init_int || hb_gtwiz_reset_all_vio_int;

  // Globally buffer the free-running input clock
  wire hb_gtwiz_reset_clk_freerun_buf_int;

  BUFG bufg_clk_freerun_inst (
    .I (hb_gtwiz_reset_clk_freerun_in),
    .O (hb_gtwiz_reset_clk_freerun_buf_int)
  );

  // For GTH core configurations which utilize the transceiver channel CPLL, the drpclk_in port must be driven by
  // the free-running clock at the exact frequency specified during core customization, for reliable bring-up
  assign ch0_drpclk_int = hb_gtwiz_reset_clk_freerun_buf_int;
  assign ch1_drpclk_int = hb_gtwiz_reset_clk_freerun_buf_int;
  assign ch2_drpclk_int = hb_gtwiz_reset_clk_freerun_buf_int;
  assign ch3_drpclk_int = hb_gtwiz_reset_clk_freerun_buf_int;
  assign ch4_drpclk_int = hb_gtwiz_reset_clk_freerun_buf_int;
  assign ch5_drpclk_int = hb_gtwiz_reset_clk_freerun_buf_int;
  assign ch6_drpclk_int = hb_gtwiz_reset_clk_freerun_buf_int;
  assign ch7_drpclk_int = hb_gtwiz_reset_clk_freerun_buf_int;
  assign ch8_drpclk_int = hb_gtwiz_reset_clk_freerun_buf_int;
  assign ch9_drpclk_int = hb_gtwiz_reset_clk_freerun_buf_int;
  assign ch10_drpclk_int = hb_gtwiz_reset_clk_freerun_buf_int;
  assign ch11_drpclk_int = hb_gtwiz_reset_clk_freerun_buf_int;
  assign ch12_drpclk_int = hb_gtwiz_reset_clk_freerun_buf_int;
  assign ch13_drpclk_int = hb_gtwiz_reset_clk_freerun_buf_int;
  assign ch14_drpclk_int = hb_gtwiz_reset_clk_freerun_buf_int;
  assign ch15_drpclk_int = hb_gtwiz_reset_clk_freerun_buf_int;
  assign ch16_drpclk_int = hb_gtwiz_reset_clk_freerun_buf_int;
  assign ch17_drpclk_int = hb_gtwiz_reset_clk_freerun_buf_int;
  assign ch18_drpclk_int = hb_gtwiz_reset_clk_freerun_buf_int;
  assign ch19_drpclk_int = hb_gtwiz_reset_clk_freerun_buf_int;

  // Instantiate a differential reference clock buffer for each reference clock differential pair in this configuration,
  // and assign the single-ended output of each differential reference clock buffer to the appropriate PLL input signal

  // Differential reference clock buffer for MGTREFCLK0_X0Y0
  wire mgtrefclk0_x0y0_int;

  IBUFDS_GTE3 #(
    .REFCLK_EN_TX_PATH  (1'b0),
    .REFCLK_HROW_CK_SEL (2'b00),
    .REFCLK_ICNTL_RX    (2'b00)
  ) IBUFDS_GTE3_MGTREFCLK0_X0Y0_INST (
    .I     (mgtrefclk0_x0y0_p),
    .IB    (mgtrefclk0_x0y0_n),
    .CEB   (1'b0),
    .O     (mgtrefclk0_x0y0_int),
    .ODIV2 ()
  );

  // Differential reference clock buffer for MGTREFCLK0_X0Y1
  wire mgtrefclk0_x0y1_int;

  IBUFDS_GTE3 #(
    .REFCLK_EN_TX_PATH  (1'b0),
    .REFCLK_HROW_CK_SEL (2'b00),
    .REFCLK_ICNTL_RX    (2'b00)
  ) IBUFDS_GTE3_MGTREFCLK0_X0Y1_INST (
    .I     (mgtrefclk0_x0y1_p),
    .IB    (mgtrefclk0_x0y1_n),
    .CEB   (1'b0),
    .O     (mgtrefclk0_x0y1_int),
    .ODIV2 ()
  );

  // Differential reference clock buffer for MGTREFCLK0_X0Y2
  wire mgtrefclk0_x0y2_int;

  IBUFDS_GTE3 #(
    .REFCLK_EN_TX_PATH  (1'b0),
    .REFCLK_HROW_CK_SEL (2'b00),
    .REFCLK_ICNTL_RX    (2'b00)
  ) IBUFDS_GTE3_MGTREFCLK0_X0Y2_INST (
    .I     (mgtrefclk0_x0y2_p),
    .IB    (mgtrefclk0_x0y2_n),
    .CEB   (1'b0),
    .O     (mgtrefclk0_x0y2_int),
    .ODIV2 ()
  );

  // Differential reference clock buffer for MGTREFCLK0_X0Y3
  wire mgtrefclk0_x0y3_int;

  IBUFDS_GTE3 #(
    .REFCLK_EN_TX_PATH  (1'b0),
    .REFCLK_HROW_CK_SEL (2'b00),
    .REFCLK_ICNTL_RX    (2'b00)
  ) IBUFDS_GTE3_MGTREFCLK0_X0Y3_INST (
    .I     (mgtrefclk0_x0y3_p),
    .IB    (mgtrefclk0_x0y3_n),
    .CEB   (1'b0),
    .O     (mgtrefclk0_x0y3_int),
    .ODIV2 ()
  );

  // Differential reference clock buffer for MGTREFCLK0_X0Y4
  wire mgtrefclk0_x0y4_int;

  IBUFDS_GTE3 #(
    .REFCLK_EN_TX_PATH  (1'b0),
    .REFCLK_HROW_CK_SEL (2'b00),
    .REFCLK_ICNTL_RX    (2'b00)
  ) IBUFDS_GTE3_MGTREFCLK0_X0Y4_INST (
    .I     (mgtrefclk0_x0y4_p),
    .IB    (mgtrefclk0_x0y4_n),
    .CEB   (1'b0),
    .O     (mgtrefclk0_x0y4_int),
    .ODIV2 ()
  );

  // Differential reference clock buffer for MGTREFCLK1_X0Y0
  wire mgtrefclk1_x0y0_int;

  IBUFDS_GTE3 #(
    .REFCLK_EN_TX_PATH  (1'b0),
    .REFCLK_HROW_CK_SEL (2'b00),
    .REFCLK_ICNTL_RX    (2'b00)
  ) IBUFDS_GTE3_MGTREFCLK1_X0Y0_INST (
    .I     (mgtrefclk1_x0y0_p),
    .IB    (mgtrefclk1_x0y0_n),
    .CEB   (1'b0),
    .O     (mgtrefclk1_x0y0_int),
    .ODIV2 ()
  );

  // Differential reference clock buffer for MGTREFCLK1_X0Y1
  wire mgtrefclk1_x0y1_int;

  IBUFDS_GTE3 #(
    .REFCLK_EN_TX_PATH  (1'b0),
    .REFCLK_HROW_CK_SEL (2'b00),
    .REFCLK_ICNTL_RX    (2'b00)
  ) IBUFDS_GTE3_MGTREFCLK1_X0Y1_INST (
    .I     (mgtrefclk1_x0y1_p),
    .IB    (mgtrefclk1_x0y1_n),
    .CEB   (1'b0),
    .O     (mgtrefclk1_x0y1_int),
    .ODIV2 ()
  );

  // Differential reference clock buffer for MGTREFCLK1_X0Y2
  wire mgtrefclk1_x0y2_int;

  IBUFDS_GTE3 #(
    .REFCLK_EN_TX_PATH  (1'b0),
    .REFCLK_HROW_CK_SEL (2'b00),
    .REFCLK_ICNTL_RX    (2'b00)
  ) IBUFDS_GTE3_MGTREFCLK1_X0Y2_INST (
    .I     (mgtrefclk1_x0y2_p),
    .IB    (mgtrefclk1_x0y2_n),
    .CEB   (1'b0),
    .O     (mgtrefclk1_x0y2_int),
    .ODIV2 ()
  );

  // Differential reference clock buffer for MGTREFCLK1_X0Y3
  wire mgtrefclk1_x0y3_int;

  IBUFDS_GTE3 #(
    .REFCLK_EN_TX_PATH  (1'b0),
    .REFCLK_HROW_CK_SEL (2'b00),
    .REFCLK_ICNTL_RX    (2'b00)
  ) IBUFDS_GTE3_MGTREFCLK1_X0Y3_INST (
    .I     (mgtrefclk1_x0y3_p),
    .IB    (mgtrefclk1_x0y3_n),
    .CEB   (1'b0),
    .O     (mgtrefclk1_x0y3_int),
    .ODIV2 ()
  );

  // Differential reference clock buffer for MGTREFCLK1_X0Y4
  wire mgtrefclk1_x0y4_int;

  IBUFDS_GTE3 #(
    .REFCLK_EN_TX_PATH  (1'b0),
    .REFCLK_HROW_CK_SEL (2'b00),
    .REFCLK_ICNTL_RX    (2'b00)
  ) IBUFDS_GTE3_MGTREFCLK1_X0Y4_INST (
    .I     (mgtrefclk1_x0y4_p),
    .IB    (mgtrefclk1_x0y4_n),
    .CEB   (1'b0),
    .O     (mgtrefclk1_x0y4_int),
    .ODIV2 ()
  );

  assign ch0_gtrefclk0_int = mgtrefclk1_x0y0_int;
  assign ch10_gtrefclk0_int = mgtrefclk1_x0y2_int;
  assign ch11_gtrefclk0_int = mgtrefclk1_x0y2_int;
  assign ch12_gtrefclk0_int = mgtrefclk1_x0y3_int;
  assign ch13_gtrefclk0_int = mgtrefclk1_x0y3_int;
  assign ch14_gtrefclk0_int = mgtrefclk1_x0y3_int;
  assign ch15_gtrefclk0_int = mgtrefclk1_x0y3_int;
  assign ch16_gtrefclk0_int = mgtrefclk1_x0y4_int;
  assign ch17_gtrefclk0_int = mgtrefclk1_x0y4_int;
  assign ch18_gtrefclk0_int = mgtrefclk1_x0y4_int;
  assign ch19_gtrefclk0_int = mgtrefclk1_x0y4_int;
  assign ch1_gtrefclk0_int = mgtrefclk1_x0y0_int;
  assign ch2_gtrefclk0_int = mgtrefclk1_x0y0_int;
  assign ch3_gtrefclk0_int = mgtrefclk1_x0y0_int;
  assign ch4_gtrefclk0_int = mgtrefclk1_x0y1_int;
  assign ch5_gtrefclk0_int = mgtrefclk1_x0y1_int;
  assign ch6_gtrefclk0_int = mgtrefclk1_x0y1_int;
  assign ch7_gtrefclk0_int = mgtrefclk1_x0y1_int;
  assign ch8_gtrefclk0_int = mgtrefclk1_x0y2_int;
  assign ch9_gtrefclk0_int = mgtrefclk1_x0y2_int;
  assign cm0_gtrefclk01_int = mgtrefclk0_x0y0_int;
  assign cm1_gtrefclk01_int = mgtrefclk0_x0y1_int;
  assign cm2_gtrefclk01_int = mgtrefclk0_x0y2_int;
  assign cm3_gtrefclk01_int = mgtrefclk0_x0y3_int;
  assign cm4_gtrefclk01_int = mgtrefclk0_x0y4_int;


  // ===================================================================================================================
  // USER CLOCKING RESETS
  // ===================================================================================================================

  // The TX user clocking helper block should be held in reset until the clock source of that block is known to be
  // stable. The following assignment is an example of how that stability can be determined, based on the selected TX
  // user clock source. Replace the assignment with the appropriate signal or logic to achieve that behavior as needed.
  assign hb0_gtwiz_userclk_tx_reset_int = ~(&txpmaresetdone_int);

  // The RX user clocking helper block should be held in reset until the clock source of that block is known to be
  // stable. The following assignment is an example of how that stability can be determined, based on the selected RX
  // user clock source. Replace the assignment with the appropriate signal or logic to achieve that behavior as needed.
  assign hb0_gtwiz_userclk_rx_reset_int = ~(&rxpmaresetdone_int);


  // ===================================================================================================================
  // PRBS STIMULUS, CHECKING, AND LINK MANAGEMENT
  // ===================================================================================================================

  // PRBS stimulus
  // -------------------------------------------------------------------------------------------------------------------

  // PRBS-based data stimulus module for transceiver channel 0
  (* DONT_TOUCH = "TRUE" *)
  gth1_example_stimulus_8b10b example_stimulus_inst0 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_tx_usrclk2_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .gtwiz_userclk_tx_active_in  (hb0_gtwiz_userclk_tx_active_int),
    .txctrl0_out                 (ch0_txctrl0_int),
    .txctrl1_out                 (ch0_txctrl1_int),
    .txctrl2_out                 (ch0_txctrl2_int),
    .txdata_out                  (hb0_gtwiz_userdata_tx_int)
  );

  // PRBS-based data stimulus module for transceiver channel 1
  (* DONT_TOUCH = "TRUE" *)
  gth1_example_stimulus_8b10b example_stimulus_inst1 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_tx_usrclk2_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .gtwiz_userclk_tx_active_in  (hb0_gtwiz_userclk_tx_active_int),
    .txctrl0_out                 (ch1_txctrl0_int),
    .txctrl1_out                 (ch1_txctrl1_int),
    .txctrl2_out                 (ch1_txctrl2_int),
    .txdata_out                  (hb1_gtwiz_userdata_tx_int)
  );

  // PRBS-based data stimulus module for transceiver channel 2
  (* DONT_TOUCH = "TRUE" *)
  gth1_example_stimulus_8b10b example_stimulus_inst2 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_tx_usrclk2_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .gtwiz_userclk_tx_active_in  (hb0_gtwiz_userclk_tx_active_int),
    .txctrl0_out                 (ch2_txctrl0_int),
    .txctrl1_out                 (ch2_txctrl1_int),
    .txctrl2_out                 (ch2_txctrl2_int),
    .txdata_out                  (hb2_gtwiz_userdata_tx_int)
  );

  // PRBS-based data stimulus module for transceiver channel 3
  (* DONT_TOUCH = "TRUE" *)
  gth1_example_stimulus_8b10b example_stimulus_inst3 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_tx_usrclk2_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .gtwiz_userclk_tx_active_in  (hb0_gtwiz_userclk_tx_active_int),
    .txctrl0_out                 (ch3_txctrl0_int),
    .txctrl1_out                 (ch3_txctrl1_int),
    .txctrl2_out                 (ch3_txctrl2_int),
    .txdata_out                  (hb3_gtwiz_userdata_tx_int)
  );

  // PRBS-based data stimulus module for transceiver channel 4
  (* DONT_TOUCH = "TRUE" *)
  gth1_example_stimulus_8b10b example_stimulus_inst4 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_tx_usrclk2_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .gtwiz_userclk_tx_active_in  (hb0_gtwiz_userclk_tx_active_int),
    .txctrl0_out                 (ch4_txctrl0_int),
    .txctrl1_out                 (ch4_txctrl1_int),
    .txctrl2_out                 (ch4_txctrl2_int),
    .txdata_out                  (hb4_gtwiz_userdata_tx_int)
  );

  // PRBS-based data stimulus module for transceiver channel 5
  (* DONT_TOUCH = "TRUE" *)
  gth1_example_stimulus_8b10b example_stimulus_inst5 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_tx_usrclk2_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .gtwiz_userclk_tx_active_in  (hb0_gtwiz_userclk_tx_active_int),
    .txctrl0_out                 (ch5_txctrl0_int),
    .txctrl1_out                 (ch5_txctrl1_int),
    .txctrl2_out                 (ch5_txctrl2_int),
    .txdata_out                  (hb5_gtwiz_userdata_tx_int)
  );

  // PRBS-based data stimulus module for transceiver channel 6
  (* DONT_TOUCH = "TRUE" *)
  gth1_example_stimulus_8b10b example_stimulus_inst6 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_tx_usrclk2_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .gtwiz_userclk_tx_active_in  (hb0_gtwiz_userclk_tx_active_int),
    .txctrl0_out                 (ch6_txctrl0_int),
    .txctrl1_out                 (ch6_txctrl1_int),
    .txctrl2_out                 (ch6_txctrl2_int),
    .txdata_out                  (hb6_gtwiz_userdata_tx_int)
  );

  // PRBS-based data stimulus module for transceiver channel 7
  (* DONT_TOUCH = "TRUE" *)
  gth1_example_stimulus_8b10b example_stimulus_inst7 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_tx_usrclk2_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .gtwiz_userclk_tx_active_in  (hb0_gtwiz_userclk_tx_active_int),
    .txctrl0_out                 (ch7_txctrl0_int),
    .txctrl1_out                 (ch7_txctrl1_int),
    .txctrl2_out                 (ch7_txctrl2_int),
    .txdata_out                  (hb7_gtwiz_userdata_tx_int)
  );

  // PRBS-based data stimulus module for transceiver channel 8
  (* DONT_TOUCH = "TRUE" *)
  gth1_example_stimulus_8b10b example_stimulus_inst8 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_tx_usrclk2_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .gtwiz_userclk_tx_active_in  (hb0_gtwiz_userclk_tx_active_int),
    .txctrl0_out                 (ch8_txctrl0_int),
    .txctrl1_out                 (ch8_txctrl1_int),
    .txctrl2_out                 (ch8_txctrl2_int),
    .txdata_out                  (hb8_gtwiz_userdata_tx_int)
  );

  // PRBS-based data stimulus module for transceiver channel 9
  (* DONT_TOUCH = "TRUE" *)
  gth1_example_stimulus_8b10b example_stimulus_inst9 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_tx_usrclk2_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .gtwiz_userclk_tx_active_in  (hb0_gtwiz_userclk_tx_active_int),
    .txctrl0_out                 (ch9_txctrl0_int),
    .txctrl1_out                 (ch9_txctrl1_int),
    .txctrl2_out                 (ch9_txctrl2_int),
    .txdata_out                  (hb9_gtwiz_userdata_tx_int)
  );

  // PRBS-based data stimulus module for transceiver channel 10
  (* DONT_TOUCH = "TRUE" *)
  gth1_example_stimulus_8b10b example_stimulus_inst10 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_tx_usrclk2_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .gtwiz_userclk_tx_active_in  (hb0_gtwiz_userclk_tx_active_int),
    .txctrl0_out                 (ch10_txctrl0_int),
    .txctrl1_out                 (ch10_txctrl1_int),
    .txctrl2_out                 (ch10_txctrl2_int),
    .txdata_out                  (hb10_gtwiz_userdata_tx_int)
  );

  // PRBS-based data stimulus module for transceiver channel 11
  (* DONT_TOUCH = "TRUE" *)
  gth1_example_stimulus_8b10b example_stimulus_inst11 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_tx_usrclk2_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .gtwiz_userclk_tx_active_in  (hb0_gtwiz_userclk_tx_active_int),
    .txctrl0_out                 (ch11_txctrl0_int),
    .txctrl1_out                 (ch11_txctrl1_int),
    .txctrl2_out                 (ch11_txctrl2_int),
    .txdata_out                  (hb11_gtwiz_userdata_tx_int)
  );

  // PRBS-based data stimulus module for transceiver channel 12
  (* DONT_TOUCH = "TRUE" *)
  gth1_example_stimulus_8b10b example_stimulus_inst12 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_tx_usrclk2_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .gtwiz_userclk_tx_active_in  (hb0_gtwiz_userclk_tx_active_int),
    .txctrl0_out                 (ch12_txctrl0_int),
    .txctrl1_out                 (ch12_txctrl1_int),
    .txctrl2_out                 (ch12_txctrl2_int),
    .txdata_out                  (hb12_gtwiz_userdata_tx_int)
  );

  // PRBS-based data stimulus module for transceiver channel 13
  (* DONT_TOUCH = "TRUE" *)
  gth1_example_stimulus_8b10b example_stimulus_inst13 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_tx_usrclk2_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .gtwiz_userclk_tx_active_in  (hb0_gtwiz_userclk_tx_active_int),
    .txctrl0_out                 (ch13_txctrl0_int),
    .txctrl1_out                 (ch13_txctrl1_int),
    .txctrl2_out                 (ch13_txctrl2_int),
    .txdata_out                  (hb13_gtwiz_userdata_tx_int)
  );

  // PRBS-based data stimulus module for transceiver channel 14
  (* DONT_TOUCH = "TRUE" *)
  gth1_example_stimulus_8b10b example_stimulus_inst14 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_tx_usrclk2_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .gtwiz_userclk_tx_active_in  (hb0_gtwiz_userclk_tx_active_int),
    .txctrl0_out                 (ch14_txctrl0_int),
    .txctrl1_out                 (ch14_txctrl1_int),
    .txctrl2_out                 (ch14_txctrl2_int),
    .txdata_out                  (hb14_gtwiz_userdata_tx_int)
  );

  // PRBS-based data stimulus module for transceiver channel 15
  (* DONT_TOUCH = "TRUE" *)
  gth1_example_stimulus_8b10b example_stimulus_inst15 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_tx_usrclk2_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .gtwiz_userclk_tx_active_in  (hb0_gtwiz_userclk_tx_active_int),
    .txctrl0_out                 (ch15_txctrl0_int),
    .txctrl1_out                 (ch15_txctrl1_int),
    .txctrl2_out                 (ch15_txctrl2_int),
    .txdata_out                  (hb15_gtwiz_userdata_tx_int)
  );

  // PRBS-based data stimulus module for transceiver channel 16
  (* DONT_TOUCH = "TRUE" *)
  gth1_example_stimulus_8b10b example_stimulus_inst16 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_tx_usrclk2_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .gtwiz_userclk_tx_active_in  (hb0_gtwiz_userclk_tx_active_int),
    .txctrl0_out                 (ch16_txctrl0_int),
    .txctrl1_out                 (ch16_txctrl1_int),
    .txctrl2_out                 (ch16_txctrl2_int),
    .txdata_out                  (hb16_gtwiz_userdata_tx_int)
  );

  // PRBS-based data stimulus module for transceiver channel 17
  (* DONT_TOUCH = "TRUE" *)
  gth1_example_stimulus_8b10b example_stimulus_inst17 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_tx_usrclk2_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .gtwiz_userclk_tx_active_in  (hb0_gtwiz_userclk_tx_active_int),
    .txctrl0_out                 (ch17_txctrl0_int),
    .txctrl1_out                 (ch17_txctrl1_int),
    .txctrl2_out                 (ch17_txctrl2_int),
    .txdata_out                  (hb17_gtwiz_userdata_tx_int)
  );

  // PRBS-based data stimulus module for transceiver channel 18
  (* DONT_TOUCH = "TRUE" *)
  gth1_example_stimulus_8b10b example_stimulus_inst18 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_tx_usrclk2_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .gtwiz_userclk_tx_active_in  (hb0_gtwiz_userclk_tx_active_int),
    .txctrl0_out                 (ch18_txctrl0_int),
    .txctrl1_out                 (ch18_txctrl1_int),
    .txctrl2_out                 (ch18_txctrl2_int),
    .txdata_out                  (hb18_gtwiz_userdata_tx_int)
  );

  // PRBS-based data stimulus module for transceiver channel 19
  (* DONT_TOUCH = "TRUE" *)
  gth1_example_stimulus_8b10b example_stimulus_inst19 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_tx_usrclk2_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .gtwiz_userclk_tx_active_in  (hb0_gtwiz_userclk_tx_active_int),
    .txctrl0_out                 (ch19_txctrl0_int),
    .txctrl1_out                 (ch19_txctrl1_int),
    .txctrl2_out                 (ch19_txctrl2_int),
    .txdata_out                  (hb19_gtwiz_userdata_tx_int)
  );

  // PRBS checking
  // -------------------------------------------------------------------------------------------------------------------

  // Declare a signal vector of PRBS match indicators, with one indicator bit per transceiver channel
  wire [19:0] prbs_match_int;

  // PRBS-based data checking module for transceiver channel 0
  gth1_example_checking_8b10b example_checking_inst0 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_rx_usrclk2_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .gtwiz_userclk_rx_active_in  (hb0_gtwiz_userclk_rx_active_int),
    .rxctrl0_in                  (ch0_rxctrl0_int),
    .rxctrl1_in                  (ch0_rxctrl1_int),
    .rxctrl2_in                  (ch0_rxctrl2_int),
    .rxctrl3_in                  (ch0_rxctrl3_int),
    .rxdata_in                   (hb0_gtwiz_userdata_rx_int),
    .prbs_match_out              (prbs_match_int[0])
  );

  // PRBS-based data checking module for transceiver channel 1
  gth1_example_checking_8b10b example_checking_inst1 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_rx_usrclk2_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .gtwiz_userclk_rx_active_in  (hb0_gtwiz_userclk_rx_active_int),
    .rxctrl0_in                  (ch1_rxctrl0_int),
    .rxctrl1_in                  (ch1_rxctrl1_int),
    .rxctrl2_in                  (ch1_rxctrl2_int),
    .rxctrl3_in                  (ch1_rxctrl3_int),
    .rxdata_in                   (hb1_gtwiz_userdata_rx_int),
    .prbs_match_out              (prbs_match_int[1])
  );

  // PRBS-based data checking module for transceiver channel 2
  gth1_example_checking_8b10b example_checking_inst2 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_rx_usrclk2_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .gtwiz_userclk_rx_active_in  (hb0_gtwiz_userclk_rx_active_int),
    .rxctrl0_in                  (ch2_rxctrl0_int),
    .rxctrl1_in                  (ch2_rxctrl1_int),
    .rxctrl2_in                  (ch2_rxctrl2_int),
    .rxctrl3_in                  (ch2_rxctrl3_int),
    .rxdata_in                   (hb2_gtwiz_userdata_rx_int),
    .prbs_match_out              (prbs_match_int[2])
  );

  // PRBS-based data checking module for transceiver channel 3
  gth1_example_checking_8b10b example_checking_inst3 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_rx_usrclk2_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .gtwiz_userclk_rx_active_in  (hb0_gtwiz_userclk_rx_active_int),
    .rxctrl0_in                  (ch3_rxctrl0_int),
    .rxctrl1_in                  (ch3_rxctrl1_int),
    .rxctrl2_in                  (ch3_rxctrl2_int),
    .rxctrl3_in                  (ch3_rxctrl3_int),
    .rxdata_in                   (hb3_gtwiz_userdata_rx_int),
    .prbs_match_out              (prbs_match_int[3])
  );

  // PRBS-based data checking module for transceiver channel 4
  gth1_example_checking_8b10b example_checking_inst4 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_rx_usrclk2_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .gtwiz_userclk_rx_active_in  (hb0_gtwiz_userclk_rx_active_int),
    .rxctrl0_in                  (ch4_rxctrl0_int),
    .rxctrl1_in                  (ch4_rxctrl1_int),
    .rxctrl2_in                  (ch4_rxctrl2_int),
    .rxctrl3_in                  (ch4_rxctrl3_int),
    .rxdata_in                   (hb4_gtwiz_userdata_rx_int),
    .prbs_match_out              (prbs_match_int[4])
  );

  // PRBS-based data checking module for transceiver channel 5
  gth1_example_checking_8b10b example_checking_inst5 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_rx_usrclk2_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .gtwiz_userclk_rx_active_in  (hb0_gtwiz_userclk_rx_active_int),
    .rxctrl0_in                  (ch5_rxctrl0_int),
    .rxctrl1_in                  (ch5_rxctrl1_int),
    .rxctrl2_in                  (ch5_rxctrl2_int),
    .rxctrl3_in                  (ch5_rxctrl3_int),
    .rxdata_in                   (hb5_gtwiz_userdata_rx_int),
    .prbs_match_out              (prbs_match_int[5])
  );

  // PRBS-based data checking module for transceiver channel 6
  gth1_example_checking_8b10b example_checking_inst6 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_rx_usrclk2_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .gtwiz_userclk_rx_active_in  (hb0_gtwiz_userclk_rx_active_int),
    .rxctrl0_in                  (ch6_rxctrl0_int),
    .rxctrl1_in                  (ch6_rxctrl1_int),
    .rxctrl2_in                  (ch6_rxctrl2_int),
    .rxctrl3_in                  (ch6_rxctrl3_int),
    .rxdata_in                   (hb6_gtwiz_userdata_rx_int),
    .prbs_match_out              (prbs_match_int[6])
  );

  // PRBS-based data checking module for transceiver channel 7
  gth1_example_checking_8b10b example_checking_inst7 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_rx_usrclk2_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .gtwiz_userclk_rx_active_in  (hb0_gtwiz_userclk_rx_active_int),
    .rxctrl0_in                  (ch7_rxctrl0_int),
    .rxctrl1_in                  (ch7_rxctrl1_int),
    .rxctrl2_in                  (ch7_rxctrl2_int),
    .rxctrl3_in                  (ch7_rxctrl3_int),
    .rxdata_in                   (hb7_gtwiz_userdata_rx_int),
    .prbs_match_out              (prbs_match_int[7])
  );

  // PRBS-based data checking module for transceiver channel 8
  gth1_example_checking_8b10b example_checking_inst8 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_rx_usrclk2_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .gtwiz_userclk_rx_active_in  (hb0_gtwiz_userclk_rx_active_int),
    .rxctrl0_in                  (ch8_rxctrl0_int),
    .rxctrl1_in                  (ch8_rxctrl1_int),
    .rxctrl2_in                  (ch8_rxctrl2_int),
    .rxctrl3_in                  (ch8_rxctrl3_int),
    .rxdata_in                   (hb8_gtwiz_userdata_rx_int),
    .prbs_match_out              (prbs_match_int[8])
  );

  // PRBS-based data checking module for transceiver channel 9
  gth1_example_checking_8b10b example_checking_inst9 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_rx_usrclk2_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .gtwiz_userclk_rx_active_in  (hb0_gtwiz_userclk_rx_active_int),
    .rxctrl0_in                  (ch9_rxctrl0_int),
    .rxctrl1_in                  (ch9_rxctrl1_int),
    .rxctrl2_in                  (ch9_rxctrl2_int),
    .rxctrl3_in                  (ch9_rxctrl3_int),
    .rxdata_in                   (hb9_gtwiz_userdata_rx_int),
    .prbs_match_out              (prbs_match_int[9])
  );

  // PRBS-based data checking module for transceiver channel 10
  gth1_example_checking_8b10b example_checking_inst10 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_rx_usrclk2_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .gtwiz_userclk_rx_active_in  (hb0_gtwiz_userclk_rx_active_int),
    .rxctrl0_in                  (ch10_rxctrl0_int),
    .rxctrl1_in                  (ch10_rxctrl1_int),
    .rxctrl2_in                  (ch10_rxctrl2_int),
    .rxctrl3_in                  (ch10_rxctrl3_int),
    .rxdata_in                   (hb10_gtwiz_userdata_rx_int),
    .prbs_match_out              (prbs_match_int[10])
  );

  // PRBS-based data checking module for transceiver channel 11
  gth1_example_checking_8b10b example_checking_inst11 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_rx_usrclk2_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .gtwiz_userclk_rx_active_in  (hb0_gtwiz_userclk_rx_active_int),
    .rxctrl0_in                  (ch11_rxctrl0_int),
    .rxctrl1_in                  (ch11_rxctrl1_int),
    .rxctrl2_in                  (ch11_rxctrl2_int),
    .rxctrl3_in                  (ch11_rxctrl3_int),
    .rxdata_in                   (hb11_gtwiz_userdata_rx_int),
    .prbs_match_out              (prbs_match_int[11])
  );

  // PRBS-based data checking module for transceiver channel 12
  gth1_example_checking_8b10b example_checking_inst12 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_rx_usrclk2_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .gtwiz_userclk_rx_active_in  (hb0_gtwiz_userclk_rx_active_int),
    .rxctrl0_in                  (ch12_rxctrl0_int),
    .rxctrl1_in                  (ch12_rxctrl1_int),
    .rxctrl2_in                  (ch12_rxctrl2_int),
    .rxctrl3_in                  (ch12_rxctrl3_int),
    .rxdata_in                   (hb12_gtwiz_userdata_rx_int),
    .prbs_match_out              (prbs_match_int[12])
  );

  // PRBS-based data checking module for transceiver channel 13
  gth1_example_checking_8b10b example_checking_inst13 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_rx_usrclk2_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .gtwiz_userclk_rx_active_in  (hb0_gtwiz_userclk_rx_active_int),
    .rxctrl0_in                  (ch13_rxctrl0_int),
    .rxctrl1_in                  (ch13_rxctrl1_int),
    .rxctrl2_in                  (ch13_rxctrl2_int),
    .rxctrl3_in                  (ch13_rxctrl3_int),
    .rxdata_in                   (hb13_gtwiz_userdata_rx_int),
    .prbs_match_out              (prbs_match_int[13])
  );

  // PRBS-based data checking module for transceiver channel 14
  gth1_example_checking_8b10b example_checking_inst14 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_rx_usrclk2_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .gtwiz_userclk_rx_active_in  (hb0_gtwiz_userclk_rx_active_int),
    .rxctrl0_in                  (ch14_rxctrl0_int),
    .rxctrl1_in                  (ch14_rxctrl1_int),
    .rxctrl2_in                  (ch14_rxctrl2_int),
    .rxctrl3_in                  (ch14_rxctrl3_int),
    .rxdata_in                   (hb14_gtwiz_userdata_rx_int),
    .prbs_match_out              (prbs_match_int[14])
  );

  // PRBS-based data checking module for transceiver channel 15
  gth1_example_checking_8b10b example_checking_inst15 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_rx_usrclk2_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .gtwiz_userclk_rx_active_in  (hb0_gtwiz_userclk_rx_active_int),
    .rxctrl0_in                  (ch15_rxctrl0_int),
    .rxctrl1_in                  (ch15_rxctrl1_int),
    .rxctrl2_in                  (ch15_rxctrl2_int),
    .rxctrl3_in                  (ch15_rxctrl3_int),
    .rxdata_in                   (hb15_gtwiz_userdata_rx_int),
    .prbs_match_out              (prbs_match_int[15])
  );

  // PRBS-based data checking module for transceiver channel 16
  gth1_example_checking_8b10b example_checking_inst16 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_rx_usrclk2_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .gtwiz_userclk_rx_active_in  (hb0_gtwiz_userclk_rx_active_int),
    .rxctrl0_in                  (ch16_rxctrl0_int),
    .rxctrl1_in                  (ch16_rxctrl1_int),
    .rxctrl2_in                  (ch16_rxctrl2_int),
    .rxctrl3_in                  (ch16_rxctrl3_int),
    .rxdata_in                   (hb16_gtwiz_userdata_rx_int),
    .prbs_match_out              (prbs_match_int[16])
  );

  // PRBS-based data checking module for transceiver channel 17
  gth1_example_checking_8b10b example_checking_inst17 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_rx_usrclk2_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .gtwiz_userclk_rx_active_in  (hb0_gtwiz_userclk_rx_active_int),
    .rxctrl0_in                  (ch17_rxctrl0_int),
    .rxctrl1_in                  (ch17_rxctrl1_int),
    .rxctrl2_in                  (ch17_rxctrl2_int),
    .rxctrl3_in                  (ch17_rxctrl3_int),
    .rxdata_in                   (hb17_gtwiz_userdata_rx_int),
    .prbs_match_out              (prbs_match_int[17])
  );

  // PRBS-based data checking module for transceiver channel 18
  gth1_example_checking_8b10b example_checking_inst18 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_rx_usrclk2_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .gtwiz_userclk_rx_active_in  (hb0_gtwiz_userclk_rx_active_int),
    .rxctrl0_in                  (ch18_rxctrl0_int),
    .rxctrl1_in                  (ch18_rxctrl1_int),
    .rxctrl2_in                  (ch18_rxctrl2_int),
    .rxctrl3_in                  (ch18_rxctrl3_int),
    .rxdata_in                   (hb18_gtwiz_userdata_rx_int),
    .prbs_match_out              (prbs_match_int[18])
  );

  // PRBS-based data checking module for transceiver channel 19
  gth1_example_checking_8b10b example_checking_inst19 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_rx_usrclk2_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .gtwiz_userclk_rx_active_in  (hb0_gtwiz_userclk_rx_active_int),
    .rxctrl0_in                  (ch19_rxctrl0_int),
    .rxctrl1_in                  (ch19_rxctrl1_int),
    .rxctrl2_in                  (ch19_rxctrl2_int),
    .rxctrl3_in                  (ch19_rxctrl3_int),
    .rxdata_in                   (hb19_gtwiz_userdata_rx_int),
    .prbs_match_out              (prbs_match_int[19])
  );

  // PRBS match and related link management
  // -------------------------------------------------------------------------------------------------------------------

  // Perform a bitwise NAND of all PRBS match indicators, creating a combinatorial indication of any PRBS mismatch
  // across all transceiver channels
  wire prbs_error_any_async = ~(&prbs_match_int);
  wire prbs_error_any_sync;

  // Synchronize the PRBS mismatch indicator the free-running clock domain, using a reset synchronizer with asynchronous
  // reset and synchronous removal
  (* DONT_TOUCH = "TRUE" *)
  gth1_example_reset_synchronizer reset_synchronizer_prbs_match_all_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .rst_in (prbs_error_any_async),
    .rst_out(prbs_error_any_sync)
  );

  // Implement an example link status state machine using a simple leaky bucket mechanism. The link status indicates
  // the continual PRBS match status to both the top-level observer and the initialization state machine, while being
  // tolerant of occasional bit errors. This is an example and can be modified as necessary.
  localparam ST_LINK_DOWN = 1'b0;
  localparam ST_LINK_UP   = 1'b1;
  reg        sm_link      = ST_LINK_DOWN;
  reg [6:0]  link_ctr     = 7'd0;

  always @(posedge hb_gtwiz_reset_clk_freerun_buf_int) begin
    case (sm_link)
      // The link is considered to be down when the link counter initially has a value less than 67. When the link is
      // down, the counter is incremented on each cycle where all PRBS bits match, but reset whenever any PRBS mismatch
      // occurs. When the link counter reaches 67, transition to the link up state.
      ST_LINK_DOWN: begin
        if (prbs_error_any_sync !== 1'b0) begin
          link_ctr <= 7'd0;
        end
        else begin
          if (link_ctr < 7'd67)
            link_ctr <= link_ctr + 7'd1;
          else
            sm_link <= ST_LINK_UP;
        end
      end

      // When the link is up, the link counter is decreased by 34 whenever any PRBS mismatch occurs, but is increased by
      // only 1 on each cycle where all PRBS bits match, up to its saturation point of 67. If the link counter reaches
      // 0 (including rollover protection), transition to the link down state.
      ST_LINK_UP: begin
        if (prbs_error_any_sync !== 1'b0) begin
          if (link_ctr > 7'd33) begin
            link_ctr <= link_ctr - 7'd34;
            if (link_ctr == 7'd34)
              sm_link  <= ST_LINK_DOWN;
          end
          else begin
            link_ctr <= 7'd0;
            sm_link  <= ST_LINK_DOWN;
          end
        end
        else begin
          if (link_ctr < 7'd67)
            link_ctr <= link_ctr + 7'd1;
        end
      end
    endcase
  end

  // Synchronize the latched link down reset input and the VIO-driven signal into the free-running clock domain
  wire link_down_latched_reset_vio_int;
  wire link_down_latched_reset_sync;

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_link_down_latched_reset_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (link_down_latched_reset_in || link_down_latched_reset_vio_int),
    .o_out  (link_down_latched_reset_sync)
  );

  // Reset the latched link down indicator when the synchronized latched link down reset signal is high. Otherwise, set
  // the latched link down indicator upon losing link. This indicator is available for user reference.
  always @(posedge hb_gtwiz_reset_clk_freerun_buf_int) begin
    if (link_down_latched_reset_sync)
      link_down_latched_out <= 1'b0;
    else if (!sm_link)
      link_down_latched_out <= 1'b1;
  end

  // Assign the link status indicator to the top-level two-state output for user reference
  assign link_status_out = sm_link;


  // ===================================================================================================================
  // INITIALIZATION
  // ===================================================================================================================

  // Declare the receiver reset signals that interface to the reset controller helper block. For this configuration,
  // which uses different PLL types for transmitter and receiver, the "reset RX datapath" feature is not used.
  wire hb_gtwiz_reset_rx_pll_and_datapath_int;
  wire hb_gtwiz_reset_rx_datapath_int = 1'b0;

  // Declare signals which connect the VIO instance to the initialization module for debug purposes
  wire       init_done_int;
  wire [3:0] init_retry_ctr_int;

  // Combine the receiver reset signals form the initialization module and the VIO to drive the appropriate reset
  // controller helper block reset input
  wire hb_gtwiz_reset_rx_pll_and_datapath_vio_int;
  wire hb_gtwiz_reset_rx_datapath_vio_int;
  wire hb_gtwiz_reset_rx_pll_and_datapath_init_int;

  assign hb_gtwiz_reset_rx_pll_and_datapath_int = hb_gtwiz_reset_rx_pll_and_datapath_init_int || hb_gtwiz_reset_rx_pll_and_datapath_vio_int;

  // The example initialization module interacts with the reset controller helper block and other example design logic
  // to retry failed reset attempts in order to mitigate bring-up issues such as initially-unavilable reference clocks
  // or data connections. It also resets the receiver in the event of link loss in an attempt to regain link, so please
  // note the possibility that this behavior can have the effect of overriding or disturbing user-provided inputs that
  // destabilize the data stream. It is a demonstration only and can be modified to suit your system needs.
  gth1_example_init example_init_inst (
    .clk_freerun_in  (hb_gtwiz_reset_clk_freerun_buf_int),
    .reset_all_in    (hb_gtwiz_reset_all_int),
    .tx_init_done_in (gtwiz_reset_tx_done_int),
    .rx_init_done_in (gtwiz_reset_rx_done_int),
    .rx_data_good_in (sm_link),
    .reset_all_out   (hb_gtwiz_reset_all_init_int),
    .reset_rx_out    (hb_gtwiz_reset_rx_pll_and_datapath_init_int),
    .init_done_out   (init_done_int),
    .retry_ctr_out   (init_retry_ctr_int)
  );


  // ===================================================================================================================
  // VIO FOR HARDWARE BRING-UP AND DEBUG
  // ===================================================================================================================

  // Synchronize txpmaresetdone into the free-running clock domain for VIO usage
  wire [19:0] txpmaresetdone_vio_sync;

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_txpmaresetdone_0_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (txpmaresetdone_int[0]),
    .o_out  (txpmaresetdone_vio_sync[0])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_txpmaresetdone_1_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (txpmaresetdone_int[1]),
    .o_out  (txpmaresetdone_vio_sync[1])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_txpmaresetdone_2_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (txpmaresetdone_int[2]),
    .o_out  (txpmaresetdone_vio_sync[2])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_txpmaresetdone_3_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (txpmaresetdone_int[3]),
    .o_out  (txpmaresetdone_vio_sync[3])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_txpmaresetdone_4_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (txpmaresetdone_int[4]),
    .o_out  (txpmaresetdone_vio_sync[4])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_txpmaresetdone_5_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (txpmaresetdone_int[5]),
    .o_out  (txpmaresetdone_vio_sync[5])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_txpmaresetdone_6_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (txpmaresetdone_int[6]),
    .o_out  (txpmaresetdone_vio_sync[6])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_txpmaresetdone_7_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (txpmaresetdone_int[7]),
    .o_out  (txpmaresetdone_vio_sync[7])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_txpmaresetdone_8_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (txpmaresetdone_int[8]),
    .o_out  (txpmaresetdone_vio_sync[8])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_txpmaresetdone_9_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (txpmaresetdone_int[9]),
    .o_out  (txpmaresetdone_vio_sync[9])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_txpmaresetdone_10_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (txpmaresetdone_int[10]),
    .o_out  (txpmaresetdone_vio_sync[10])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_txpmaresetdone_11_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (txpmaresetdone_int[11]),
    .o_out  (txpmaresetdone_vio_sync[11])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_txpmaresetdone_12_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (txpmaresetdone_int[12]),
    .o_out  (txpmaresetdone_vio_sync[12])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_txpmaresetdone_13_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (txpmaresetdone_int[13]),
    .o_out  (txpmaresetdone_vio_sync[13])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_txpmaresetdone_14_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (txpmaresetdone_int[14]),
    .o_out  (txpmaresetdone_vio_sync[14])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_txpmaresetdone_15_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (txpmaresetdone_int[15]),
    .o_out  (txpmaresetdone_vio_sync[15])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_txpmaresetdone_16_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (txpmaresetdone_int[16]),
    .o_out  (txpmaresetdone_vio_sync[16])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_txpmaresetdone_17_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (txpmaresetdone_int[17]),
    .o_out  (txpmaresetdone_vio_sync[17])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_txpmaresetdone_18_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (txpmaresetdone_int[18]),
    .o_out  (txpmaresetdone_vio_sync[18])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_txpmaresetdone_19_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (txpmaresetdone_int[19]),
    .o_out  (txpmaresetdone_vio_sync[19])
  );

  // Synchronize rxpmaresetdone into the free-running clock domain for VIO usage
  wire [19:0] rxpmaresetdone_vio_sync;

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_rxpmaresetdone_0_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxpmaresetdone_int[0]),
    .o_out  (rxpmaresetdone_vio_sync[0])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_rxpmaresetdone_1_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxpmaresetdone_int[1]),
    .o_out  (rxpmaresetdone_vio_sync[1])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_rxpmaresetdone_2_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxpmaresetdone_int[2]),
    .o_out  (rxpmaresetdone_vio_sync[2])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_rxpmaresetdone_3_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxpmaresetdone_int[3]),
    .o_out  (rxpmaresetdone_vio_sync[3])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_rxpmaresetdone_4_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxpmaresetdone_int[4]),
    .o_out  (rxpmaresetdone_vio_sync[4])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_rxpmaresetdone_5_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxpmaresetdone_int[5]),
    .o_out  (rxpmaresetdone_vio_sync[5])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_rxpmaresetdone_6_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxpmaresetdone_int[6]),
    .o_out  (rxpmaresetdone_vio_sync[6])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_rxpmaresetdone_7_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxpmaresetdone_int[7]),
    .o_out  (rxpmaresetdone_vio_sync[7])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_rxpmaresetdone_8_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxpmaresetdone_int[8]),
    .o_out  (rxpmaresetdone_vio_sync[8])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_rxpmaresetdone_9_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxpmaresetdone_int[9]),
    .o_out  (rxpmaresetdone_vio_sync[9])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_rxpmaresetdone_10_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxpmaresetdone_int[10]),
    .o_out  (rxpmaresetdone_vio_sync[10])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_rxpmaresetdone_11_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxpmaresetdone_int[11]),
    .o_out  (rxpmaresetdone_vio_sync[11])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_rxpmaresetdone_12_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxpmaresetdone_int[12]),
    .o_out  (rxpmaresetdone_vio_sync[12])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_rxpmaresetdone_13_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxpmaresetdone_int[13]),
    .o_out  (rxpmaresetdone_vio_sync[13])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_rxpmaresetdone_14_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxpmaresetdone_int[14]),
    .o_out  (rxpmaresetdone_vio_sync[14])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_rxpmaresetdone_15_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxpmaresetdone_int[15]),
    .o_out  (rxpmaresetdone_vio_sync[15])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_rxpmaresetdone_16_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxpmaresetdone_int[16]),
    .o_out  (rxpmaresetdone_vio_sync[16])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_rxpmaresetdone_17_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxpmaresetdone_int[17]),
    .o_out  (rxpmaresetdone_vio_sync[17])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_rxpmaresetdone_18_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxpmaresetdone_int[18]),
    .o_out  (rxpmaresetdone_vio_sync[18])
  );

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_rxpmaresetdone_19_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxpmaresetdone_int[19]),
    .o_out  (rxpmaresetdone_vio_sync[19])
  );

  // Synchronize gtwiz_reset_tx_done into the free-running clock domain for VIO usage
  wire [0:0] gtwiz_reset_tx_done_vio_sync;

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_gtwiz_reset_tx_done_0_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (gtwiz_reset_tx_done_int[0]),
    .o_out  (gtwiz_reset_tx_done_vio_sync[0])
  );

  // Synchronize gtwiz_reset_rx_done into the free-running clock domain for VIO usage
  wire [0:0] gtwiz_reset_rx_done_vio_sync;

  (* DONT_TOUCH = "TRUE" *)
  gth1_example_bit_synchronizer bit_synchronizer_vio_gtwiz_reset_rx_done_0_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (gtwiz_reset_rx_done_int[0]),
    .o_out  (gtwiz_reset_rx_done_vio_sync[0])
  );


  // Instantiate the VIO IP core for hardware bring-up and debug purposes, connecting relevant debug and analysis
  // signals which have been enabled during Wizard IP customization. This initial set of connected signals is
  // provided as a convenience and example, but more or fewer ports can be used as needed; simply re-customize and
  // re-generate the VIO instance, then connect any exposed signals that are needed. Signals which are synchronous to
  // clocks other than the free-running clock will require synchronization. For usage, refer to Vivado Design Suite
  // User Guide: Programming and Debugging (UG908)
  gth1_vio_0 gth1_vio_0_inst (
    .clk (hb_gtwiz_reset_clk_freerun_buf_int)
    ,.probe_in0 (link_status_out)
    ,.probe_in1 (link_down_latched_out)
    ,.probe_in2 (init_done_int)
    ,.probe_in3 (init_retry_ctr_int)
    ,.probe_in4 (txpmaresetdone_vio_sync)
    ,.probe_in5 (rxpmaresetdone_vio_sync)
    ,.probe_in6 (gtwiz_reset_tx_done_vio_sync)
    ,.probe_in7 (gtwiz_reset_rx_done_vio_sync)
    ,.probe_out0 (hb_gtwiz_reset_all_vio_int)
    ,.probe_out1 (hb0_gtwiz_reset_tx_pll_and_datapath_int)
    ,.probe_out2 (hb0_gtwiz_reset_tx_datapath_int)
    ,.probe_out3 (hb_gtwiz_reset_rx_pll_and_datapath_vio_int)
    ,.probe_out4 (hb_gtwiz_reset_rx_datapath_vio_int)
    ,.probe_out5 (link_down_latched_reset_vio_int)
  );


  // ===================================================================================================================
  // EXAMPLE WRAPPER INSTANCE
  // ===================================================================================================================

  // Instantiate the example design wrapper, mapping its enabled ports to per-channel internal signals and example
  // resources as appropriate
  gth1_example_wrapper example_wrapper_inst (
    .gthrxn_in                               (gthrxn_int)
   ,.gthrxp_in                               (gthrxp_int)
   ,.gthtxn_out                              (gthtxn_int)
   ,.gthtxp_out                              (gthtxp_int)
   ,.gtwiz_userclk_tx_reset_in               (gtwiz_userclk_tx_reset_int)
   ,.gtwiz_userclk_tx_srcclk_out             (gtwiz_userclk_tx_srcclk_int)
   ,.gtwiz_userclk_tx_usrclk_out             (gtwiz_userclk_tx_usrclk_int)
   ,.gtwiz_userclk_tx_usrclk2_out            (gtwiz_userclk_tx_usrclk2_int)
   ,.gtwiz_userclk_tx_active_out             (gtwiz_userclk_tx_active_int)
   ,.gtwiz_userclk_rx_reset_in               (gtwiz_userclk_rx_reset_int)
   ,.gtwiz_userclk_rx_srcclk_out             (gtwiz_userclk_rx_srcclk_int)
   ,.gtwiz_userclk_rx_usrclk_out             (gtwiz_userclk_rx_usrclk_int)
   ,.gtwiz_userclk_rx_usrclk2_out            (gtwiz_userclk_rx_usrclk2_int)
   ,.gtwiz_userclk_rx_active_out             (gtwiz_userclk_rx_active_int)
   ,.gtwiz_reset_clk_freerun_in              ({1{hb_gtwiz_reset_clk_freerun_buf_int}})
   ,.gtwiz_reset_all_in                      ({1{hb_gtwiz_reset_all_int}})
   ,.gtwiz_reset_tx_pll_and_datapath_in      (gtwiz_reset_tx_pll_and_datapath_int)
   ,.gtwiz_reset_tx_datapath_in              (gtwiz_reset_tx_datapath_int)
   ,.gtwiz_reset_rx_pll_and_datapath_in      ({1{hb_gtwiz_reset_rx_pll_and_datapath_int}})
   ,.gtwiz_reset_rx_datapath_in              ({1{hb_gtwiz_reset_rx_datapath_int}})
   ,.gtwiz_reset_rx_cdr_stable_out           (gtwiz_reset_rx_cdr_stable_int)
   ,.gtwiz_reset_tx_done_out                 (gtwiz_reset_tx_done_int)
   ,.gtwiz_reset_rx_done_out                 (gtwiz_reset_rx_done_int)
   ,.gtwiz_userdata_tx_in                    (gtwiz_userdata_tx_int)
   ,.gtwiz_userdata_rx_out                   (gtwiz_userdata_rx_int)
   ,.gtrefclk01_in                           (gtrefclk01_int)
   ,.qpll1outclk_out                         (qpll1outclk_int)
   ,.qpll1outrefclk_out                      (qpll1outrefclk_int)
   ,.drpclk_in                               (drpclk_int)
   ,.gtrefclk0_in                            (gtrefclk0_int)
   ,.rx8b10ben_in                            (rx8b10ben_int)
   ,.tx8b10ben_in                            (tx8b10ben_int)
   ,.txctrl0_in                              (txctrl0_int)
   ,.txctrl1_in                              (txctrl1_int)
   ,.txctrl2_in                              (txctrl2_int)
   ,.rxctrl0_out                             (rxctrl0_int)
   ,.rxctrl1_out                             (rxctrl1_int)
   ,.rxctrl2_out                             (rxctrl2_int)
   ,.rxctrl3_out                             (rxctrl3_int)
   ,.rxpmaresetdone_out                      (rxpmaresetdone_int)
   ,.txpmaresetdone_out                      (txpmaresetdone_int)
);


endmodule
