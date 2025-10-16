module HEX2BinarySM #(parameter N = 8)
(
    input [15:0] HEX,
	 output [N-1:0] binarySM
);
/*
    // Extract one HEX value from BCD input and convert it to binary
    always_comb begin
        case(HEX[15:12]) // Considering the position of the HEX value within BCD
            4'h0: binarySM[N-1:12] = 4'b0000;
            4'h1: binarySM[N-1:12] = 4'b0001;
            4'h2: binarySM[N-1:12] = 4'b0010;
            4'h3: binarySM[N-1:12] = 4'b0011;
            4'h4: binarySM[N-1:12] = 4'b0100;
            4'h5: binarySM[N-1:12] = 4'b0101;
            4'h6: binarySM[N-1:12] = 4'b0110;
            4'h7: binarySM[N-1:12] = 4'b0111;
            4'h8: binarySM[N-1:12] = 4'b1000;
            4'h9: binarySM[N-1:12] = 4'b1001;
            4'hA: binarySM[N-1:12] = 4'b1010;
            4'hB: binarySM[N-1:12] = 4'b1011;
            4'hC: binarySM[N-1:12] = 4'b1100;
            4'hD: binarySM[N-1:12] = 4'b1101;
            4'hE: binarySM[N-1:12] = 4'b1110;
            4'hF: binarySM[N-1:12] = 4'b1111;
            default: binarySM[N-1:12] = 4'b0000; // Default to 0 for unknown HEX values
        endcase
    end
	 
	 always_comb begin
        case(HEX[11:8]) // Considering the position of the HEX value within BCD
            4'h0: binarySM[N-5:8] = 4'b0000;
            4'h1: binarySM[N-5:8] = 4'b0001;
            4'h2: binarySM[N-5:8] = 4'b0010;
            4'h3: binarySM[N-5:8] = 4'b0011;
            4'h4: binarySM[N-5:8] = 4'b0100;
            4'h5: binarySM[N-5:8] = 4'b0101;
            4'h6: binarySM[N-5:8] = 4'b0110;
            4'h7: binarySM[N-5:8] = 4'b0111;
            4'h8: binarySM[N-5:8] = 4'b1000;
            4'h9: binarySM[N-5:8] = 4'b1001;
            4'hA: binarySM[N-5:8] = 4'b1010;
            4'hB: binarySM[N-5:8] = 4'b1011;
            4'hC: binarySM[N-5:8] = 4'b1100;
            4'hD: binarySM[N-5:8] = 4'b1101;
            4'hE: binarySM[N-5:8] = 4'b1110;
            4'hF: binarySM[N-5:8] = 4'b1111;
            default: binarySM[N-5:8] = 4'b0000; // Default to 0 for unknown HEX values
        endcase
    end*/
	 
	 always_comb begin
        case(HEX[7:4]) // Considering the position of the HEX value within BCD
            4'h0: binarySM[N-1:4] = 4'b0000;
            4'h1: binarySM[N-1:4] = 4'b0001;
            4'h2: binarySM[N-1:4] = 4'b0010;
            4'h3: binarySM[N-1:4] = 4'b0011;
            4'h4: binarySM[N-1:4] = 4'b0100;
            4'h5: binarySM[N-1:4] = 4'b0101;
            4'h6: binarySM[N-1:4] = 4'b0110;
            4'h7: binarySM[N-1:4] = 4'b0111;
            4'h8: binarySM[N-1:4] = 4'b1000;
            4'h9: binarySM[N-1:4] = 4'b1001;
            4'hA: binarySM[N-1:4] = 4'b1010;
            4'hB: binarySM[N-1:4] = 4'b1011;
            4'hC: binarySM[N-1:4] = 4'b1100;
            4'hD: binarySM[N-1:4] = 4'b1101;
            4'hE: binarySM[N-1:4] = 4'b1110;
            4'hF: binarySM[N-1:4] = 4'b1111;
            default: binarySM[N-1:4] = 4'b0000; // Default to 0 for unknown HEX values
        endcase
    end
	 
	 always_comb begin
        case(HEX[3:0]) 
            4'h0: binarySM[N-5:0] = 4'b0000;
            4'h1: binarySM[N-5:0] = 4'b0001;
            4'h2: binarySM[N-5:0] = 4'b0010;
            4'h3: binarySM[N-5:0] = 4'b0011;
            4'h4: binarySM[N-5:0] = 4'b0100;
            4'h5: binarySM[N-5:0] = 4'b0101;
            4'h6: binarySM[N-5:0] = 4'b0110;
            4'h7: binarySM[N-5:0] = 4'b0111;
            4'h8: binarySM[N-5:0] = 4'b1000;
            4'h9: binarySM[N-5:0] = 4'b1001;
            4'hA: binarySM[N-5:0] = 4'b1010;
            4'hB: binarySM[N-5:0] = 4'b1011;
            4'hC: binarySM[N-5:0] = 4'b1100;
            4'hD: binarySM[N-5:0] = 4'b1101;
            4'hE: binarySM[N-5:0] = 4'b1110;
            4'hF: binarySM[N-5:0] = 4'b1111;
            default: binarySM[N-5:0] = 4'b0000; // Default to 0 for unknown HEX values
        endcase
    end
endmodule