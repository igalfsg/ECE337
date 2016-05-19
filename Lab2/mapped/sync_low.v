/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Tue Jan 26 20:21:34 2016
/////////////////////////////////////////////////////////////


module sync_low ( clk, n_rst, async_in, sync_out );
  input clk, n_rst, async_in;
  output sync_out;
  wire   flip;

  DFFSR flip_reg ( .D(async_in), .CLK(clk), .R(n_rst), .S(1'b1), .Q(flip) );
  DFFSR sync_out_reg ( .D(flip), .CLK(clk), .R(n_rst), .S(1'b1), .Q(sync_out)
         );
endmodule

