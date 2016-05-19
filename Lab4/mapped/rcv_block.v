/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Thu Feb 11 19:43:52 2016
/////////////////////////////////////////////////////////////


module flex_stp_sr_NUM_BITS9_SHIFT_MSB0 ( clk, n_rst, shift_enable, serial_in, 
        parallel_out );
  output [8:0] parallel_out;
  input clk, n_rst, shift_enable, serial_in;
  wire   n13, n15, n17, n19, n21, n23, n25, n27, n29, n1, n2, n3, n4, n5, n6,
         n7, n8, n9;

  DFFSR \parallel_out_reg[8]  ( .D(n29), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[8]) );
  DFFSR \parallel_out_reg[7]  ( .D(n27), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[7]) );
  DFFSR \parallel_out_reg[6]  ( .D(n25), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[6]) );
  DFFSR \parallel_out_reg[5]  ( .D(n23), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[5]) );
  DFFSR \parallel_out_reg[4]  ( .D(n21), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[4]) );
  DFFSR \parallel_out_reg[3]  ( .D(n19), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[3]) );
  DFFSR \parallel_out_reg[2]  ( .D(n17), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[2]) );
  DFFSR \parallel_out_reg[1]  ( .D(n15), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[1]) );
  DFFSR \parallel_out_reg[0]  ( .D(n13), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[0]) );
  INVX1 U2 ( .A(n1), .Y(n29) );
  MUX2X1 U3 ( .B(parallel_out[8]), .A(serial_in), .S(shift_enable), .Y(n1) );
  INVX1 U4 ( .A(n2), .Y(n27) );
  MUX2X1 U5 ( .B(parallel_out[7]), .A(parallel_out[8]), .S(shift_enable), .Y(
        n2) );
  INVX1 U6 ( .A(n3), .Y(n25) );
  MUX2X1 U7 ( .B(parallel_out[6]), .A(parallel_out[7]), .S(shift_enable), .Y(
        n3) );
  INVX1 U8 ( .A(n4), .Y(n23) );
  MUX2X1 U9 ( .B(parallel_out[5]), .A(parallel_out[6]), .S(shift_enable), .Y(
        n4) );
  INVX1 U10 ( .A(n5), .Y(n21) );
  MUX2X1 U11 ( .B(parallel_out[4]), .A(parallel_out[5]), .S(shift_enable), .Y(
        n5) );
  INVX1 U12 ( .A(n6), .Y(n19) );
  MUX2X1 U13 ( .B(parallel_out[3]), .A(parallel_out[4]), .S(shift_enable), .Y(
        n6) );
  INVX1 U14 ( .A(n7), .Y(n17) );
  MUX2X1 U15 ( .B(parallel_out[2]), .A(parallel_out[3]), .S(shift_enable), .Y(
        n7) );
  INVX1 U16 ( .A(n8), .Y(n15) );
  MUX2X1 U17 ( .B(parallel_out[1]), .A(parallel_out[2]), .S(shift_enable), .Y(
        n8) );
  INVX1 U18 ( .A(n9), .Y(n13) );
  MUX2X1 U19 ( .B(parallel_out[0]), .A(parallel_out[1]), .S(shift_enable), .Y(
        n9) );
endmodule


module sr_9bit ( clk, n_rst, shift_strobe, serial_in, packet_data, stop_bit );
  output [7:0] packet_data;
  input clk, n_rst, shift_strobe, serial_in;
  output stop_bit;


  flex_stp_sr_NUM_BITS9_SHIFT_MSB0 cambios ( .clk(clk), .n_rst(n_rst), 
        .shift_enable(shift_strobe), .serial_in(serial_in), .parallel_out({
        stop_bit, packet_data}) );
endmodule


