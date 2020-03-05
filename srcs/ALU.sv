module ALU(A,B,F,Y);
input [31:0] A,B;
input [2:0] F;
output reg[31:0] Y;
wire [31:0] sum,Bout;
assign Bout = F[2]? ~B:B; // Determines if B is + or -
assign sum = A + Bout + F[2]; // Adds A and Bout for 1's comp and if F[2] = 1 then it makes 2's comp
assign z = (Y==32'b0); // checks if all bits are 0
always @ (*)
case(F[1:0])
2'b00 : Y = A & Bout; // Ands A and B or ~B
2'b01 : Y = A | Bout; // Ors A and B or ~B
2'b10 : Y = sum; // Adds together A and B or ~B(-B)
2'b11 : Y = sum[31]; //  Checks if MSB is 1(-) or 0(+)
endcase
endmodule
