module GCLA #(parameter N = 4)
(
   input [N-1:0] A, B,
	input Cin,
	output OVR,
	output logic Pout, Gout,
	output logic [N-1:0] S
);
   logic [N:0] C;
	
	logic [N-1:0] P, G;

   assign P[0] = A[0] ^ B[0];
	
	assign P[1] = A[1] ^ B[1];
	
	assign P[2] = A[2] ^ B[2];
	
	assign P[3] = A[3] ^ B[3];
	
	assign G[0] = A[0] & B[0];

   assign G[1] = A[1] & B[1];
  
   assign G[2] = A[2] & B[2];

   assign G[3] = A[3] & B[3];
	
	assign C[0] = Cin;
	
	assign C[1] = G[0] | (P[0] & C[0]);
	 
	//assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C[0]);
	assign C[2] = G[1] | (P[1] & C[1]);
	
	//assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & P[0] & C[0]);
	assign C[3] = G[2] | (P[2] & C[2]);
	
	//assign C[4] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & P[0] & C[0]);
   assign C[4] = G[3] | (P[3] & C[3]);
	
   assign S[0] = (A[0] ^ B[0]) ^ C[0];

   assign S[1] = (A[1] ^ B[1]) ^ C[1];

   assign S[2] = (A[2] ^ B[2]) ^ C[2];

   assign S[3] = (A[3] ^ B[3]) ^ C[3];
	
	assign Pout = P[3] & P[2] & P[1] & P[0];
	
	assign Gout = G[3] | (G[2] & P[3]) | (G[1] & P[3] & P[2]) | (G[0] & P[3] & P[2] & P[1]);
	
	assign OVR = C[4] ^ C[3];

endmodule	

   	