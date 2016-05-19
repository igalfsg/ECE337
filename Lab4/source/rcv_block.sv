// $Id: $
// File name:   rcv_block.sv
// Created:     2/10/2016
// Author:      Igal Flegmann Sandler
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: last module
module rcv_block(
input wire clk,
input wire n_rst,
input wire serial_in,
input wire data_read,
output wire [7:0]rx_data,
output wire data_ready,
output wire overrun_error,
output wire framing_error);

reg shift_strobe;
reg estop;
reg start_bit;
reg claro;
reg sbc_enable;
reg enab_t;
reg err; //framing error
reg packet_done;
reg [7:0] packet_d;
reg load_buffer;


sr_9bit srthing (.clk(clk), .n_rst(n_rst), .shift_strobe(shift_strobe), .serial_in(serial_in), .packet_data(packet_d), .stop_bit(estop));
start_bit_det ae (.clk(clk), .n_rst(n_rst), .serial_in(serial_in), .start_bit_detected(start_bit));
stop_bit_chk dsad (.clk(clk), .n_rst(n_rst), .sbc_clear(claro), .sbc_enable(sbc_enable), .stop_bit(estop), .framing_error(err));
timer sds (.clk(clk), .n_rst(n_rst), .enable_timer(enab_t), .shift_strobe(shift_strobe), .packet_done(packet_done));
rcu yooo (.clk(clk), .n_rst(n_rst), .start_bit_detected(start_bit), .packet_done(packet_done), .framing_error(err), .sbc_clear(claro), .sbc_enable(sbc_enable), .load_buffer(load_buffer), .enable_timer(enab_t));
rx_data_buff jbibs (.clk(clk), .n_rst(n_rst), .load_buffer(load_buffer), .packet_data(packet_d), .data_read(data_read), .rx_data(rx_data), .data_ready(data_ready), .overrun_error(overrun_error));


assign framing_error = err;

endmodule


