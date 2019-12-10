# ******** PRBS -- Selection **********#
set_property TX_PATTERN {PRBS 31-bit} [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
set_property RX_PATTERN {PRBS 31-bit} [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
# ***********************************************
# Time of wait, depends of the Bandwidth 
#*****************************************
set gbt_time 80000
set PATH z:/pics/CTP_Board_IBERT/PROTO_2/Test_2/Data_eyescan10Gbps
 for {set i 0} {$i < 4} {incr i} {  
      if {$i == 0} {
      set a  0  
      set_property TXDIFFSWING {840 mV (1010)} [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      after 1000 
      set_property TXDIFFSWING {840 mV (1010)} [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      # ============= Reset procedure ================# 
      set_property LOGIC.TX_RESET_DATAPATH 1 [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      set_property LOGIC.TX_RESET_DATAPATH 0 [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      set_property LOGIC.RX_RESET_DATAPATH 1 [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      # ======================================================# 
      after 10000 
      } elseif {$i == 2} { 
      set a 40 
      set_property TXDIFFSWING {660 mV (0111)} [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      after 1000 
      set_property TXDIFFSWING {660 mV (0111)} [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      # ============= Reset procedure ================# 
      set_property LOGIC.TX_RESET_DATAPATH 1 [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      set_property LOGIC.TX_RESET_DATAPATH 0 [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      set_property LOGIC.RX_RESET_DATAPATH 1 [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      set_property LOGIC.RX_RESET_DATAPATH 0 [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      set_property LOGIC.MGT_ERRCNT_RESET_CTRL 1 [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      set_property LOGIC.MGT_ERRCNT_RESET_CTRL 0 [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      # ======================================================# 
      after 10000 
      } elseif {$i == 3} {
      set a 60
      set_property TXDIFFSWING {390 mV (0011)} [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      after 1000 
      set_property TXDIFFSWING {390 mV (0011)} [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      # ============= Reset procedure ================# 
      set_property LOGIC.TX_RESET_DATAPATH 1 [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      set_property LOGIC.TX_RESET_DATAPATH 0 [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      set_property LOGIC.RX_RESET_DATAPATH 1 [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      set_property LOGIC.RX_RESET_DATAPATH 0 [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      set_property LOGIC.MGT_ERRCNT_RESET_CTRL 1 [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      set_property LOGIC.MGT_ERRCNT_RESET_CTRL 0 [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      commit_hw_sio [get_hw_sio_links -of_objects [get_hw_sio_linkgroups {LINKGROUP_0}]]
      # ======================================================# 
      after 10000 
      }
     set  file_scan  SCAN_$a 
     set xil_newScan [create_hw_sio_scan -description $file_scan 2d_full_eye [lindex [get_hw_sio_links localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_224/MGT_X0Y0/TX->localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_224/MGT_X0Y2/RX] 0 ]]
     set_property DWELL_BER 1e-9 [get_hw_sio_scans $xil_newScan]
     run_hw_sio_scan [get_hw_sio_scans $xil_newScan]
     after $gbt_time
     write_hw_sio_scan -force $PATH/$file_scan.csv [get_hw_sio_scans $file_scan]
     
     set file_scan SCAN_[expr {$a + 1}]
     set xil_newScan [create_hw_sio_scan -description $file_scan 2d_full_eye [lindex [get_hw_sio_links localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_224/MGT_X0Y1/TX->localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_224/MGT_X0Y3/RX] 0 ]]
     set_property DWELL_BER 1e-9 [get_hw_sio_scans $xil_newScan]
     run_hw_sio_scan [get_hw_sio_scans $xil_newScan]
     after $gbt_time
     write_hw_sio_scan -force $PATH/$file_scan.csv [get_hw_sio_scans $file_scan] 
     
     set file_scan SCAN_[expr {$a + 2}]
     set xil_newScan [create_hw_sio_scan -description $file_scan 2d_full_eye [lindex [get_hw_sio_links localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_224/MGT_X0Y2/TX->localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_224/MGT_X0Y0/RX] 0 ]]
     set_property DWELL_BER 1e-9 [get_hw_sio_scans $xil_newScan]
     run_hw_sio_scan [get_hw_sio_scans $xil_newScan]
     after $gbt_time
     write_hw_sio_scan -force $PATH/$file_scan.csv [get_hw_sio_scans $file_scan] 
  
     set file_scan SCAN_[expr {$a + 3}]
     set xil_newScan [create_hw_sio_scan -description $file_scan 2d_full_eye [lindex [get_hw_sio_links localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_224/MGT_X0Y3/TX->localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_224/MGT_X0Y1/RX] 0 ]]
     set_property DWELL_BER 1e-9 [get_hw_sio_scans $xil_newScan]
     run_hw_sio_scan [get_hw_sio_scans $xil_newScan]
     after $gbt_time
     write_hw_sio_scan -force $PATH/$file_scan.csv [get_hw_sio_scans $file_scan] 
     
     set file_scan SCAN_[expr {$a + 4}]
     set xil_newScan [create_hw_sio_scan -description $file_scan 2d_full_eye [lindex [get_hw_sio_links localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_225/MGT_X0Y4/TX->localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_225/MGT_X0Y6/RX] 0 ]]
     set_property DWELL_BER 1e-9 [get_hw_sio_scans $xil_newScan]
     run_hw_sio_scan [get_hw_sio_scans $xil_newScan]
     after $gbt_time
     write_hw_sio_scan -force $PATH/$file_scan.csv [get_hw_sio_scans $file_scan] 
     
     set file_scan SCAN_[expr {$a + 5}]
     set xil_newScan [create_hw_sio_scan -description $file_scan 2d_full_eye [lindex [get_hw_sio_links localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_225/MGT_X0Y5/TX->localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_225/MGT_X0Y7/RX] 0 ]]
     set_property DWELL_BER 1e-9 [get_hw_sio_scans $xil_newScan]
     run_hw_sio_scan [get_hw_sio_scans $xil_newScan]
     after $gbt_time
     write_hw_sio_scan -force $PATH/$file_scan.csv [get_hw_sio_scans $file_scan] 
     
     set file_scan SCAN_[expr {$a + 6}]
     set xil_newScan [create_hw_sio_scan -description $file_scan 2d_full_eye [lindex [get_hw_sio_links localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_225/MGT_X0Y6/TX->localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_225/MGT_X0Y4/RX] 0 ]]
     set_property DWELL_BER 1e-9 [get_hw_sio_scans $xil_newScan]
     run_hw_sio_scan [get_hw_sio_scans $xil_newScan]
     after $gbt_time
     write_hw_sio_scan -force $PATH/$file_scan.csv [get_hw_sio_scans $file_scan] 
     
     set file_scan SCAN_[expr {$a + 7}]
     set xil_newScan [create_hw_sio_scan -description $file_scan 2d_full_eye [lindex [get_hw_sio_links localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_225/MGT_X0Y7/TX->localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_225/MGT_X0Y5/RX] 0 ]]
     set_property DWELL_BER 1e-9 [get_hw_sio_scans $xil_newScan]
     run_hw_sio_scan [get_hw_sio_scans $xil_newScan]
     after $gbt_time
     write_hw_sio_scan -force $PATH/$file_scan.csv [get_hw_sio_scans $file_scan] 
     
     set file_scan SCAN_[expr {$a + 8}]
     set xil_newScan [create_hw_sio_scan -description $file_scan 2d_full_eye [lindex [get_hw_sio_links localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_226/MGT_X0Y8/TX->localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_226/MGT_X0Y10/RX] 0 ]]
     set_property DWELL_BER 1e-9 [get_hw_sio_scans $xil_newScan]
     run_hw_sio_scan [get_hw_sio_scans $xil_newScan]
     after $gbt_time
     write_hw_sio_scan -force $PATH/$file_scan.csv [get_hw_sio_scans $file_scan] 
     
     set file_scan SCAN_[expr {$a + 9}]
     set xil_newScan [create_hw_sio_scan -description $file_scan 2d_full_eye [lindex [get_hw_sio_links localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_226/MGT_X0Y9/TX->localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_226/MGT_X0Y11/RX] 0 ]]
     set_property DWELL_BER 1e-9 [get_hw_sio_scans $xil_newScan]
     run_hw_sio_scan [get_hw_sio_scans $xil_newScan]
     after $gbt_time
     write_hw_sio_scan -force $PATH/$file_scan.csv [get_hw_sio_scans $file_scan] 
     
     set file_scan SCAN_[expr {$a + 10}]
     set xil_newScan [create_hw_sio_scan -description $file_scan 2d_full_eye [lindex [get_hw_sio_links localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_226/MGT_X0Y10/TX->localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_226/MGT_X0Y8/RX] 0 ]]
     set_property DWELL_BER 1e-9 [get_hw_sio_scans $xil_newScan]
     run_hw_sio_scan [get_hw_sio_scans $xil_newScan]
     after $gbt_time
     write_hw_sio_scan -force $PATH/$file_scan.csv [get_hw_sio_scans $file_scan] 
     
     set file_scan SCAN_[expr {$a + 11}]
     set xil_newScan [create_hw_sio_scan -description $file_scan 2d_full_eye [lindex [get_hw_sio_links localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_226/MGT_X0Y11/TX->localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_226/MGT_X0Y9/RX] 0 ]]
     set_property DWELL_BER 1e-9 [get_hw_sio_scans $xil_newScan]
     run_hw_sio_scan [get_hw_sio_scans $xil_newScan]
     after $gbt_time
     write_hw_sio_scan -force $PATH/$file_scan.csv [get_hw_sio_scans $file_scan] 
     
     set file_scan SCAN_[expr {$a + 12}]
     set xil_newScan [create_hw_sio_scan -description $file_scan 2d_full_eye [lindex [get_hw_sio_links localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_227/MGT_X0Y12/TX->localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_227/MGT_X0Y13/RX] 0 ]]
     set_property DWELL_BER 1e-9 [get_hw_sio_scans $xil_newScan]
     run_hw_sio_scan [get_hw_sio_scans $xil_newScan]
     after $gbt_time
     write_hw_sio_scan -force $PATH/$file_scan.csv [get_hw_sio_scans $file_scan] 
     
     set file_scan SCAN_[expr {$a + 13}]
     set xil_newScan [create_hw_sio_scan -description $file_scan 2d_full_eye [lindex [get_hw_sio_links localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_227/MGT_X0Y13/TX->localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_227/MGT_X0Y12/RX] 0 ]]
     set_property DWELL_BER 1e-9 [get_hw_sio_scans $xil_newScan]
     run_hw_sio_scan [get_hw_sio_scans $xil_newScan]
     after $gbt_time
     write_hw_sio_scan -force $PATH/$file_scan.csv [get_hw_sio_scans $file_scan] 
     
     set file_scan SCAN_[expr {$a + 14}]
     set xil_newScan [create_hw_sio_scan -description $file_scan 2d_full_eye [lindex [get_hw_sio_links localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_227/MGT_X0Y14/TX->localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_227/MGT_X0Y15/RX] 0 ]]
     set_property DWELL_BER 1e-9 [get_hw_sio_scans $xil_newScan]
     run_hw_sio_scan [get_hw_sio_scans $xil_newScan]
     after $gbt_time
     write_hw_sio_scan -force $PATH/$file_scan.csv [get_hw_sio_scans $file_scan] 
     
     set file_scan SCAN_[expr {$a + 15}]
     set xil_newScan [create_hw_sio_scan -description $file_scan 2d_full_eye [lindex [get_hw_sio_links localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_227/MGT_X0Y15/TX->localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_227/MGT_X0Y14/RX] 0 ]]
     set_property DWELL_BER 1e-9 [get_hw_sio_scans $xil_newScan]
     run_hw_sio_scan [get_hw_sio_scans $xil_newScan]
     after $gbt_time
     write_hw_sio_scan -force $PATH/$file_scan.csv [get_hw_sio_scans $file_scan] 
     
     set file_scan SCAN_[expr {$a + 16}]
     set xil_newScan [create_hw_sio_scan -description $file_scan 2d_full_eye [lindex [get_hw_sio_links localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_228/MGT_X0Y16/TX->localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_228/MGT_X0Y17/RX] 0 ]]
     set_property DWELL_BER 1e-9 [get_hw_sio_scans $xil_newScan]
     run_hw_sio_scan [get_hw_sio_scans $xil_newScan]
     after $gbt_time
     write_hw_sio_scan -force $PATH/$file_scan.csv [get_hw_sio_scans $file_scan] 
     
     set file_scan SCAN_[expr {$a + 17}]
     set xil_newScan [create_hw_sio_scan -description $file_scan 2d_full_eye [lindex [get_hw_sio_links localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_228/MGT_X0Y17/TX->localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_228/MGT_X0Y16/RX] 0 ]]
     set_property DWELL_BER 1e-9 [get_hw_sio_scans $xil_newScan]
     run_hw_sio_scan [get_hw_sio_scans $xil_newScan]
     after $gbt_time
     write_hw_sio_scan -force $PATH/$file_scan.csv [get_hw_sio_scans $file_scan] 
     
     set file_scan SCAN_[expr {$a + 18}]
     set xil_newScan [create_hw_sio_scan -description $file_scan 2d_full_eye [lindex [get_hw_sio_links localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_228/MGT_X0Y18/TX->localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_228/MGT_X0Y19/RX] 0 ]]
     set_property DWELL_BER 1e-9 [get_hw_sio_scans $xil_newScan]
     run_hw_sio_scan [get_hw_sio_scans $xil_newScan]
     after $gbt_time
     write_hw_sio_scan -force $PATH/$file_scan.csv [get_hw_sio_scans $file_scan] 
     
     set file_scan SCAN_[expr {$a + 19}]
     set xil_newScan [create_hw_sio_scan -description $file_scan 2d_full_eye [lindex [get_hw_sio_links localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_228/MGT_X0Y19/TX->localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_228/MGT_X0Y18/RX] 0 ]]
     set_property DWELL_BER 1e-9 [get_hw_sio_scans $xil_newScan]
     run_hw_sio_scan [get_hw_sio_scans $xil_newScan]
     after $gbt_time
     write_hw_sio_scan -force $PATH/$file_scan.csv [get_hw_sio_scans $file_scan] 
      after $gbt_time
     
  } 
  
        