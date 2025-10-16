module OutputUnit
(
   input clock,
	input reset,
	input [15:0] SW,
	output [3:0] CAT,
	output [0:6] SEG
);

   wire clk;
	
	wire [1:0] sel;
	
	wire [3:0] Output;
	
	ClockDivider #(262144, 32) ClockDivider_inst
	(
	   .CLK(clock),
		.CLEAR(reset),
		.OUT(clk)
	);
	
	FSM FSM_inst
	(
	   .slow_clock(clk),
		.reset(reset),
		.SEL(sel),
		.CAT(CAT)
	);
	
	four2one #(4) four2one
	(
	   .A(sel[0]),
		.B(sel[1]),
		.D0(SW[3:0]),
		.D1(SW[7:4]),
		.D2(SW[11:8]),
		.D3(SW[15:12]),
		.Y(Output)
	);
	
	binary2seven binary2seven_inst
	(
	   .BIN(Output),
		.SEV(SEG)
	);

endmodule 