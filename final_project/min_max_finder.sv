/* Takes in 72 bit arrays for each color, 72 bits for Red, 72 for Green, 72 for Blue
	
Pixel number layout - 5 is pixel of interest

1	2	3
4	5	6
7	8	9

*/

module min_max_finder
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




//Variables required for Red MIN/MAX/FINAL value comparisons
reg [7:0] r_next; //Actual R-Data to write to SRAM
reg [7:0] min_r_12; //min value between pixel 1 and 2
reg [7:0] min_r_34; 
reg [7:0] min_r_67; 
reg [7:0] min_r_89;
reg [7:0] min_r_1234; // min value between pixels 1,2,3 and 4
reg [7:0] min_r_6789;
reg [7:0] min_r_final;  //final min value for neighboring pixels

// Max is the same as above
reg [7:0] max_r_12;
reg [7:0] max_r_34;
reg [7:0] max_r_67;
reg [7:0] max_r_89;
reg [7:0] max_r_1234;
reg [7:0] max_r_6789;
reg [7:0] max_r_final;

//Variables required for Green MIN/MAX/FINAL value comparisons REPEATED from RED
reg [7:0] g_next;
reg [7:0] min_g_12;
reg [7:0] min_g_34;
reg [7:0] min_g_67;
reg [7:0] min_g_89;
reg [7:0] min_g_1234;
reg [7:0] min_g_6789;
reg [7:0] min_g_final;  
reg [7:0] max_g_12;
reg [7:0] max_g_34;
reg [7:0] max_g_67;
reg [7:0] max_g_89;
reg [7:0] max_g_1234;
reg [7:0] max_g_6789;
reg [7:0] max_g_final;
//Variables required for Green MIN/MAX/FINAL value comparisons REPEATED from RED
reg [7:0] b_next;
reg [7:0] min_b_12;
reg [7:0] min_b_34;
reg [7:0] min_b_67;
reg [7:0] min_b_89;
reg [7:0] min_b_1234;
reg [7:0] min_b_6789;
reg [7:0] min_b_final;  
reg [7:0] max_b_12;
reg [7:0] max_b_34;
reg [7:0] max_b_67;
reg [7:0] max_b_89;
reg [7:0] max_b_1234;
reg [7:0] max_b_6789;
reg [7:0] max_b_final;

//Flip flop used to update the values on the clock edge
//On reset, r_out is set to 0 
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
//Calculations used for finding min values

assign min_r_12 = (r_in[71:64]<r_in[63:56]?r_in[71:64]:r_in[63:56]);
assign min_r_34 = (r_in[55:48]<r_in[47:40]?r_in[55:48]:r_in[47:40]);
assign min_r_67 = (r_in[31:24]<r_in[23:16]?r_in[31:24]:r_in[23:16]);
assign min_r_89 = (r_in[15:8]<r_in[7:0]?r_in[15:8]:r_in[7:0]);
assign min_r_1234 = (min_r_12 < min_r_34 ? min_r_12 : min_r_34);
assign min_r_6789 = (min_r_67 < min_r_89 ? min_r_67 : min_r_89);
assign min_r_final = (min_r_1234 < min_r_6789 ? min_r_1234 : min_r_6789);

assign max_r_12 = (r_in[71:64]>r_in[63:56]?r_in[71:64]:r_in[63:56]);
assign max_r_34 = (r_in[55:48]>r_in[47:40]?r_in[55:48]:r_in[47:40]);
assign max_r_67 = (r_in[31:24]>r_in[23:16]?r_in[31:24]:r_in[23:16]);
assign max_r_89 = (r_in[15:8]>r_in[7:0]?r_in[15:8]:r_in[7:0]);
assign max_r_1234 = (max_r_12 > max_r_34 ? max_r_12 : max_r_34);
assign max_r_6789 = (max_r_67 > max_r_89 ? max_r_67 : max_r_89);
assign max_r_final = (max_r_1234 > max_r_6789 ? max_r_1234 : max_r_6789);

