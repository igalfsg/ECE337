// $Id: $
// File name:   flex_pts_sr.sv
// Created:     2/1/2016
// Author:      Igal Flegmann Sandler
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: w.
module flex_pts_sr
#(
parameter NUM_BITS = 4,
parameter SHIFT_MSB = 1
)
(
	input wire clk,
	input wire n_rst,
	input wire shift_enable,	
	input wire load_enable,
	input reg [NUM_BITS-1:0]parallel_in,
	output wire serial_out
);


reg [NUM_BITS-1:0]ahora;
reg [NUM_BITS-1:0]inter;
always_ff @ (posedge clk, negedge n_rst)
begin  
if(1'b0 == n_rst)
	begin
	//reset stuff
	 ahora[NUM_BITS-1:0] <= '1;
	end
else
	begin
	ahora<=inter;  
	end
end

always_comb 
begin
	if (load_enable == 1)
	begin
		inter = parallel_in;
	end
	else
	begin
		if (shift_enable == 1'b1)
	    	begin
    
			if (SHIFT_MSB == 1)
	    		begin
				inter = {ahora[NUM_BITS-2:0],1'b1};
	    		end
			else
			begin
				inter= {1'b1, ahora[NUM_BITS-1:1] };
			end
	    	end
	    	else
	     	    inter=ahora;
	end
end
if(SHIFT_MSB == 1)
begin
	assign serial_out = ahora[NUM_BITS-1];
end
else
begin
	assign serial_out = ahora[0];
end


endmodule