module GCLAAddSub #(parameter N = 8)
(
   input [N-1:0] Aout, Bout,
	input AddSubtract,
	output Cout,
	output OVR,
	output logic [N-1:0] R
);
   
	logic [N-1:0] S, P, G, C, B2, A2, R1;
	
	logic Pout1, Pout2, Gout1, Gout2;
	
	logic C4;
	
	//assign A2 = AddSubtract ? ~Aout+1:Aout;
	
	assign B2 = AddSubtract? ~Bout:Bout;

   GCLA #(4) GCLA_inst1
	(
	   .A(Aout[3:0]),
	   .B(B2[3:0]),
	   .Cin(AddSubtract),
	   .S(S[3:0]),
	   //.P(P[3:0]),
		.Pout(Pout1),
		.Gout(Gout1)
	   //.G(G[3:0]),
		//.Cout(C4)
	 );
	 
	 GCLACircuit #(4) GCLACircuit_inst1
	 (
	   //.P(P[3:0]),
		.Pin1(Pout1),
		.Gin1(Gout1),
		//.G(G[3:0]),
		.Cin(AddSubtract),
		//.Cout(C4)
		.C4(C4)
	 );
	 
	 GCLA #(4) GCLA_inst2
	 (
	   .A(Aout[7:4]),
		.B(B2[7:4]),
		.Cin(C4),
		//.Cin(AddSubtract),
		.S(S[7:4]),
		//.P(P[7:4]),
		.Pout(Pout2),
		.Gout(Gout2),
		//.G(G[7:4]),
		.OVR(OVR)
		//.Cout(Cout)
	 );
	 
	 GCLACircuit #(4) GCLACircuit_inst2
	 (
	   //.P(P[7:4]),
		.Pin1(Pout1),
		.Gin1(Gout1),
		.Pin2(Pout2),
		.Gin2(Gout2),
		//.G(G[7:4]),
		.Cin(AddSubtract),
		//.Cin(C4),
		.Cout(Cout)
	 );
	 
	 assign R1 = S;
	 
	 assign R = AddSubtract? ~R1+1:R1;
	 /*
	 if(~AddSubtract)
	    assign R = Aout + Bout;
	 else  
	    assign R = Aout - Bout;*/
	 
endmodule 	 
		 
		 
		 