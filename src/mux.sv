module mux #(parameter N = 8)
(
   input [N-1:0] A, B,
	output [N-1:0] Y,
	input S
);
   assign Y = (S == 0) ? A : B;

endmodule 