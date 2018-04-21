
module InstructionDecoder(I, CR, RLCR, PLAR, PLWR, SELA, SELW, PLAC, ENA, INCA, DECA, PLWC, RESW, ENW, INCW, DECW, SELDATA, OEDATA);
  
  input [2:0] I;
  input [2:0] CR;
  output reg RLCR, PLAR, PLWR, SELA, SELW, PLAC, ENA, INCA, DECA, PLWC, RESW, ENW, INCW, DECW, OEDATA;
  output reg [1:0] SELDATA; 
  
  always@(I or CR ) begin
  casex({I,CR}) 
    //1
    6'b000xxx: begin
               RLCR=1'b1; PLAR=1'b0; PLWR=1'b0; SELA=1'bx;
               SELW=1'bx; PLAC=1'b0; ENA=1'b0; INCA=1'bx; 
               DECA=1'bx; PLWC=1'b0; RESW=1'b0; ENW=1'b0;
               INCW=1'bx; DECW=1'bx; SELDATA=2'bxx; OEDATA=1'b0;
               end
    //2            
    6'b001xxx: begin
               RLCR=1'b0; PLAR=1'b0; PLWR=1'b0; SELA=1'bx;
               SELW=1'bx; PLAC=1'b0; ENA=1'b0; INCA=1'bx; 
               DECA=1'bx; PLWC=1'b0; RESW=1'b0; ENW=1'b0;
               INCW=1'bx; DECW=1'bx; SELDATA=2'b1x; OEDATA=1'b1;  
               end
    //3             
    6'b010xxx: begin 
               RLCR=1'b0; PLAR=1'b0; PLWR=1'b0; SELA=1'bx;
               SELW=1'bx; PLAC=1'b0; ENA=1'b0; INCA=1'bx; 
               DECA=1'bx; PLWC=1'b0; RESW=1'b0; ENW=1'b0;
               INCW=1'bx; DECW=1'bx; SELDATA=2'b01; OEDATA=1'b1; 
               end  
    //4              
    6'b011xxx: begin 
	       RLCR=1'b0; PLAR=1'b0; PLWR=1'b0; SELA=1'bx;
               SELW=1'bx; PLAC=1'b0; ENA=1'b0; INCA=1'bx; 
               DECA=1'bx; PLWC=1'b0; RESW=1'b0; ENW=1'b0;
               INCW=1'bx; DECW=1'bx; SELDATA=2'b00; OEDATA=1'b1;
             end
    //5
    6'b100xx0,
    6'b100x11: begin 
               RLCR=1'b0; PLAR=1'b0; PLWR=1'b0; SELA=1'b1;
               SELW=1'b1; PLAC=1'b1; ENA=1'b0; INCA=1'bx; 
               DECA=1'bx; PLWC=1'b1; RESW=1'b0; ENW=1'b0;
               INCW=1'bx; DECW=1'bx; SELDATA=2'bxx; OEDATA=1'b0;
             end
    //6
    6'b100x01: begin 
               RLCR=1'b0; PLAR=1'b0; PLWR=1'b0; SELA=1'b1;
               SELW=1'bx; PLAC=1'b1; ENA=1'b0; INCA=1'bx; 
               DECA=1'bx; PLWC=1'b0; RESW=1'b1; ENW=1'b0;
               INCW=1'bx; DECW=1'bx; SELDATA=2'bxx; OEDATA=1'b0; 
             end
    //7              
    6'b101xxx: begin 
               RLCR=1'b0; PLAR=1'b1; PLWR=1'b0; SELA=1'b0;
               SELW=1'bx; PLAC=1'b1; ENA=1'b0; INCA=1'bx; 
               DECA=1'bx; PLWC=1'b0; RESW=1'b0; ENW=1'b0;
               INCW=1'bx; DECW=1'bx; SELDATA=2'bxx; OEDATA=1'b0;
             end
    //8
    6'b110xx0,
    6'b110x11: begin RLCR=1'b0; PLAR=1'b0; PLWR=1'b1; SELA=1'bx;
               SELW=1'b0; PLAC=1'b0; ENA=1'b0; INCA=1'bx; 
               DECA=1'bx; PLWC=1'b1; RESW=1'b0; ENW=1'b0;
               INCW=1'bx; DECW=1'bx; SELDATA=2'bxx; OEDATA=1'b0;    
             end
    //9
    6'b110x01: begin 
	       RLCR=1'b0; PLAR=1'b0; PLWR=1'b1; SELA=1'bx;
               SELW=1'b0; PLAC=1'b0; ENA=1'b0; INCA=1'bx; 
               DECA=1'bx; PLWC=1'b0; RESW=1'b1; ENW=1'b0;
               INCW=1'bx; DECW=1'bx; SELDATA=2'bxx; OEDATA=1'b0;
             end
    //10
    6'b111000: begin 
	       RLCR=1'b0; PLAR=1'b0; PLWR=1'b0; SELA=1'bx;
               SELW=1'bx; PLAC=1'b0; ENA=1'b1; INCA=1'b1; 
               DECA=1'b0; PLWC=1'b0; RESW=1'b0; ENW=1'b1;
               INCW=1'b0; DECW=1'b1; SELDATA=2'bxx; OEDATA=1'b0;
             end
    //11
    6'b1110x1: begin 
	       RLCR=1'b0; PLAR=1'b0; PLWR=1'b0; SELA=1'bx;
               SELW=1'bx; PLAC=1'b0; ENA=1'b1; INCA=1'b1; 
               DECA=1'b0; PLWC=1'b0; RESW=1'b0; ENW=1'b1;
               INCW=1'b1; DECW=1'b0; SELDATA=2'bxx; OEDATA=1'b0;
             end
    //12
    6'b111010: begin 
	       RLCR=1'b0; PLAR=1'b0; PLWR=1'b0; SELA=1'bx;
               SELW=1'bx; PLAC=1'b0; ENA=1'b1; INCA=1'b1; 
               DECA=1'b0; PLWC=1'b0; RESW=1'b0; ENW=1'b0;
               INCW=1'bx; DECW=1'bx; SELDATA=2'bxx; OEDATA=1'b0;
             end
    //13
    6'b111100: begin 
	       RLCR=1'b0; PLAR=1'b0; PLWR=1'b0; SELA=1'bx;
               SELW=1'bx; PLAC=1'b0; ENA=1'b1; INCA=1'b0; 
               DECA=1'b1; PLWC=1'b0; RESW=1'b0; ENW=1'b1;
               INCW=1'b0; DECW=1'b1; SELDATA=2'bxx; OEDATA=1'b0;
             end
    //14
    6'b1111x1: begin 
	       RLCR=1'b0; PLAR=1'b0; PLWR=1'b0; SELA=1'bx;
               SELW=1'bx; PLAC=1'b0; ENA=1'b1; INCA=1'b0; 
               DECA=1'b1; PLWC=1'b0; RESW=1'b0; ENW=1'b1;
               INCW=1'b0; DECW=1'b0; SELDATA=2'bxx; OEDATA=1'b0;
             end
    //15
    6'b111110: begin
	       RLCR=1'b0; PLAR=1'b0; PLWR=1'b0; SELA=1'bx;
               SELW=1'bx; PLAC=1'b0; ENA=1'b1; INCA=1'b0; 
               DECA=1'b1; PLWC=1'b0; RESW=1'b0; ENW=1'b0;
               INCW=1'bx; DECW=1'bx; SELDATA=2'bxx; OEDATA=1'b0;
             end

               
               
                                  
  endcase
end
endmodule


module test_InstructionDecoder;
	//InstructionDecoder instructionDecoder();



endmodule