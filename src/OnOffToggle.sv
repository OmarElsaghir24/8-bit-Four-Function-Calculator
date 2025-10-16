module OnOffToggle
(
   input OnOff, IN,
	output OUT
);
   logic state, nextstate;
	parameter ON=1'b1, OFF=1'b0;
	    always_ff @ (negedge OnOff)
		     state <= nextstate;
		 always_ff @ (state)
		     case(state)
			       OFF: nextstate = ON;
					 ON: nextstate = OFF;
			  endcase 
	assign OUT = state*IN;
endmodule 