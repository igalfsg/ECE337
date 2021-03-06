// $Id: $
// File name:   magnitude.sv
// Created:     2/15/2016
// Author:      Igal Flegmann Sandler
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: magnitude .
module magnitude
(
input wire [16:0] in,
output wire [15:0] out
);

reg [15:0]temp;


always_comb
begin
	if (in[16] == 1'b1)
	begin
		temp = in[15:0] ^ '1;//make sure this is legal
		temp = temp +1;
	end
	else
	begin
		temp = in[15:0];
	end
end

assign out = temp;

endmodule 