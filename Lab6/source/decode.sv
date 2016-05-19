// $Id: $
// File name:   decode.sv
// Created:     2/21/2016
// Author:      Igal Flegmann Sandler
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: yo
module decode(
input wire clk,
input wire n_rst,
input wire d_plus,
input wire shift_enable,
input wire eop,
output wire d_orig);

reg outputstuff;
reg storedff;
reg nextout;
   
always_ff @(posedge clk, negedge n_rst)
begin
	if(1'b0 == n_rst)
	begin
		outputstuff <= 1;
		storedff <= 1;
	end
	else
	begin
	   outputstuff <= nextout;

	   storedff <= d_plus;
	   
	end
end

always_comb
begin
	if (shift_enable == 1 && eop == 1)
	  begin   
	     nextout = 1;
	  end
	else if (shift_enable == 1 && eop == 0)
	  begin
	     nextout =  d_plus;
	  end
	else
	  begin
	     nextout = outputstuff;
	  end
end // always_comb begin
   

assign d_orig = outputstuff == storedff;
endmodule 