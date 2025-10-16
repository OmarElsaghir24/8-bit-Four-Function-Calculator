module CLACircuit
(
   input P, G, 
	input Cin,
	output logic C
);

   assign C = G | (P & Cin);
	/*assign C[1] = G[0] | (P[0] & Cin);
	
	assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & Cin);
	
	assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & P[0] & Cin);
	
	assign C[4] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & P[0] & Cin);*/
	
	// If this doesn't work, implement the CLA circuit where all of C[0] till C[4] are calculated at once.
	
endmodule