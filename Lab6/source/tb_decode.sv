// $Id: $
// File name:   tb_mealy.sv
// Created:     2/9/2015
// Author:      Igal Flegmann
// Lab Section: 99
// Version:     1.0  Initial Design Entry
// Description: 1101 mealy 
`timescale 1ns / 100ps

module tb_decode();
   localparam	CLK_PERIOD	= 2.5;
   localparam	CHECK_DELAY = 1;

   reg tb_clk;
   reg tb_n_rst;
   reg tb_d_plus;
   reg tb_shift_enable;
   reg tb_eop;
   reg tb_d_orig;
   


   decode DUT(.clk(tb_clk), .n_rst(tb_n_rst),.d_plus(tb_d_plus), .shift_enable(tb_shift_enable),.eop(tb_eop), .d_orig(tb_d_orig));



   always
     begin
	tb_clk = 1'b0;
	#(CLK_PERIOD/2.0);
	tb_clk = 1'b1;
	#(CLK_PERIOD/2.0);
     end
   
   initial
     begin
	tb_d_plus = 0;
	tb_n_rst = 1'b0;
	tb_shift_enable = 0;
	tb_eop = 0;
	@(negedge tb_clk);
	tb_n_rst = 1'b1;
	#7
	@(negedge tb_clk);
	tb_d_plus = 0;
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	tb_shift_enable = 1;
	@(negedge tb_clk);
	tb_shift_enable = 0;
	@(negedge tb_clk);
	@(negedge tb_clk);
	tb_d_plus = 1;
	@(negedge tb_clk);
	@(negedge tb_clk);
	
	@(posedge tb_clk);
	#1
	if(tb_d_orig == 1)
	  $info("1: Passed");
        else 
          $error("1: FAILED");
	#7
	tb_d_plus = 0;
	tb_n_rst = 1'b0;
	tb_shift_enable = 0;
	tb_eop = 0;
	@(negedge tb_clk);
	tb_n_rst = 1'b1;
	#7
	@(negedge tb_clk);
	tb_d_plus = 0;
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	tb_d_plus = 1;
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	tb_d_plus = 0;
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	tb_d_plus = 1;
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	tb_d_plus = 0;
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	tb_shift_enable = 1;
	@(negedge tb_clk);
	tb_shift_enable = 0;
	@(negedge tb_clk);
	@(negedge tb_clk);
	tb_d_plus = 1;
	@(negedge tb_clk);
	@(negedge tb_clk);
	
	@(posedge tb_clk);
	#1
	if(tb_d_orig == 1)
	  $info("2: Passed");
        else 
          $error("2: FAILED");
	#7
	tb_d_plus = 0;
	tb_n_rst = 1'b0;
	tb_shift_enable = 0;
	tb_eop = 0;
	@(negedge tb_clk);
	tb_n_rst = 1'b1;
	#7
	@(negedge tb_clk);
	tb_d_plus = 0;
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	tb_d_plus = 1;
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	tb_d_plus = 0;
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	tb_d_plus = 1;
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	tb_d_plus = 0;
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	tb_shift_enable = 1;
	@(negedge tb_clk);
	tb_shift_enable = 0;
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	
	@(posedge tb_clk);
	#1
	if(tb_d_orig == 0)
	  $info("3: Passed");
        else 
          $error("3: FAILED");
	#7
	@(negedge tb_clk);
	tb_d_plus = 0;
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	tb_d_plus = 1;
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	tb_d_plus = 0;
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	tb_d_plus = 1;
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	tb_d_plus = 0;
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	tb_shift_enable = 1;
	@(negedge tb_clk);
	tb_shift_enable = 0;
	@(negedge tb_clk);
	@(negedge tb_clk);
	tb_eop = 1;
	@(negedge tb_clk);
	
	@(negedge tb_clk);
	
	@(posedge tb_clk);
	#1
	if(tb_d_orig == 0)
	  $info("4: Passed");
        else 
          $error("4: FAILED");
	#7
	tb_eop = 0;
	@(negedge tb_clk);
	tb_d_plus = 0;
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	tb_d_plus = 1;
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	tb_d_plus = 0;
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	tb_d_plus = 1;
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	tb_d_plus = 0;
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	tb_shift_enable = 1;
	@(negedge tb_clk);
	if(tb_d_orig == 0)
	  $info("5: Passed");
        else 
          $error("5: FAILED");
	  #7
	@(negedge tb_clk);
	tb_d_plus = 1;
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	tb_shift_enable = 1;
	@(negedge tb_clk);
	tb_shift_enable = 0;
	@(negedge tb_clk);
	@(negedge tb_clk);
	tb_d_plus = 0;
	@(negedge tb_clk);
	@(negedge tb_clk);
	
	@(posedge tb_clk);
	#1
	if(tb_d_orig == 1)
	  $info("1: Passed");
        else 
          $error("1: FAILED");
	#7
	tb_shift_enable = 0;
	#2
	@(negedge tb_clk);
	tb_d_plus = 0;
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	tb_d_plus = 1;
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	tb_d_plus = 0;
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	tb_d_plus = 1;
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	tb_d_plus = 0;
	@(negedge tb_clk);
	@(negedge tb_clk);
	@(negedge tb_clk);
	tb_shift_enable = 1;
	@(negedge tb_clk);
	tb_shift_enable = 0;
	@(negedge tb_clk);
	@(negedge tb_clk);
	tb_eop = 1;
	@(negedge tb_clk);
	
	@(negedge tb_clk);
	
	@(posedge tb_clk);
	tb_shift_enable = 1;
	#1
	if(tb_d_orig == 0)
	  $info("4: Passed");
        else 
          $error("4: FAILED");
	#1
	tb_eop = 0;
	tb_shift_enable = 0;
     end // initial begin
endmodule // tb_edge_detect
