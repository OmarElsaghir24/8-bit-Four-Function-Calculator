module Adder //#(parameter N = 4)
(
   input A, B,
	input Cin,
	output logic P, G, S
);

   //logic [N-1:0] P_sum, G_sum;
	assign S = (A ^ B) ^ Cin;
	
	assign P = (A ^ B);

   assign G = A & B;	
	
endmodule 