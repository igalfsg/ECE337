

module smooth_toplevel
(
	input wire clk, 
	input wire n_rst,
	input wire [71:0] red_data,
	input wire [71:0] green_data,
	input wire [71:0] blue_data, 
	
	//Output
	output wire [23:0] pixel_data  	
);
	reg [7:0] r_out;
  	reg [7:0] g_out;
  	reg [7:0] b_out;

	min_max_finder smooth_calc(.clk(clk), .n_rst(n_rst), .r_in(red_data), .g_in(green_data), .b_in(blue_data), .r_out(r_out), .g_out(g_out), .b_out(b_out));

	assign pixel_data = {b_out, g_out, r_out};


endmodule 

