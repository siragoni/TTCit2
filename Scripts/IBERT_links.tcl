# ================================================================================ #   
# == Comment: This script create 20  MGT links of the  CTP-Board (Prototype  2 ) = # 
# == If you want to use the script  you must verify the  "localhost"            == #
# ================================================================================= #  

set xil_newLink [create_hw_sio_link -description {Link 0} [lindex [get_hw_sio_txs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_224/MGT_X0Y0/TX] 0] [lindex [get_hw_sio_rxs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_224/MGT_X0Y2/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link 1} [lindex [get_hw_sio_txs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_224/MGT_X0Y1/TX] 0] [lindex [get_hw_sio_rxs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_224/MGT_X0Y3/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link 2} [lindex [get_hw_sio_txs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_224/MGT_X0Y2/TX] 0] [lindex [get_hw_sio_rxs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_224/MGT_X0Y0/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link 3} [lindex [get_hw_sio_txs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_224/MGT_X0Y3/TX] 0] [lindex [get_hw_sio_rxs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_224/MGT_X0Y1/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link 4} [lindex [get_hw_sio_txs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_225/MGT_X0Y4/TX] 0] [lindex [get_hw_sio_rxs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_225/MGT_X0Y6/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link 5} [lindex [get_hw_sio_txs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_225/MGT_X0Y5/TX] 0] [lindex [get_hw_sio_rxs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_225/MGT_X0Y7/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link 6} [lindex [get_hw_sio_txs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_225/MGT_X0Y6/TX] 0] [lindex [get_hw_sio_rxs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_225/MGT_X0Y4/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link 7} [lindex [get_hw_sio_txs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_225/MGT_X0Y7/TX] 0] [lindex [get_hw_sio_rxs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_225/MGT_X0Y5/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link 8} [lindex [get_hw_sio_txs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_226/MGT_X0Y8/TX] 0] [lindex [get_hw_sio_rxs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_226/MGT_X0Y10/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link 9} [lindex [get_hw_sio_txs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_226/MGT_X0Y9/TX] 0] [lindex [get_hw_sio_rxs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_226/MGT_X0Y11/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link 10} [lindex [get_hw_sio_txs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_226/MGT_X0Y10/TX] 0] [lindex [get_hw_sio_rxs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_226/MGT_X0Y8/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link 11} [lindex [get_hw_sio_txs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_226/MGT_X0Y11/TX] 0] [lindex [get_hw_sio_rxs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_226/MGT_X0Y9/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link 12} [lindex [get_hw_sio_txs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_227/MGT_X0Y12/TX] 0] [lindex [get_hw_sio_rxs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_227/MGT_X0Y13/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link 13} [lindex [get_hw_sio_txs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_227/MGT_X0Y13/TX] 0] [lindex [get_hw_sio_rxs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_227/MGT_X0Y12/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link 14} [lindex [get_hw_sio_txs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_227/MGT_X0Y14/TX] 0] [lindex [get_hw_sio_rxs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_227/MGT_X0Y15/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link 15} [lindex [get_hw_sio_txs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_227/MGT_X0Y15/TX] 0] [lindex [get_hw_sio_rxs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_227/MGT_X0Y14/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link 16} [lindex [get_hw_sio_txs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_228/MGT_X0Y16/TX] 0] [lindex [get_hw_sio_rxs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_228/MGT_X0Y17/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link 17} [lindex [get_hw_sio_txs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_228/MGT_X0Y17/TX] 0] [lindex [get_hw_sio_rxs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_228/MGT_X0Y16/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link 18} [lindex [get_hw_sio_txs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_228/MGT_X0Y18/TX] 0] [lindex [get_hw_sio_rxs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_228/MGT_X0Y19/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link 19} [lindex [get_hw_sio_txs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_228/MGT_X0Y19/TX] 0] [lindex [get_hw_sio_rxs localhost:3121/xilinx_tcf/Digilent/210251A1BBE3/0_1_2/IBERT/Quad_228/MGT_X0Y18/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLinkGroup [create_hw_sio_linkgroup -description {Link Group 0} [get_hw_sio_links $xil_newLinks]]
unset xil_newLinks
