module reg3(clk, PL, di, do);
  input clk,PL;
  input [2:0] di;
  output reg [2:0] do;
  
  always@(posedge clk ) 
    if(PL)
      do<=di;
     
endmodule

module test_Reg3;
  reg clk, PL;
  reg [2:0] di;
  wire [2:0] do;
  
  reg8 instReg8(clk, PL, di, do);
  
  always #5 clk = ~clk;
  
  initial
  begin
    #0 clk = 1'b0;
       PL = 1'b0;
       di = 3'h7;
       
    #20 PL = 1'b1;
    
    #20 PL = 1'b0;
    
    #20 $finish;
  end
  
endmodule