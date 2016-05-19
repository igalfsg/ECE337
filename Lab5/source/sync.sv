// $Id: $
// File name:   sync.sv
// Created:     2/15/2016
// Author:      Igal Flegmann Sandler
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: sync
module sync
(
	input wire clk,
	input wire n_reset,
	input wire data_ready,
	output reg sync_out
);

reg flip;

always_ff @ (posedge clk, negedge n_reset)
begin  
if(1'b0 == n_reset)
begin
 flip <= 0;
 sync_out <=0;
end
else
 begin
 flip <= data_ready;
sync_out <= flip;
end
end
endmodule
	
