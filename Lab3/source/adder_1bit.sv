// $Id: $
// File name:   adder_1bit.sv
// Created:     1/24/2016
// Author:      Igal Flegmann Sandler
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: yooo:
// :
module adder_1bit(

input wire a,
input wire b,
input wire carry_in,
output wire sum,
output wire carry_out
);
always @ (a, b)
begin 
	assert((a == 1'b1) || (a == 1'b0))
	else $error("Input 'a' of component is not a digital logic value");
	assert((b == 1'b1) || (b == 1'b0))
	else $error("Input 'b' of component is not a digital logic value");
end

assign sum = carry_in ^ (a ^ b);
assign carry_out = ((! carry_in) & b & a) | (carry_in & (b | a));

endmodule 