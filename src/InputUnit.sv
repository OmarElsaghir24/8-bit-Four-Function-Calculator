module InputUnit
(
   input clk,
	input reset,
	input [3:0] row,
	output [3:0] col,
	output [16:0] out
);

   wire [15:0] wire1;
	
	wire [7:0] wire2;
	
	keypad_input keypad_input_inst
	(
	   .clk(clk),
		.reset(reset),
		.row(row),
		.col(col),
		.out(out)
	);
	
endmodule 