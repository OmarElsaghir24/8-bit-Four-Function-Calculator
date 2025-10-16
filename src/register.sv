module register #(parameter N = 4)
(
   input CLK, RST, CE,
	input [1:0] M,
	input [N-1:0] D,
	output logic [N-1:0] Q
);
   always_ff @ (posedge CLK or posedge RST) begin 
	    if (RST) Q <= 0;
		      else if (CE) begin 
				     if (M == 2'b01) Q <= Q >> 1'b1;
					      else if (M == 2'b10) Q <= Q + 1'b1;
							if (M == 2'b11) Q <= D;
				end
		 end 
endmodule  