module start_bit_det ( clk, n_rst, serial_in, start_bit_detected );
  input clk, n_rst, serial_in;
  output start_bit_detected;
  wire   old_sample, new_sample, sync_phase, n4;

  DFFSR sync_phase_reg ( .D(serial_in), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        sync_phase) );
  DFFSR new_sample_reg ( .D(sync_phase), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        new_sample) );
  DFFSR old_sample_reg ( .D(new_sample), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        old_sample) );
  NOR2X1 U6 ( .A(new_sample), .B(n4), .Y(start_bit_detected) );
  INVX1 U7 ( .A(old_sample), .Y(n4) );
endmodule


module stop_bit_chk ( clk, n_rst, sbc_clear, sbc_enable, stop_bit, 
        framing_error );
  input clk, n_rst, sbc_clear, sbc_enable, stop_bit;
  output framing_error;
  wire   n5, n2, n3;

  DFFSR framing_error_reg ( .D(n5), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        framing_error) );
  NOR2X1 U3 ( .A(sbc_clear), .B(n2), .Y(n5) );
  MUX2X1 U4 ( .B(framing_error), .A(n3), .S(sbc_enable), .Y(n2) );
  INVX1 U5 ( .A(stop_bit), .Y(n3) );
endmodule


module flex_counter_NUM_CNT_BITS4_1 ( clk, n_rst, clear, count_enable, 
        rollover_val, count_out, rollover_flag );
  input [3:0] rollover_val;
  output [3:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   n44, rollover_flagr, n54, n55, n56, n57, n2, n3, n4, n5, n6, n7, n8,
         n9, n10, n11, n12, n13, n19, n20, n21, n22, n23, n24, n25, n26, n27,
         n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41,
         n42, n43;

  DFFSR \ahora_reg[0]  ( .D(n57), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR \ahora_reg[1]  ( .D(n56), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[1]) );
  DFFSR \ahora_reg[2]  ( .D(n55), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR \ahora_reg[3]  ( .D(n54), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[3]) );
  DFFSR cur_flag_reg ( .D(rollover_flagr), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        n44) );
  BUFX2 U8 ( .A(n44), .Y(rollover_flag) );
  OAI22X1 U9 ( .A(n2), .B(n3), .C(n4), .D(n5), .Y(rollover_flagr) );
  NAND3X1 U10 ( .A(n6), .B(n7), .C(n8), .Y(n5) );
  XOR2X1 U11 ( .A(n9), .B(n10), .Y(n8) );
  OAI21X1 U12 ( .A(rollover_val[1]), .B(n11), .C(n12), .Y(n4) );
  AND2X1 U13 ( .A(n13), .B(n19), .Y(n12) );
  MUX2X1 U14 ( .B(n20), .A(n21), .S(n22), .Y(n57) );
  OAI21X1 U15 ( .A(n21), .B(n23), .C(n13), .Y(n20) );
  MUX2X1 U16 ( .B(n24), .A(n25), .S(count_out[1]), .Y(n56) );
  AOI21X1 U17 ( .A(n26), .B(n21), .C(n22), .Y(n25) );
  NAND2X1 U18 ( .A(n26), .B(count_out[0]), .Y(n24) );
  OAI22X1 U19 ( .A(n27), .B(n3), .C(n28), .D(n29), .Y(n55) );
  INVX1 U20 ( .A(n30), .Y(n54) );
  AOI22X1 U21 ( .A(count_out[3]), .B(n22), .C(n31), .D(n26), .Y(n30) );
  INVX1 U22 ( .A(n29), .Y(n26) );
  NAND3X1 U23 ( .A(n3), .B(n13), .C(n2), .Y(n29) );
  INVX1 U24 ( .A(n23), .Y(n2) );
  OAI22X1 U25 ( .A(rollover_val[3]), .B(n32), .C(n33), .D(n34), .Y(n23) );
  INVX1 U26 ( .A(n6), .Y(n34) );
  XOR2X1 U27 ( .A(n32), .B(rollover_val[3]), .Y(n6) );
  AOI22X1 U28 ( .A(n7), .B(n35), .C(n36), .D(n37), .Y(n33) );
  OAI21X1 U29 ( .A(rollover_val[1]), .B(n11), .C(n38), .Y(n35) );
  NAND3X1 U30 ( .A(n19), .B(n9), .C(n10), .Y(n38) );
  XOR2X1 U31 ( .A(count_enable), .B(count_out[0]), .Y(n10) );
  INVX1 U32 ( .A(rollover_val[0]), .Y(n9) );
  NAND2X1 U33 ( .A(rollover_val[1]), .B(n11), .Y(n19) );
  OAI21X1 U34 ( .A(n39), .B(n40), .C(n41), .Y(n11) );
  OAI21X1 U35 ( .A(n39), .B(n21), .C(n42), .Y(n41) );
  INVX1 U36 ( .A(count_out[1]), .Y(n42) );
  INVX1 U37 ( .A(count_out[0]), .Y(n21) );
  XOR2X1 U38 ( .A(n37), .B(n36), .Y(n7) );
  MUX2X1 U39 ( .B(n28), .A(n27), .S(n39), .Y(n36) );
  XNOR2X1 U40 ( .A(n40), .B(n27), .Y(n28) );
  INVX1 U41 ( .A(rollover_val[2]), .Y(n37) );
  MUX2X1 U42 ( .B(count_out[3]), .A(n31), .S(count_enable), .Y(n32) );
  XOR2X1 U43 ( .A(count_out[3]), .B(n43), .Y(n31) );
  NOR2X1 U44 ( .A(n40), .B(n27), .Y(n43) );
  INVX1 U45 ( .A(count_out[2]), .Y(n27) );
  NAND2X1 U46 ( .A(count_out[1]), .B(count_out[0]), .Y(n40) );
  INVX1 U47 ( .A(n3), .Y(n22) );
  NAND2X1 U48 ( .A(n39), .B(n13), .Y(n3) );
  INVX1 U49 ( .A(clear), .Y(n13) );
  INVX1 U50 ( .A(count_enable), .Y(n39) );
