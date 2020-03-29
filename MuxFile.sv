module MultiPlex #(parameter width=1) (in0, in1, out, Select);
input [width-1:0] inl, inr;
input  Select;
output[width-1:0] out;

always @(*) begin
        case (Select)
                1'b0: out <= inl;
                1'b1: out <= inr;
        endcase
end
endmodule
