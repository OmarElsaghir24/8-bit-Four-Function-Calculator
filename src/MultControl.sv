module MultControl
(
   input Clock, Reset, Q0, C0,
	output Start, Add, Shift, Halt
);

   reg [4:0] state;
	
	// one-hot state assignments for five states
	parameter StartS = 5'b00001, TestS = 5'b00010, AddS = 5'b00100, ShiftS = 5'b01000, HaltS = 5'b10000;
	reg [1:0] Counter;
	
	// State transitions on positive edge of Clock or Reset
	always @ (posedge Clock, negedge Reset)
	   if (Reset == 0) 
		       state <= StartS;
		   else 
			   case (state)
				   StartS: state <= TestS; 
					TestS: if (Q0) state <= AddS;
					          else state <= ShiftS;
					AddS: state <= ShiftS;
					ShiftS: if (C0) state <= HaltS;
					           else state <= TestS;
					HaltS: state <= HaltS;
			   endcase 
				
	// Moore model - activate one output per state
	assign Start = state[0];
	assign Add = state[2];
	assign Shift = state[3];
	assign Halt = state[4];
	
endmodule 