endmodule


module flex_counter_NUM_CNT_BITS4_0 ( clk, n_rst, clear, count_enable, 
        rollover_val, count_out, rollover_flag );
  input [3:0] rollover_val;
  output [3:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   rollover_flagr, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12,
         n13, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31,
         n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45,
         n46;

  DFFSR \ahora_reg[0]  ( .D(n43), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR \ahora_reg[1]  ( .D(n44), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[1]) );
  DFFSR \ahora_reg[2]  ( .D(n45), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR \ahora_reg[3]  ( .D(n46), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[3]) );
  DFFSR cur_flag_reg ( .D(rollover_flagr), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        rollover_flag) );
  OAI22X1 U8 ( .A(n1), .B(n2), .C(n3), .D(n4), .Y(rollover_flagr) );
  NAND3X1 U9 ( .A(n5), .B(n6), .C(n7), .Y(n4) );
  XOR2X1 U10 ( .A(n8), .B(n9), .Y(n7) );
  OAI21X1 U11 ( .A(rollover_val[1]), .B(n10), .C(n11), .Y(n3) );
  AND2X1 U12 ( .A(n12), .B(n13), .Y(n11) );
  MUX2X1 U13 ( .B(n19), .A(n20), .S(n21), .Y(n43) );
  OAI21X1 U14 ( .A(n20), .B(n22), .C(n12), .Y(n19) );
  MUX2X1 U15 ( .B(n23), .A(n24), .S(count_out[1]), .Y(n44) );
  AOI21X1 U16 ( .A(n25), .B(n20), .C(n21), .Y(n24) );
  NAND2X1 U17 ( .A(n25), .B(count_out[0]), .Y(n23) );
  OAI22X1 U18 ( .A(n26), .B(n2), .C(n27), .D(n28), .Y(n45) );
  INVX1 U19 ( .A(n29), .Y(n46) );
  AOI22X1 U20 ( .A(count_out[3]), .B(n21), .C(n30), .D(n25), .Y(n29) );
  INVX1 U21 ( .A(n28), .Y(n25) );
  NAND3X1 U22 ( .A(n2), .B(n12), .C(n1), .Y(n28) );
  INVX1 U23 ( .A(n22), .Y(n1) );
  OAI22X1 U24 ( .A(rollover_val[3]), .B(n31), .C(n32), .D(n33), .Y(n22) );
  INVX1 U25 ( .A(n5), .Y(n33) );
  XOR2X1 U26 ( .A(n31), .B(rollover_val[3]), .Y(n5) );
  AOI22X1 U27 ( .A(n6), .B(n34), .C(n35), .D(n36), .Y(n32) );
  OAI21X1 U28 ( .A(rollover_val[1]), .B(n10), .C(n37), .Y(n34) );
  NAND3X1 U29 ( .A(n13), .B(n8), .C(n9), .Y(n37) );
  XOR2X1 U30 ( .A(count_enable), .B(count_out[0]), .Y(n9) );
  INVX1 U31 ( .A(rollover_val[0]), .Y(n8) );
  NAND2X1 U32 ( .A(rollover_val[1]), .B(n10), .Y(n13) );
  OAI21X1 U33 ( .A(n38), .B(n39), .C(n40), .Y(n10) );
  OAI21X1 U34 ( .A(n38), .B(n20), .C(n41), .Y(n40) );
  INVX1 U35 ( .A(count_out[1]), .Y(n41) );
  INVX1 U36 ( .A(count_out[0]), .Y(n20) );
  XOR2X1 U37 ( .A(n36), .B(n35), .Y(n6) );
  MUX2X1 U38 ( .B(n27), .A(n26), .S(n38), .Y(n35) );
  XNOR2X1 U39 ( .A(n39), .B(n26), .Y(n27) );
  INVX1 U40 ( .A(rollover_val[2]), .Y(n36) );
  MUX2X1 U41 ( .B(count_out[3]), .A(n30), .S(count_enable), .Y(n31) );
  XOR2X1 U42 ( .A(count_out[3]), .B(n42), .Y(n30) );
  NOR2X1 U43 ( .A(n39), .B(n26), .Y(n42) );
  INVX1 U44 ( .A(count_out[2]), .Y(n26) );
  NAND2X1 U45 ( .A(count_out[1]), .B(count_out[0]), .Y(n39) );
  INVX1 U46 ( .A(n2), .Y(n21) );
  NAND2X1 U47 ( .A(n38), .B(n12), .Y(n2) );
  INVX1 U48 ( .A(clear), .Y(n12) );
  INVX1 U49 ( .A(count_enable), .Y(n38) );
