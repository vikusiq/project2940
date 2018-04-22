`define NBITS 8

module genDone(AC, WC, WR, CR, WCin, done);
  input [`NBITS-1:0] AC; //Address Counter
  input [`NBITS-1:0] WC; //Word Counter
  input [`NBITS-1:0] WR; //Word Register
  input [1:0] CR; //Control Register
  input WCin; //Word CarryIn

  output reg done;

  wire n1,n2,n3,n4,n5;
  
  assign n1 = (WC === 1);
  assign n2 = (WC === 0);
  assign n3 = (WC+1 === WR);
  assign n4 = (WC === WR);
  assign n5 = (WC === AC);
  
  always@(WC or WR or AC or CR or WCin or n1 or n2 or n3 or n4 or n5 )
  begin
    casex({CR[1:0], WCin, n1, n2, n3, n4, n5})
      8'b0000xxxx: done = 1'b0;
      8'b0001xxxx: done = 1'b1;
      8'b001x0xxx: done = 1'b0;
      8'b001x1xxx: done = 1'b1; 
           
      8'b010xx0xx: done = 1'b0;
      8'b010xx1xx: done = 1'b1; 
           
      8'b011xxx0x: done = 1'b0;
      8'b011xxx1x: done = 1'b1;      
      8'b10xxxxx0: done = 1'b0;
      8'b10xxxxx1: done = 1'b1;      
      8'b11xxxxxx: done = 1'b0;
      
  endcase
  end
  
endmodule

module test_GenDone;
  
  reg  [`NBITS-1:0] AC;
  reg  [`NBITS-1:0] WC;
  reg  [`NBITS-1:0] WR;
  reg  [1:0] CR;
  reg  WCin;
  wire done;
  
  genDone InstGenDone(AC, WC, WR, CR, WCin, done);
  
  initial begin 
    #0   CR = 2'b00; WCin = 1'b0; WC = 8'hFF; AC = 8'hFF; WR = 8'hFF;
    #20  CR = 2'b00; WCin = 1'b0; WC = 8'h01; AC = 8'hFF; WR = 8'hFF;    
    #20  CR = 2'b00; WCin = 1'b1; WC = 8'hFF; AC = 8'hFF; WR = 8'hFF;
    #20  CR = 2'b00; WCin = 1'b1; WC = 8'h00; AC = 8'h00; WR = 8'hFF;
        
    #20  CR = 2'b01; WCin = 1'b0; WC = 8'hFF; AC = 8'hFF; WR = 8'hFF;
    #20  CR = 2'b01; WCin = 1'b0; WC = 8'hFE; AC = 8'hFF; WR = 8'hFF;    
    
    #20  CR = 2'b01; WCin = 1'b1; WC = 8'hAA; AC = 8'hFF; WR = 8'hFF;
    #20  CR = 2'b01; WCin = 1'b1; WC = 8'hFF; AC = 8'hFF; WR = 8'hFF;    
    #20  CR = 2'b10; WCin = 1'b0; WC = 8'hAA; AC = 8'hFF; WR = 8'hFF;
    #20  CR = 2'b10; WCin = 1'b0; WC = 8'hFF; AC = 8'hFF; WR = 8'hFF;    
    #20  CR = 2'b11; WCin = 1'b1; WC = 8'hFF; AC = 8'hFF; WR = 8'hFF;    
    #20 $finish;
  end
 endmodule