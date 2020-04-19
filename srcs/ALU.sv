module ALU #(parameter N = 32)(A,B,F,Y, Ovf, Zero);

	input logic [N-1:0] A,B;
	input logic [2:0] F;
	output logic [N-1:0] Y;
	output logic Ovf, Zero;
	logic [N-1:0] sum,Bout;
	wire [N-1:0] Temp;
	

assign Bout = F[2]? ~B:B;     // Determines if B is + or -
assign sum = A + Bout + F[2]; // Adds A and Bout for 1's comp and if F[2] = 1 then it makes 2's comp
	assign z = (Y=={N{1'b0}});        // checks if all bits are 0
assign Temp = {1'b0,A}+{1'b0,Bout};
	assign Ovf = Temp[N];
	assign Zero = Y == 0;

always @ (*)
	case(F[1:0])
		2'b00 : Y = A & Bout; // Ands A and B or ~B
		2'b01 : Y = A | Bout; // Ors A and B or ~B
		2'b10 : Y = sum;      // Adds together A and B or ~B(-B)
		2'b11 : Y = sum[N-1];  //  Checks if MSB is 1(-) or 0(+)
	endcase
endmodule
