// $Id: $
// File name:   fir_filter.sv
// Created:     2/15/2016
// Author:      Igal Flegmann Sandler
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: fir counter
module fir_filter
(
input wire clk,
input wire n_reset,
input wire [15:0] sample_data,
input wire [15:0] fir_coefficient,
input wire data_ready,
input wire load_coeff,
output wire one_k_samples,
output wire modwait,
output wire [15:0] fir_out,
output wire err
);

reg cnt_up;
reg [2:0] op;
reg [16:0] outreg_data;
reg [3:0] src1;
reg [3:0] src2;
reg [3:0] dest; 
reg overflow;
reg clear;
reg dr;
reg lc;

sync S1 (.clk(clk), .n_reset(n_reset), .data_ready(data_ready), .sync_out(dr));
sync S2 (.clk(clk), .n_reset(n_reset), .data_ready(load_coeff), .sync_out(lc));
magnitude M1 (.in(outreg_data), .out(fir_out));
counter C1 (.clk(clk), .n_reset(n_reset), .cnt_up(cnt_up), .clear(clear), .one_k_samples(one_k_samples));
controller C2 (.clk(clk), .n_reset(n_reset), .dr(dr), .lc(lc), .overflow(overflow), .cnt_up(cnt_up), .clear(clear), .modwait(modwait), .op(op), .src1(src1), .src2(src2), .dest(dest), .err(err));
datapath D1 (.clk(clk), .n_reset(n_reset), .op(op), .src1(src1), .src2(src2), .dest(dest), .ext_data1(sample_data), .ext_data2(fir_coefficient), .outreg_data(outreg_data), .overflow(overflow));

endmodule 
