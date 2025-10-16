module HEX2Binary #(parameter N = 8)
(
   input [15:0] HEX,
	output [N-1:0] binarySM
);

   assign binarySM = HEX[15]*(8'b10000000) + HEX[11:8]*(8'b00010000) + HEX[7:4]*(8'b0001) + HEX[3:0];
	
endmodule 