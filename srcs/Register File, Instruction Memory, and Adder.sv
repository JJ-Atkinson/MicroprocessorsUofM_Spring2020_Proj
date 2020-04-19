// Register File

module regfile (input logic clk,
					 input logic we3,
					 input logic [4:0] ra1, ra2, wa3,
					 input logic [31:0] wd3,
					 output logic [31:0] rd1, rd2);
logic [31:0] rf[31:0];
// three ported refister file
// read two ports combinationally
// write third port on rising edge of clock
// register 0 hardwired to 0

always @ (posedge clk)
	if (we3) rf[wa3] <= wd3;

	assign rd1 = (ra1 != 0) ? rf[ra1] : 0;
	assign rd2 = (ra2 != 0) ? rf[ra2] : 0;
	
endmodule

/----------------------------------------------------------------

// Instruction Memory

module imem(input [5:0]  a,
		output[31:0] rd);
reg[31:0] RAM[63:0];

initial
	begin
		$readmemh("memfile.dat", RAM);	//We need to write a data file. 
	end
assign rd = RAM[a]; // word alligned
endmodule