// if pixel 5 value > max, set pixel 5 to max, if pixel 5 < min, set to min, otherwise set to Pixel 5 value
assign r_next = (r_in[39:32] > max_r_final ? max_r_final : (r_in[39:32] < min_r_final ? min_r_final : r_in[39:32]));

//Calculations for Green value of Pixel 5, same as Red
assign min_g_12 = (g_in[71:64]<g_in[63:56]?g_in[71:64]:g_in[63:56]);
assign min_g_34 = (g_in[55:48]<g_in[47:40]?g_in[55:48]:g_in[47:40]);
assign min_g_67 = (g_in[31:24]<g_in[23:16]?g_in[31:24]:g_in[23:16]);
assign min_g_89 = (g_in[15:8]<g_in[7:0]?g_in[15:8]:g_in[7:0]);
assign min_g_1234 = (min_g_12 < min_g_34 ? min_g_12 : min_g_34);
assign min_g_6789 = (min_g_67 < min_g_89 ? min_g_67 : min_g_89);
assign min_g_final = (min_g_1234 < min_g_6789 ? min_g_1234 : min_g_6789);

assign max_g_12 = (g_in[71:64]>g_in[63:56]?g_in[71:64]:g_in[63:56]);
assign max_g_34 = (g_in[55:48]>g_in[47:40]?g_in[55:48]:g_in[47:40]);
assign max_g_67 = (g_in[31:24]>g_in[23:16]?g_in[31:24]:g_in[23:16]);
assign max_g_89 = (g_in[15:8]>g_in[7:0]?g_in[15:8]:g_in[7:0]);
assign max_g_1234 = (max_g_12 > max_g_34 ? max_g_12 : max_g_34);
assign max_g_6789 = (max_g_67 > max_g_89 ? max_g_67 : max_g_89);
assign max_g_final = (max_g_1234 > max_g_6789 ? max_g_1234 : max_g_6789);

assign g_next = (g_in[39:32] > max_g_final ? max_g_final : (g_in[39:32] < min_g_final ? min_g_final : g_in[39:32]));

//Calculations for Blue value of Pixel 5, same as Red
assign min_b_12 = (b_in[71:64]<b_in[63:56]?b_in[71:64]:b_in[63:56]);
assign min_b_34 = (b_in[55:48]<b_in[47:40]?b_in[55:48]:b_in[47:40]);
assign min_b_67 = (b_in[31:24]<b_in[23:16]?b_in[31:24]:b_in[23:16]);
assign min_b_89 = (b_in[15:8]<b_in[7:0]?b_in[15:8]:b_in[7:0]);
assign min_b_1234 = (min_b_12 < min_b_34 ? min_b_12 : min_b_34);
assign min_b_6789 = (min_b_67 < min_b_89 ? min_b_67 : min_b_89);
assign min_b_final = (min_b_1234 < min_b_6789 ? min_b_1234 : min_b_6789);

assign max_b_12 = (b_in[71:64]>b_in[63:56]?b_in[71:64]:b_in[63:56]);
assign max_b_34 = (b_in[55:48]>b_in[47:40]?b_in[55:48]:b_in[47:40]);
assign max_b_67 = (b_in[31:24]>b_in[23:16]?b_in[31:24]:b_in[23:16]);
assign max_b_89 = (b_in[15:8]>b_in[7:0]?b_in[15:8]:b_in[7:0]);
assign max_b_1234 = (max_b_12 > max_b_34 ? max_b_12 : max_b_34);
assign max_b_6789 = (max_b_67 > max_b_89 ? max_b_67 : max_b_89);
assign max_b_final = (max_b_1234 > max_b_6789 ? max_b_1234 : max_b_6789);

assign b_next = (b_in[39:32] > max_b_final ? max_b_final : (b_in[39:32] < min_b_final ? min_b_final : b_in[39:32]));




endmodule

