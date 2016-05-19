// $Id: $
// File name:   flex_counter.sv
// Created:     2/2/2016
// Author:      Igal Flegmann Sandler
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: yupi.
module flex_counter
#(
parameter NUM_CNT_BITS = 4
)
(
	input wire clk,
	input wire n_rst, clear,
	input wire count_enable,	
	input reg [NUM_CNT_BITS-1:0]rollover_val,
	output wire [NUM_CNT_BITS-1:0]count_out,
	output wire rollover_flag
);


reg [NUM_CNT_BITS-1:0]ahora;
reg [NUM_CNT_BITS-1:0]sig;
reg rollover_flagr;
reg cur_flag;
always_ff @ (posedge clk, negedge n_rst)
begin  
	if(1'b0 == n_rst)
	begin
	//reset stuff
		ahora[NUM_CNT_BITS-1:0] <= '0;
		cur_flag <= '0;
	end
	else
	begin
		ahora<=sig; 
		cur_flag <=  rollover_flagr;
	end
end

always_comb 
begin
	if (clear == 1'b1)
	begin
		sig = '0;
		rollover_flagr = 1'b0;
	end
	else
	begin
		if (count_enable == 1)
		begin
			sig = ahora + 1;
			if (sig == (rollover_val))
			begin
				rollover_flagr = 1'b1;
			end
			else if (sig > (rollover_val))
			begin
				rollover_flagr = 1'b0;
				sig = 1;
			end
			else
			begin
				rollover_flagr = 1'b0;
			end
			
		end
		else
		begin
			sig = ahora;
			if (sig >= (rollover_val))
			begin
				rollover_flagr = 1'b1;
			end
			else
			begin
				rollover_flagr = 1'b0;
			end
		end
	end
end
assign count_out = ahora;
assign rollover_flag = cur_flag;


endmodule
