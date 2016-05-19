// $Id: $
// File name:   moore.sv
// Created:     2/4/2016
// Author:      Igal Flegmann Sandler
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: firstthing.
module moore
(
	input wire clk,
	input wire n_rst,
	input wire i,	
	output reg o
);
typedef enum bit [2:0] {STATE0, STATE1, STATE2, STATE3, STATE4} stateType;
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
	case(state)
		STATE0:
		begin
			nxt_state = i == 1 ? STATE1 : STATE0;
		end
		STATE1:
		begin
			nxt_state = i == 1 ? STATE2 : STATE0;
		end
		STATE2:
		begin
			nxt_state = i == 1 ? STATE2 : STATE3;
		end
		STATE3:
		begin
			nxt_state = i == 1 ? STATE4 : STATE0;
		end
		STATE4:
		begin
			nxt_state = i == 1 ? STATE2 : STATE0;
		end
	endcase
end
assign o = (state==STATE4);
endmodule
