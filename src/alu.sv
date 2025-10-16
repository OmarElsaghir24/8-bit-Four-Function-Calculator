module alu #(parameter N = 8)
(
   input [N:0] A,
	input [N-1:0] B,
	output [N:0] Result,
	input Sel
);
   assign Result = (Sel == 0) ? (A + B) : (A - B);

endmodule 