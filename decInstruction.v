module InstructionDecoder(I, CR, PLCR, PLAR, PLWR, SELA, SELW, PLAC, ENA, INCA, DECA, PLWC, RESW, ENW, INCW, DECW, SELDATA, OEDATA);
  
  input [2:0] I;   //Instruction
  input [2:0] CR;  //Control Register Out
  
  output reg PLCR; //Parallel Load Control Register
  output reg PLAR; //Parallel Load Address Register
  output reg PLWR; //Parallel Load Word Register
  
  output reg SELA; //Select Address Multiplexer 
  output reg SELW; //Select Word Multiplexer
  
  output reg PLAC; //Parallel Load Address Counter 
  output reg ENA;  //Enable Address Counter
  output reg INCA; //Increment Address Counter
  output reg DECA; //Decrement Address Counter 
  
  output reg PLWC; //Parallel Load Word Count
  output reg RESW; //Reset Word Counter  
  output reg ENW;  //Enable Word Counter 
  output reg INCW; //Increment Word Counter
  output reg DECW; //Decrement Word Counter
  
  output reg [1:0] SELDATA; //Data Multiplexer Select
  output reg OEDATA;  
  
  always@(I or CR ) begin
  casex({I,CR}) 
    //1
    6'b000xxx: begin
               PLCR=1'b1; PLAR=1'b0; PLWR=1'b0; SELA=1'bx;
               SELW=1'bx; PLAC=1'b0; ENA=1'b0; INCA=1'bx; 
               DECA=1'bx; PLWC=1'b0; RESW=1'b0; ENW=1'b0;
               INCW=1'bx; DECW=1'bx; SELDATA=2'bxx; OEDATA=1'b0;
               end
    //2            
    6'b001xxx: begin
               PLCR=1'b0; PLAR=1'b0; PLWR=1'b0; SELA=1'bx;
               SELW=1'bx; PLAC=1'b0; ENA=1'b0; INCA=1'bx; 
               DECA=1'bx; PLWC=1'b0; RESW=1'b0; ENW=1'b0;
               INCW=1'bx; DECW=1'bx; SELDATA=2'b1x; OEDATA=1'b1;  
               end
    //3             
    6'b010xxx: begin 
               PLCR=1'b0; PLAR=1'b0; PLWR=1'b0; SELA=1'bx;
               SELW=1'bx; PLAC=1'b0; ENA=1'b0; INCA=1'bx; 
               DECA=1'bx; PLWC=1'b0; RESW=1'b0; ENW=1'b0;
               INCW=1'bx; DECW=1'bx; SELDATA=2'b01; OEDATA=1'b1; 
               end  
    //4              
    6'b011xxx: begin 
			   PLCR=1'b0; PLAR=1'b0; PLWR=1'b0; SELA=1'bx;
               SELW=1'bx; PLAC=1'b0; ENA=1'b0; INCA=1'bx; 
               DECA=1'bx; PLWC=1'b0; RESW=1'b0; ENW=1'b0;
               INCW=1'bx; DECW=1'bx; SELDATA=2'b00; OEDATA=1'b1;
             end
    //5
    6'b100xx0,
    6'b100x11: begin 
               PLCR=1'b0; PLAR=1'b0; PLWR=1'b0; SELA=1'b1;
               SELW=1'b1; PLAC=1'b1; ENA=1'b0; INCA=1'bx; 
               DECA=1'bx; PLWC=1'b1; RESW=1'b0; ENW=1'b0;
               INCW=1'bx; DECW=1'bx; SELDATA=2'bxx; OEDATA=1'b0;
             end
    //6
    6'b100x01: begin 
               PLCR=1'b0; PLAR=1'b0; PLWR=1'b0; SELA=1'b1;
               SELW=1'bx; PLAC=1'b1; ENA=1'b0; INCA=1'bx; 
               DECA=1'bx; PLWC=1'b0; RESW=1'b1; ENW=1'b0;
               INCW=1'bx; DECW=1'bx; SELDATA=2'bxx; OEDATA=1'b0; 
             end
    //7              
    6'b101xxx: begin 
               PLCR=1'b0; PLAR=1'b1; PLWR=1'b0; SELA=1'b0;
               SELW=1'bx; PLAC=1'b1; ENA=1'b0; INCA=1'bx; 
               DECA=1'bx; PLWC=1'b0; RESW=1'b0; ENW=1'b0;
               INCW=1'bx; DECW=1'bx; SELDATA=2'bxx; OEDATA=1'b0;
             end
    //8
    6'b110xx0,
    6'b110x11: begin PLCR=1'b0; PLAR=1'b0; PLWR=1'b1; SELA=1'bx;
               SELW=1'b0; PLAC=1'b0; ENA=1'b0; INCA=1'bx; 
               DECA=1'bx; PLWC=1'b1; RESW=1'b0; ENW=1'b0;
               INCW=1'bx; DECW=1'bx; SELDATA=2'bxx; OEDATA=1'b0;    
             end
    //9
    6'b110x01: begin 
	           PLCR=1'b0; PLAR=1'b0; PLWR=1'b1; SELA=1'bx;
               SELW=1'b0; PLAC=1'b0; ENA=1'b0; INCA=1'bx; 
               DECA=1'bx; PLWC=1'b0; RESW=1'b1; ENW=1'b0;
               INCW=1'bx; DECW=1'bx; SELDATA=2'bxx; OEDATA=1'b0;
             end
    //10
    6'b111000: begin 
	           PLCR=1'b0; PLAR=1'b0; PLWR=1'b0; SELA=1'bx;
               SELW=1'bx; PLAC=1'b0; ENA=1'b1; INCA=1'b1; 
               DECA=1'b0; PLWC=1'b0; RESW=1'b0; ENW=1'b1;
               INCW=1'b0; DECW=1'b1; SELDATA=2'bxx; OEDATA=1'b0;
             end
    //11
    6'b1110x1: begin 
	           PLCR=1'b0; PLAR=1'b0; PLWR=1'b0; SELA=1'bx;
               SELW=1'bx; PLAC=1'b0; ENA=1'b1; INCA=1'b1; 
               DECA=1'b0; PLWC=1'b0; RESW=1'b0; ENW=1'b1;
               INCW=1'b1; DECW=1'b0; SELDATA=2'bxx; OEDATA=1'b0;
             end
    //12
    6'b111010: begin 
	           PLCR=1'b0; PLAR=1'b0; PLWR=1'b0; SELA=1'bx;
               SELW=1'bx; PLAC=1'b0; ENA=1'b1; INCA=1'b1; 
               DECA=1'b0; PLWC=1'b0; RESW=1'b0; ENW=1'b0;
               INCW=1'bx; DECW=1'bx; SELDATA=2'bxx; OEDATA=1'b0;
             end
    //13
    6'b111100: begin 
	           PLCR=1'b0; PLAR=1'b0; PLWR=1'b0; SELA=1'bx;
               SELW=1'bx; PLAC=1'b0; ENA=1'b1; INCA=1'b0; 
               DECA=1'b1; PLWC=1'b0; RESW=1'b0; ENW=1'b1;
               INCW=1'b0; DECW=1'b1; SELDATA=2'bxx; OEDATA=1'b0;
             end
    //14
    6'b1111x1: begin 
	           PLCR=1'b0; PLAR=1'b0; PLWR=1'b0; SELA=1'bx;
               SELW=1'bx; PLAC=1'b0; ENA=1'b1; INCA=1'b0; 
               DECA=1'b1; PLWC=1'b0; RESW=1'b0; ENW=1'b1;
               INCW=1'b0; DECW=1'b0; SELDATA=2'bxx; OEDATA=1'b0;
             end
    //15
    6'b111110: begin
	           PLCR=1'b0; PLAR=1'b0; PLWR=1'b0; SELA=1'bx;
               SELW=1'bx; PLAC=1'b0; ENA=1'b1; INCA=1'b0; 
               DECA=1'b1; PLWC=1'b0; RESW=1'b0; ENW=1'b0;
               INCW=1'bx; DECW=1'bx; SELDATA=2'bxx; OEDATA=1'b0;
             end                                
  endcase
end
endmodule


module test_InstructionDecoder;
	//Nu chiar este ce de testat aici
endmodule