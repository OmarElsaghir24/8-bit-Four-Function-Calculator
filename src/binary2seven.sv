module binary2seven
(
   input [3:0] BIN,
	output logic [0:6] SEV
);

	always_comb   
	    begin 
	       case (BIN)
			        4'b0000: SEV = 7'b1111110; // 0
					  4'b0001: SEV = 7'b0110000; // 1
					  4'b0010: SEV = 7'b1101101; // 2
					  4'b0011: SEV = 7'b1111001; // 3
					  4'b0100: SEV = 7'b0110011; // 4
					  4'b0101: SEV = 7'b1011011; // 5
					  4'b0110: SEV = 7'b1011111; // 6
					  4'b0111: SEV = 7'b1110000; // 7
					  4'b1000: SEV = 7'b1111111; // 8
					  4'b1001: SEV = 7'b1110011; // 9
					  4'b1010: SEV = 7'b1110111; // A
					  4'b1011: SEV = 7'b0011111; // B
					  4'b1100: SEV = 7'b1001110; // C
					  4'b1101: SEV = 7'b0111101; // D
					  4'b1110: SEV = 7'b1001111; // E
					  4'b1111: SEV = 7'b1000111; // F
					  default: SEV = 7'b1111111;
				  endcase 
		end 
endmodule 