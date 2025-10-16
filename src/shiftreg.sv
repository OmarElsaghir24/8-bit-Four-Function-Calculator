module shiftreg #(parameter N = 8)
(
   input [N-1:0] D,
	output reg [N-1:0] Q,
	input CLK,
	input LD,
	input SH,
	input SerIn
);
   
	always @ (posedge CLK)
	   begin 
		    if (LD == 1'b1)
			     Q = D;
				       else if (SH == 1'b1)
						     Q = {Q[N-2:0], SerIn};
			 else 
			     Q = Q;
	   end 
endmodule 