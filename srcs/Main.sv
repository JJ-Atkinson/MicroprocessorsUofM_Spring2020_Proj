`timescale 1ns/1ps



module Main();

wire MemtoReg, PCSrc, MemWrite, Banch,
       	ALUSrc, RegDst, RegWrite, 
	Clk, Zero, ALUResult, PCSrc,
	ReadData, Jump, Ovf;

reg [31:0] PC;

wire [31:0] Instr, PCPlus4, ALUResult, WriteData
	SrcA, SrcB, ImmExt, PCBranch, ReadData, Result, PCPrimePrime,
		PCPrime;

wire [2:0] ALUControl;


MultiPlex mp1 #(parameter width=32) (in1, in2, PCPrimePrime, PCSrc);
MultiPlex mp2 #(parameter width=32) (PCPrimePrime, {4'b0, Instr[25:0], 2'b0},
       	PCPrime, Jump);

// needs clk

// needs im

assign PCPlus4 = 4 + PC;

controlUnit cu (Clk, Instr[31:25], Instr[5:0], MemtoReg, MemWrite, Branch, ALUControl, ALUSrc, RegDst, RegWrite, Jump);

assign PCSrc = Branch & Zero;

// register file has src a

MultiPlex registerFileMux #(parameter width=5) (Instr[20:16], Instr[15:11], A3_registerfile, RegDst);
MultiPlex mp3 #(parameter width=32) (RD2 from register, ImmExt, SrcB, ALUSrc);
assign PCBranch = {IMMExt[29:0], 2'b0} + PCPlus4;

signExtend se (Instr[15:0], ImmExt);

ALU alcool (SrcA, SrcB, ALUControl, ALUResult, Ovf, /*need to add*/ Zero);
//                                             not used


dataMemory dm(Clk, MemWrite, ALUResult, ReadData, WriteData);


MultiPlex mp4 #(parameter width=32) (ALuResult, ReadData, Result, MemtoReg);

endmodule
