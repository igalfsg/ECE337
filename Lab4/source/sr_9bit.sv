// $Id: $
// File name:   sr_9bit.sv
// Created:     2/9/2016
// Author:      Igal Flegmann Sandler
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: sr stuff
module sr_9bit(
input wire clk,
input wire n_rst,
input wire shift_strobe,
input wire serial_in,
output wire [7:0]packet_data,
output wire stop_bit);

wire [8:0]temp;

flex_stp_sr #(9,0) cambios (.clk(clk), .n_rst(n_rst), .shift_enable(shift_strobe), .serial_in(serial_in), .parallel_out(temp));
assign packet_data = temp[7:0];
assign stop_bit = temp[8];

endmodule

