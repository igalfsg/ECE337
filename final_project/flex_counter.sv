// $Id: $
// File name:   flex_counter.sv
// Created:     2/2/2016
// Author:      Arthur Huang
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: making last file
module flex_counter
#(
  parameter NUM_CNT_BITS=4
)
(
	input wire clk,
	input wire n_rst,
	input wire clear,
	input wire count_enable,

	input wire [NUM_CNT_BITS-1:0]rollover_val,
	output reg [NUM_CNT_BITS-1:0]count_out,
	output reg rollover_flag
);
reg flag_reg;
reg [NUM_CNT_BITS-1:0] counter_reg;

always_ff@(posedge clk, negedge n_rst)
begin
	if(n_rst == 0)
	begin
		count_out<='0;
		rollover_flag<='0;
	end
	else
	begin
		count_out <= counter_reg;
		rollover_flag<= flag_reg;
	end
end

always_comb
begin
	if(clear == 1)
	begin
		counter_reg = '0;
		flag_reg = '0;
	end
	else if (count_enable == 1)
	begin
		counter_reg=(count_out == rollover_val)? 1: count_out+1;
		flag_reg = (counter_reg == rollover_val)? 1:0;
	end else
	begin
		counter_reg= count_out;
		flag_reg = rollover_flag;

	end

end
endmodule
