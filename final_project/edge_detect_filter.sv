// $Id: $
// File name:   arit.sv
// Created:     11/13/2014
// Modified:    11/23/2014
// Author:      Saulo Cesar Rodrigues Pereira Sobrinho
// Project 
// Version:     1.0  Initial Design Entry
// Description: Arithmetic block.

module edge_detect_filter
  (
  input wire clk,
  input wire n_rst,
  input wire [71:0] r_in,
  input wire [71:0] g_in,
  input wire [71:0] b_in,
  output reg [7:0] r_out,
  output reg [7:0] g_out,
  output reg [7:0] b_out


  );
  
  /*
  7:0     - reg9
  15:8    - reg8
  23:16   - reg7
  31:24   - reg6
  39:32   - reg5
  47:40   - reg4
  55:48   - reg3
  63:56   - reg2
  71:64   - reg1
  */
  
  /*We work with 10 bit words to avoid overflows in the intermediate calculations.
    Since we multiply the number by 4, there's a potential overflow for any number >= 64,
    by working with 10 bit, we allow any multiplication to happen, and maybe the negative numbers
    can compensate.
  */


reg [7:0] r_next;
reg [7:0] g_next;
reg [7:0] b_next;

reg r_overflow;  //overflow flag
reg r_underflow;  //underflow flag
reg g_overflow;  //overflow flag
reg g_underflow;  //underflow flag
reg b_overflow;  //overflow flag
reg b_underflow;  //underflow flag

always_ff @ (posedge clk, negedge n_rst) begin
  if (n_rst == 0) begin
	r_out <= 8'h0;
	g_out <= 8'h0;
	b_out <= 8'h0;
  end else begin
	r_out <= r_next;
	g_out <= g_next;
	b_out <= b_next;
  end
