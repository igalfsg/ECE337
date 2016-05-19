// $Id: $
// File name:   edge_detect.sv
// Created:     2/21/2016
// Author:      Igal Flegmann Sandler
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: ytolo
module edge_detect(
input wire clk,
input wire n_rst,
input wire d_plus,
output reg d_edge);

reg igalito;
always_ff @(posedge clk, negedge n_rst)
begin
	
	if(1'b0 == n_rst)
	begin
		d_edge <= 0;
		igalito <= 1;
	end	
	else
	begin
		igalito <= d_plus;
		d_edge <= d_plus ^ igalito;
	end

end


endmodule	