endmodule


module timer ( clk, n_rst, enable_timer, shift_strobe, packet_done );
  input clk, n_rst, enable_timer;
  output shift_strobe, packet_done;
  wire   q;

  flex_counter_NUM_CNT_BITS4_1 nom ( .clk(clk), .n_rst(n_rst), .clear(
        packet_done), .count_enable(q), .rollover_val({1'b1, 1'b0, 1'b1, 1'b0}), .rollover_flag(shift_strobe) );
  flex_counter_NUM_CNT_BITS4_0 nomnom ( .clk(clk), .n_rst(n_rst), .clear(
        packet_done), .count_enable(shift_strobe), .rollover_val({1'b1, 1'b0, 
        1'b0, 1'b1}), .rollover_flag(packet_done) );
  DFFSR q_reg ( .D(enable_timer), .CLK(clk), .R(n_rst), .S(1'b1), .Q(q) );
endmodule


module rcu ( clk, n_rst, start_bit_detected, packet_done, framing_error, 
        sbc_clear, sbc_enable, load_buffer, enable_timer );
  input clk, n_rst, start_bit_detected, packet_done, framing_error;
  output sbc_clear, sbc_enable, load_buffer, enable_timer;
  wire   n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18;
  wire   [2:0] curr_state;
  wire   [2:0] nxt_state;

  DFFSR \curr_state_reg[0]  ( .D(nxt_state[0]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(curr_state[0]) );
  DFFSR \curr_state_reg[2]  ( .D(nxt_state[2]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(curr_state[2]) );
  DFFSR \curr_state_reg[1]  ( .D(nxt_state[1]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(curr_state[1]) );
  NOR2X1 U6 ( .A(curr_state[2]), .B(n4), .Y(sbc_clear) );
  OAI21X1 U7 ( .A(n5), .B(n6), .C(n7), .Y(nxt_state[2]) );
  INVX1 U8 ( .A(sbc_enable), .Y(n7) );
  NOR2X1 U9 ( .A(n8), .B(curr_state[2]), .Y(sbc_enable) );
  NAND2X1 U10 ( .A(curr_state[2]), .B(n9), .Y(n6) );
  NAND2X1 U11 ( .A(n8), .B(n10), .Y(n5) );
  NAND2X1 U12 ( .A(curr_state[1]), .B(curr_state[0]), .Y(n8) );
  NOR2X1 U13 ( .A(curr_state[2]), .B(n9), .Y(nxt_state[1]) );
  INVX1 U14 ( .A(n11), .Y(n9) );
  OAI21X1 U15 ( .A(curr_state[0]), .B(n12), .C(n4), .Y(n11) );
  OAI21X1 U16 ( .A(n13), .B(n14), .C(n15), .Y(nxt_state[0]) );
  NAND2X1 U17 ( .A(packet_done), .B(enable_timer), .Y(n15) );
  NAND2X1 U18 ( .A(n16), .B(n12), .Y(n14) );
  MUX2X1 U19 ( .B(n10), .A(start_bit_detected), .S(n17), .Y(n13) );
  INVX1 U20 ( .A(framing_error), .Y(n10) );
  NOR2X1 U21 ( .A(n4), .B(n17), .Y(load_buffer) );
  NAND2X1 U22 ( .A(curr_state[0]), .B(n12), .Y(n4) );
  INVX1 U23 ( .A(curr_state[1]), .Y(n12) );
  INVX1 U24 ( .A(n18), .Y(enable_timer) );
  NAND3X1 U25 ( .A(n16), .B(n17), .C(curr_state[1]), .Y(n18) );
  INVX1 U26 ( .A(curr_state[2]), .Y(n17) );
  INVX1 U27 ( .A(curr_state[0]), .Y(n16) );
endmodule


module rx_data_buff ( clk, n_rst, load_buffer, packet_data, data_read, rx_data, 
        data_ready, overrun_error );
  input [7:0] packet_data;
  output [7:0] rx_data;
  input clk, n_rst, load_buffer, data_read;
  output data_ready, overrun_error;
  wire   n15, n17, n19, n21, n23, n25, n27, n29, n30, n31, n1, n2, n3, n4, n5,
         n6, n7, n8, n9, n10, n11;

  DFFSR \rx_data_reg[7]  ( .D(n29), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[7]) );
  DFFSR \rx_data_reg[6]  ( .D(n27), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[6]) );
  DFFSR \rx_data_reg[5]  ( .D(n25), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[5]) );
  DFFSR \rx_data_reg[4]  ( .D(n23), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[4]) );
  DFFSR \rx_data_reg[3]  ( .D(n21), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[3]) );
  DFFSR \rx_data_reg[2]  ( .D(n19), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[2]) );
  DFFSR \rx_data_reg[1]  ( .D(n17), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[1]) );
  DFFSR \rx_data_reg[0]  ( .D(n15), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[0]) );
  DFFSR data_ready_reg ( .D(n31), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        data_ready) );
  DFFSR overrun_error_reg ( .D(n30), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        overrun_error) );
  OAI21X1 U3 ( .A(data_read), .B(n1), .C(n2), .Y(n31) );
  INVX1 U4 ( .A(load_buffer), .Y(n2) );
  INVX1 U5 ( .A(data_ready), .Y(n1) );
  NOR2X1 U6 ( .A(data_read), .B(n3), .Y(n30) );
  AOI21X1 U7 ( .A(load_buffer), .B(data_ready), .C(overrun_error), .Y(n3) );
  INVX1 U8 ( .A(n4), .Y(n29) );
  MUX2X1 U9 ( .B(rx_data[7]), .A(packet_data[7]), .S(load_buffer), .Y(n4) );
  INVX1 U10 ( .A(n5), .Y(n27) );
  MUX2X1 U11 ( .B(rx_data[6]), .A(packet_data[6]), .S(load_buffer), .Y(n5) );
  INVX1 U12 ( .A(n6), .Y(n25) );
  MUX2X1 U13 ( .B(rx_data[5]), .A(packet_data[5]), .S(load_buffer), .Y(n6) );
  INVX1 U14 ( .A(n7), .Y(n23) );
  MUX2X1 U15 ( .B(rx_data[4]), .A(packet_data[4]), .S(load_buffer), .Y(n7) );
  INVX1 U16 ( .A(n8), .Y(n21) );
  MUX2X1 U17 ( .B(rx_data[3]), .A(packet_data[3]), .S(load_buffer), .Y(n8) );
  INVX1 U18 ( .A(n9), .Y(n19) );
  MUX2X1 U19 ( .B(rx_data[2]), .A(packet_data[2]), .S(load_buffer), .Y(n9) );
  INVX1 U20 ( .A(n10), .Y(n17) );
  MUX2X1 U21 ( .B(rx_data[1]), .A(packet_data[1]), .S(load_buffer), .Y(n10) );
  INVX1 U22 ( .A(n11), .Y(n15) );
  MUX2X1 U23 ( .B(rx_data[0]), .A(packet_data[0]), .S(load_buffer), .Y(n11) );
