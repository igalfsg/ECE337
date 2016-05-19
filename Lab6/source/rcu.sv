// $Id: $
// File name:   rcu.sv
// Created:     2/25/2016
// Author:      Igal Flegmann Sandler
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: gl hf
module rcu
(
    input wire clk,
    input wire n_rst,
    input wire d_edge,
    input wire eop,
    input wire shift_enable,
    input wire [7:0]rcv_data,
    input wire byte_received,
    output logic rcving,
    output logic w_enable,
    output logic r_error
);

   

typedef enum bit [4:0] {IDLE, EIDLE, RECEIVING, CHECK_SYNC, RECIEVE_STUFF, SAVE_BYTE, CHECK_EOP, ERROR, CHECK_D_EDGE, CHECK_EDGE_E} stateType;
stateType state;
stateType next_state;
always_ff @ (negedge n_rst, posedge clk)
begin : REG_LOGIC
    if (n_rst == 0)
    begin
        state<=IDLE;
    end
    else
    begin
        state<=next_state;
    end
end
   

always_comb
begin: NEXT_STATE
    next_state = state;
    case(state)
        IDLE: 
	  begin
            if (d_edge == 1'b1)
	      begin
                next_state = RECEIVING;
	      end
            else
	      begin
                next_state = IDLE;
	      end
	   
        end // case: IDLE
      
        RECEIVING: begin
            if (byte_received == 1'b1)
	      begin
                next_state = CHECK_SYNC;
	      end
	   
            else
	      begin
                next_state = RECEIVING;
	      end
	   
        end // case: RECEIVING
      
        CHECK_SYNC: begin
            if (rcv_data == 8'b10000000)
	      begin
                next_state = RECIEVE_STUFF;
	      end
	   
            else
	      begin
                next_state = ERROR;
	      end
	   
        end // case: CHECK_SYNC
      
        RECIEVE_STUFF: begin  
            if (byte_received == 1'b1)
	      begin
                next_state = SAVE_BYTE;
	      end
	   
            else if (eop == 1 & shift_enable == 1)
	      begin
                next_state = ERROR;
	      end
	   
            else
	      begin
                next_state = RECIEVE_STUFF;
	      end
	   
        end // case: RECIEVE_STUFF
      
        SAVE_BYTE: 
	  begin  
            next_state = CHECK_EOP;
          end
      
        CHECK_EOP: begin    
	    if (eop == 0 && shift_enable == 1)
	      begin
                next_state = RECIEVE_STUFF;
	      end
	   
            else if (eop == 1 && shift_enable ==1)
	      begin
                next_state = CHECK_D_EDGE;
	      end
	   
            else
	      begin
                next_state = CHECK_EOP;
	      end
	   
        end // case: CHECK_EOP
      
      
        CHECK_D_EDGE: begin
            if (d_edge == 1)
	      begin
                next_state = IDLE;
	      end
	   
            else
	      begin
                next_state = CHECK_D_EDGE;
	      end
	   
            end
        ERROR: begin
            if (eop == 1 && shift_enable == 1)
	      begin
                next_state = CHECK_EDGE_E;
	      end
	   
            else
	      begin
                next_state = ERROR;
	      end
	   
            end
        CHECK_EDGE_E: begin
            if (d_edge == 1)
	      begin
		 
                next_state = EIDLE;
	      end
	   
            else
	      begin
                next_state = CHECK_EDGE_E;
		 end
        end // case: CHECK_EDGE_E
      
        EIDLE: begin
            if (d_edge == 1)
	      begin
                next_state = RECEIVING;
		 end
            else
	      begin
                next_state = EIDLE;
	      end
	   
        end // case: EIDLE
      
  
    endcase       
    rcving = ~(next_state == IDLE || next_state == CHECK_EDGE_E || next_state == CHECK_D_EDGE || next_state== EIDLE);
    w_enable = (next_state == SAVE_BYTE);
   r_error = (next_state == ERROR || next_state == CHECK_EDGE_E || next_state == EIDLE);

end // block: NEXT_STATE
   
   

endmodule // rcu

