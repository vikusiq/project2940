`define NBITS  8

module mux12(di0, di1, sel, do);
  input  [`NBITS-1:0] di0, di1;
  input  sel; 
  output [`NBITS-1:0] do;
  reg    [`NBITS-1:0] do;
  
  always@(sel) begin
    casex(sel)
      1'b0: do = di0;
      1'b1: do = di1;
    endcase  
end
endmodule

module test_Mux12;
  reg [`NBITS-1:0] input0;
  reg [`NBITS-1:0] input1;
  reg selection;
  wire [`NBITS-1:0] out;
  
  mux12 InstMux12(input0, input1, selection, out);
  
  initial 
    begin
      #0  input0 = 8'b1;
          input1 = 8'h0F;
          selection = 1'b0;
      #20 selection = 1'b1;
      
      #10 $finish;
    end
  
endmodule