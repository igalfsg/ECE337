// $Id: $
// File name:   mealy.sv
// Created:     2/4/2016
// Author:      Igal Flegmann Sandler
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: second
module mealy
(
	input wire clk,
	input wire n_rst,
	input wire i,	
	output reg o
);
typedef enum bit [2:0] {STATE0, STATE1, STATE2, STATE3} stateType;
stateType state;
stateType nxt_state;

always_ff @ (posedge clk, negedge n_rst)
begin  
	if(1'b0 == n_rst)
	begin
	//reset stuff
		state <= STATE0;
	end
	else
	begin
		state <= nxt_state;
	end
end

always_comb 
begin
	nxt_state = STATE0;
	o = 0;
	case(state)
		STATE0:
		begin
			//nxt_state = i == 1 ? STATE1 : STATE0;
			if (i==1)
			begin
				nxt_state = STATE1;
				o = 0;
			end
			else
			begin
				nxt_state = STATE0;
				o = 0;
			end
		end
		STATE1:
		begin
			//nxt_state = i == 1 ? STATE2 : STATE0;
			if (i==1)
			begin
				nxt_state = STATE2;
				o = 0;
			end
			else
			begin
				nxt_state = STATE0;
				o = 0;
			end
		end
		STATE2:
		begin
			if (i==1)
			begin
				nxt_state = STATE2;
				o = 0;
			end
			else
			begin
				nxt_state = STATE3;
				o = 0;
			end
		end
		STATE3:
		begin
			if (i==1)
			begin
				nxt_state = STATE1;
				o = 1;
			end
			else
			begin
				nxt_state = STATE0;
				o = 0;
			end
		end
	endcase
end

endmodule