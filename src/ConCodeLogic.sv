module ConCodeLogic #(parameter N = 4)
(
    input [N-1:0] R,
	 output NEG, OVR, ZERO
);
    //assign ZERO = !(R[0]|R[1]|R[2]|R[3]|R[4]|R[5]|R[6]|R[7]);
	 assign ZERO = 8'b0 == R;
	 assign NEG = R[7];

endmodule 