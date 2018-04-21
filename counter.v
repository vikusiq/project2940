//Se numara cand carryIn e pe '0' si ENABLE-ul e activ
//directia de numarare e data de INC -> crescator
//                               DEC -> descrescator
//Cand carryIn e pe 1 (adica inactiv) , counter-ul sta in starea de hold si nu mai numara
module Counter(clk, RES, EN, PL, di, INC, DEC, CarryIn, CarryOut, do);
  input clk, RES, EN, INC, DEC, PL, CarryIn;
  input [7:0] di;
  
  output wire CarryOut;
  output reg [7:0] do;
  
  always @(posedge clk)
   casex({RES, EN, PL, CarryIn, INC, DEC})
      6'b1xxxxx: do = 8'b0;  //reset
      6'b00xxxx: do = do;    //enable-ul inactiv 
      6'b011xxx: do = di;    //paralel load activ
      6'b010010: do = do + 1;//inc activ si carryIn Activ pe 0
      6'b010001: do = do - 1;//dec activ si carryIn Activ pe 0
      6'b0101xx: do = do;    //carryIn inactiv,stare de HOLD
        default: do = do;
   endcase
   
wire carryFromUpperSide;
wire carryFromBottomSide;

assign carryFromUpperSide = {RES, EN, PL, CarryIn, INC, do} == 13'b0_1_0_0_1_11111111 ? 1'b1 : 1'b0;
assign carryFromBottomSide = {RES, EN, PL, CarryIn, DEC, do} == 13'b0_1_0_0_1_00000000 ? 1'b1 : 1'b0;
assign CarryOut = carryFromUpperSide || carryFromBottomSide ? 1'b1 : 1'b0;

endmodule




module test_Counter;
  reg clk,RES,EN, INC, DEC, PL, CarryIn;
  reg [7:0] di;
  
  wire [7:0] do;
  wire CarryOut;
  
  Counter counter(.clk(clk), .RES(RES), .EN(EN), .PL(PL), .di(di), .INC(INC), .DEC(DEC), .CarryIn(CarryIn), .CarryOut(CarryOut), .do(do));
  
  
  always #5 clk = ~clk;
  
  initial 
    begin
      #0 
        clk = 1'b0;
        RES = 1'b1;     //Reset activ
        EN = 1'b1;
        PL = 1'b0;
        di = 8'h0;
        INC = 1'b0;
        DEC = 1'b0;
        CarryIn = 1'b1; //inactiv
      #50
        RES = 1'b0;
        EN = 1'b1;
        PL = 1'b1;      //se va face PL
        di = 8'b11111110; 
      #20
        PL = 1'b0;
        INC = 1'b1;     //INC Activ
        CarryIn = 1'b0; //CarryIn activ    
      #50
        EN = 1'b0;      //HOLD
      #20
        EN = 1'b1;
        INC = 1'b0;
        DEC = 1'b1;     //DEC activ
      #20 
	PL = 1'b1;	//PL activ
	di = 8'hFF;	
      #20 //ca rezultat la aceasta etapa, NU ar trebui sa fie semnalizat overflow
	PL = 1'b0;
	RES = 1'b1;	//Reset activ
	EN = 1'b1;
	INC = 1'b1;	//INC activ 
	CarryIn = 1'b0; //carry activ
      #20
	RES = 1'b0;
	di = 8'h01;
	PL = 1'b1;	
      #20
	PL = 1'b0;
	INC = 1'b0;
	DEC = 1'b1;	
      #100 $finish;
    end
endmodule


