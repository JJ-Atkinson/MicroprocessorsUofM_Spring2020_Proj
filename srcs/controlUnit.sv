`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2020 01:28:37 AM
// Design Name: 
// Module Name: controlUnit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module controlUnit(clk, op, funct, memtoreg, memwrite, branch, alucontrol, aluscr, regdst, regwrite, jump);
input[5:0] op, funct;
input clk;
output memtoreg, memwrite, branch, aluscr, regdst, regwrite, jump;
output[2:0] alucontrol;



reg[9:0] out = 10'b0;
assign alucontrol[2:0] = out[2:0];
assign jump = out[3];
assign regwrite = out[9];
assign regdst = out[8];
assign alusrc = out[7];
assign branch = out[6];
assign memwrite = out[5];
assign memtoreg = out[4];

reg[1:0] aluop = 2'b0;

always @(*) begin
    case (op)
/*  r   */  6'b000000: begin out[9:3] <= 7'b1100000; aluop <= 2'b10; end
/*  lw  */  6'b100011: begin out[9:3] <= 7'b1010010; aluop <= 2'b00; end
/*  sw  */  6'b101011: begin out[9:3] <= 7'b0110100; aluop <= 2'b00; end
/* beq  */  6'b000100: begin out[9:3] <= 7'b0001000; aluop <= 2'b00; end
/* addi */  6'b001000: begin out[9:3] <= 7'b1010000; aluop <= 2'b01; end
/*  j   */  6'b000010: begin out[9:3] <= 7'b0000001; aluop <= 2'b00; end
    endcase
    
    casez ({aluop, funct})
        8'b00??????: out[2:0] <= 3'b010; // add
        8'b?1??????: out[2:0] <= 3'b110; // sub
        8'b1?100000: out[2:0] <= 3'b010; // add
        8'b1?100010: out[2:0] <= 3'b110; // sub
        8'b1?100100: out[2:0] <= 3'b000; // and
        8'b1?100101: out[2:0] <= 3'b001; // or
        8'b1?101010: out[2:0] <= 3'b111; // slt
    endcase
end

endmodule
