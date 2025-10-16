module FSM 
(
    input slow_clock, reset,
	 output logic [1:0] SEL,
	 output logic [3:0] CAT
);
    logic [1:0] state, nextstate;
	 
	 always_ff @ (negedge slow_clock, negedge reset)
	           if (reset == 0) state <= 2'b0; else state <= nextstate;
	 always_ff @ (state)
	         case ({state})
				       2'b00: begin nextstate = 2'b01; SEL = 2'b00; CAT = 4'b1000; end 
						 2'b01: begin nextstate = 2'b10; SEL = 2'b01; CAT = 4'b0100; end 
						 2'b10: begin nextstate = 2'b11; SEL = 2'b10; CAT = 4'b0010; end 
						 2'b11: begin nextstate = 2'b00; SEL = 2'b11; CAT = 4'b0001; end 
				endcase 
endmodule 