end

  wire [10:0]r_ext_reg_2 ;
  wire [10:0]r_ext_reg_4 ;
  wire [10:0]r_ext_reg_6 ;
  wire [10:0]r_ext_reg_8 ;
  wire [10:0]r_ext_reg_5 ;

  wire [10:0]g_ext_reg_2 ;
  wire [10:0]g_ext_reg_4 ;
  wire [10:0]g_ext_reg_6 ;
  wire [10:0]g_ext_reg_8 ;
  wire [10:0]g_ext_reg_5 ;

  wire [10:0]b_ext_reg_2 ;
  wire [10:0]b_ext_reg_4 ;
  wire [10:0]b_ext_reg_6 ;
  wire [10:0]b_ext_reg_8 ;
  wire [10:0]b_ext_reg_5 ;

  
  reg [10:0]r_neg_reg_2;
  reg [10:0]r_neg_reg_4;
  reg [10:0]r_neg_reg_6;
  reg [10:0]r_neg_reg_8;
  
  reg [10:0]g_neg_reg_2;
  reg [10:0]g_neg_reg_4;
  reg [10:0]g_neg_reg_6;
  reg [10:0]g_neg_reg_8;

  reg [10:0]b_neg_reg_2;
  reg [10:0]b_neg_reg_4;
  reg [10:0]b_neg_reg_6;
  reg [10:0]b_neg_reg_8;

  
  reg [10:0]r_out_p1;
  reg [10:0]r_out_p2;
  reg [10:0]r_temp;

  reg [10:0]g_out_p1;
  reg [10:0]g_out_p2;
  reg [10:0]g_temp;

  reg [10:0]b_out_p1;
  reg [10:0]b_out_p2;
  reg [10:0]b_temp;
  
  //Multiplication by 4

  assign r_ext_reg_5 = {1'b0,r_in[39:32],2'b00};
  assign g_ext_reg_5 = {1'b0,g_in[39:32],2'b00};
  assign b_ext_reg_5 = {1'b0,b_in[39:32],2'b00};
  //2's Complement
  assign r_ext_reg_8 = {3'b111, (~r_in[15:8])};
  assign r_ext_reg_6 = {3'b111,(~r_in[31:24])};
  assign r_ext_reg_4 = {3'b111,(~r_in[47:40])};
  assign r_ext_reg_2 = {3'b111,(~r_in[63:56])};

  assign g_ext_reg_8 = {3'b111, (~g_in[15:8])};
  assign g_ext_reg_6 = {3'b111,(~g_in[31:24])};
  assign g_ext_reg_4 = {3'b111,(~g_in[47:40])};
  assign g_ext_reg_2 = {3'b111,(~g_in[63:56])};

  assign b_ext_reg_8 = {3'b111, (~b_in[15:8])};
  assign b_ext_reg_6 = {3'b111,(~b_in[31:24])};
  assign b_ext_reg_4 = {3'b111,(~b_in[47:40])};
  assign b_ext_reg_2 = {3'b111,(~b_in[63:56])};
  
  always @(r_ext_reg_2, r_ext_reg_4, r_ext_reg_6, r_ext_reg_8)
  begin
    r_neg_reg_2 = r_ext_reg_2 + 11'd1;
    r_neg_reg_4 = r_ext_reg_4 + 11'd1;  
    r_neg_reg_6 = r_ext_reg_6 + 11'd1;
    r_neg_reg_8 = r_ext_reg_8 + 11'd1;
  end

  always @(g_ext_reg_2, g_ext_reg_4, g_ext_reg_6, g_ext_reg_8)
  begin
    g_neg_reg_2 = g_ext_reg_2 + 11'd1;
    g_neg_reg_4 = g_ext_reg_4 + 11'd1;  
    g_neg_reg_6 = g_ext_reg_6 + 11'd1;
    g_neg_reg_8 = g_ext_reg_8 + 11'd1;
  end

  always @(b_ext_reg_2, b_ext_reg_4, b_ext_reg_6, b_ext_reg_8)
  begin
    b_neg_reg_2 = b_ext_reg_2 + 11'd1;
    b_neg_reg_4 = b_ext_reg_4 + 11'd1;  
    b_neg_reg_6 = b_ext_reg_6 + 11'd1;
    b_neg_reg_8 = b_ext_reg_8 + 11'd1;
  end
  

  //Matrix Convolution
  always @(r_neg_reg_2,r_neg_reg_4,r_ext_reg_5,r_neg_reg_6,r_neg_reg_8)
  begin
    r_out_p1 = r_neg_reg_2 + r_neg_reg_4;
    r_out_p2 = r_neg_reg_6 + r_neg_reg_8;  
    r_temp = r_out_p1 + r_out_p2 + r_ext_reg_5;   
  end  

  always @(g_neg_reg_2,g_neg_reg_4,g_ext_reg_5,g_neg_reg_6,g_neg_reg_8)
  begin
    g_out_p1 = g_neg_reg_2 + g_neg_reg_4;
    g_out_p2 = g_neg_reg_6 + g_neg_reg_8;  
    g_temp = g_out_p1 + g_out_p2 + g_ext_reg_5;   
  end 

  always @(b_neg_reg_2,b_neg_reg_4,b_ext_reg_5,b_neg_reg_6,b_neg_reg_8)
  begin
    b_out_p1 = b_neg_reg_2 + b_neg_reg_4;
    b_out_p2 = b_neg_reg_6 + b_neg_reg_8;  
    b_temp = b_out_p1 + b_out_p2 + b_ext_reg_5;   
  end 
  
  //Output 
  assign r_next = (r_overflow == 1'b1)? 8'hFF : (r_underflow == 1'b1)? 8'h00 : r_temp[7:0];
  assign r_underflow = r_temp[10];
  assign r_overflow = (r_underflow == 1'b0)? r_temp[8] | r_temp[9]:0;
  

  assign g_next = (g_overflow == 1'b1)? 8'hFF : (g_underflow == 1'b1)? 8'h00 : g_temp[7:0];
  assign g_underflow = g_temp[10];
  assign g_overflow = (g_underflow == 1'b0)? g_temp[8] | g_temp[9]:0; 
  
  assign b_next = (b_overflow == 1'b1)? 8'hFF : (b_underflow == 1'b1)? 8'h00 : b_temp[7:0];
  assign b_underflow = b_temp[10];
  assign b_overflow = (b_underflow == 1'b0)? b_temp[8] | b_temp[9]:0;
  
endmodule
