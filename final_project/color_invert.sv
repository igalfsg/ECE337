module color_invert(
	input wire clk,
	input wire n_rst,	
	input wire [23:0] rgb_in,
	output reg [23:0] rgb_out
);

reg [23:0] rgb_next;


always_ff @ (posedge clk, negedge n_rst) begin
  if (n_rst == 0)
	rgb_out <= 8'h0;
  else 
	rgb_out <= rgb_next;
end

assign rgb_next = {8'hFF - rgb_in[23:16], 8'hFF - rgb_in[15:8], 8'hFF - rgb_in[7:0]};


endmodule
