//Divide by 2**N counter
module DivideByN #(parameter N = 23) (
input CLOCK, CLEAR,
output reg OUT,
output reg [N-1:0] COUNT // COUNT is defined as an N-bit register
);
always @ (negedge CLOCK, negedge CLEAR)
if (CLEAR==1'b0) COUNT <= 0; // COUNT is loaded with all 0's
else
begin
if (COUNT == (2**N)-2'd2) begin OUT <= 1'b1; COUNT <= (2**N)-1'b1; end // Once COUNT = 2**N-2 OUT = 1
else
if (COUNT == (2**N)-1'd1) begin OUT <=1'b0; COUNT <= 0; end //Once COUNT = 2**N-1 OUT=0
else begin OUT <= 1'b0; COUNT <= COUNT + 1'b1; end // COUNT is incremented
end
endmodule