endmodule


module rcv_block ( clk, n_rst, serial_in, data_read, rx_data, data_ready, 
        overrun_error, framing_error );
  output [7:0] rx_data;
  input clk, n_rst, serial_in, data_read;
  output data_ready, overrun_error, framing_error;
  wire   shift_strobe, estop, start_bit, claro, sbc_enable, enab_t,
         packet_done, load_buffer;
  wire   [7:0] packet_d;

  sr_9bit srthing ( .clk(clk), .n_rst(n_rst), .shift_strobe(shift_strobe), 
        .serial_in(serial_in), .packet_data(packet_d), .stop_bit(estop) );
  start_bit_det ae ( .clk(clk), .n_rst(n_rst), .serial_in(serial_in), 
        .start_bit_detected(start_bit) );
  stop_bit_chk dsad ( .clk(clk), .n_rst(n_rst), .sbc_clear(claro), 
        .sbc_enable(sbc_enable), .stop_bit(estop), .framing_error(
        framing_error) );
  timer sds ( .clk(clk), .n_rst(n_rst), .enable_timer(enab_t), .shift_strobe(
        shift_strobe), .packet_done(packet_done) );
  rcu yooo ( .clk(clk), .n_rst(n_rst), .start_bit_detected(start_bit), 
        .packet_done(packet_done), .framing_error(framing_error), .sbc_clear(
        claro), .sbc_enable(sbc_enable), .load_buffer(load_buffer), 
        .enable_timer(enab_t) );
  rx_data_buff jbibs ( .clk(clk), .n_rst(n_rst), .load_buffer(load_buffer), 
        .packet_data(packet_d), .data_read(data_read), .rx_data(rx_data), 
        .data_ready(data_ready), .overrun_error(overrun_error) );
endmodule

