// $Id: $
// File name:   sensor_s.sv
// Created:     1/20/2016
// Author:      Igal Flegmann Sandler
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: file1

module sensor_s
(
input wire [3:0] sensors,
output wire error
);
wire tem1;
wire tem2;
wire or1;

and FirstS (tem1, sensors[1], sensors[2]);
and SecondS (tem2, sensors[1], sensors[3]);
or firstor (or1, tem1, tem2);
or secondor (error, sensors[0], or1);

endmodule