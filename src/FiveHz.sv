module FiveHz
(
   input clock, reset,
	output FiveHz
);

   wire clk, clk1, clk2;
 
   DivideByN #(20) Clock1_inst
	(
	   .CLOCK(clock),
		.CLEAR(reset),
		.OUT(clk)
	);
	
	DivideByN #(1) Clock2_inst
	(
	   .CLOCK(clk),
		.CLEAR(reset),
		.OUT(clk1)
	);
	
	DivideByN #(1) Clock3_inst
	(
	   .CLOCK(clk1),
		.CLEAR(reset),
		.OUT(clk2)
	);
	
	DivideByN #(1) Clock4_inst
	(
	   .CLOCK(clk2),
		.CLEAR(reset),
		.OUT(FiveHz)
	);
	
endmodule 