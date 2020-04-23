`timescale 1ns/1ps

module Main();

wire MemtoReg, PCSrc, MemWrite, Banch,
       	ALUSrc, RegDst, RegWrite, 
	Clk, Zero, 
	Jump, Ovf;


wire [31:0] Instr, PCPlus4, ALUResult, WriteData,
	SrcA, SrcB, ImmExt, PCBranch, ReadData, Result, PCPrimePrime,
		PCPrime, RD2, PC;

wire [2:0] ALUControl;


MultiPlex mp1 (PCPlus4, PCBRanch, PCPrimePrime, PCSrc);
MultiPlex mp2 (PCPrimePrime, {4'b0, Instr[25:0], 2'b0},
       	PCPrime, Jump);

// needs clk

imem instr_memory (PC, Instr);

assign PCPlus4 = 4 + PC;

controlUnit cu (Clk, Instr[31:25], Instr[5:0], MemtoReg, MemWrite, Branch, ALUControl, ALUSrc, RegDst, RegWrite, Jump);

assign PCSrc = Branch & Zero;

regfile register_file (Clk, RegWrite, Instr[25:21], Instr[20:16], A3_registerfile, Result, SrcA, RD2);


// register file has src a

MultiPlex #(.width(5)) registerFileMux (Instr[20:16], Instr[15:11], A3_registerfile, RegDst);

//             vv error here
MultiPlex mp3 (RD2, ImmExt, SrcB, ALUSrc);
assign PCBranch = {ImmExt[29:0], 2'b0} + PCPlus4;

signExtend se (Instr[15:0], ImmExt);

ALU alcool (SrcA, SrcB, ALUControl, ALUResult, Ovf, Zero);


dataMemory dm(Clk, MemWrite, ALUResult, ReadData, WriteData);


MultiPlex mp4 (ALuResult, ReadData, Result, MemtoReg);

endmodule
