// $Id: $
// File name:   sensor_d.sv
// Created:     1/20/2016
// Author:      Igal Flegmann Sandler
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: file2

module sensor_d
(
input wire [3:0] sensors,
output wire error
);

wire tem1;
wire tem2;
wire tem3;

assign error = (((sensors[1] == 1'b1) & (sensors[2] == 1'b1)) | ((sensors[1] == 1'b1) & (sensors[3] == 1'b1)) | (sensors[0] == 1'b1)) ? 1'b1 : 1'b0;

endmodule