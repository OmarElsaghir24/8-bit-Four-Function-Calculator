module ArithmeticUnit
(
   input Clock,
	input Reset,
	input LoadAH, LoadAL, LoadA, LoadB, LoadR,
	input AddSub, 
	//input Start,
	//input add, sub, mult, div,
	//input [1:0] Op,
	//input [15:0] register, 
	input [7:0] A, B,
	output reg [15:0] Rout,
	output OVR, NEG, ZERO
	//output Done, Halt
);
   wire zero, zero1, ovr, ovr1, Done1;

   wire [7:0] AoutH, AoutL, Bout, B1, Result;
	
	wire [15:0] R, R1, R2, R3, Dividend;
	
	GCLAAddSub #(8) GCLAAddSub_inst
	(
	   .Aout(A),
		.Bout(B),
		.AddSubtract(AddSub),
		.OVR(ovr),
		.R(Result)
	);

	//assign ovr = ~A[7]&~B[7]&Result[7] | A[7]&B[7]&~Result[7];
	
	ConCodeLogic #(8) ConCodeLogic_inst
	(
	   .R(Result),
		.NEG(NEG),
		.ZERO(zero)
	);
	
	NBitRegister #(8) NBitRegister_R
	(
	   .D(Result),
		.CLK(LoadR),
		.CLR(Reset),
		.Q(Rout)
	);
	
	NBitRegister #(2) NBitRegister_inst
	(
	   .D({zero,ovr}),
		.CLK(LoadR),
		.CLR(Reset),
		.Q({ZERO,OVR})
	);

endmodule 