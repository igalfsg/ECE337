// $Id: $
// File name:   controller.sv
// Created:     2/16/2016
// Author:      Igal Flegmann Sandler
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: controller

module controller(
		  input  wire clk,
		  input  wire n_reset,
		  input  wire dr,
		  input  wire lc,
		  input	 wire overflow,
		  output reg  cnt_up,
		  output reg  clear,
		  output wire modwait,
		  output reg	  [2:0] op,
		  output reg	  [3:0] src1,
		  output reg	  [3:0] src2,
		  output reg	  [3:0] dest,
		  output reg  err
		  );
   reg 			      modwaitr;
   reg 			      cur_modw;
   
   typedef enum 	      bit [4:0] {IDLE, STORE, ZERO, EIDLE, SORT1, SORT2, SORT3, SORT4, MUL1, SUB1, MUL2, ADD1, MUL3, SUB2, MUL4, ADD2, COEF1, CHILL1, COEF2, CHILL2, COEF3, CHILL3, COEF4} stateType;
   stateType state;
   stateType next_state;

   assign clear = lc;
   assign cnt_up = (state == ZERO);
   assign modwait = cur_modw;
   
   always_ff @ (posedge clk, negedge n_reset)
     begin
	if(n_reset == 0) 
	  begin
	     cur_modw <= 0;
	     state <= IDLE;
	  end
	else 
	  begin
	     cur_modw <= modwaitr;
	     state <= next_state;
	  end
     end

   always_comb 
     begin
      next_state = state;
      op = 0;
      src1 = 0;
      src2 = 0;
      dest = 0;
      err = 0;
      
      begin : CONTSTATE
	 
	 case(state)
	 
	  
	   IDLE :
	     begin
	      if(lc == 1)
		 next_state = COEF1;
	      else if(dr == 1) 
		 next_state = STORE;
	      else
		next_state = IDLE;
	   end 
	   
	   STORE : 
	     begin
	      op = 3'b010;
	      dest = 5;
	      err = 0;
	      if(dr == 1)
		next_state = ZERO;
	      else
		next_state = EIDLE;
	     end 
	   
	   ZERO : 
	     begin
	      op = 3'b101;
	      src1 = '0;
	      src2 = '0;
	      dest = '0;
	      err = 0;
	      next_state = SORT1;
	     end 
	   SORT1 : 
	     begin
	      op = 3'b001;
	      src1 = 2;
	      src2 = 0;
	      dest = 1;
	      err = 0;
	      next_state = SORT2;
	     end 
	   SORT2 : 
	     begin
	      op = 3'b001;
	      src1 = 3;
	      src2 = 0;
	      dest = 2;
	      err = 0;
	      next_state = SORT3;
	     end 
	   SORT3 : 
	     begin
	      op = 3'b001;
	      src1 = 4;
	      src2 = 0;
	      dest = 3;
	      err = 0;
	      next_state = SORT4;
	     end
	   SORT4 : 
	     begin
	      op = 3'b001;
	      src1 = 5;
	      src2 = 0;
	      dest = 4;
	      err = 0;
	      next_state = MUL1;
	     end
	   MUL1 : 
	     begin
	      op = 3'b110;
	      src1 = 1;
	      src2 = 6;
	      dest = 7;
	      err =0;
	      next_state = SUB1;
	     end 
	   SUB1 : 
	     begin
	      op = 3'b101;
	      src1 = 0;
	      src2 = 7;
	      dest = 0;
	      err = 0;
	      if(overflow == 1'b1)
		next_state = EIDLE;
	      else
		next_state = MUL2;
	     end
	   MUL2 : 
	     begin
	      op = 3'b110;
	      src1 = 2;
	      src2 = 8;
	      dest = 7;
	      err = 0;
	      next_state = ADD1;
	     end 
	   ADD1 : 
	     begin
	      op = 3'b100;
	      src1 = 0;
	      src2 = 7;
	      dest = 0;
	      err = 0;
	      if(overflow == 1'b1)
		next_state = EIDLE;
	      else
		next_state = MUL3;
	     end
	   MUL3 : 
	     begin
	      op = 3'b110;
	      src1 = 3;
	      src2 = 9;
	      dest = 7;
	      err = 0;
	      next_state = SUB2;
	     end 
	   SUB2 : 
	     begin
	      op = 3'b101;
	      src1 = 0;
	      src2 = 7;
	      err = 0;
	      if(overflow == 1)
		next_state = EIDLE;
	      else
		next_state = MUL4;
	     end 
	   MUL4 : 
	     begin
	      op = 3'b110;
	      src1 = 4;
	      src2 = 10;
	      dest = 7;
	      err = 0;
	      next_state = ADD2;
	     end 
	   ADD2 : 
	     begin
	      op = 3'b100;
	      src1 = 0;
	      src2 = 7;
	      dest = 0;
	      err = 0;
	      if(overflow == 1'b1)
		next_state = EIDLE;
	      else
		next_state = IDLE;
	     end 
	   EIDLE : 
	     begin
	      op = 0;
	      dest = 0;
	      src1 = 0;
	      src2 = 0;
	      err = 1;
	      if(dr == 0) 
	        next_state = EIDLE;
	      else
		next_state = STORE;
	     end
	   COEF1 : 
	     begin
	      op = 3'b011;
	      src1 = 0;
	      src2 = 0;
	      dest = 10;
	      err = 0;
	      next_state = CHILL1;
	     end 
	   CHILL1 : 
	     begin
	      op = 0;
	      src1 = 0;
	      src2 = 0;
	      dest = 0;
	      err = 0;
	      if(lc == 1)
		next_state = COEF2;
	      else
		next_state = CHILL1;
	     end 
	   COEF2 : 
	     begin
	      op = 3'b011;
	      src1 = 0;
	      src2 = 0;
	      dest = 9;
	      err = 0;
	      next_state = CHILL2;
	     end 
	   CHILL2 : 
	     begin
	      op = 0;
	      src1 = 0;
	      src2 = 0;
	      dest = 0;
	      err = 0;
	      if(lc == 1)
		next_state = COEF3;
	      else
		next_state = CHILL2;
	     end
	   COEF3 : 
	     begin
	      op = 3'b011;
	      src1 = 0;
	      src2 = 0;
	      dest = 8;
	      err = 0;
	      next_state = CHILL3;
	     end
	   CHILL3 : 
	     begin
	      op = 0;
	      src1 = 0;
	      src2 = 0;
	      dest = 0;
	      err = 0;
	      if(lc == 1)
		next_state = COEF4;
	      else
		next_state = CHILL3;
	     end 
	   COEF4 : 
	     begin		
	      op = 3'b011;
	      src1 = 0;
	      src2 = 0;
	      dest = 6;
	      err = 0;
	      next_state = IDLE;
	     end 
	 endcase 
	 modwaitr = ~(state == IDLE || state == EIDLE || state == CHILL1 || state == CHILL2 || state == CHILL3);
      end 
     
   end // always_comb 
endmodule 
