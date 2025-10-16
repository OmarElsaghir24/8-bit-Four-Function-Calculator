module SignedMultiplier
(
    input Clock, Reset,
	 input [7:0] Multiplicand,
	 input [7:0] Multiplier,
	 output [15:0] Product,
	 output reg Done,
	 output Halt
);

     reg [7:0] RegQ;
	  //reg [8:0] RegA;
	  reg [16:0] RegA, RegM;
	  reg [2:0] Count;
	  wire C0, Start, Add, Shift;
	  int i;
	  
	  assign Product = {RegA[7:0],RegQ};
	  
	  // 3-bit counter for # iterations
	  always @ (posedge Clock)
	      if (Start == 1) Count <= 3'b000;
			else if (Shift == 1) Count <= Count + 1;
			
	  assign C0 = Count[2] & Count[1] & Count[0];
	  
	  // Multiplicand register (load only)
	  always @ (posedge Clock)
	        if (Start == 1) //RegM <= Multiplicand;
			  begin 
			        for (i = 7; i <= 15; i = i + 1) RegM[i] <= Multiplicand[7];
					  for (i = 0; i <= 6; i = i + 1)  RegM[i] <= Multiplicand[i];
			  end 
	  // Multiplier register (load, shift)
	  always @ (posedge Clock)
	      if (Start == 1) RegQ <= Multiplier;
			else if (Shift == 1) RegQ <= {RegA[0],RegQ[7:1]};
	  // Accumulate register (clear, load, shift)
	  always @ (posedge Clock)
	      if (Start == 1)  RegA <= 16'b000000000;
			else if (Add == 1 && Count == 7) RegA <= RegA - RegM;
			          else if (Add == 1 && Count != 7) RegA <= RegA + RegM; 
			else if (Shift == 1) RegA <= RegA >>> 1; 
		always @ (posedge Clock, negedge Reset)
		     if(Reset == 0) Done = 1'b0; else if (Halt == 1) Done = 1'b1;
			       else Done = 1'b0;
	  // Instantiate controller module
	  MultControl Ctrl (Clock,Reset,RegQ[0],C0,Start,Add,Shift,Halt);
	  
endmodule 