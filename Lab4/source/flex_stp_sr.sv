// $Id: $
// File name:   flex_stp_sr.sv
// Created:     1/27/2016
// Author:      Igal Flegmann Sandler
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: third.
module flex_stp_sr
#(
parameter NUM_BITS = 4,
parameter SHIFT_MSB = 0
)
(
	input wire clk,
	input wire n_rst,
	input wire shift_enable,
	input wire serial_in,	
	output reg [NUM_BITS-1:0]parallel_out
);


int i;
reg [NUM_BITS-1:0]inter;
always_ff @ (posedge clk, negedge n_rst)
begin  
if(1'b0 == n_rst)
	begin
	//reset stuff
	 parallel_out[NUM_BITS-1:0] <= '1;
	end
else
	begin
	parallel_out<=inter;  
	end
end

always_comb 
begin
if (shift_enable == 1'b1)
    begin
    
	if (SHIFT_MSB == 1)
    	begin
		inter = {parallel_out[NUM_BITS-2:0],serial_in};
    	end
	else
	begin
		inter= {serial_in, parallel_out[NUM_BITS-1:1] };
	end
    end
    else
         inter=parallel_out;
end 
endmodule