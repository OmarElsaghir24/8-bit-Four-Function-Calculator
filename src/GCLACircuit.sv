module GCLACircuit #(parameter N = 4)
(
   input  Pin1, Gin1, Pin2, Gin2,
	input Cin,
	output C4,
	output Cout
);

   logic P_sum, G_sum;
	
	//logic [N-1:4] P_sum1, G_sum1;
	
	//assign P_sum = P[3] * P[2] * P[1] * P[0];
	
	//assign G_sum = G[3] + (G[2] * P[3]) + (G[1] * P[3] * P[2]) + (G[0] * P[3] * P[2] * P[1]);
	
	assign C4 = Gin1 | (Pin1 & Cin);
	
	assign Cout = Gin2 | (Gin1 & Pin2) | (Pin2 & Pin1 & Cin);
	
	//assign Cout = Gin2 | (Pin2 & Cin);
	
endmodule 