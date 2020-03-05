`timescale 1ns/1ps
module test_alu32 ();

 logic [31:0] A, B, Y;
 logic [2:0] F;
 logic Z,Ovf;

 alu32 ALU (A,B,F,Y,Z);

 initial begin
 A = 32'h00000000; B = 32'h00000000; F = 3'h2; #10;
  A = 32'h00000000; B = 32'hFFFFFFFF; F = 3'h2; #10;
   A = 32'h00000001; B = 32'hFFFFFFFF; F = 3'h2; #10;
    A = 32'h000000FF; B = 32'h00000001; F = 3'h2; #10;
     A = 32'h00000000; B = 32'h00000000; F = 3'h6; #10;
      A = 32'h00000000; B = 32'hFFFFFFFF; F = 3'h6; #10;
       A = 32'h00000001; B = 32'h00000001; F = 3'h6; #10;
        A = 32'h00000100; B = 32'h00000001; F = 3'h6; #10;
         A = 32'h00000000; B = 32'h00000000; F = 3'h7; #10;
          A = 32'h00000000; B = 32'h00000001; F = 3'h7; #10;
           A = 32'h00000000; B = 32'hFFFFFFFF; F = 3'h7; #10;
            A = 32'h00000001; B = 32'h00000000; F = 3'h7; #10;
             A = 32'hFFFFFFFF; B = 32'h00000000; F = 3'h7; #10;
              A = 32'hFFFFFFFF; B = 32'hFFFFFFFF; F = 3'h4; #10;
               A = 32'hFFFFFFFF; B = 32'h12345678; F = 3'h0; #10;
                A = 32'h12345678; B = 32'h87654321; F = 3'h0; #10;
                 A = 32'h00000000; B = 32'hFFFFFFFF; F = 3'h4; #10;
                  A = 32'hFFFFFFFF; B = 32'hFFFFFFFF; F = 3'h5; #10;
                   A = 32'h12345678; B = 32'h87654321; F = 3'h1; #10;
                    A = 32'h00000000; B = 32'hFFFFFFFF; F = 3'h5; #10;
                     A = 32'h00000000; B = 32'h00000000; F = 3'h1; #10;


 $finish;
 end

endmodule
