// $Id: $
// File name:   usb_receiver.sv
// Created:     2/25/2016
// Author:      Igal Flegmann Sandler
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: yolo

module usb_receiver (
		     input wire        clk,
		     input wire        n_rst,
		     input wire        d_plus,
		     input wire        d_minus,
		     input wire        r_enable,
		     output logic       [7:0]r_data,
		     output logic       empty,
		     output logic      full,
		     output logic       rcving,
		     output logic       r_error);

   reg 				       eop;//
   reg 				       d_orig;//
   reg 				       d_edge;//
   reg 				       byte_received;//
   reg [7:0] 			       rcv_data;//
   reg 				       w_enable;//
   reg 				       dhigh;//
   reg 				       dlow;//
   reg 				       shift_enable;//
 				       

   sync_high highstuff (.clk(clk), .n_rst(n_rst), .async_in(d_plus), .sync_out(dhigh));
   sync_low lows (.clk(clk), .n_rst(n_rst), .async_in(d_minus), .sync_out(dlow));

   decode dec (.clk(clk), .n_rst(n_rst), .d_plus(dhigh), .shift_enable(shift_enable), .eop(eop), .d_orig(d_orig));   
   edge_detect edg (.clk(clk), .n_rst(n_rst), .d_plus(dhigh), .d_edge(d_edge));
   timer tim1 (.clk(clk), .n_rst(n_rst), .d_edge(d_edge), .rcving(rcving), .shift_enable(shift_enable), .byte_received(byte_received));
   shift_register sr (.clk(clk), .n_rst(n_rst), .shift_enable(shift_enable), .d_orig(d_orig), .rcv_data(rcv_data));
   rx_fifo rxf (.clk(clk), .n_rst(n_rst), .r_enable(r_enable), .w_enable(w_enable), .w_data(rcv_data), .r_data(r_data), .empty(empty), .full(full));
   eop_detect eop_d (.d_plus(dhigh), .d_minus(dlow), .eop(eop));
   rcu rc (.clk(clk), .n_rst(n_rst), .d_edge(d_edge), .eop(eop), .shift_enable(shift_enable), .rcv_data(rcv_data), .byte_received(byte_received), .rcving(rcving), .w_enable(w_enable), .r_error(r_error));
   
endmodule
