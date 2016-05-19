// $Id: $
// File name:   timer.sv
// Created:     2/25/2016
// Author:      Igal Flegmann Sandler
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: yolo
module timer
(
    input wire clk,
    input wire n_rst,
    input wire d_edge,   
    input wire rcving,
    output logic shift_enable,   
    output logic byte_received
);
    reg [3:0] use_forshift;
    reg tempy;
    reg tempy2;
    reg the_real_stuff;
    always_ff @ (posedge clk, negedge n_rst)
      begin
        if (1'b0 == n_rst)
            begin
            	tempy <= 0;
            	tempy2 <= 0;
           end
        else
            begin
            	tempy<=tempy2;
            	tempy2 <=the_real_stuff;
            end
      end // always_ff @
   



    flex_counter #(4) middleofbits (.clk(clk), .n_rst(n_rst), .count_enable(rcving), .clear(~rcving|d_edge), .rollover_val(4'd8), .count_out(use_forshift));
    flex_counter #(4) numbits (.clk(clk), .n_rst(n_rst), .count_enable(shift_enable), .clear(~rcving), .rollover_val(4'd8), .rollover_flag(the_real_stuff));

    assign shift_enable = (use_forshift == 3);
    assign byte_received = (tempy == 0 && tempy2 == 1);


endmodule // timer

