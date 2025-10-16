module ControlUnit
(
   input clock, clear, enter, add, sub, mult, div, Done, Halt,
	output [1:0] Op,
	output reg reset, LoadAH, LoadAL, LoadB, LoadR, AddSub, IUAU, Start
);
	reg [3:0] state, nextstate;
	parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100, S5 = 3'b101, S6 = 3'b110, S7 = 3'b111;
	wire clock2;
	/*parameter S0 = 4'b0000, S1 = 4'b0001, S2 = 4'b0010, S3 = 4'b0011, S4 = 4'b0100, S5 = 4'b0101, S6 = 4'b0110, S7 = 4'b0111, S8 = 4'b1000;*/
	parameter A1 = 2'b00, A2 = 2'b01, A3 = 2'b10, A4 = 2'b11;
	
	EdgeDetect EdgeDetect_inst
	(
	   .in(~enter),
		.clock(clock),
		.out(clock2)
	);
	
	always @ (negedge clock2 or negedge clear)
	    if(clear == 0) state <= S0;
		     else state <= nextstate;
	always @ (clock2)	
	   case(state)
		    S0: if(enter) begin reset = 1'b1; LoadAH = 1'b0; LoadAL = 1'b0; LoadB = 1'b0; Start = 1'b1; LoadR = 1'b0; IUAU = 1'b0; nextstate = S1;end
			 S1: if(enter) begin reset = 1'b0; LoadAH = 1'b0; LoadAL = 1'b0; LoadB = 1'b0; Start = 1'b1; LoadR = 1'b0; IUAU = 1'b0; nextstate = S2;end
			 S2: if(enter) begin reset = 1'b0; LoadAH = 1'b1; LoadAL = 1'b1; LoadB = 1'b0; Start = 1'b1; LoadR = 1'b0; IUAU = 1'b0; nextstate = S3;end
			 S3: if(enter) begin reset = 1'b0; LoadAH = 1'b0; LoadAL = 1'b0; LoadB = 1'b1; Start = 1'b1; LoadR = 1'b0; IUAU = 1'b0; nextstate = S4;end
			 S4: begin if(~add) begin LoadAH = 1'b0; LoadAL = 1'b1; LoadB = 1'b1; AddSub = 1'b0; nextstate = S5;end
			     else if(~sub) begin LoadAH = 1'b0; LoadAL = 1'b1; LoadB = 1'b1; AddSub = 1'b1; nextstate = S6;end
				  else if(~mult) begin LoadAH = 1'b0; LoadAL = 1'b1; LoadB = 1'b1; Start = 1'b1; nextstate = S7;end
				  else if(~div) begin /*LoadAH = 1'b1; LoadAL = 1'b1; LoadB = 1'b1;*/ Start = 1'b1; nextstate = S7;end end
			 S5: begin reset = 1'b0; LoadAH = 1'b1; LoadAL = 1'b1; LoadB = 1'b1; AddSub = 1'b0; Start = 1'b1; LoadR = 1'b1; IUAU = 1'b1; nextstate = S5;end
			 S6: begin reset = 1'b0; LoadAH = 1'b1; LoadAL = 1'b1; LoadB = 1'b1; AddSub = 1'b1; Start = 1'b1; LoadR = 1'b1; IUAU = 1'b1; nextstate = S6;end
			 S7: begin if(Done == 1'b1) begin reset = 1'b0; /*LoadAH = 1'b1; LoadAL = 1'b1; LoadB = 1'b1;*/ Start = 1'b0; LoadR = 1'b1; IUAU = 1'b1; nextstate = S7;end 
			     else begin nextstate = S7;end end
		endcase
		
		always @ (negedge add, negedge sub, negedge mult, negedge div)
		      if(~add) begin Op = A1;end
				else if(~sub) begin Op = A1;end
				else if(~mult) begin Op = A2;end
				else if(~div) begin Op = A3;end
endmodule 