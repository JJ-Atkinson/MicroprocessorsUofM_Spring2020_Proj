module dataMemory #(parameter M = 32)(CLK, WE, A, RD, WD);
  input logic CLK;
  // write port
  input logic [M-1:0] WD;
  input logic WE;
  // address input, shared by read and write port  
  input logic [M-1:0] A; 
  //read data
  output logic [M-1:0] RD;     
  
  logic [M-1:0]RAM[2**M-1:0];
  assign RD = RAM[A[M-1:2]]; // World alligned
  
  always_ff @(posedge CLK)
    if(WE)
      RAM[A[M-1:2]] <= WD;
endmodule
  
  
