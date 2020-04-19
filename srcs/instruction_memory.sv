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

