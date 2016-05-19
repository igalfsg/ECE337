// $Id: $
// File name:   timer.sv
// Created:     2/6/2016
// Author:      Igal Flegmann Sandler
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: timer
module timer(
input wire clk,
input wire n_rst,
input wire enable_timer,
output wire shift_strobe,
output wire packet_done);


reg q;

always_ff @ (posedge clk, negedge n_rst)
begin  
if(n_rst == 0)
q <= 0;
else
q <= enable_timer;
end

flex_counter #(4) nom (.clk(clk), .n_rst(n_rst), .count_enable(q), .clear(packet_done), .rollover_val(4'b1010), .rollover_flag(shift_strobe));
flex_counter #(4) nomnom (.clk(clk), .n_rst(n_rst), .count_enable(shift_strobe), .clear(packet_done), .rollover_val(4'b1001), .rollover_flag(packet_done));//might be 9

endmodule
