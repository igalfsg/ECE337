// $Id: $
// File name:   adder_16bit.sv
// Created:     1/27/2016
// Author:      Igal Flegmann Sandler
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: waaa.
`timescale 1ns / 100ps

module adder_16bit
(
	input wire [15:0] a,
	input wire [15:0] b,
	input wire carry_in,
	output wire [15:0] sum,
	output wire overflow
);
genvar i;
	adder_nbit #(16) addin (.a(a), .b(b), .carry_in(carry_in), .sum(sum), .overflow(overflow));
generate
 for(i = 0; i < 16; i = i + 1)
 begin
always @ (a[i], b[i])
   begin
	assert((a[i] == 1'b1) || (a[i] == 1'b0))
	else $error("Input 'a' of component is not a digital logic value");
	assert((b[i] == 1'b1) || (b[i] == 1'b0))
	else $error("Input 'b' of component is not a digital logic value");
   end
 end
endgenerate

// STUDENT: Fill in the correct port map with parameter override syntax for using your n-bit ripple carry adder design to be an 8-bit ripple carry adder design
endmodule