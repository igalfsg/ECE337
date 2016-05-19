// $Id: $
// File name:   sensor_b.sv
// Created:     1/20/2016
// Author:      Igal Flegmann Sandler
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: script2.


module sensor_b
(
input wire [3:0] sensors,
output reg error
);

always_comb begin
if((sensors[1] == 1'b1 & sensors[2] == 1'b1) | (sensors[1] == 1'b1 & sensors[3] == 1'b1) | sensors[0] == 1'b1)
begin
error =1'b1;
end
else begin
error =1'b0;
end
end
endmodule