// $Id: $
// File name:   tb_mealy.sv
// Created:     2/9/2015
// Author:      Igal Flegmann
// Lab Section: 99
// Version:     1.0  Initial Design Entry
// Description: 1101 mealy 
`timescale 1ns / 100ps

module tb_rx_fifo();
   localparam	CLK_PERIOD	= 2.5;
   localparam	CHECK_DELAY = 1;

   reg tb_clk;
   reg tb_n_rst;
   reg tb_r_enable;
   reg tb_w_enable;
   reg [7:0]tb_w_data;
   reg [7:0]tb_r_data;
   reg tb_empty;
   reg tb_full;
   
   


   rx_fifo DUT(.clk(tb_clk), .n_rst(tb_n_rst),.r_enable(tb_r_enable), .w_enable(tb_w_enable),.w_data(tb_w_data), .r_data(tb_r_data), .empty(tb_empty), .full(tb_full));



   always
     begin
	tb_clk = 1'b0;
	#(CLK_PERIOD/2.0);
	tb_clk = 1'b1;
	#(CLK_PERIOD/2.0);
     end


   initial
     begin
	tb_r_enable = 0;
	tb_r_enable = 0;
	tb_w_data = 0;
	tb_n_rst = 1'b0;
	@(negedge tb_clk);
	tb_n_rst = 1'b1;
	#7
	if(tb_empty == 1)
	  $info("1: Passed");
        else 
          $error("1: FAILED");
	#1
	if(tb_full == 0)
	  $info("2: Passed");
        else 
          $error("2: FAILED");
	@(negedge tb_clk);
	tb_w_enable = 1;
	tb_w_data = 8'b10101010;
	@(negedge tb_clk);
	@(negedge tb_clk);
	tb_w_enable = 0;
	tb_r_enable = 1;
	
	@(negedge tb_clk);
	if (tb_w_data == tb_r_data)
	  $info("3: Passed");
        else 
          $error("3: FAILED");
	tb_w_enable = 1;
	if (tb_w_data == tb_r_data)
	  $info("3: Passed");
        else 
          $error("3: FAILED");
	@(negedge tb_clk);
	tb_w_data = 8'b01010101;
	@(negedge tb_clk);
	tb_w_enable=  0;
	tb_w_data = 8'b01010111;
	@(negedge tb_clk);





	  end // initial begin
   
   
endmodule // tb_rx_fifo
