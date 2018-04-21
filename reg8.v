module reg8(clk, PL, di, do);
  input clk,PL;
  input [7:0] di;
  output reg [7:0] do;
  
  always@(posedge clk ) begin
    if(PL)
      do<=di;
    end        
endmodule

module test_Reg8;
  reg clk, PL;
  reg [7:0] di;
  wire [7:0] do;
  
  reg8 instReg8(clk, PL, di, do);
  
  always #5 clk = ~clk;
  
  initial
  begin
    #0 clk = 1'b0;
       PL = 1'b0;
       di = 8'hAF;
       
    #20 PL = 1'b1;
    
    #20 PL = 1'b0;
    
    #20 $finish;
  end
  
endmodule