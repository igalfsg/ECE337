/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Wed Mar  2 12:44:16 2016
/////////////////////////////////////////////////////////////
module lab7_out_ctrl (
	clk, 
	n_rst, 
	d_plus, 
	d_minus, 
	bus_mode, 
	tx_value);
   input clk;
   input n_rst;
   output d_plus;
   output d_minus;
   input [1:0] bus_mode;
   input tx_value;

   // Internal wires
   wire n10;
   wire n11;
   wire n3;
   wire n4;
   wire n5;
   wire n6;
   wire n7;

   DFFSR d_minus_reg_reg (.S(1'b1), 
	.R(n_rst), 
	.Q(d_minus), 
	.D(n11), 
	.CLK(clk));
   DFFSR d_plus_reg_reg (.S(n_rst), 
	.R(1'b1), 
	.Q(d_plus), 
	.D(n10), 
	.CLK(clk));
   NOR2X1 U5 (.Y(n11), 
	.B(n4), 
	.A(n3));
   MUX2X1 U6 (.Y(n4), 
	.S(bus_mode[1]), 
	.B(n5), 
	.A(d_minus));
   INVX1 U7 (.Y(n5), 
	.A(tx_value));
   MUX2X1 U8 (.Y(n10), 
	.S(bus_mode[1]), 
	.B(n6), 
	.A(n7));
   NAND2X1 U9 (.Y(n7), 
	.B(bus_mode[0]), 
	.A(d_plus));
   NOR2X1 U10 (.Y(n6), 
	.B(n3), 
	.A(tx_value));
   INVX1 U11 (.Y(n3), 
	.A(bus_mode[0]));
endmodule

module lab7_encoder (
	clk, 
	n_rst, 
	tx_bit, 
	shift_enable, 
	tx_value);
   input clk;
   input n_rst;
   input tx_bit;
   input shift_enable;
   output tx_value;

   // Internal wires
   wire last_bit;
   wire n1;
   wire n2;

   DFFSR last_bit_reg (.S(n_rst), 
	.R(1'b1), 
	.Q(last_bit), 
	.D(n2), 
	.CLK(clk));
   XNOR2X1 U2 (.Y(tx_value), 
	.B(tx_bit), 
	.A(last_bit));
   INVX1 U3 (.Y(n2), 
	.A(n1));
   MUX2X1 U4 (.Y(n1), 
	.S(shift_enable), 
	.B(last_bit), 
	.A(tx_bit));
endmodule

module lab7_tx_sr_1 (
	clk, 
	n_rst, 
	shift_enable, 
	tx_enable, 
	tx_data, 
	load_data, 
	tx_out, 
	FE_OFN1_nclk);
   input clk;
   input n_rst;
   input shift_enable;
   input tx_enable;
   input [7:0] tx_data;
   input load_data;
   output tx_out;
   input FE_OFN1_nclk;

   // Internal wires
   wire FE_OFN6_n13;
   wire n29;
   wire n30;
   wire n31;
   wire n32;
   wire n33;
   wire n34;
   wire n35;
   wire n36;
   wire n9;
   wire n10;
   wire n11;
   wire n12;
   wire n13;
   wire n14;
   wire n15;
   wire n16;
   wire n17;
   wire n18;
   wire n19;
   wire n20;
   wire n21;
   wire n22;
   wire n23;
   wire n24;
   wire n25;
   wire n26;
   wire n27;
   wire [7:1] curr_val;

   BUFX2 FE_OFC6_n13 (.Y(FE_OFN6_n13), 
	.A(n13));
   DFFSR \curr_val_reg[7]  (.S(1'b1), 
	.R(n_rst), 
	.Q(curr_val[7]), 
	.D(n30), 
	.CLK(clk));
   DFFSR \curr_val_reg[6]  (.S(1'b1), 
	.R(n_rst), 
	.Q(curr_val[6]), 
	.D(n31), 
	.CLK(clk));
   DFFSR \curr_val_reg[5]  (.S(1'b1), 
	.R(n_rst), 
	.Q(curr_val[5]), 
	.D(n32), 
	.CLK(FE_OFN1_nclk));
   DFFSR \curr_val_reg[4]  (.S(1'b1), 
	.R(n_rst), 
	.Q(curr_val[4]), 
	.D(n33), 
	.CLK(FE_OFN1_nclk));
   DFFSR \curr_val_reg[3]  (.S(1'b1), 
	.R(n_rst), 
	.Q(curr_val[3]), 
	.D(n34), 
	.CLK(clk));
   DFFSR \curr_val_reg[2]  (.S(1'b1), 
	.R(n_rst), 
	.Q(curr_val[2]), 
	.D(n35), 
	.CLK(clk));
   DFFSR \curr_val_reg[1]  (.S(1'b1), 
	.R(n_rst), 
	.Q(curr_val[1]), 
	.D(n36), 
	.CLK(clk));
   DFFSR \curr_val_reg[0]  (.S(1'b1), 
	.R(n_rst), 
	.Q(tx_out), 
	.D(n29), 
	.CLK(clk));
   OAI21X1 U11 (.Y(n36), 
	.C(n11), 
	.B(n10), 
	.A(n9));
   AOI22X1 U12 (.Y(n11), 
	.D(FE_OFN6_n13), 
	.C(curr_val[1]), 
	.B(n12), 
	.A(curr_val[2]));
   INVX1 U13 (.Y(n10), 
	.A(tx_data[1]));
   OAI21X1 U14 (.Y(n35), 
	.C(n15), 
	.B(n14), 
	.A(n9));
   AOI22X1 U15 (.Y(n15), 
	.D(curr_val[2]), 
	.C(FE_OFN6_n13), 
	.B(n12), 
	.A(curr_val[3]));
   INVX1 U16 (.Y(n14), 
	.A(tx_data[2]));
   OAI21X1 U17 (.Y(n34), 
	.C(n17), 
	.B(n16), 
	.A(n9));
   AOI22X1 U18 (.Y(n17), 
	.D(FE_OFN6_n13), 
	.C(curr_val[3]), 
	.B(n12), 
	.A(curr_val[4]));
   INVX1 U19 (.Y(n16), 
	.A(tx_data[3]));
   OAI21X1 U20 (.Y(n33), 
	.C(n19), 
	.B(n18), 
	.A(n9));
   AOI22X1 U21 (.Y(n19), 
	.D(FE_OFN6_n13), 
	.C(curr_val[4]), 
	.B(n12), 
	.A(curr_val[5]));
   INVX1 U22 (.Y(n18), 
	.A(tx_data[4]));
   OAI21X1 U23 (.Y(n32), 
	.C(n21), 
	.B(n20), 
	.A(n9));
   AOI22X1 U24 (.Y(n21), 
	.D(FE_OFN6_n13), 
	.C(curr_val[5]), 
	.B(n12), 
	.A(curr_val[6]));
   INVX1 U25 (.Y(n20), 
	.A(tx_data[5]));
   OAI21X1 U26 (.Y(n31), 
	.C(n23), 
	.B(n22), 
	.A(n9));
   AOI22X1 U27 (.Y(n23), 
	.D(FE_OFN6_n13), 
	.C(curr_val[6]), 
	.B(n12), 
	.A(curr_val[7]));
   INVX1 U28 (.Y(n22), 
	.A(tx_data[6]));
   NAND2X1 U29 (.Y(n30), 
	.B(n25), 
	.A(n24));
   INVX1 U30 (.Y(n25), 
	.A(n12));
   MUX2X1 U31 (.Y(n24), 
	.S(FE_OFN6_n13), 
	.B(tx_data[7]), 
	.A(curr_val[7]));
   OAI21X1 U32 (.Y(n29), 
	.C(n27), 
	.B(n26), 
	.A(n9));
   AOI22X1 U33 (.Y(n27), 
	.D(FE_OFN6_n13), 
	.C(tx_out), 
	.B(n12), 
	.A(curr_val[1]));
   NOR2X1 U34 (.Y(n12), 
	.B(load_data), 
	.A(FE_OFN6_n13));
   AOI21X1 U35 (.Y(n13), 
	.C(load_data), 
	.B(shift_enable), 
	.A(tx_enable));
   INVX1 U36 (.Y(n26), 
	.A(tx_data[0]));
   INVX1 U37 (.Y(n9), 
	.A(load_data));
endmodule

module lab7_tx_sr_0 (
	clk, 
	n_rst, 
	shift_enable, 
	tx_enable, 
	tx_data, 
	load_data, 
	tx_out, 
	FE_OFN1_nclk, 
	FE_OFN2_nclk);
   input clk;
   input n_rst;
   input shift_enable;
   input tx_enable;
   input [7:0] tx_data;
   input load_data;
   output tx_out;
   input FE_OFN1_nclk;
   input FE_OFN2_nclk;

   // Internal wires
   wire FE_OFN4_n13;
   wire n9;
   wire n10;
   wire n11;
   wire n12;
   wire n13;
   wire n14;
   wire n15;
   wire n16;
   wire n17;
   wire n18;
   wire n19;
   wire n20;
   wire n21;
   wire n22;
   wire n23;
   wire n24;
   wire n25;
   wire n26;
   wire n27;
   wire n28;
   wire n36;
   wire n37;
   wire n38;
   wire n39;
   wire n40;
   wire n41;
   wire n42;
   wire [7:1] curr_val;

   BUFX2 FE_OFC4_n13 (.Y(FE_OFN4_n13), 
	.A(n13));
   DFFSR \curr_val_reg[7]  (.S(1'b1), 
	.R(n_rst), 
	.Q(curr_val[7]), 
	.D(n41), 
	.CLK(clk));
   DFFSR \curr_val_reg[6]  (.S(1'b1), 
	.R(n_rst), 
	.Q(curr_val[6]), 
	.D(n40), 
	.CLK(clk));
   DFFSR \curr_val_reg[5]  (.S(1'b1), 
	.R(n_rst), 
	.Q(curr_val[5]), 
	.D(n39), 
	.CLK(FE_OFN2_nclk));
   DFFSR \curr_val_reg[4]  (.S(1'b1), 
	.R(n_rst), 
	.Q(curr_val[4]), 
	.D(n38), 
	.CLK(FE_OFN1_nclk));
   DFFSR \curr_val_reg[3]  (.S(1'b1), 
	.R(n_rst), 
	.Q(curr_val[3]), 
	.D(n37), 
	.CLK(FE_OFN1_nclk));
   DFFSR \curr_val_reg[2]  (.S(1'b1), 
	.R(n_rst), 
	.Q(curr_val[2]), 
	.D(n36), 
	.CLK(clk));
   DFFSR \curr_val_reg[1]  (.S(1'b1), 
	.R(n_rst), 
	.Q(curr_val[1]), 
	.D(n28), 
	.CLK(clk));
   DFFSR \curr_val_reg[0]  (.S(1'b1), 
	.R(n_rst), 
	.Q(tx_out), 
	.D(n42), 
	.CLK(FE_OFN1_nclk));
   OAI21X1 U11 (.Y(n28), 
	.C(n11), 
	.B(n10), 
	.A(n9));
   AOI22X1 U12 (.Y(n11), 
	.D(FE_OFN4_n13), 
	.C(curr_val[1]), 
	.B(n12), 
	.A(curr_val[2]));
   INVX1 U13 (.Y(n10), 
	.A(tx_data[1]));
   OAI21X1 U14 (.Y(n36), 
	.C(n15), 
	.B(n14), 
	.A(n9));
   AOI22X1 U15 (.Y(n15), 
	.D(curr_val[2]), 
	.C(FE_OFN4_n13), 
	.B(n12), 
	.A(curr_val[3]));
   INVX1 U16 (.Y(n14), 
	.A(tx_data[2]));
   OAI21X1 U17 (.Y(n37), 
	.C(n17), 
	.B(n16), 
	.A(n9));
   AOI22X1 U18 (.Y(n17), 
	.D(FE_OFN4_n13), 
	.C(curr_val[3]), 
	.B(n12), 
	.A(curr_val[4]));
   INVX1 U19 (.Y(n16), 
	.A(tx_data[3]));
   OAI21X1 U20 (.Y(n38), 
	.C(n19), 
	.B(n18), 
	.A(n9));
   AOI22X1 U21 (.Y(n19), 
	.D(FE_OFN4_n13), 
	.C(curr_val[4]), 
	.B(n12), 
	.A(curr_val[5]));
   INVX1 U22 (.Y(n18), 
	.A(tx_data[4]));
   OAI21X1 U23 (.Y(n39), 
	.C(n21), 
	.B(n20), 
	.A(n9));
   AOI22X1 U24 (.Y(n21), 
	.D(FE_OFN4_n13), 
	.C(curr_val[5]), 
	.B(n12), 
	.A(curr_val[6]));
   INVX1 U25 (.Y(n20), 
	.A(tx_data[5]));
   OAI21X1 U26 (.Y(n40), 
	.C(n23), 
	.B(n22), 
	.A(n9));
   AOI22X1 U27 (.Y(n23), 
	.D(FE_OFN4_n13), 
	.C(curr_val[6]), 
	.B(n12), 
	.A(curr_val[7]));
   INVX1 U28 (.Y(n22), 
	.A(tx_data[6]));
   NAND2X1 U29 (.Y(n41), 
	.B(n25), 
	.A(n24));
   INVX1 U30 (.Y(n25), 
	.A(n12));
   MUX2X1 U31 (.Y(n24), 
	.S(FE_OFN4_n13), 
	.B(tx_data[7]), 
	.A(curr_val[7]));
   OAI21X1 U32 (.Y(n42), 
	.C(n27), 
	.B(n26), 
	.A(n9));
   AOI22X1 U33 (.Y(n27), 
	.D(FE_OFN4_n13), 
	.C(tx_out), 
	.B(n12), 
	.A(curr_val[1]));
   NOR2X1 U34 (.Y(n12), 
	.B(load_data), 
	.A(FE_OFN4_n13));
   AOI21X1 U35 (.Y(n13), 
	.C(load_data), 
	.B(shift_enable), 
	.A(tx_enable));
   INVX1 U36 (.Y(n26), 
	.A(tx_data[0]));
   INVX1 U37 (.Y(n9), 
	.A(load_data));
endmodule

module fiforam (
	wclk, 
	wenable, 
	waddr, 
	raddr, 
	wdata, 
	rdata, 
	FE_OFN0_wenable_fifo, 
	FE_OFN1_nclk, 
	FE_OFN2_nclk);
   input wclk;
   input wenable;
   input [2:0] waddr;
   input [2:0] raddr;
   input [7:0] wdata;
   output [7:0] rdata;
   input FE_OFN0_wenable_fifo;
   input FE_OFN1_nclk;
   input FE_OFN2_nclk;

   // Internal wires
   wire FE_OFN22_n174;
   wire FE_OFN21_n172;
   wire FE_OFN20_n175;
   wire FE_OFN19_n173;
   wire FE_OFN18_n183;
   wire FE_OFN17_n241;
   wire FE_OFN16_n223;
   wire FE_OFN15_n203;
   wire FE_OFN14_n250;
   wire FE_OFN13_n232;
   wire FE_OFN12_n214;
   wire FE_OFN11_n190;
   wire FE_OFN10_n55;
   wire FE_OFN9_n53;
   wire FE_OFN8_n56;
   wire FE_OFN7_n54;
   wire FE_OFN3_nclk;
   wire N10;
   wire N11;
   wire N12;
   wire N13;
   wire N14;
   wire N15;
   wire \fiforeg[0][7] ;
   wire \fiforeg[0][6] ;
   wire \fiforeg[0][5] ;
   wire \fiforeg[0][4] ;
   wire \fiforeg[0][3] ;
   wire \fiforeg[0][2] ;
   wire \fiforeg[0][1] ;
   wire \fiforeg[0][0] ;
   wire \fiforeg[1][7] ;
   wire \fiforeg[1][6] ;
   wire \fiforeg[1][5] ;
   wire \fiforeg[1][4] ;
   wire \fiforeg[1][3] ;
   wire \fiforeg[1][2] ;
   wire \fiforeg[1][1] ;
   wire \fiforeg[1][0] ;
   wire \fiforeg[2][7] ;
   wire \fiforeg[2][6] ;
   wire \fiforeg[2][5] ;
   wire \fiforeg[2][4] ;
   wire \fiforeg[2][3] ;
   wire \fiforeg[2][2] ;
   wire \fiforeg[2][1] ;
   wire \fiforeg[2][0] ;
   wire \fiforeg[3][7] ;
   wire \fiforeg[3][6] ;
   wire \fiforeg[3][5] ;
   wire \fiforeg[3][4] ;
   wire \fiforeg[3][3] ;
   wire \fiforeg[3][2] ;
   wire \fiforeg[3][1] ;
   wire \fiforeg[3][0] ;
   wire \fiforeg[4][7] ;
   wire \fiforeg[4][6] ;
   wire \fiforeg[4][5] ;
   wire \fiforeg[4][4] ;
   wire \fiforeg[4][3] ;
   wire \fiforeg[4][2] ;
   wire \fiforeg[4][1] ;
   wire \fiforeg[4][0] ;
   wire \fiforeg[5][7] ;
   wire \fiforeg[5][6] ;
   wire \fiforeg[5][5] ;
   wire \fiforeg[5][4] ;
   wire \fiforeg[5][3] ;
   wire \fiforeg[5][2] ;
   wire \fiforeg[5][1] ;
   wire \fiforeg[5][0] ;
   wire \fiforeg[6][7] ;
   wire \fiforeg[6][6] ;
   wire \fiforeg[6][5] ;
   wire \fiforeg[6][4] ;
   wire \fiforeg[6][3] ;
   wire \fiforeg[6][2] ;
   wire \fiforeg[6][1] ;
   wire \fiforeg[6][0] ;
   wire \fiforeg[7][7] ;
   wire \fiforeg[7][6] ;
   wire \fiforeg[7][5] ;
   wire \fiforeg[7][4] ;
   wire \fiforeg[7][3] ;
   wire \fiforeg[7][2] ;
   wire \fiforeg[7][1] ;
   wire \fiforeg[7][0] ;
   wire N17;
   wire N18;
   wire N19;
   wire N20;
   wire N21;
   wire N22;
   wire N23;
   wire N24;
   wire n89;
   wire n90;
   wire n91;
   wire n92;
   wire n93;
   wire n94;
   wire n95;
   wire n96;
   wire n97;
   wire n98;
   wire n99;
   wire n100;
   wire n101;
   wire n102;
   wire n103;
   wire n104;
   wire n105;
   wire n106;
   wire n107;
   wire n108;
   wire n109;
   wire n110;
   wire n111;
   wire n112;
   wire n113;
   wire n114;
   wire n115;
   wire n116;
   wire n117;
   wire n118;
   wire n119;
   wire n120;
   wire n121;
   wire n122;
   wire n123;
   wire n124;
   wire n125;
   wire n126;
   wire n127;
   wire n128;
   wire n129;
   wire n130;
   wire n131;
   wire n132;
   wire n133;
   wire n134;
   wire n135;
   wire n136;
   wire n137;
   wire n138;
   wire n139;
   wire n140;
   wire n141;
   wire n142;
   wire n143;
   wire n144;
   wire n145;
   wire n146;
   wire n147;
   wire n148;
   wire n149;
   wire n150;
   wire n151;
   wire n152;
   wire n9;
   wire n10;
   wire n11;
   wire n12;
   wire n13;
   wire n14;
   wire n15;
   wire n16;
   wire n17;
   wire n18;
   wire n19;
   wire n20;
   wire n21;
   wire n22;
   wire n23;
   wire n24;
   wire n25;
   wire n26;
   wire n27;
   wire n28;
   wire n29;
   wire n30;
   wire n31;
   wire n32;
   wire n33;
   wire n34;
   wire n35;
   wire n36;
   wire n37;
   wire n38;
   wire n39;
   wire n40;
   wire n41;
   wire n42;
   wire n43;
   wire n44;
   wire n45;
   wire n46;
   wire n47;
   wire n48;
   wire n49;
   wire n50;
   wire n51;
   wire n52;
   wire n53;
   wire n54;
   wire n55;
   wire n56;
   wire n57;
   wire n58;
   wire n59;
   wire n60;
   wire n61;
   wire n62;
   wire n63;
   wire n64;
   wire n65;
   wire n66;
   wire n67;
   wire n68;
   wire n69;
   wire n70;
   wire n71;
   wire n72;
   wire n73;
   wire n74;
   wire n75;
   wire n76;
   wire n77;
   wire n78;
   wire n79;
   wire n80;
   wire n81;
   wire n82;
   wire n83;
   wire n84;
   wire n85;
   wire n86;
   wire n87;
   wire n88;
   wire n153;
   wire n154;
   wire n155;
   wire n156;
   wire n157;
   wire n158;
   wire n159;
   wire n160;
   wire n161;
   wire n162;
   wire n163;
   wire n164;
   wire n165;
   wire n166;
   wire n167;
   wire n168;
   wire n169;
   wire n170;
   wire n171;
   wire n172;
   wire n173;
   wire n174;
   wire n175;
   wire n176;
   wire n177;
   wire n178;
   wire n179;
   wire n180;
   wire n181;
   wire n182;
   wire n183;
   wire n184;
   wire n185;
   wire n186;
   wire n187;
   wire n188;
   wire n189;
   wire n190;
   wire n191;
   wire n192;
   wire n193;
   wire n194;
   wire n195;
   wire n196;
   wire n197;
   wire n198;
   wire n199;
   wire n200;
   wire n201;
   wire n202;
   wire n203;
   wire n204;
   wire n205;
   wire n206;
   wire n207;
   wire n208;
   wire n209;
   wire n210;
   wire n211;
   wire n212;
   wire n213;
   wire n214;
   wire n215;
   wire n216;
   wire n217;
   wire n218;
   wire n219;
   wire n220;
   wire n221;
   wire n222;
   wire n223;
   wire n224;
   wire n225;
   wire n226;
   wire n227;
   wire n228;
   wire n229;
   wire n230;
   wire n231;
   wire n232;
   wire n233;
   wire n234;
   wire n235;
   wire n236;
   wire n237;
   wire n238;
   wire n239;
   wire n240;
   wire n241;
   wire n242;
   wire n243;
   wire n244;
   wire n245;
   wire n246;
   wire n247;
   wire n248;
   wire n249;
   wire n250;
   wire n251;
   wire n252;
   wire n253;
   wire n254;
   wire n255;
   wire n256;
   wire n257;
   wire n258;
   wire n259;
   wire n260;
   wire n261;
   wire n262;

   assign N10 = raddr[0] ;
   assign N11 = raddr[1] ;
   assign N12 = raddr[2] ;
   assign N13 = waddr[0] ;
   assign N14 = waddr[1] ;
   assign N15 = waddr[2] ;

   BUFX4 FE_OFC22_n174 (.Y(FE_OFN22_n174), 
	.A(n174));
   BUFX4 FE_OFC21_n172 (.Y(FE_OFN21_n172), 
	.A(n172));
   BUFX2 FE_OFC20_n175 (.Y(FE_OFN20_n175), 
	.A(n175));
   BUFX4 FE_OFC19_n173 (.Y(FE_OFN19_n173), 
	.A(n173));
   BUFX2 FE_OFC18_n183 (.Y(FE_OFN18_n183), 
	.A(n183));
   BUFX2 FE_OFC17_n241 (.Y(FE_OFN17_n241), 
	.A(n241));
   BUFX2 FE_OFC16_n223 (.Y(FE_OFN16_n223), 
	.A(n223));
   BUFX2 FE_OFC15_n203 (.Y(FE_OFN15_n203), 
	.A(n203));
   BUFX2 FE_OFC14_n250 (.Y(FE_OFN14_n250), 
	.A(n250));
   BUFX2 FE_OFC13_n232 (.Y(FE_OFN13_n232), 
	.A(n232));
   BUFX2 FE_OFC12_n214 (.Y(FE_OFN12_n214), 
	.A(n214));
   BUFX2 FE_OFC11_n190 (.Y(FE_OFN11_n190), 
	.A(n190));
   BUFX2 FE_OFC10_n55 (.Y(FE_OFN10_n55), 
	.A(n55));
   BUFX2 FE_OFC9_n53 (.Y(FE_OFN9_n53), 
	.A(n53));
   BUFX4 FE_OFC8_n56 (.Y(FE_OFN8_n56), 
	.A(n56));
   BUFX4 FE_OFC7_n54 (.Y(FE_OFN7_n54), 
	.A(n54));
   BUFX4 FE_OFC3_nclk (.Y(FE_OFN3_nclk), 
	.A(wclk));
   DFFPOSX1 \fiforeg_reg[0][7]  (.Q(\fiforeg[0][7] ), 
	.D(n152), 
	.CLK(FE_OFN3_nclk));
   DFFPOSX1 \fiforeg_reg[0][6]  (.Q(\fiforeg[0][6] ), 
	.D(n151), 
	.CLK(FE_OFN3_nclk));
   DFFPOSX1 \fiforeg_reg[0][5]  (.Q(\fiforeg[0][5] ), 
	.D(n150), 
	.CLK(FE_OFN2_nclk));
   DFFPOSX1 \fiforeg_reg[0][4]  (.Q(\fiforeg[0][4] ), 
	.D(n149), 
	.CLK(FE_OFN2_nclk));
   DFFPOSX1 \fiforeg_reg[0][3]  (.Q(\fiforeg[0][3] ), 
	.D(n148), 
	.CLK(wclk));
   DFFPOSX1 \fiforeg_reg[0][2]  (.Q(\fiforeg[0][2] ), 
	.D(n147), 
	.CLK(wclk));
   DFFPOSX1 \fiforeg_reg[0][1]  (.Q(\fiforeg[0][1] ), 
	.D(n146), 
	.CLK(wclk));
   DFFPOSX1 \fiforeg_reg[0][0]  (.Q(\fiforeg[0][0] ), 
	.D(n145), 
	.CLK(FE_OFN2_nclk));
   DFFPOSX1 \fiforeg_reg[1][7]  (.Q(\fiforeg[1][7] ), 
	.D(n144), 
	.CLK(FE_OFN3_nclk));
   DFFPOSX1 \fiforeg_reg[1][6]  (.Q(\fiforeg[1][6] ), 
	.D(n143), 
	.CLK(FE_OFN3_nclk));
   DFFPOSX1 \fiforeg_reg[1][5]  (.Q(\fiforeg[1][5] ), 
	.D(n142), 
	.CLK(wclk));
   DFFPOSX1 \fiforeg_reg[1][4]  (.Q(\fiforeg[1][4] ), 
	.D(n141), 
	.CLK(FE_OFN2_nclk));
   DFFPOSX1 \fiforeg_reg[1][3]  (.Q(\fiforeg[1][3] ), 
	.D(n140), 
	.CLK(wclk));
   DFFPOSX1 \fiforeg_reg[1][2]  (.Q(\fiforeg[1][2] ), 
	.D(n139), 
	.CLK(wclk));
   DFFPOSX1 \fiforeg_reg[1][1]  (.Q(\fiforeg[1][1] ), 
	.D(n138), 
	.CLK(FE_OFN3_nclk));
   DFFPOSX1 \fiforeg_reg[1][0]  (.Q(\fiforeg[1][0] ), 
	.D(n137), 
	.CLK(FE_OFN2_nclk));
   DFFPOSX1 \fiforeg_reg[2][7]  (.Q(\fiforeg[2][7] ), 
	.D(n136), 
	.CLK(FE_OFN3_nclk));
   DFFPOSX1 \fiforeg_reg[2][6]  (.Q(\fiforeg[2][6] ), 
	.D(n135), 
	.CLK(FE_OFN3_nclk));
   DFFPOSX1 \fiforeg_reg[2][5]  (.Q(\fiforeg[2][5] ), 
	.D(n134), 
	.CLK(FE_OFN2_nclk));
   DFFPOSX1 \fiforeg_reg[2][4]  (.Q(\fiforeg[2][4] ), 
	.D(n133), 
	.CLK(FE_OFN2_nclk));
   DFFPOSX1 \fiforeg_reg[2][3]  (.Q(\fiforeg[2][3] ), 
	.D(n132), 
	.CLK(wclk));
   DFFPOSX1 \fiforeg_reg[2][2]  (.Q(\fiforeg[2][2] ), 
	.D(n131), 
	.CLK(wclk));
   DFFPOSX1 \fiforeg_reg[2][1]  (.Q(\fiforeg[2][1] ), 
	.D(n130), 
	.CLK(wclk));
   DFFPOSX1 \fiforeg_reg[2][0]  (.Q(\fiforeg[2][0] ), 
	.D(n129), 
	.CLK(FE_OFN2_nclk));
   DFFPOSX1 \fiforeg_reg[3][7]  (.Q(\fiforeg[3][7] ), 
	.D(n128), 
	.CLK(FE_OFN3_nclk));
   DFFPOSX1 \fiforeg_reg[3][6]  (.Q(\fiforeg[3][6] ), 
	.D(n127), 
	.CLK(FE_OFN3_nclk));
   DFFPOSX1 \fiforeg_reg[3][5]  (.Q(\fiforeg[3][5] ), 
	.D(n126), 
	.CLK(wclk));
   DFFPOSX1 \fiforeg_reg[3][4]  (.Q(\fiforeg[3][4] ), 
	.D(n125), 
	.CLK(FE_OFN2_nclk));
   DFFPOSX1 \fiforeg_reg[3][3]  (.Q(\fiforeg[3][3] ), 
	.D(n124), 
	.CLK(wclk));
   DFFPOSX1 \fiforeg_reg[3][2]  (.Q(\fiforeg[3][2] ), 
	.D(n123), 
	.CLK(wclk));
   DFFPOSX1 \fiforeg_reg[3][1]  (.Q(\fiforeg[3][1] ), 
	.D(n122), 
	.CLK(FE_OFN3_nclk));
   DFFPOSX1 \fiforeg_reg[3][0]  (.Q(\fiforeg[3][0] ), 
	.D(n121), 
	.CLK(FE_OFN3_nclk));
   DFFPOSX1 \fiforeg_reg[4][7]  (.Q(\fiforeg[4][7] ), 
	.D(n120), 
	.CLK(FE_OFN3_nclk));
   DFFPOSX1 \fiforeg_reg[4][6]  (.Q(\fiforeg[4][6] ), 
	.D(n119), 
	.CLK(FE_OFN3_nclk));
   DFFPOSX1 \fiforeg_reg[4][5]  (.Q(\fiforeg[4][5] ), 
	.D(n118), 
	.CLK(FE_OFN3_nclk));
   DFFPOSX1 \fiforeg_reg[4][4]  (.Q(\fiforeg[4][4] ), 
	.D(n117), 
	.CLK(FE_OFN2_nclk));
   DFFPOSX1 \fiforeg_reg[4][3]  (.Q(\fiforeg[4][3] ), 
	.D(n116), 
	.CLK(FE_OFN1_nclk));
   DFFPOSX1 \fiforeg_reg[4][2]  (.Q(\fiforeg[4][2] ), 
	.D(n115), 
	.CLK(wclk));
   DFFPOSX1 \fiforeg_reg[4][1]  (.Q(\fiforeg[4][1] ), 
	.D(n114), 
	.CLK(FE_OFN2_nclk));
   DFFPOSX1 \fiforeg_reg[4][0]  (.Q(\fiforeg[4][0] ), 
	.D(n113), 
	.CLK(FE_OFN2_nclk));
   DFFPOSX1 \fiforeg_reg[5][7]  (.Q(\fiforeg[5][7] ), 
	.D(n112), 
	.CLK(FE_OFN3_nclk));
   DFFPOSX1 \fiforeg_reg[5][6]  (.Q(\fiforeg[5][6] ), 
	.D(n111), 
	.CLK(FE_OFN3_nclk));
   DFFPOSX1 \fiforeg_reg[5][5]  (.Q(\fiforeg[5][5] ), 
	.D(n110), 
	.CLK(FE_OFN2_nclk));
   DFFPOSX1 \fiforeg_reg[5][4]  (.Q(\fiforeg[5][4] ), 
	.D(n109), 
	.CLK(FE_OFN1_nclk));
   DFFPOSX1 \fiforeg_reg[5][3]  (.Q(\fiforeg[5][3] ), 
	.D(n108), 
	.CLK(FE_OFN2_nclk));
   DFFPOSX1 \fiforeg_reg[5][2]  (.Q(\fiforeg[5][2] ), 
	.D(n107), 
	.CLK(wclk));
   DFFPOSX1 \fiforeg_reg[5][1]  (.Q(\fiforeg[5][1] ), 
	.D(n106), 
	.CLK(FE_OFN3_nclk));
   DFFPOSX1 \fiforeg_reg[5][0]  (.Q(\fiforeg[5][0] ), 
	.D(n105), 
	.CLK(FE_OFN2_nclk));
   DFFPOSX1 \fiforeg_reg[6][7]  (.Q(\fiforeg[6][7] ), 
	.D(n104), 
	.CLK(FE_OFN3_nclk));
   DFFPOSX1 \fiforeg_reg[6][6]  (.Q(\fiforeg[6][6] ), 
	.D(n103), 
	.CLK(FE_OFN3_nclk));
   DFFPOSX1 \fiforeg_reg[6][5]  (.Q(\fiforeg[6][5] ), 
	.D(n102), 
	.CLK(FE_OFN2_nclk));
   DFFPOSX1 \fiforeg_reg[6][4]  (.Q(\fiforeg[6][4] ), 
	.D(n101), 
	.CLK(FE_OFN2_nclk));
   DFFPOSX1 \fiforeg_reg[6][3]  (.Q(\fiforeg[6][3] ), 
	.D(n100), 
	.CLK(FE_OFN1_nclk));
   DFFPOSX1 \fiforeg_reg[6][2]  (.Q(\fiforeg[6][2] ), 
	.D(n99), 
	.CLK(wclk));
   DFFPOSX1 \fiforeg_reg[6][1]  (.Q(\fiforeg[6][1] ), 
	.D(n98), 
	.CLK(FE_OFN2_nclk));
   DFFPOSX1 \fiforeg_reg[6][0]  (.Q(\fiforeg[6][0] ), 
	.D(n97), 
	.CLK(FE_OFN1_nclk));
   DFFPOSX1 \fiforeg_reg[7][7]  (.Q(\fiforeg[7][7] ), 
	.D(n96), 
	.CLK(FE_OFN3_nclk));
   DFFPOSX1 \fiforeg_reg[7][6]  (.Q(\fiforeg[7][6] ), 
	.D(n95), 
	.CLK(FE_OFN3_nclk));
   DFFPOSX1 \fiforeg_reg[7][5]  (.Q(\fiforeg[7][5] ), 
	.D(n94), 
	.CLK(FE_OFN2_nclk));
   DFFPOSX1 \fiforeg_reg[7][4]  (.Q(\fiforeg[7][4] ), 
	.D(n93), 
	.CLK(FE_OFN1_nclk));
   DFFPOSX1 \fiforeg_reg[7][3]  (.Q(\fiforeg[7][3] ), 
	.D(n92), 
	.CLK(FE_OFN1_nclk));
   DFFPOSX1 \fiforeg_reg[7][2]  (.Q(\fiforeg[7][2] ), 
	.D(n91), 
	.CLK(wclk));
   DFFPOSX1 \fiforeg_reg[7][1]  (.Q(\fiforeg[7][1] ), 
	.D(n90), 
	.CLK(wclk));
   DFFPOSX1 \fiforeg_reg[7][0]  (.Q(\fiforeg[7][0] ), 
	.D(n89), 
	.CLK(FE_OFN2_nclk));
   NOR2X1 U10 (.Y(n54), 
	.B(N11), 
	.A(n63));
   NOR2X1 U11 (.Y(n53), 
	.B(n62), 
	.A(n63));
   AOI22X1 U12 (.Y(n10), 
	.D(n53), 
	.C(\fiforeg[6][0] ), 
	.B(FE_OFN7_n54), 
	.A(\fiforeg[4][0] ));
   NOR2X1 U13 (.Y(n56), 
	.B(N12), 
	.A(N11));
   NOR2X1 U14 (.Y(n55), 
	.B(N12), 
	.A(n62));
   AOI22X1 U15 (.Y(n9), 
	.D(n55), 
	.C(\fiforeg[2][0] ), 
	.B(FE_OFN8_n56), 
	.A(\fiforeg[0][0] ));
   AOI21X1 U16 (.Y(n14), 
	.C(N10), 
	.B(n9), 
	.A(n10));
   AOI22X1 U17 (.Y(n12), 
	.D(FE_OFN9_n53), 
	.C(\fiforeg[7][0] ), 
	.B(FE_OFN7_n54), 
	.A(\fiforeg[5][0] ));
   AOI22X1 U18 (.Y(n11), 
	.D(n55), 
	.C(\fiforeg[3][0] ), 
	.B(FE_OFN8_n56), 
	.A(\fiforeg[1][0] ));
   AOI21X1 U19 (.Y(n13), 
	.C(n61), 
	.B(n11), 
	.A(n12));
   OR2X1 U20 (.Y(rdata[0]), 
	.B(n13), 
	.A(n14));
   AOI22X1 U21 (.Y(n16), 
	.D(FE_OFN9_n53), 
	.C(\fiforeg[6][1] ), 
	.B(FE_OFN7_n54), 
	.A(\fiforeg[4][1] ));
   AOI22X1 U22 (.Y(n15), 
	.D(FE_OFN10_n55), 
	.C(\fiforeg[2][1] ), 
	.B(FE_OFN8_n56), 
	.A(\fiforeg[0][1] ));
   AOI21X1 U23 (.Y(n20), 
	.C(N10), 
	.B(n15), 
	.A(n16));
   AOI22X1 U24 (.Y(n18), 
	.D(FE_OFN9_n53), 
	.C(\fiforeg[7][1] ), 
	.B(FE_OFN7_n54), 
	.A(\fiforeg[5][1] ));
   AOI22X1 U25 (.Y(n17), 
	.D(FE_OFN10_n55), 
	.C(\fiforeg[3][1] ), 
	.B(FE_OFN8_n56), 
	.A(\fiforeg[1][1] ));
   AOI21X1 U26 (.Y(n19), 
	.C(n61), 
	.B(n17), 
	.A(n18));
   OR2X1 U27 (.Y(rdata[1]), 
	.B(n19), 
	.A(n20));
   AOI22X1 U28 (.Y(n22), 
	.D(FE_OFN9_n53), 
	.C(\fiforeg[6][2] ), 
	.B(FE_OFN7_n54), 
	.A(\fiforeg[4][2] ));
   AOI22X1 U29 (.Y(n21), 
	.D(FE_OFN10_n55), 
	.C(\fiforeg[2][2] ), 
	.B(FE_OFN8_n56), 
	.A(\fiforeg[0][2] ));
   AOI21X1 U30 (.Y(n26), 
	.C(N10), 
	.B(n21), 
	.A(n22));
   AOI22X1 U31 (.Y(n24), 
	.D(FE_OFN9_n53), 
	.C(\fiforeg[7][2] ), 
	.B(FE_OFN7_n54), 
	.A(\fiforeg[5][2] ));
   AOI22X1 U32 (.Y(n23), 
	.D(FE_OFN10_n55), 
	.C(\fiforeg[3][2] ), 
	.B(FE_OFN8_n56), 
	.A(\fiforeg[1][2] ));
   AOI21X1 U33 (.Y(n25), 
	.C(n61), 
	.B(n23), 
	.A(n24));
   OR2X1 U34 (.Y(rdata[2]), 
	.B(n25), 
	.A(n26));
   AOI22X1 U35 (.Y(n28), 
	.D(n53), 
	.C(\fiforeg[6][3] ), 
	.B(FE_OFN7_n54), 
	.A(\fiforeg[4][3] ));
   AOI22X1 U36 (.Y(n27), 
	.D(n55), 
	.C(\fiforeg[2][3] ), 
	.B(FE_OFN8_n56), 
	.A(\fiforeg[0][3] ));
   AOI21X1 U37 (.Y(n32), 
	.C(N10), 
	.B(n27), 
	.A(n28));
   AOI22X1 U38 (.Y(n30), 
	.D(n53), 
	.C(\fiforeg[7][3] ), 
	.B(FE_OFN7_n54), 
	.A(\fiforeg[5][3] ));
   AOI22X1 U39 (.Y(n29), 
	.D(n55), 
	.C(\fiforeg[3][3] ), 
	.B(FE_OFN8_n56), 
	.A(\fiforeg[1][3] ));
   AOI21X1 U40 (.Y(n31), 
	.C(n61), 
	.B(n29), 
	.A(n30));
   OR2X1 U41 (.Y(rdata[3]), 
	.B(n31), 
	.A(n32));
   AOI22X1 U42 (.Y(n34), 
	.D(n53), 
	.C(\fiforeg[6][4] ), 
	.B(FE_OFN7_n54), 
	.A(\fiforeg[4][4] ));
   AOI22X1 U43 (.Y(n33), 
	.D(FE_OFN10_n55), 
	.C(\fiforeg[2][4] ), 
	.B(FE_OFN8_n56), 
	.A(\fiforeg[0][4] ));
   AOI21X1 U44 (.Y(n38), 
	.C(N10), 
	.B(n33), 
	.A(n34));
   AOI22X1 U45 (.Y(n36), 
	.D(n53), 
	.C(\fiforeg[7][4] ), 
	.B(FE_OFN7_n54), 
	.A(\fiforeg[5][4] ));
   AOI22X1 U46 (.Y(n35), 
	.D(FE_OFN10_n55), 
	.C(\fiforeg[3][4] ), 
	.B(FE_OFN8_n56), 
	.A(\fiforeg[1][4] ));
   AOI21X1 U47 (.Y(n37), 
	.C(n61), 
	.B(n35), 
	.A(n36));
   OR2X1 U48 (.Y(rdata[4]), 
	.B(n37), 
	.A(n38));
   AOI22X1 U49 (.Y(n40), 
	.D(FE_OFN9_n53), 
	.C(\fiforeg[6][5] ), 
	.B(FE_OFN7_n54), 
	.A(\fiforeg[4][5] ));
   AOI22X1 U50 (.Y(n39), 
	.D(FE_OFN10_n55), 
	.C(\fiforeg[2][5] ), 
	.B(FE_OFN8_n56), 
	.A(\fiforeg[0][5] ));
   AOI21X1 U51 (.Y(n44), 
	.C(N10), 
	.B(n39), 
	.A(n40));
   AOI22X1 U52 (.Y(n42), 
	.D(FE_OFN9_n53), 
	.C(\fiforeg[7][5] ), 
	.B(FE_OFN7_n54), 
	.A(\fiforeg[5][5] ));
   AOI22X1 U53 (.Y(n41), 
	.D(FE_OFN10_n55), 
	.C(\fiforeg[3][5] ), 
	.B(FE_OFN8_n56), 
	.A(\fiforeg[1][5] ));
   AOI21X1 U54 (.Y(n43), 
	.C(n61), 
	.B(n41), 
	.A(n42));
   OR2X1 U55 (.Y(rdata[5]), 
	.B(n43), 
	.A(n44));
   AOI22X1 U56 (.Y(n46), 
	.D(FE_OFN9_n53), 
	.C(\fiforeg[6][6] ), 
	.B(FE_OFN7_n54), 
	.A(\fiforeg[4][6] ));
   AOI22X1 U57 (.Y(n45), 
	.D(FE_OFN10_n55), 
	.C(\fiforeg[2][6] ), 
	.B(FE_OFN8_n56), 
	.A(\fiforeg[0][6] ));
   AOI21X1 U58 (.Y(n50), 
	.C(N10), 
	.B(n45), 
	.A(n46));
   AOI22X1 U59 (.Y(n48), 
	.D(FE_OFN9_n53), 
	.C(\fiforeg[7][6] ), 
	.B(FE_OFN7_n54), 
	.A(\fiforeg[5][6] ));
   AOI22X1 U60 (.Y(n47), 
	.D(FE_OFN10_n55), 
	.C(\fiforeg[3][6] ), 
	.B(FE_OFN8_n56), 
	.A(\fiforeg[1][6] ));
   AOI21X1 U61 (.Y(n49), 
	.C(n61), 
	.B(n47), 
	.A(n48));
   OR2X1 U62 (.Y(rdata[6]), 
	.B(n49), 
	.A(n50));
   AOI22X1 U63 (.Y(n52), 
	.D(FE_OFN9_n53), 
	.C(\fiforeg[6][7] ), 
	.B(FE_OFN7_n54), 
	.A(\fiforeg[4][7] ));
   AOI22X1 U64 (.Y(n51), 
	.D(FE_OFN10_n55), 
	.C(\fiforeg[2][7] ), 
	.B(FE_OFN8_n56), 
	.A(\fiforeg[0][7] ));
   AOI21X1 U65 (.Y(n60), 
	.C(N10), 
	.B(n51), 
	.A(n52));
   AOI22X1 U66 (.Y(n58), 
	.D(FE_OFN9_n53), 
	.C(\fiforeg[7][7] ), 
	.B(FE_OFN7_n54), 
	.A(\fiforeg[5][7] ));
   AOI22X1 U67 (.Y(n57), 
	.D(FE_OFN10_n55), 
	.C(\fiforeg[3][7] ), 
	.B(FE_OFN8_n56), 
	.A(\fiforeg[1][7] ));
   AOI21X1 U68 (.Y(n59), 
	.C(n61), 
	.B(n57), 
	.A(n58));
   OR2X1 U69 (.Y(rdata[7]), 
	.B(n59), 
	.A(n60));
   INVX2 U70 (.Y(n61), 
	.A(N10));
   INVX2 U71 (.Y(n62), 
	.A(N11));
   INVX2 U72 (.Y(n63), 
	.A(N12));
   NOR2X1 U73 (.Y(n173), 
	.B(N14), 
	.A(n211));
   NOR2X1 U74 (.Y(n172), 
	.B(n180), 
	.A(n211));
   AOI22X1 U75 (.Y(n65), 
	.D(FE_OFN21_n172), 
	.C(\fiforeg[6][0] ), 
	.B(FE_OFN19_n173), 
	.A(\fiforeg[4][0] ));
   NOR2X1 U76 (.Y(n175), 
	.B(N15), 
	.A(N14));
   NOR2X1 U77 (.Y(n174), 
	.B(N15), 
	.A(n180));
   AOI22X1 U78 (.Y(n64), 
	.D(FE_OFN22_n174), 
	.C(\fiforeg[2][0] ), 
	.B(n175), 
	.A(\fiforeg[0][0] ));
   AOI21X1 U79 (.Y(n69), 
	.C(N13), 
	.B(n64), 
	.A(n65));
   AOI22X1 U80 (.Y(n67), 
	.D(FE_OFN21_n172), 
	.C(\fiforeg[7][0] ), 
	.B(FE_OFN19_n173), 
	.A(\fiforeg[5][0] ));
   AOI22X1 U81 (.Y(n66), 
	.D(FE_OFN22_n174), 
	.C(\fiforeg[3][0] ), 
	.B(FE_OFN20_n175), 
	.A(\fiforeg[1][0] ));
   AOI21X1 U82 (.Y(n68), 
	.C(n212), 
	.B(n66), 
	.A(n67));
   OR2X1 U83 (.Y(N24), 
	.B(n68), 
	.A(n69));
   AOI22X1 U84 (.Y(n71), 
	.D(FE_OFN21_n172), 
	.C(\fiforeg[6][1] ), 
	.B(FE_OFN19_n173), 
	.A(\fiforeg[4][1] ));
   AOI22X1 U85 (.Y(n70), 
	.D(FE_OFN22_n174), 
	.C(\fiforeg[2][1] ), 
	.B(FE_OFN20_n175), 
	.A(\fiforeg[0][1] ));
   AOI21X1 U86 (.Y(n75), 
	.C(N13), 
	.B(n70), 
	.A(n71));
   AOI22X1 U87 (.Y(n73), 
	.D(FE_OFN21_n172), 
	.C(\fiforeg[7][1] ), 
	.B(FE_OFN19_n173), 
	.A(\fiforeg[5][1] ));
   AOI22X1 U88 (.Y(n72), 
	.D(FE_OFN22_n174), 
	.C(\fiforeg[3][1] ), 
	.B(FE_OFN20_n175), 
	.A(\fiforeg[1][1] ));
   AOI21X1 U89 (.Y(n74), 
	.C(n212), 
	.B(n72), 
	.A(n73));
   OR2X1 U90 (.Y(N23), 
	.B(n74), 
	.A(n75));
   AOI22X1 U91 (.Y(n77), 
	.D(FE_OFN21_n172), 
	.C(\fiforeg[6][2] ), 
	.B(FE_OFN19_n173), 
	.A(\fiforeg[4][2] ));
   AOI22X1 U92 (.Y(n76), 
	.D(FE_OFN22_n174), 
	.C(\fiforeg[2][2] ), 
	.B(FE_OFN20_n175), 
	.A(\fiforeg[0][2] ));
   AOI21X1 U93 (.Y(n81), 
	.C(N13), 
	.B(n76), 
	.A(n77));
   AOI22X1 U94 (.Y(n79), 
	.D(FE_OFN21_n172), 
	.C(\fiforeg[7][2] ), 
	.B(FE_OFN19_n173), 
	.A(\fiforeg[5][2] ));
   AOI22X1 U95 (.Y(n78), 
	.D(FE_OFN22_n174), 
	.C(\fiforeg[3][2] ), 
	.B(FE_OFN20_n175), 
	.A(\fiforeg[1][2] ));
   AOI21X1 U96 (.Y(n80), 
	.C(n212), 
	.B(n78), 
	.A(n79));
   OR2X1 U97 (.Y(N22), 
	.B(n80), 
	.A(n81));
   AOI22X1 U98 (.Y(n83), 
	.D(FE_OFN21_n172), 
	.C(\fiforeg[6][3] ), 
	.B(FE_OFN19_n173), 
	.A(\fiforeg[4][3] ));
   AOI22X1 U99 (.Y(n82), 
	.D(FE_OFN22_n174), 
	.C(\fiforeg[2][3] ), 
	.B(n175), 
	.A(\fiforeg[0][3] ));
   AOI21X1 U100 (.Y(n87), 
	.C(N13), 
	.B(n82), 
	.A(n83));
   AOI22X1 U101 (.Y(n85), 
	.D(FE_OFN21_n172), 
	.C(\fiforeg[7][3] ), 
	.B(FE_OFN19_n173), 
	.A(\fiforeg[5][3] ));
   AOI22X1 U102 (.Y(n84), 
	.D(FE_OFN22_n174), 
	.C(\fiforeg[3][3] ), 
	.B(n175), 
	.A(\fiforeg[1][3] ));
   AOI21X1 U103 (.Y(n86), 
	.C(n212), 
	.B(n84), 
	.A(n85));
   OR2X1 U104 (.Y(N21), 
	.B(n86), 
	.A(n87));
   AOI22X1 U105 (.Y(n153), 
	.D(FE_OFN21_n172), 
	.C(\fiforeg[6][4] ), 
	.B(FE_OFN19_n173), 
	.A(\fiforeg[4][4] ));
   AOI22X1 U106 (.Y(n88), 
	.D(FE_OFN22_n174), 
	.C(\fiforeg[2][4] ), 
	.B(FE_OFN20_n175), 
	.A(\fiforeg[0][4] ));
   AOI21X1 U107 (.Y(n157), 
	.C(N13), 
	.B(n88), 
	.A(n153));
   AOI22X1 U108 (.Y(n155), 
	.D(FE_OFN21_n172), 
	.C(\fiforeg[7][4] ), 
	.B(FE_OFN19_n173), 
	.A(\fiforeg[5][4] ));
   AOI22X1 U109 (.Y(n154), 
	.D(FE_OFN22_n174), 
	.C(\fiforeg[3][4] ), 
	.B(n175), 
	.A(\fiforeg[1][4] ));
   AOI21X1 U110 (.Y(n156), 
	.C(n212), 
	.B(n154), 
	.A(n155));
   OR2X1 U111 (.Y(N20), 
	.B(n156), 
	.A(n157));
   AOI22X1 U112 (.Y(n159), 
	.D(FE_OFN21_n172), 
	.C(\fiforeg[6][5] ), 
	.B(FE_OFN19_n173), 
	.A(\fiforeg[4][5] ));
   AOI22X1 U113 (.Y(n158), 
	.D(FE_OFN22_n174), 
	.C(\fiforeg[2][5] ), 
	.B(FE_OFN20_n175), 
	.A(\fiforeg[0][5] ));
   AOI21X1 U114 (.Y(n163), 
	.C(N13), 
	.B(n158), 
	.A(n159));
   AOI22X1 U115 (.Y(n161), 
	.D(FE_OFN21_n172), 
	.C(\fiforeg[7][5] ), 
	.B(FE_OFN19_n173), 
	.A(\fiforeg[5][5] ));
   AOI22X1 U116 (.Y(n160), 
	.D(FE_OFN22_n174), 
	.C(\fiforeg[3][5] ), 
	.B(FE_OFN20_n175), 
	.A(\fiforeg[1][5] ));
   AOI21X1 U117 (.Y(n162), 
	.C(n212), 
	.B(n160), 
	.A(n161));
   OR2X1 U118 (.Y(N19), 
	.B(n162), 
	.A(n163));
   AOI22X1 U119 (.Y(n165), 
	.D(FE_OFN21_n172), 
	.C(\fiforeg[6][6] ), 
	.B(FE_OFN19_n173), 
	.A(\fiforeg[4][6] ));
   AOI22X1 U120 (.Y(n164), 
	.D(FE_OFN22_n174), 
	.C(\fiforeg[2][6] ), 
	.B(FE_OFN20_n175), 
	.A(\fiforeg[0][6] ));
   AOI21X1 U121 (.Y(n169), 
	.C(N13), 
	.B(n164), 
	.A(n165));
   AOI22X1 U122 (.Y(n167), 
	.D(FE_OFN21_n172), 
	.C(\fiforeg[7][6] ), 
	.B(FE_OFN19_n173), 
	.A(\fiforeg[5][6] ));
   AOI22X1 U123 (.Y(n166), 
	.D(FE_OFN22_n174), 
	.C(\fiforeg[3][6] ), 
	.B(FE_OFN20_n175), 
	.A(\fiforeg[1][6] ));
   AOI21X1 U124 (.Y(n168), 
	.C(n212), 
	.B(n166), 
	.A(n167));
   OR2X1 U125 (.Y(N18), 
	.B(n168), 
	.A(n169));
   AOI22X1 U126 (.Y(n171), 
	.D(FE_OFN21_n172), 
	.C(\fiforeg[6][7] ), 
	.B(FE_OFN19_n173), 
	.A(\fiforeg[4][7] ));
   AOI22X1 U127 (.Y(n170), 
	.D(FE_OFN22_n174), 
	.C(\fiforeg[2][7] ), 
	.B(FE_OFN20_n175), 
	.A(\fiforeg[0][7] ));
   AOI21X1 U128 (.Y(n179), 
	.C(N13), 
	.B(n170), 
	.A(n171));
   AOI22X1 U129 (.Y(n177), 
	.D(FE_OFN21_n172), 
	.C(\fiforeg[7][7] ), 
	.B(FE_OFN19_n173), 
	.A(\fiforeg[5][7] ));
   AOI22X1 U130 (.Y(n176), 
	.D(FE_OFN22_n174), 
	.C(\fiforeg[3][7] ), 
	.B(FE_OFN20_n175), 
	.A(\fiforeg[1][7] ));
   AOI21X1 U131 (.Y(n178), 
	.C(n212), 
	.B(n176), 
	.A(n177));
   OR2X1 U132 (.Y(N17), 
	.B(n178), 
	.A(n179));
   INVX2 U133 (.Y(n180), 
	.A(N14));
   MUX2X1 U134 (.Y(n99), 
	.S(FE_OFN18_n183), 
	.B(n181), 
	.A(n182));
   INVX1 U135 (.Y(n182), 
	.A(\fiforeg[6][2] ));
   MUX2X1 U136 (.Y(n98), 
	.S(FE_OFN18_n183), 
	.B(n184), 
	.A(n185));
   INVX1 U137 (.Y(n185), 
	.A(\fiforeg[6][1] ));
   MUX2X1 U138 (.Y(n97), 
	.S(FE_OFN18_n183), 
	.B(n186), 
	.A(n187));
   INVX1 U139 (.Y(n187), 
	.A(\fiforeg[6][0] ));
   MUX2X1 U140 (.Y(n96), 
	.S(FE_OFN11_n190), 
	.B(n188), 
	.A(n189));
   INVX1 U141 (.Y(n189), 
	.A(\fiforeg[7][7] ));
   MUX2X1 U142 (.Y(n95), 
	.S(FE_OFN11_n190), 
	.B(n191), 
	.A(n192));
   INVX1 U143 (.Y(n192), 
	.A(\fiforeg[7][6] ));
   MUX2X1 U144 (.Y(n94), 
	.S(FE_OFN11_n190), 
	.B(n193), 
	.A(n194));
   INVX1 U145 (.Y(n194), 
	.A(\fiforeg[7][5] ));
   MUX2X1 U146 (.Y(n93), 
	.S(FE_OFN11_n190), 
	.B(n195), 
	.A(n196));
   INVX1 U147 (.Y(n196), 
	.A(\fiforeg[7][4] ));
   MUX2X1 U148 (.Y(n92), 
	.S(FE_OFN11_n190), 
	.B(n197), 
	.A(n198));
   INVX1 U149 (.Y(n198), 
	.A(\fiforeg[7][3] ));
   MUX2X1 U150 (.Y(n91), 
	.S(FE_OFN11_n190), 
	.B(n181), 
	.A(n199));
   INVX1 U151 (.Y(n199), 
	.A(\fiforeg[7][2] ));
   MUX2X1 U152 (.Y(n90), 
	.S(FE_OFN11_n190), 
	.B(n184), 
	.A(n200));
   INVX1 U153 (.Y(n200), 
	.A(\fiforeg[7][1] ));
   MUX2X1 U154 (.Y(n89), 
	.S(FE_OFN11_n190), 
	.B(n186), 
	.A(n201));
   NAND3X1 U155 (.Y(n190), 
	.C(N13), 
	.B(N14), 
	.A(N15));
   INVX1 U156 (.Y(n201), 
	.A(\fiforeg[7][0] ));
   MUX2X1 U157 (.Y(n152), 
	.S(FE_OFN15_n203), 
	.B(n188), 
	.A(n202));
   INVX1 U158 (.Y(n202), 
	.A(\fiforeg[0][7] ));
   MUX2X1 U159 (.Y(n151), 
	.S(FE_OFN15_n203), 
	.B(n191), 
	.A(n204));
   INVX1 U160 (.Y(n204), 
	.A(\fiforeg[0][6] ));
   MUX2X1 U161 (.Y(n150), 
	.S(FE_OFN15_n203), 
	.B(n193), 
	.A(n205));
   INVX1 U162 (.Y(n205), 
	.A(\fiforeg[0][5] ));
   MUX2X1 U163 (.Y(n149), 
	.S(FE_OFN15_n203), 
	.B(n195), 
	.A(n206));
   INVX1 U164 (.Y(n206), 
	.A(\fiforeg[0][4] ));
   MUX2X1 U165 (.Y(n148), 
	.S(FE_OFN15_n203), 
	.B(n197), 
	.A(n207));
   INVX1 U166 (.Y(n207), 
	.A(\fiforeg[0][3] ));
   MUX2X1 U167 (.Y(n147), 
	.S(FE_OFN15_n203), 
	.B(n181), 
	.A(n208));
   INVX1 U168 (.Y(n208), 
	.A(\fiforeg[0][2] ));
   MUX2X1 U169 (.Y(n146), 
	.S(FE_OFN15_n203), 
	.B(n184), 
	.A(n209));
   INVX1 U170 (.Y(n209), 
	.A(\fiforeg[0][1] ));
   MUX2X1 U171 (.Y(n145), 
	.S(FE_OFN15_n203), 
	.B(n186), 
	.A(n210));
   NAND3X1 U172 (.Y(n203), 
	.C(n212), 
	.B(n211), 
	.A(n180));
   INVX1 U173 (.Y(n210), 
	.A(\fiforeg[0][0] ));
   MUX2X1 U174 (.Y(n144), 
	.S(FE_OFN12_n214), 
	.B(n188), 
	.A(n213));
   INVX1 U175 (.Y(n213), 
	.A(\fiforeg[1][7] ));
   MUX2X1 U176 (.Y(n143), 
	.S(FE_OFN12_n214), 
	.B(n191), 
	.A(n215));
   INVX1 U177 (.Y(n215), 
	.A(\fiforeg[1][6] ));
   MUX2X1 U178 (.Y(n142), 
	.S(FE_OFN12_n214), 
	.B(n193), 
	.A(n216));
   INVX1 U179 (.Y(n216), 
	.A(\fiforeg[1][5] ));
   MUX2X1 U180 (.Y(n141), 
	.S(FE_OFN12_n214), 
	.B(n195), 
	.A(n217));
   INVX1 U181 (.Y(n217), 
	.A(\fiforeg[1][4] ));
   MUX2X1 U182 (.Y(n140), 
	.S(FE_OFN12_n214), 
	.B(n197), 
	.A(n218));
   INVX1 U183 (.Y(n218), 
	.A(\fiforeg[1][3] ));
   MUX2X1 U184 (.Y(n139), 
	.S(FE_OFN12_n214), 
	.B(n181), 
	.A(n219));
   INVX1 U185 (.Y(n219), 
	.A(\fiforeg[1][2] ));
   MUX2X1 U186 (.Y(n138), 
	.S(FE_OFN12_n214), 
	.B(n184), 
	.A(n220));
   INVX1 U187 (.Y(n220), 
	.A(\fiforeg[1][1] ));
   MUX2X1 U188 (.Y(n137), 
	.S(FE_OFN12_n214), 
	.B(n186), 
	.A(n221));
   NAND3X1 U189 (.Y(n214), 
	.C(N13), 
	.B(n211), 
	.A(n180));
   INVX1 U190 (.Y(n221), 
	.A(\fiforeg[1][0] ));
   MUX2X1 U191 (.Y(n136), 
	.S(FE_OFN16_n223), 
	.B(n188), 
	.A(n222));
   INVX1 U192 (.Y(n222), 
	.A(\fiforeg[2][7] ));
   MUX2X1 U193 (.Y(n135), 
	.S(FE_OFN16_n223), 
	.B(n191), 
	.A(n224));
   INVX1 U194 (.Y(n224), 
	.A(\fiforeg[2][6] ));
   MUX2X1 U195 (.Y(n134), 
	.S(FE_OFN16_n223), 
	.B(n193), 
	.A(n225));
   INVX1 U196 (.Y(n225), 
	.A(\fiforeg[2][5] ));
   MUX2X1 U197 (.Y(n133), 
	.S(FE_OFN16_n223), 
	.B(n195), 
	.A(n226));
   INVX1 U198 (.Y(n226), 
	.A(\fiforeg[2][4] ));
   MUX2X1 U199 (.Y(n132), 
	.S(FE_OFN16_n223), 
	.B(n197), 
	.A(n227));
   INVX1 U200 (.Y(n227), 
	.A(\fiforeg[2][3] ));
   MUX2X1 U201 (.Y(n131), 
	.S(FE_OFN16_n223), 
	.B(n181), 
	.A(n228));
   INVX1 U202 (.Y(n228), 
	.A(\fiforeg[2][2] ));
   MUX2X1 U203 (.Y(n130), 
	.S(FE_OFN16_n223), 
	.B(n184), 
	.A(n229));
   INVX1 U204 (.Y(n229), 
	.A(\fiforeg[2][1] ));
   MUX2X1 U205 (.Y(n129), 
	.S(FE_OFN16_n223), 
	.B(n186), 
	.A(n230));
   NAND3X1 U206 (.Y(n223), 
	.C(N14), 
	.B(n211), 
	.A(n212));
   INVX1 U207 (.Y(n230), 
	.A(\fiforeg[2][0] ));
   MUX2X1 U208 (.Y(n128), 
	.S(FE_OFN13_n232), 
	.B(n188), 
	.A(n231));
   INVX1 U209 (.Y(n231), 
	.A(\fiforeg[3][7] ));
   MUX2X1 U210 (.Y(n127), 
	.S(FE_OFN13_n232), 
	.B(n191), 
	.A(n233));
   INVX1 U211 (.Y(n233), 
	.A(\fiforeg[3][6] ));
   MUX2X1 U212 (.Y(n126), 
	.S(FE_OFN13_n232), 
	.B(n193), 
	.A(n234));
   INVX1 U213 (.Y(n234), 
	.A(\fiforeg[3][5] ));
   MUX2X1 U214 (.Y(n125), 
	.S(FE_OFN13_n232), 
	.B(n195), 
	.A(n235));
   INVX1 U215 (.Y(n235), 
	.A(\fiforeg[3][4] ));
   MUX2X1 U216 (.Y(n124), 
	.S(FE_OFN13_n232), 
	.B(n197), 
	.A(n236));
   INVX1 U217 (.Y(n236), 
	.A(\fiforeg[3][3] ));
   MUX2X1 U218 (.Y(n123), 
	.S(FE_OFN13_n232), 
	.B(n181), 
	.A(n237));
   INVX1 U219 (.Y(n237), 
	.A(\fiforeg[3][2] ));
   MUX2X1 U220 (.Y(n122), 
	.S(FE_OFN13_n232), 
	.B(n184), 
	.A(n238));
   INVX1 U221 (.Y(n238), 
	.A(\fiforeg[3][1] ));
   MUX2X1 U222 (.Y(n121), 
	.S(FE_OFN13_n232), 
	.B(n186), 
	.A(n239));
   NAND3X1 U223 (.Y(n232), 
	.C(N13), 
	.B(n211), 
	.A(N14));
   INVX1 U224 (.Y(n211), 
	.A(N15));
   INVX1 U225 (.Y(n239), 
	.A(\fiforeg[3][0] ));
   MUX2X1 U226 (.Y(n120), 
	.S(FE_OFN17_n241), 
	.B(n188), 
	.A(n240));
   INVX1 U227 (.Y(n240), 
	.A(\fiforeg[4][7] ));
   MUX2X1 U228 (.Y(n119), 
	.S(FE_OFN17_n241), 
	.B(n191), 
	.A(n242));
   INVX1 U229 (.Y(n242), 
	.A(\fiforeg[4][6] ));
   MUX2X1 U230 (.Y(n118), 
	.S(FE_OFN17_n241), 
	.B(n193), 
	.A(n243));
   INVX1 U231 (.Y(n243), 
	.A(\fiforeg[4][5] ));
   MUX2X1 U232 (.Y(n117), 
	.S(FE_OFN17_n241), 
	.B(n195), 
	.A(n244));
   INVX1 U233 (.Y(n244), 
	.A(\fiforeg[4][4] ));
   MUX2X1 U234 (.Y(n116), 
	.S(FE_OFN17_n241), 
	.B(n197), 
	.A(n245));
   INVX1 U235 (.Y(n245), 
	.A(\fiforeg[4][3] ));
   MUX2X1 U236 (.Y(n115), 
	.S(FE_OFN17_n241), 
	.B(n181), 
	.A(n246));
   INVX1 U237 (.Y(n246), 
	.A(\fiforeg[4][2] ));
   MUX2X1 U238 (.Y(n114), 
	.S(FE_OFN17_n241), 
	.B(n184), 
	.A(n247));
   INVX1 U239 (.Y(n247), 
	.A(\fiforeg[4][1] ));
   MUX2X1 U240 (.Y(n113), 
	.S(FE_OFN17_n241), 
	.B(n186), 
	.A(n248));
   NAND3X1 U241 (.Y(n241), 
	.C(N15), 
	.B(n180), 
	.A(n212));
   INVX1 U242 (.Y(n248), 
	.A(\fiforeg[4][0] ));
   MUX2X1 U243 (.Y(n112), 
	.S(FE_OFN14_n250), 
	.B(n188), 
	.A(n249));
   INVX1 U244 (.Y(n249), 
	.A(\fiforeg[5][7] ));
   MUX2X1 U245 (.Y(n111), 
	.S(FE_OFN14_n250), 
	.B(n191), 
	.A(n251));
   INVX1 U246 (.Y(n251), 
	.A(\fiforeg[5][6] ));
   MUX2X1 U247 (.Y(n110), 
	.S(FE_OFN14_n250), 
	.B(n193), 
	.A(n252));
   INVX1 U248 (.Y(n252), 
	.A(\fiforeg[5][5] ));
   MUX2X1 U249 (.Y(n109), 
	.S(FE_OFN14_n250), 
	.B(n195), 
	.A(n253));
   INVX1 U250 (.Y(n253), 
	.A(\fiforeg[5][4] ));
   MUX2X1 U251 (.Y(n108), 
	.S(FE_OFN14_n250), 
	.B(n197), 
	.A(n254));
   INVX1 U252 (.Y(n254), 
	.A(\fiforeg[5][3] ));
   MUX2X1 U253 (.Y(n107), 
	.S(FE_OFN14_n250), 
	.B(n181), 
	.A(n255));
   INVX1 U254 (.Y(n255), 
	.A(\fiforeg[5][2] ));
   MUX2X1 U255 (.Y(n181), 
	.S(wenable), 
	.B(N22), 
	.A(wdata[2]));
   MUX2X1 U256 (.Y(n106), 
	.S(FE_OFN14_n250), 
	.B(n184), 
	.A(n256));
   INVX1 U257 (.Y(n256), 
	.A(\fiforeg[5][1] ));
   MUX2X1 U258 (.Y(n184), 
	.S(wenable), 
	.B(N23), 
	.A(wdata[1]));
   MUX2X1 U259 (.Y(n105), 
	.S(FE_OFN14_n250), 
	.B(n186), 
	.A(n257));
   NAND3X1 U260 (.Y(n250), 
	.C(N13), 
	.B(n180), 
	.A(N15));
   INVX1 U261 (.Y(n257), 
	.A(\fiforeg[5][0] ));
   MUX2X1 U262 (.Y(n186), 
	.S(wenable), 
	.B(N24), 
	.A(wdata[0]));
   MUX2X1 U263 (.Y(n104), 
	.S(FE_OFN18_n183), 
	.B(n188), 
	.A(n258));
   INVX1 U264 (.Y(n258), 
	.A(\fiforeg[6][7] ));
   MUX2X1 U265 (.Y(n188), 
	.S(FE_OFN0_wenable_fifo), 
	.B(N17), 
	.A(wdata[7]));
   MUX2X1 U266 (.Y(n103), 
	.S(FE_OFN18_n183), 
	.B(n191), 
	.A(n259));
   INVX1 U267 (.Y(n259), 
	.A(\fiforeg[6][6] ));
   MUX2X1 U268 (.Y(n191), 
	.S(FE_OFN0_wenable_fifo), 
	.B(N18), 
	.A(wdata[6]));
   MUX2X1 U269 (.Y(n102), 
	.S(FE_OFN18_n183), 
	.B(n193), 
	.A(n260));
   INVX1 U270 (.Y(n260), 
	.A(\fiforeg[6][5] ));
   MUX2X1 U271 (.Y(n193), 
	.S(FE_OFN0_wenable_fifo), 
	.B(N19), 
	.A(wdata[5]));
   MUX2X1 U272 (.Y(n101), 
	.S(FE_OFN18_n183), 
	.B(n195), 
	.A(n261));
   INVX1 U273 (.Y(n261), 
	.A(\fiforeg[6][4] ));
   MUX2X1 U274 (.Y(n195), 
	.S(FE_OFN0_wenable_fifo), 
	.B(N20), 
	.A(wdata[4]));
   MUX2X1 U275 (.Y(n100), 
	.S(FE_OFN18_n183), 
	.B(n197), 
	.A(n262));
   NAND3X1 U276 (.Y(n183), 
	.C(N15), 
	.B(n212), 
	.A(N14));
   INVX2 U277 (.Y(n212), 
	.A(N13));
   INVX1 U278 (.Y(n262), 
	.A(\fiforeg[6][3] ));
   MUX2X1 U279 (.Y(n197), 
	.S(FE_OFN0_wenable_fifo), 
	.B(N21), 
	.A(wdata[3]));
endmodule

module write_ptr (
	wclk, 
	rst_n, 
	wenable, 
	wptr, 
	wptr_nxt, 
	FE_OFN1_nclk);
   input wclk;
   input rst_n;
   input wenable;
   output [3:0] wptr;
   output [3:0] wptr_nxt;
   input FE_OFN1_nclk;

   // Internal wires
   wire n9;
   wire n10;
   wire n11;
   wire n12;
   wire [2:0] binary_nxt;
   wire [3:0] binary_r;

   DFFSR \binary_r_reg[0]  (.S(1'b1), 
	.R(rst_n), 
	.Q(binary_r[0]), 
	.D(binary_nxt[0]), 
	.CLK(FE_OFN1_nclk));
   DFFSR \binary_r_reg[1]  (.S(1'b1), 
	.R(rst_n), 
	.Q(binary_r[1]), 
	.D(binary_nxt[1]), 
	.CLK(FE_OFN1_nclk));
   DFFSR \binary_r_reg[2]  (.S(1'b1), 
	.R(rst_n), 
	.Q(binary_r[2]), 
	.D(binary_nxt[2]), 
	.CLK(FE_OFN1_nclk));
   DFFSR \binary_r_reg[3]  (.S(1'b1), 
	.R(rst_n), 
	.Q(binary_r[3]), 
	.D(wptr_nxt[3]), 
	.CLK(FE_OFN1_nclk));
   DFFSR \gray_r_reg[3]  (.S(1'b1), 
	.R(rst_n), 
	.Q(wptr[3]), 
	.D(wptr_nxt[3]), 
	.CLK(FE_OFN1_nclk));
   DFFSR \gray_r_reg[2]  (.S(1'b1), 
	.R(rst_n), 
	.Q(wptr[2]), 
	.D(wptr_nxt[2]), 
	.CLK(FE_OFN1_nclk));
   DFFSR \gray_r_reg[1]  (.S(1'b1), 
	.R(rst_n), 
	.Q(wptr[1]), 
	.D(wptr_nxt[1]), 
	.CLK(FE_OFN1_nclk));
   DFFSR \gray_r_reg[0]  (.S(1'b1), 
	.R(rst_n), 
	.Q(wptr[0]), 
	.D(wptr_nxt[0]), 
	.CLK(wclk));
   XOR2X1 U11 (.Y(wptr_nxt[2]), 
	.B(binary_nxt[2]), 
	.A(wptr_nxt[3]));
   XNOR2X1 U12 (.Y(wptr_nxt[3]), 
	.B(binary_r[3]), 
	.A(n9));
   NAND2X1 U13 (.Y(n9), 
	.B(n10), 
	.A(binary_r[2]));
   XOR2X1 U14 (.Y(wptr_nxt[1]), 
	.B(binary_nxt[1]), 
	.A(binary_nxt[2]));
   XOR2X1 U15 (.Y(wptr_nxt[0]), 
	.B(binary_nxt[0]), 
	.A(binary_nxt[1]));
   XOR2X1 U16 (.Y(binary_nxt[2]), 
	.B(binary_r[2]), 
	.A(n10));
   INVX1 U17 (.Y(n10), 
	.A(n11));
   NAND3X1 U18 (.Y(n11), 
	.C(wenable), 
	.B(binary_r[0]), 
	.A(binary_r[1]));
   XNOR2X1 U19 (.Y(binary_nxt[1]), 
	.B(binary_r[1]), 
	.A(n12));
   NAND2X1 U20 (.Y(n12), 
	.B(binary_r[0]), 
	.A(wenable));
   XOR2X1 U21 (.Y(binary_nxt[0]), 
	.B(wenable), 
	.A(binary_r[0]));
endmodule

module write_fifo_ctrl (
	wclk, 
	rst_n, 
	wenable, 
	rptr, 
	wenable_fifo, 
	wptr, 
	waddr, 
	full_flag, 
	FE_OFN0_wenable_fifo, 
	FE_OFN1_nclk);
   input wclk;
   input rst_n;
   input wenable;
   input [3:0] rptr;
   output wenable_fifo;
   output [3:0] wptr;
   output [2:0] waddr;
   output full_flag;
   input FE_OFN0_wenable_fifo;
   input FE_OFN1_nclk;

   // Internal wires
   wire FE_OFN26_nfifo_full;
   wire FE_OFN25_waddr_0_;
   wire \gray_wptr[2] ;
   wire N5;
   wire n2;
   wire n3;
   wire n16;
   wire n17;
   wire n18;
   wire n19;
   wire n20;
   wire n21;
   wire [3:0] wptr_nxt;
   wire [3:0] wrptr_r2;
   wire [3:0] wrptr_r1;

   BUFX2 FE_OFC26_nfifo_full (.Y(full_flag), 
	.A(FE_OFN26_nfifo_full));
   BUFX2 FE_OFC25_waddr_0_ (.Y(waddr[0]), 
	.A(FE_OFN25_waddr_0_));
   DFFSR \wrptr_r1_reg[3]  (.S(1'b1), 
	.R(rst_n), 
	.Q(wrptr_r1[3]), 
	.D(rptr[3]), 
	.CLK(FE_OFN1_nclk));
   DFFSR \wrptr_r1_reg[2]  (.S(1'b1), 
	.R(rst_n), 
	.Q(wrptr_r1[2]), 
	.D(rptr[2]), 
	.CLK(FE_OFN1_nclk));
   DFFSR \wrptr_r1_reg[1]  (.S(1'b1), 
	.R(rst_n), 
	.Q(wrptr_r1[1]), 
	.D(rptr[1]), 
	.CLK(FE_OFN1_nclk));
   DFFSR \wrptr_r1_reg[0]  (.S(1'b1), 
	.R(rst_n), 
	.Q(wrptr_r1[0]), 
	.D(rptr[0]), 
	.CLK(FE_OFN1_nclk));
   DFFSR \wrptr_r2_reg[3]  (.S(1'b1), 
	.R(rst_n), 
	.Q(wrptr_r2[3]), 
	.D(wrptr_r1[3]), 
	.CLK(FE_OFN1_nclk));
   DFFSR \wrptr_r2_reg[2]  (.S(1'b1), 
	.R(rst_n), 
	.Q(wrptr_r2[2]), 
	.D(wrptr_r1[2]), 
	.CLK(FE_OFN1_nclk));
   DFFSR \wrptr_r2_reg[1]  (.S(1'b1), 
	.R(rst_n), 
	.Q(wrptr_r2[1]), 
	.D(wrptr_r1[1]), 
	.CLK(FE_OFN1_nclk));
   DFFSR \wrptr_r2_reg[0]  (.S(1'b1), 
	.R(rst_n), 
	.Q(wrptr_r2[0]), 
	.D(wrptr_r1[0]), 
	.CLK(FE_OFN1_nclk));
   DFFSR full_flag_r_reg (.S(1'b1), 
	.R(rst_n), 
	.Q(FE_OFN26_nfifo_full), 
	.D(N5), 
	.CLK(FE_OFN1_nclk));
   DFFSR \waddr_reg[2]  (.S(1'b1), 
	.R(rst_n), 
	.Q(waddr[2]), 
	.D(\gray_wptr[2] ), 
	.CLK(FE_OFN1_nclk));
   DFFSR \waddr_reg[1]  (.S(1'b1), 
	.R(rst_n), 
	.Q(waddr[1]), 
	.D(wptr_nxt[1]), 
	.CLK(FE_OFN1_nclk));
   DFFSR \waddr_reg[0]  (.S(1'b1), 
	.R(rst_n), 
	.Q(FE_OFN25_waddr_0_), 
	.D(wptr_nxt[0]), 
	.CLK(FE_OFN1_nclk));
   write_ptr WPU1 (.wclk(wclk), 
	.rst_n(rst_n), 
	.wenable(FE_OFN0_wenable_fifo), 
	.wptr(wptr), 
	.wptr_nxt(wptr_nxt), 
	.FE_OFN1_nclk(FE_OFN1_nclk));
   NOR2X1 U16 (.Y(wenable_fifo), 
	.B(n2), 
	.A(full_flag));
   INVX1 U17 (.Y(n2), 
	.A(wenable));
   NOR2X1 U18 (.Y(N5), 
	.B(n16), 
	.A(n3));
   NAND2X1 U19 (.Y(n16), 
	.B(n18), 
	.A(n17));
   XOR2X1 U20 (.Y(n18), 
	.B(\gray_wptr[2] ), 
	.A(n19));
   XOR2X1 U21 (.Y(\gray_wptr[2] ), 
	.B(wptr_nxt[2]), 
	.A(wptr_nxt[3]));
   XNOR2X1 U22 (.Y(n19), 
	.B(wrptr_r2[2]), 
	.A(wrptr_r2[3]));
   XNOR2X1 U23 (.Y(n17), 
	.B(wptr_nxt[1]), 
	.A(wrptr_r2[1]));
   NAND2X1 U24 (.Y(n3), 
	.B(n21), 
	.A(n20));
   XOR2X1 U25 (.Y(n21), 
	.B(wptr_nxt[3]), 
	.A(wrptr_r2[3]));
   XNOR2X1 U26 (.Y(n20), 
	.B(wptr_nxt[0]), 
	.A(wrptr_r2[0]));
endmodule

module read_ptr (
	rclk, 
	rst_n, 
	renable, 
	rptr, 
	rptr_nxt, 
	FE_OFN1_nclk);
   input rclk;
   input rst_n;
   input renable;
   output [3:0] rptr;
   output [3:0] rptr_nxt;
   input FE_OFN1_nclk;

   // Internal wires
   wire n9;
   wire n10;
   wire n11;
   wire n12;
   wire [2:0] binary_nxt;
   wire [3:0] binary_r;

   DFFSR \binary_r_reg[0]  (.S(1'b1), 
	.R(rst_n), 
	.Q(binary_r[0]), 
	.D(binary_nxt[0]), 
	.CLK(rclk));
   DFFSR \binary_r_reg[1]  (.S(1'b1), 
	.R(rst_n), 
	.Q(binary_r[1]), 
	.D(binary_nxt[1]), 
	.CLK(rclk));
   DFFSR \binary_r_reg[2]  (.S(1'b1), 
	.R(rst_n), 
	.Q(binary_r[2]), 
	.D(binary_nxt[2]), 
	.CLK(rclk));
   DFFSR \binary_r_reg[3]  (.S(1'b1), 
	.R(rst_n), 
	.Q(binary_r[3]), 
	.D(rptr_nxt[3]), 
	.CLK(FE_OFN1_nclk));
   DFFSR \gray_r_reg[3]  (.S(1'b1), 
	.R(rst_n), 
	.Q(rptr[3]), 
	.D(rptr_nxt[3]), 
	.CLK(FE_OFN1_nclk));
   DFFSR \gray_r_reg[2]  (.S(1'b1), 
	.R(rst_n), 
	.Q(rptr[2]), 
	.D(rptr_nxt[2]), 
	.CLK(FE_OFN1_nclk));
   DFFSR \gray_r_reg[1]  (.S(1'b1), 
	.R(rst_n), 
	.Q(rptr[1]), 
	.D(rptr_nxt[1]), 
	.CLK(FE_OFN1_nclk));
   DFFSR \gray_r_reg[0]  (.S(1'b1), 
	.R(rst_n), 
	.Q(rptr[0]), 
	.D(rptr_nxt[0]), 
	.CLK(rclk));
   XOR2X1 U11 (.Y(rptr_nxt[2]), 
	.B(binary_nxt[2]), 
	.A(rptr_nxt[3]));
   XNOR2X1 U12 (.Y(rptr_nxt[3]), 
	.B(binary_r[3]), 
	.A(n9));
   NAND2X1 U13 (.Y(n9), 
	.B(n10), 
	.A(binary_r[2]));
   XOR2X1 U14 (.Y(rptr_nxt[1]), 
	.B(binary_nxt[1]), 
	.A(binary_nxt[2]));
   XOR2X1 U15 (.Y(rptr_nxt[0]), 
	.B(binary_nxt[0]), 
	.A(binary_nxt[1]));
   XOR2X1 U16 (.Y(binary_nxt[2]), 
	.B(binary_r[2]), 
	.A(n10));
   INVX1 U17 (.Y(n10), 
	.A(n11));
   NAND3X1 U18 (.Y(n11), 
	.C(renable), 
	.B(binary_r[0]), 
	.A(binary_r[1]));
   XNOR2X1 U19 (.Y(binary_nxt[1]), 
	.B(binary_r[1]), 
	.A(n12));
   NAND2X1 U20 (.Y(n12), 
	.B(binary_r[0]), 
	.A(renable));
   XOR2X1 U21 (.Y(binary_nxt[0]), 
	.B(renable), 
	.A(binary_r[0]));
endmodule

module read_fifo_ctrl (
	rclk, 
	rst_n, 
	renable, 
	wptr, 
	rptr, 
	raddr, 
	empty_flag, 
	FE_OFN1_nclk);
   input rclk;
   input rst_n;
   input renable;
   input [3:0] wptr;
   output [3:0] rptr;
   output [2:0] raddr;
   output empty_flag;
   input FE_OFN1_nclk;

   // Internal wires
   wire FE_OFN24_raddr_0_;
   wire renable_p2;
   wire \gray_rptr[2] ;
   wire N3;
   wire n2;
   wire n3;
   wire n16;
   wire n17;
   wire n18;
   wire n19;
   wire n20;
   wire [3:0] rptr_nxt;
   wire [3:0] rwptr_r2;
   wire [3:0] rwptr_r1;

   BUFX2 FE_OFC24_raddr_0_ (.Y(raddr[0]), 
	.A(FE_OFN24_raddr_0_));
   DFFSR \rwptr_r1_reg[3]  (.S(1'b1), 
	.R(rst_n), 
	.Q(rwptr_r1[3]), 
	.D(wptr[3]), 
	.CLK(FE_OFN1_nclk));
   DFFSR \rwptr_r1_reg[2]  (.S(1'b1), 
	.R(rst_n), 
	.Q(rwptr_r1[2]), 
	.D(wptr[2]), 
	.CLK(FE_OFN1_nclk));
   DFFSR \rwptr_r1_reg[1]  (.S(1'b1), 
	.R(rst_n), 
	.Q(rwptr_r1[1]), 
	.D(wptr[1]), 
	.CLK(FE_OFN1_nclk));
   DFFSR \rwptr_r1_reg[0]  (.S(1'b1), 
	.R(rst_n), 
	.Q(rwptr_r1[0]), 
	.D(wptr[0]), 
	.CLK(rclk));
   DFFSR \rwptr_r2_reg[3]  (.S(1'b1), 
	.R(rst_n), 
	.Q(rwptr_r2[3]), 
	.D(rwptr_r1[3]), 
	.CLK(FE_OFN1_nclk));
   DFFSR \rwptr_r2_reg[2]  (.S(1'b1), 
	.R(rst_n), 
	.Q(rwptr_r2[2]), 
	.D(rwptr_r1[2]), 
	.CLK(FE_OFN1_nclk));
   DFFSR \rwptr_r2_reg[1]  (.S(1'b1), 
	.R(rst_n), 
	.Q(rwptr_r2[1]), 
	.D(rwptr_r1[1]), 
	.CLK(rclk));
   DFFSR \rwptr_r2_reg[0]  (.S(1'b1), 
	.R(rst_n), 
	.Q(rwptr_r2[0]), 
	.D(rwptr_r1[0]), 
	.CLK(rclk));
   DFFSR empty_flag_r_reg (.S(rst_n), 
	.R(1'b1), 
	.Q(empty_flag), 
	.D(N3), 
	.CLK(rclk));
   DFFSR \raddr_reg[2]  (.S(1'b1), 
	.R(rst_n), 
	.Q(raddr[2]), 
	.D(\gray_rptr[2] ), 
	.CLK(rclk));
   DFFSR \raddr_reg[1]  (.S(1'b1), 
	.R(rst_n), 
	.Q(raddr[1]), 
	.D(rptr_nxt[1]), 
	.CLK(rclk));
   DFFSR \raddr_reg[0]  (.S(1'b1), 
	.R(rst_n), 
	.Q(FE_OFN24_raddr_0_), 
	.D(rptr_nxt[0]), 
	.CLK(FE_OFN1_nclk));
   read_ptr RPU1 (.rclk(rclk), 
	.rst_n(rst_n), 
	.renable(renable_p2), 
	.rptr(rptr), 
	.rptr_nxt(rptr_nxt), 
	.FE_OFN1_nclk(FE_OFN1_nclk));
   NOR2X1 U15 (.Y(renable_p2), 
	.B(renable), 
	.A(empty_flag));
   NOR2X1 U17 (.Y(N3), 
	.B(n3), 
	.A(n2));
   NAND2X1 U18 (.Y(n3), 
	.B(n17), 
	.A(n16));
   XOR2X1 U19 (.Y(n17), 
	.B(\gray_rptr[2] ), 
	.A(n18));
   XOR2X1 U20 (.Y(\gray_rptr[2] ), 
	.B(rptr_nxt[2]), 
	.A(rptr_nxt[3]));
   XNOR2X1 U21 (.Y(n18), 
	.B(rwptr_r2[2]), 
	.A(rwptr_r2[3]));
   XNOR2X1 U22 (.Y(n16), 
	.B(rptr_nxt[1]), 
	.A(rwptr_r2[1]));
   NAND2X1 U23 (.Y(n2), 
	.B(n20), 
	.A(n19));
   XNOR2X1 U24 (.Y(n20), 
	.B(rptr_nxt[0]), 
	.A(rwptr_r2[0]));
   XNOR2X1 U25 (.Y(n19), 
	.B(rwptr_r2[3]), 
	.A(rptr_nxt[3]));
endmodule

module fifo (
	r_clk, 
	w_clk, 
	n_rst, 
	r_enable, 
	w_enable, 
	w_data, 
	r_data, 
	empty, 
	full, 
	FE_OFN1_nclk, 
	FE_OFN2_nclk);
   input r_clk;
   input w_clk;
   input n_rst;
   input r_enable;
   input w_enable;
   input [7:0] w_data;
   output [7:0] r_data;
   output empty;
   output full;
   input FE_OFN1_nclk;
   input FE_OFN2_nclk;

   // Internal wires
   wire FE_OFN0_wenable_fifo;
   wire wenable_fifo;
   wire [2:0] waddr;
   wire [2:0] raddr;
   wire [3:0] rptr;
   wire [3:0] wptr;

   BUFX2 FE_OFC0_wenable_fifo (.Y(FE_OFN0_wenable_fifo), 
	.A(wenable_fifo));
   fiforam UFIFORAM (.wclk(w_clk), 
	.wenable(wenable_fifo), 
	.waddr(waddr), 
	.raddr(raddr), 
	.wdata(w_data), 
	.rdata(r_data), 
	.FE_OFN0_wenable_fifo(FE_OFN0_wenable_fifo), 
	.FE_OFN1_nclk(FE_OFN1_nclk), 
	.FE_OFN2_nclk(FE_OFN2_nclk));
   write_fifo_ctrl UWFC (.wclk(w_clk), 
	.rst_n(n_rst), 
	.wenable(w_enable), 
	.rptr(rptr), 
	.wenable_fifo(wenable_fifo), 
	.wptr(wptr), 
	.waddr(waddr), 
	.full_flag(full), 
	.FE_OFN0_wenable_fifo(FE_OFN0_wenable_fifo), 
	.FE_OFN1_nclk(FE_OFN1_nclk));
   read_fifo_ctrl URFC (.rclk(r_clk), 
	.rst_n(n_rst), 
	.renable(r_enable), 
	.wptr(wptr), 
	.rptr(rptr), 
	.raddr(raddr), 
	.empty_flag(empty), 
	.FE_OFN1_nclk(FE_OFN1_nclk));
endmodule

module lab7_tx_fifo (
	clk, 
	n_rst, 
	read_done, 
	read_data, 
	fifo_empty, 
	fifo_full, 
	write_enable, 
	write_data, 
	FE_OFN1_nclk, 
	FE_OFN2_nclk);
   input clk;
   input n_rst;
   input read_done;
   output [7:0] read_data;
   output fifo_empty;
   output fifo_full;
   input write_enable;
   input [7:0] write_data;
   input FE_OFN1_nclk;
   input FE_OFN2_nclk;

   fifo IP_FIFO (.r_clk(clk), 
	.w_clk(clk), 
	.n_rst(n_rst), 
	.r_enable(read_done), 
	.w_enable(write_enable), 
	.w_data(write_data), 
	.r_data(read_data), 
	.empty(fifo_empty), 
	.full(fifo_full), 
	.FE_OFN1_nclk(FE_OFN1_nclk), 
	.FE_OFN2_nclk(FE_OFN2_nclk));
endmodule

module lab7_timer (
	clk, 
	n_rst, 
	start, 
	stop, 
	shift_enable, 
	bit_done);
   input clk;
   input n_rst;
   input start;
   input stop;
   output shift_enable;
   output bit_done;

   // Internal wires
   wire N73;
   wire N82;
   wire n32;
   wire n33;
   wire n1;
   wire n2;
   wire n3;
   wire n4;
   wire n5;
   wire n6;
   wire n7;
   wire n13;
   wire n14;
   wire n15;
   wire n16;
   wire n17;
   wire n18;
   wire n19;
   wire n20;
   wire n21;
   wire n22;
   wire n23;
   wire n24;
   wire n25;
   wire [1:0] curr_state;
   wire [2:0] clk_cnt;
   wire [2:0] nxt_clk_cnt;

   assign shift_enable = N73 ;
   assign bit_done = N82 ;

   DFFSR \curr_state_reg[0]  (.S(1'b1), 
	.R(n_rst), 
	.Q(curr_state[0]), 
	.D(n33), 
	.CLK(clk));
   DFFSR \curr_state_reg[1]  (.S(1'b1), 
	.R(n_rst), 
	.Q(curr_state[1]), 
	.D(n32), 
	.CLK(clk));
   DFFSR \clk_cnt_reg[0]  (.S(1'b1), 
	.R(n_rst), 
	.Q(clk_cnt[0]), 
	.D(nxt_clk_cnt[0]), 
	.CLK(clk));
   DFFSR \clk_cnt_reg[1]  (.S(1'b1), 
	.R(n_rst), 
	.Q(clk_cnt[1]), 
	.D(nxt_clk_cnt[1]), 
	.CLK(clk));
   DFFSR \clk_cnt_reg[2]  (.S(1'b1), 
	.R(n_rst), 
	.Q(clk_cnt[2]), 
	.D(nxt_clk_cnt[2]), 
	.CLK(clk));
   NOR2X1 U8 (.Y(nxt_clk_cnt[2]), 
	.B(n2), 
	.A(n1));
   MUX2X1 U9 (.Y(n2), 
	.S(n4), 
	.B(clk_cnt[2]), 
	.A(n3));
   MUX2X1 U10 (.Y(nxt_clk_cnt[1]), 
	.S(clk_cnt[1]), 
	.B(n5), 
	.A(n6));
   INVX1 U11 (.Y(n6), 
	.A(nxt_clk_cnt[0]));
   NAND2X1 U12 (.Y(n5), 
	.B(n7), 
	.A(clk_cnt[0]));
   NOR2X1 U13 (.Y(nxt_clk_cnt[0]), 
	.B(clk_cnt[0]), 
	.A(n1));
   OAI21X1 U14 (.Y(n33), 
	.C(n14), 
	.B(n13), 
	.A(n7));
   AOI22X1 U15 (.Y(n14), 
	.D(n17), 
	.C(n16), 
	.B(n15), 
	.A(curr_state[1]));
   OAI22X1 U16 (.Y(n15), 
	.D(n20), 
	.C(n19), 
	.B(n18), 
	.A(n4));
   INVX1 U17 (.Y(n19), 
	.A(n21));
   INVX1 U18 (.Y(n13), 
	.A(start));
   INVX1 U19 (.Y(n7), 
	.A(n1));
   NOR2X1 U20 (.Y(n1), 
	.B(curr_state[1]), 
	.A(curr_state[0]));
   OAI21X1 U21 (.Y(n32), 
	.C(n23), 
	.B(n17), 
	.A(n22));
   OAI21X1 U22 (.Y(n23), 
	.C(curr_state[1]), 
	.B(n21), 
	.A(n20));
   NAND2X1 U23 (.Y(n21), 
	.B(n18), 
	.A(n4));
   INVX1 U24 (.Y(n18), 
	.A(n3));
   NOR2X1 U25 (.Y(n3), 
	.B(clk_cnt[2]), 
	.A(n24));
   XOR2X1 U26 (.Y(n24), 
	.B(clk_cnt[0]), 
	.A(clk_cnt[1]));
   INVX1 U27 (.Y(n17), 
	.A(stop));
   INVX1 U28 (.Y(N82), 
	.A(n25));
   NOR2X1 U29 (.Y(N73), 
	.B(n25), 
	.A(n22));
   NAND2X1 U30 (.Y(n25), 
	.B(n4), 
	.A(clk_cnt[2]));
   AND2X1 U31 (.Y(n4), 
	.B(clk_cnt[0]), 
	.A(clk_cnt[1]));
   INVX1 U32 (.Y(n22), 
	.A(n16));
   NOR2X1 U33 (.Y(n16), 
	.B(curr_state[1]), 
	.A(n20));
   INVX1 U34 (.Y(n20), 
	.A(curr_state[0]));
endmodule

module lab7_tcu (
	clk, 
	n_rst, 
	transmit, 
	bit_done, 
	bus_mode, 
	stop, 
	start, 
	sync, 
	read_done, 
	tx_sel, 
	tx_enable_0, 
	load_data_0, 
	tx_enable_1, 
	load_data_1);
   input clk;
   input n_rst;
   input transmit;
   input bit_done;
   output [1:0] bus_mode;
   output stop;
   output start;
   output sync;
   output read_done;
   output tx_sel;
   output tx_enable_0;
   output load_data_0;
   output tx_enable_1;
   output load_data_1;

   // Internal wires
   wire FE_OFN23_curr_state_1_;
   wire n86;
   wire n88;
   wire n90;
   wire n93;
   wire n94;
   wire n95;
   wire n96;
   wire n1;
   wire n2;
   wire n3;
   wire n4;
   wire n5;
   wire n6;
   wire n7;
   wire n8;
   wire n9;
   wire n10;
   wire n11;
   wire n13;
   wire n14;
   wire n15;
   wire n16;
   wire n17;
   wire n18;
   wire n19;
   wire n20;
   wire n21;
   wire n22;
   wire n23;
   wire n24;
   wire n25;
   wire n26;
   wire n27;
   wire n28;
   wire n29;
   wire n30;
   wire n31;
   wire n32;
   wire n33;
   wire n34;
   wire n35;
   wire n36;
   wire n37;
   wire n38;
   wire n39;
   wire n40;
   wire n41;
   wire n42;
   wire n43;
   wire n44;
   wire n45;
   wire n46;
   wire n47;
   wire n48;
   wire n49;
   wire n50;
   wire n51;
   wire n52;
   wire n53;
   wire n54;
   wire n55;
   wire n56;
   wire n57;
   wire n58;
   wire n59;
   wire n60;
   wire n61;
   wire n62;
   wire n63;
   wire n64;
   wire n65;
   wire n66;
   wire n67;
   wire n68;
   wire n69;
   wire n70;
   wire n71;
   wire n72;
   wire [3:0] curr_state;
   wire [2:0] bit_cnt;

   assign tx_enable_1 = tx_sel ;

   BUFX2 FE_OFC23_curr_state_1_ (.Y(FE_OFN23_curr_state_1_), 
	.A(curr_state[1]));
   DFFSR \bit_cnt_reg[0]  (.S(1'b1), 
	.R(n_rst), 
	.Q(bit_cnt[0]), 
	.D(n90), 
	.CLK(clk));
   DFFSR \bit_cnt_reg[1]  (.S(1'b1), 
	.R(n_rst), 
	.Q(bit_cnt[1]), 
	.D(n88), 
	.CLK(clk));
   DFFSR \bit_cnt_reg[2]  (.S(1'b1), 
	.R(n_rst), 
	.Q(bit_cnt[2]), 
	.D(n86), 
	.CLK(clk));
   DFFSR \curr_state_reg[0]  (.S(1'b1), 
	.R(n_rst), 
	.Q(curr_state[0]), 
	.D(n96), 
	.CLK(clk));
   DFFSR \curr_state_reg[2]  (.S(1'b1), 
	.R(n_rst), 
	.Q(curr_state[2]), 
	.D(n94), 
	.CLK(clk));
   DFFSR \curr_state_reg[1]  (.S(1'b1), 
	.R(n_rst), 
	.Q(curr_state[1]), 
	.D(n95), 
	.CLK(clk));
   DFFSR \curr_state_reg[3]  (.S(1'b1), 
	.R(n_rst), 
	.Q(curr_state[3]), 
	.D(n93), 
	.CLK(clk));
   NAND3X1 U3 (.Y(tx_sel), 
	.C(n3), 
	.B(n2), 
	.A(n1));
   INVX1 U4 (.Y(n3), 
	.A(n4));
   OAI21X1 U5 (.Y(n4), 
	.C(n7), 
	.B(n6), 
	.A(n5));
   OAI21X1 U6 (.Y(tx_enable_0), 
	.C(n9), 
	.B(n8), 
	.A(curr_state[2]));
   AOI21X1 U7 (.Y(n9), 
	.C(n11), 
	.B(n5), 
	.A(n10));
   INVX1 U9 (.Y(bus_mode[1]), 
	.A(n13));
   INVX1 U10 (.Y(sync), 
	.A(n14));
   MUX2X1 U11 (.Y(n96), 
	.S(n17), 
	.B(n15), 
	.A(n16));
   NOR2X1 U12 (.Y(n15), 
	.B(n19), 
	.A(n18));
   OAI21X1 U13 (.Y(n19), 
	.C(n22), 
	.B(n21), 
	.A(n20));
   MUX2X1 U14 (.Y(n22), 
	.S(n25), 
	.B(n23), 
	.A(n24));
   NAND2X1 U15 (.Y(n24), 
	.B(n27), 
	.A(n26));
   INVX1 U16 (.Y(n23), 
	.A(n1));
   INVX1 U17 (.Y(n20), 
	.A(n28));
   NAND3X1 U18 (.Y(n18), 
	.C(n7), 
	.B(n30), 
	.A(n29));
   INVX1 U19 (.Y(n29), 
	.A(load_data_1));
   NAND2X1 U20 (.Y(n95), 
	.B(n30), 
	.A(n31));
   INVX1 U21 (.Y(n30), 
	.A(start));
   NOR2X1 U22 (.Y(start), 
	.B(curr_state[0]), 
	.A(n26));
   MUX2X1 U23 (.Y(n31), 
	.S(n17), 
	.B(n32), 
	.A(FE_OFN23_curr_state_1_));
   OR2X1 U24 (.Y(n32), 
	.B(n34), 
	.A(n33));
   OAI21X1 U25 (.Y(n34), 
	.C(n37), 
	.B(n36), 
	.A(n35));
   INVX1 U26 (.Y(n37), 
	.A(n38));
   OAI21X1 U27 (.Y(n33), 
	.C(n41), 
	.B(n40), 
	.A(n39));
   AND2X1 U28 (.Y(n41), 
	.B(n42), 
	.A(n14));
   INVX1 U29 (.Y(n39), 
	.A(n43));
   OAI21X1 U30 (.Y(n43), 
	.C(n1), 
	.B(n25), 
	.A(n27));
   OAI21X1 U31 (.Y(n94), 
	.C(n45), 
	.B(n17), 
	.A(n44));
   AND2X1 U32 (.Y(n45), 
	.B(n47), 
	.A(n46));
   OAI21X1 U33 (.Y(n46), 
	.C(curr_state[2]), 
	.B(n48), 
	.A(n17));
   AOI21X1 U34 (.Y(n44), 
	.C(n38), 
	.B(n49), 
	.A(n35));
   OAI21X1 U35 (.Y(n49), 
	.C(n36), 
	.B(n27), 
	.A(transmit));
   INVX1 U36 (.Y(n36), 
	.A(n48));
   OAI21X1 U37 (.Y(n48), 
	.C(n1), 
	.B(n26), 
	.A(n16));
   NAND3X1 U38 (.Y(n93), 
	.C(n52), 
	.B(n51), 
	.A(n50));
   AOI21X1 U39 (.Y(n52), 
	.C(n53), 
	.B(n17), 
	.A(curr_state[3]));
   OAI21X1 U40 (.Y(n53), 
	.C(n42), 
	.B(n54), 
	.A(n1));
   NAND2X1 U41 (.Y(n54), 
	.B(n40), 
	.A(n35));
   INVX1 U42 (.Y(n35), 
	.A(n25));
   NAND3X1 U43 (.Y(n25), 
	.C(bit_cnt[2]), 
	.B(bit_cnt[0]), 
	.A(bit_cnt[1]));
   OAI21X1 U44 (.Y(n17), 
	.C(n56), 
	.B(n55), 
	.A(n21));
   OAI21X1 U45 (.Y(n56), 
	.C(n58), 
	.B(n57), 
	.A(n38));
   NAND2X1 U46 (.Y(n57), 
	.B(n13), 
	.A(n7));
   NAND3X1 U47 (.Y(n13), 
	.C(n59), 
	.B(FE_OFN23_curr_state_1_), 
	.A(curr_state[3]));
   NOR2X1 U48 (.Y(n59), 
	.B(n60), 
	.A(curr_state[0]));
   OAI21X1 U49 (.Y(n38), 
	.C(n61), 
	.B(n6), 
	.A(n16));
   AOI21X1 U50 (.Y(n61), 
	.C(stop), 
	.B(FE_OFN23_curr_state_1_), 
	.A(n11));
   NAND2X1 U51 (.Y(n55), 
	.B(n40), 
	.A(n28));
   INVX1 U52 (.Y(n40), 
	.A(transmit));
   INVX1 U53 (.Y(n21), 
	.A(n62));
   NOR2X1 U54 (.Y(n51), 
	.B(n63), 
	.A(stop));
   OAI21X1 U55 (.Y(stop), 
	.C(n64), 
	.B(n5), 
	.A(n6));
   NAND3X1 U56 (.Y(n64), 
	.C(curr_state[3]), 
	.B(curr_state[2]), 
	.A(n28));
   AND2X1 U57 (.Y(n50), 
	.B(n7), 
	.A(n27));
   NAND2X1 U58 (.Y(n27), 
	.B(n8), 
	.A(n11));
   XNOR2X1 U59 (.Y(n90), 
	.B(bit_cnt[0]), 
	.A(n58));
   INVX1 U60 (.Y(n58), 
	.A(bit_done));
   XNOR2X1 U61 (.Y(n88), 
	.B(n65), 
	.A(bit_cnt[1]));
   XOR2X1 U62 (.Y(n86), 
	.B(n66), 
	.A(bit_cnt[2]));
   NOR2X1 U63 (.Y(n66), 
	.B(n65), 
	.A(n67));
   NAND2X1 U64 (.Y(n65), 
	.B(bit_cnt[0]), 
	.A(bit_done));
   INVX1 U65 (.Y(n67), 
	.A(bit_cnt[1]));
   NAND2X1 U66 (.Y(load_data_0), 
	.B(n2), 
	.A(n14));
   NAND3X1 U67 (.Y(n14), 
	.C(n62), 
	.B(n8), 
	.A(curr_state[0]));
   INVX1 U68 (.Y(n8), 
	.A(FE_OFN23_curr_state_1_));
   OR2X1 U69 (.Y(bus_mode[0]), 
	.B(n69), 
	.A(n68));
   NAND3X1 U70 (.Y(n69), 
	.C(n7), 
	.B(n26), 
	.A(n6));
   NAND3X1 U71 (.Y(n7), 
	.C(curr_state[3]), 
	.B(n60), 
	.A(n28));
   NAND2X1 U72 (.Y(n26), 
	.B(FE_OFN23_curr_state_1_), 
	.A(n62));
   NOR2X1 U73 (.Y(n62), 
	.B(curr_state[2]), 
	.A(curr_state[3]));
   INVX1 U74 (.Y(n6), 
	.A(n10));
   NOR2X1 U75 (.Y(n10), 
	.B(FE_OFN23_curr_state_1_), 
	.A(n60));
   NAND3X1 U76 (.Y(n68), 
	.C(n1), 
	.B(read_done), 
	.A(n70));
   NAND3X1 U77 (.Y(n1), 
	.C(FE_OFN23_curr_state_1_), 
	.B(n16), 
	.A(n71));
   INVX1 U78 (.Y(n16), 
	.A(curr_state[0]));
   NOR2X1 U79 (.Y(read_done), 
	.B(load_data_1), 
	.A(n63));
   NAND2X1 U80 (.Y(load_data_1), 
	.B(n47), 
	.A(n42));
   NAND2X1 U81 (.Y(n47), 
	.B(n71), 
	.A(n28));
   NOR2X1 U82 (.Y(n28), 
	.B(curr_state[0]), 
	.A(FE_OFN23_curr_state_1_));
   NAND3X1 U83 (.Y(n42), 
	.C(n72), 
	.B(FE_OFN23_curr_state_1_), 
	.A(curr_state[3]));
   NOR2X1 U84 (.Y(n72), 
	.B(curr_state[0]), 
	.A(curr_state[2]));
   INVX1 U85 (.Y(n63), 
	.A(n2));
   NAND3X1 U86 (.Y(n2), 
	.C(FE_OFN23_curr_state_1_), 
	.B(n71), 
	.A(curr_state[0]));
   NOR2X1 U87 (.Y(n71), 
	.B(curr_state[3]), 
	.A(n60));
   INVX1 U88 (.Y(n60), 
	.A(curr_state[2]));
   INVX1 U89 (.Y(n70), 
	.A(n11));
   NOR2X1 U90 (.Y(n11), 
	.B(curr_state[2]), 
	.A(n5));
   NAND2X1 U91 (.Y(n5), 
	.B(curr_state[0]), 
	.A(curr_state[3]));
endmodule

module lab7_usb_transmitter (
	clk, 
	n_rst, 
	d_plus, 
	d_minus, 
	transmit, 
	write_enable, 
	write_data, 
	fifo_empty, 
	fifo_full);
   input clk;
   input n_rst;
   output d_plus;
   output d_minus;
   input transmit;
   input write_enable;
   input [7:0] write_data;
   output fifo_empty;
   output fifo_full;

   // Internal wires
   wire FE_OFN2_nclk;
   wire FE_OFN1_nclk;
   wire tx_sel_int;
   wire tx_out_0_int;
   wire tx_out_1_int;
   wire sync_int;
   wire tx_value_int;
   wire shift_enable_int;
   wire tx_enable_0_int;
   wire load_data_0_int;
   wire tx_enable_1_int;
   wire load_data_1_int;
   wire read_done_int;
   wire start_int;
   wire stop_int;
   wire bit_done_int;
   wire n1;
   wire n2;
   wire n3;
   wire [7:0] tx_data_int;
   wire [7:0] read_data_int;
   wire [1:0] bus_mode_int;

   BUFX4 FE_OFC2_nclk (.Y(FE_OFN2_nclk), 
	.A(clk));
   BUFX4 FE_OFC1_nclk (.Y(FE_OFN1_nclk), 
	.A(clk));
   lab7_out_ctrl OCTRL (.clk(clk), 
	.n_rst(n_rst), 
	.d_plus(d_plus), 
	.d_minus(d_minus), 
	.bus_mode(bus_mode_int), 
	.tx_value(tx_value_int));
   lab7_encoder ENC (.clk(clk), 
	.n_rst(n_rst), 
	.tx_bit(n3), 
	.shift_enable(shift_enable_int), 
	.tx_value(tx_value_int));
   lab7_tx_sr_1 T_SR_0 (.clk(clk), 
	.n_rst(n_rst), 
	.shift_enable(shift_enable_int), 
	.tx_enable(tx_enable_0_int), 
	.tx_data(tx_data_int), 
	.load_data(load_data_0_int), 
	.tx_out(tx_out_0_int), 
	.FE_OFN1_nclk(FE_OFN1_nclk));
   lab7_tx_sr_0 T_SR_1 (.clk(clk), 
	.n_rst(n_rst), 
	.shift_enable(shift_enable_int), 
	.tx_enable(tx_enable_1_int), 
	.tx_data(tx_data_int), 
	.load_data(load_data_1_int), 
	.tx_out(tx_out_1_int), 
	.FE_OFN1_nclk(FE_OFN1_nclk), 
	.FE_OFN2_nclk(FE_OFN2_nclk));
   lab7_tx_fifo T_FIFO (.clk(clk), 
	.n_rst(n_rst), 
	.read_done(read_done_int), 
	.read_data(read_data_int), 
	.fifo_empty(fifo_empty), 
	.fifo_full(fifo_full), 
	.write_enable(write_enable), 
	.write_data(write_data), 
	.FE_OFN1_nclk(FE_OFN1_nclk), 
	.FE_OFN2_nclk(FE_OFN2_nclk));
   lab7_timer TIM (.clk(clk), 
	.n_rst(n_rst), 
	.start(start_int), 
	.stop(stop_int), 
	.shift_enable(shift_enable_int), 
	.bit_done(bit_done_int));
   lab7_tcu CTRL (.clk(clk), 
	.n_rst(n_rst), 
	.transmit(transmit), 
	.bit_done(bit_done_int), 
	.bus_mode(bus_mode_int), 
	.stop(stop_int), 
	.start(start_int), 
	.sync(sync_int), 
	.read_done(read_done_int), 
	.tx_sel(tx_sel_int), 
	.tx_enable_0(tx_enable_0_int), 
	.load_data_0(load_data_0_int), 
	.tx_enable_1(tx_enable_1_int), 
	.load_data_1(load_data_1_int));
   OR2X1 U3 (.Y(tx_data_int[7]), 
	.B(sync_int), 
	.A(read_data_int[7]));
   AND2X1 U4 (.Y(tx_data_int[6]), 
	.B(n1), 
	.A(read_data_int[6]));
   AND2X1 U5 (.Y(tx_data_int[5]), 
	.B(n1), 
	.A(read_data_int[5]));
   AND2X1 U6 (.Y(tx_data_int[4]), 
	.B(n1), 
	.A(read_data_int[4]));
   AND2X1 U7 (.Y(tx_data_int[3]), 
	.B(n1), 
	.A(read_data_int[3]));
   AND2X1 U8 (.Y(tx_data_int[2]), 
	.B(n1), 
	.A(read_data_int[2]));
   AND2X1 U9 (.Y(tx_data_int[1]), 
	.B(n1), 
	.A(read_data_int[1]));
   AND2X1 U10 (.Y(tx_data_int[0]), 
	.B(n1), 
	.A(read_data_int[0]));
   INVX1 U11 (.Y(n1), 
	.A(sync_int));
   INVX1 U12 (.Y(n3), 
	.A(n2));
   MUX2X1 U13 (.Y(n2), 
	.S(tx_sel_int), 
	.B(tx_out_0_int), 
	.A(tx_out_1_int));
endmodule

module lab7_layout_design_t (
	clk, 
	n_rst, 
	d_plus, 
	d_minus, 
	transmit, 
	write_enable, 
	write_data, 
	fifo_empty, 
	fifo_full);
   input clk;
   input n_rst;
   output d_plus;
   output d_minus;
   input transmit;
   input write_enable;
   input [7:0] write_data;
   output fifo_empty;
   output fifo_full;

   lab7_usb_transmitter LD (.clk(clk), 
	.n_rst(n_rst), 
	.d_plus(d_plus), 
	.d_minus(d_minus), 
	.transmit(transmit), 
	.write_enable(write_enable), 
	.write_data(write_data), 
	.fifo_empty(fifo_empty), 
	.fifo_full(fifo_full));
endmodule

module lab7_layout_design (
	clk, 
	n_rst, 
	d_plus, 
	d_minus, 
	transmit, 
	write_enable, 
	write_data, 
	fifo_empty, 
	fifo_full);
   input clk;
   input n_rst;
   output d_plus;
   output d_minus;
   input transmit;
   input write_enable;
   input [7:0] write_data;
   output fifo_empty;
   output fifo_full;

   // Internal wires
   wire nclk;
   wire nn_rst;
   wire ntransmit;
   wire nwrite_enable;
   wire nd_plus;
   wire nd_minus;
   wire nfifo_empty;
   wire nfifo_full;
   wire [7:0] nwrite_data;

   lab7_layout_design_t I0 (.clk(nclk), 
	.n_rst(nn_rst), 
	.d_plus(nd_plus), 
	.d_minus(nd_minus), 
	.transmit(ntransmit), 
	.write_enable(nwrite_enable), 
	.write_data(nwrite_data), 
	.fifo_empty(nfifo_empty), 
	.fifo_full(nfifo_full));
   PADVDD U1 ();
   PADGND U2 ();
   PADOUT U3 (.YPAD(d_minus), 
	.DO(nd_minus));
   PADOUT U4 (.YPAD(d_plus), 
	.DO(nd_plus));
   PADOUT U5 (.YPAD(fifo_empty), 
	.DO(nfifo_empty));
   PADOUT U6 (.YPAD(fifo_full), 
	.DO(nfifo_full));
   PADINC U7 (.YPAD(clk), 
	.DI(nclk));
   PADINC U8 (.YPAD(n_rst), 
	.DI(nn_rst));
   PADINC U9 (.YPAD(transmit), 
	.DI(ntransmit));
   PADINC U10 (.YPAD(write_data[0]), 
	.DI(nwrite_data[0]));
   PADINC U11 (.YPAD(write_data[1]), 
	.DI(nwrite_data[1]));
   PADINC U12 (.YPAD(write_data[2]), 
	.DI(nwrite_data[2]));
   PADINC U13 (.YPAD(write_data[3]), 
	.DI(nwrite_data[3]));
   PADINC U14 (.YPAD(write_data[4]), 
	.DI(nwrite_data[4]));
   PADINC U15 (.YPAD(write_data[5]), 
	.DI(nwrite_data[5]));
   PADINC U16 (.YPAD(write_data[6]), 
	.DI(nwrite_data[6]));
   PADINC U17 (.YPAD(write_data[7]), 
	.DI(nwrite_data[7]));
   PADINC U18 (.YPAD(write_enable), 
	.DI(nwrite_enable));
endmodule

