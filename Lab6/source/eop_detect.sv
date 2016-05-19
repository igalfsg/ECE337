// $Id: $
// File name:   eop_detect.sv
// Created:     2/21/2016
// Author:      Igal Flegmann Sandler
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: yolo.
module eop_detect(
input wire d_plus,
input wire d_minus,
output wire eop);


assign eop = (~d_plus & ~d_minus);
endmodule 