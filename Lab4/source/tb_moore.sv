// $Id: $
// File name:   tb_moore.sv
// Created:     2/9/2015
// Author:      Igal Flegmann
// Lab Section: 99
// Version:     1.0  Initial Design Entry
// Description: 1101 mealy 
`timescale 1ns / 100ps
module tb_moore ();

    // Define parameters
	// basic test bench parameters
	localparam	CLK_PERIOD	= 2.5;
	localparam	CHECK_DELAY = 1; // Check 1ns after the rising edge to allow for propagation delay
    localparam  NUM_CNT_BITS = 4;


  
   
    reg tb_clk;
    reg tb_n_rst;
    reg tb_i;
    reg tb_o;
   
    integer testcase;


    moore DUT
    ( 

        .clk( tb_clk ),
        .n_rst( tb_n_rst ),
        .i( tb_i ),
        .o( tb_o )
     
    );



    // Clock generation block
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end




    initial
    begin


        //1
        testcase = 1;

        //async reset
		tb_n_rst = 1'b0;
        #5;
        tb_n_rst = 1'b1;
        #5;
		
        tb_i = 1'b1;
        @(posedge tb_clk);
        tb_i = 1'b1;
        @(posedge tb_clk);
        tb_i = 1'b0;
        @(posedge tb_clk);
        tb_i = 1'b1;

        #(CHECK_DELAY);
        
        if( tb_o == 1 )
            $info("1: Passed");
        else 
            $error("1: FAILED");


        
        //2
        testcase = 2;

	tb_n_rst = 1'b0;
        #5;
        tb_n_rst = 1'b1;
        #5;

        tb_i = 1'b1;
        @(posedge tb_clk);
        tb_i = 1'b1;
        @(posedge tb_clk);
        tb_i = 1'b0;
        @(posedge tb_clk);
        tb_i = 1'b1;	
        @(posedge tb_clk);	
        tb_i = 1'b1;
        @(posedge tb_clk);
        tb_i = 1'b0;
        @(posedge tb_clk);
        tb_i = 1'b1;
       
        
         

        #(CHECK_DELAY);
        if( tb_o == 1 )
            $info("2: Passed");
        else 
            $error("2: FAILED");

        //3
        testcase = 3;

     
		tb_n_rst = 1'b0;
        #5;
        tb_n_rst = 1'b1;
        #5; 
        tb_i = 1'b1;
        @(posedge tb_clk);
        tb_i = 1'b1;
        @(posedge tb_clk);
        tb_i = 1'b0;
        @(posedge tb_clk);
        tb_i = 1'b1;	
        @(posedge tb_clk);	
        tb_i = 1'b1;
        @(posedge tb_clk);
        tb_i = 1'b0;
        @(posedge tb_clk);
        tb_i = 1'b0;
       
      
        #(CHECK_DELAY);
        if( tb_o == 0 )
            $info("3: Passed");
        else 
            $error("3: FAILED");
    end
endmodule