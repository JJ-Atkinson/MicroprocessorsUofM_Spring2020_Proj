module signExtend #(parameter inw=15, outw=32) (in, out);

input [inw-1:0] in; 
output reg [outw-1:0] out;

always @(*) begin
	out[inw-1:0] = in[inw-1:0];
        out[outw-1:inw] = {outw-inw{in[inw-1]}};
end 
endmodule
