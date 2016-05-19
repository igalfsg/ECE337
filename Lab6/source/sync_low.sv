// $Id: $
// File name:   sync_low.sv
// Created:     1/26/2016
// Author:      Igal Flegmann Sandler
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: dflkasj.
module sync_low
(
	input wire clk,
	input wire n_rst,
	input wire async_in,
	output reg sync_out
);
reg flip;

always_ff @ (posedge clk, negedge n_rst)
begin  
if(1'b0 == n_rst)
begin
 flip <= 0;
 sync_out <=0;
end
else
 begin
 flip <= async_in;
sync_out <= flip;
end
end
endmodule
	