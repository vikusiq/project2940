`define NBITS 8

module mux13(di0, di1, di2, sel, do);
  input  [`NBITS-1:0] di0, di1;
  input  [`NBITS-6:0] di2;
  input  [1:0] sel; 
  output [`NBITS-1:0] do;
  reg    [`NBITS-1:0] do;
  
  always@(sel) begin
     casex(sel)
     2'b00: do=di0;
     2'b01: do=di1;
     2'b1x: do={5'b11111, di2};
   endcase
  end
endmodule

module test_Mux13;
  reg [`NBITS-1:0] input0;
  reg [`NBITS-1:0] input1;
  reg [`NBITS-6:0] input2;
  reg [1:0] selection;
  wire [`NBITS-1:0] out;
  
  mux13 InstMux13(input0, input1, input2, selection, out);
  
  initial 
    begin
      #0  input0 = 8'b1;
          input1 = 8'h0F;
          input2 = 3'b010;
          selection = 2'b00;
        
      #20 input0 = 8'b1;
          input1 = 8'h0F;
          input2 = 3'b010;
          selection = 2'b01;
          
      #20 input0 = 8'b1;
          input1 = 8'h0F;
          input2 = 3'b010;
          selection = 2'b10;
          
      #20 input0 = 8'b1;
          input1 = 8'h0F;
          input2 = 3'b010;
          selection = 2'b01;     
                
      #20 input0 = 8'b1;
          input1 = 8'h0F;
          input2 = 3'b010;
          selection = 2'b11;       
             
      
      #10 $finish;
    end
  
endmodule