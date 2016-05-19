// $Id: $
// File name:   rx_fifo.sv
// Created:     2/21/2016
// Author:      Igal Flegmann Sandler
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: yolo
module rx_fifo (
input wire clk, 
input wire n_rst,
input wire r_enable,
input wire w_enable,
input wire [7:0]w_data,
output wire [7:0]r_data,
output wire empty,
output wire full);

fifo fifo_stuff (.r_clk(clk), .w_clk(clk), .n_rst(n_rst), .r_enable(r_enable), .w_enable(w_enable), .w_data(w_data), .r_data(r_data), .empty(empty), .full(full));
endmodule