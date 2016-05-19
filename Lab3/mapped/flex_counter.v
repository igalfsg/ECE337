/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Wed Feb  3 13:25:51 2016
/////////////////////////////////////////////////////////////


module flex_counter ( clk, n_rst, clear, count_enable, rollover_val, count_out, 
        rollover_flag );
  input [3:0] rollover_val;
  output [3:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   rollover_flagr, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64,
         n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78,
         n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91, n92,
         n93, n94;

  DFFSR \ahora_reg[0]  ( .D(n57), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR \ahora_reg[1]  ( .D(n56), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[1]) );
  DFFSR \ahora_reg[2]  ( .D(n55), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR \ahora_reg[3]  ( .D(n54), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[3]) );
  DFFSR cur_flag_reg ( .D(rollover_flagr), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        rollover_flag) );
  OAI22X1 U48 ( .A(n58), .B(n59), .C(n60), .D(n61), .Y(rollover_flagr) );
  NAND3X1 U49 ( .A(n62), .B(n63), .C(n64), .Y(n61) );
  XOR2X1 U50 ( .A(n65), .B(n66), .Y(n64) );
  OAI21X1 U51 ( .A(rollover_val[1]), .B(n67), .C(n68), .Y(n60) );
  AND2X1 U52 ( .A(n69), .B(n70), .Y(n68) );
  MUX2X1 U53 ( .B(n71), .A(n72), .S(n73), .Y(n57) );
  OAI21X1 U54 ( .A(n72), .B(n74), .C(n69), .Y(n71) );
  MUX2X1 U55 ( .B(n75), .A(n76), .S(count_out[1]), .Y(n56) );
  AOI21X1 U56 ( .A(n77), .B(n72), .C(n73), .Y(n76) );
  NAND2X1 U57 ( .A(n77), .B(count_out[0]), .Y(n75) );
  OAI22X1 U58 ( .A(n78), .B(n59), .C(n79), .D(n80), .Y(n55) );
  INVX1 U59 ( .A(n81), .Y(n54) );
  AOI22X1 U60 ( .A(count_out[3]), .B(n73), .C(n82), .D(n77), .Y(n81) );
  INVX1 U61 ( .A(n80), .Y(n77) );
  NAND3X1 U62 ( .A(n59), .B(n69), .C(n58), .Y(n80) );
  INVX1 U63 ( .A(n74), .Y(n58) );
  OAI22X1 U64 ( .A(rollover_val[3]), .B(n83), .C(n84), .D(n85), .Y(n74) );
  INVX1 U65 ( .A(n62), .Y(n85) );
  XOR2X1 U66 ( .A(n83), .B(rollover_val[3]), .Y(n62) );
  AOI22X1 U67 ( .A(n63), .B(n86), .C(n87), .D(n88), .Y(n84) );
  OAI21X1 U68 ( .A(rollover_val[1]), .B(n67), .C(n89), .Y(n86) );
  NAND3X1 U69 ( .A(n70), .B(n65), .C(n66), .Y(n89) );
  XOR2X1 U70 ( .A(count_enable), .B(count_out[0]), .Y(n66) );
  INVX1 U71 ( .A(rollover_val[0]), .Y(n65) );
  NAND2X1 U72 ( .A(rollover_val[1]), .B(n67), .Y(n70) );
  OAI21X1 U73 ( .A(n90), .B(n91), .C(n92), .Y(n67) );
  OAI21X1 U74 ( .A(n90), .B(n72), .C(n93), .Y(n92) );
  INVX1 U75 ( .A(count_out[1]), .Y(n93) );
  INVX1 U76 ( .A(count_out[0]), .Y(n72) );
  XOR2X1 U77 ( .A(n88), .B(n87), .Y(n63) );
  MUX2X1 U78 ( .B(n79), .A(n78), .S(n90), .Y(n87) );
  XNOR2X1 U79 ( .A(n91), .B(n78), .Y(n79) );
  INVX1 U80 ( .A(rollover_val[2]), .Y(n88) );
  MUX2X1 U81 ( .B(count_out[3]), .A(n82), .S(count_enable), .Y(n83) );
  XOR2X1 U82 ( .A(count_out[3]), .B(n94), .Y(n82) );
  NOR2X1 U83 ( .A(n91), .B(n78), .Y(n94) );
  INVX1 U84 ( .A(count_out[2]), .Y(n78) );
  NAND2X1 U85 ( .A(count_out[1]), .B(count_out[0]), .Y(n91) );
  INVX1 U86 ( .A(n59), .Y(n73) );
  NAND2X1 U87 ( .A(n90), .B(n69), .Y(n59) );
  INVX1 U88 ( .A(clear), .Y(n69) );
  INVX1 U89 ( .A(count_enable), .Y(n90) );
endmodule

