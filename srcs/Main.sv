`timescale 1ns/1ps



module Main();

wire MemtoReg, PCSrc, MemWrite, Banch,
       	ALUSrc, RegDst, RegWrite, 
	Clk, Zero, ALUResult, PCSrc,
	ReadData, Jump, Ovf;

reg [31:0] PC;

wire [31:0] Instr, PCPlus4, ALUResult, WriteData,
	SrcA, SrcB, ImmExt, PCBranch, ReadData, Result, PCPrimePrime,
		PCPrime, RD2;

wire [2:0] ALUControl;


MultiPlex mp1 (in1, in2, PCPrimePrime, PCSrc);
MultiPlex mp2 (PCPrimePrime, {4'b0, Instr[25:0], 2'b0},
       	PCPrime, Jump);

// needs clk

// needs im

assign PCPlus4 = 4 + PC;

controlUnit cu (Clk, Instr[31:25], Instr[5:0], MemtoReg, MemWrite, Branch, ALUControl, ALUSrc, RegDst, RegWrite, Jump);

assign PCSrc = Branch & Zero;


//input logic clk,
//			    input logic we3,
//				input logic [4:0] ra1, ra2, wa3,
//				input logic [31:0] wd3,
//				output logic [31:0] rd1, rd2

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
