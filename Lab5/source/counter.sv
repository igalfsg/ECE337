// $Id: $
// File name:   counter.sv
// Created:     2/15/2016
// Author:      Igal Flegmann Sandler
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: counter .
module counter
(
	input wire clk,
	input wire n_reset,
	input wire cnt_up,
	input wire clear,
	output wire one_k_samples);
	

	flex_counter #(10) countingstuff(.clk(clk),.n_rst(n_reset), .clear(1'b0), .count_enable(cnt_up), .rollover_val(10'd1000), .rollover_flag(one_k_samples));

endmodule 