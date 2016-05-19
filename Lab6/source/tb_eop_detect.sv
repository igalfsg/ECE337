`timescale 1ns / 100ps

  module tb_eop_detect();


   
   reg tb_d_plus;
   reg tb_d_minus;
   reg tb_eop_output;


   eop_detect DUT(.d_minus(tb_d_minus), .d_plus(tb_d_plus), .eop(tb_eop_output));
   


   initial
     begin
	tb_d_plus = 0;
	tb_d_minus = 0;
	#(7)
	if(tb_eop_output == 1)
	  $info("passed 1 asserted");
	else
	  $error("you failed ");

	tb_d_plus = 1;
	tb_d_minus = 1;
	#(7)
	if(tb_eop_output == 0)
	  $info("passed 0 asserted");
	else
	  $error("you failed ");

	tb_d_plus = 1;
	tb_d_minus = 0;
	#7
	if(tb_eop_output == 0)
	  $info("passed 0 asserted");
	else
	  $error("you failed ");

	#1
	tb_d_plus = 0;
	tb_d_minus = 1;
	#7
	if(tb_eop_output == 0)
	  $info("passed 0 asserted");
	else
	  $error("you failed ");
	
	#1
	tb_d_plus = 0;
	tb_d_minus = 0;
	#(7)
	if(tb_eop_output == 1)
	  $info("passed 1 asserted");
	else
	  $error("you failed ");

	tb_d_plus = 1;
	tb_d_minus = 1;
	#(7)
	if(tb_eop_output == 0)
	  $info("passed 0 asserted");
	else
	  $error("you failed ");

	tb_d_plus = 1;
	tb_d_minus = 0;
	#7
	if(tb_eop_output == 0)
	  $info("passed 0 asserted");
	else
	  $error("you failed ");

	tb_d_plus = 0;
	tb_d_minus = 1;
	#7
	if(tb_eop_output == 0)
	  $info("passed 0 asserted");
	else
	  $error("you failed ");
	
     end // initial begin

endmodule // tb_eop_detect

   