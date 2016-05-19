

module invert_toplevel
(
	input wire clk, 
	input wire n_rst,
	input wire [7:0] red_data,
	input wire [7:0] green_data,
	input wire [7:0] blue_data, 

	input wire w_count_enable,     //only fires when the pixel is being mathed on
	input wire w_flag_clear,       //clears the counter, when in IDLE state
	

	
	//Output
	output wire w_image_done,      //counter tells us when the image is done being processed
	output wire [23:0] pixel_data  	
);
	reg [7:0] r_out;
  	reg [7:0] g_out;
  	reg [7:0] b_out;

	color_invert inv_calc(.clk(clk), .n_rst(n_rst), .rgb_in({red_data, green_data, blue_data}), .rgb_out(pixel_data));
	
	flex_counter #(.NUM_CNT_BITS(18)) numpixels ( .clk(clk), .n_rst(n_rst), .clear(w_flag_clear), .count_enable(w_count_enable), .rollover_flag(w_image_done), .rollover_val(18'd307200)); 




endmodule 

