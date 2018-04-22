module AM2940(clk, DataInput, ACI, WCI, Instruction, ACO, WCO, Done, DataOut, AddressOut);  
	input clk, ACI, WCI;
	input [7:0] DataInput;
	input [2:0] Instruction;
	
	output ACO, WCO, Done;
	output [7:0] DataOut;
	output [7:0] AddressOut;
	
	//AddressRegister
	wire AddressRegister_PL;
	wire [7:0] AddressRegister_DataOut;

	//Address_Multiplexer
	wire AddressMultiplexer_SEL;
	wire [7:0] AddressMultiplexer_DataOut;
	
	//AddressCounter
	wire AddressCounter_Reset;  
	wire AddressCounter_Enable;
	wire AddressCounter_PL;
	wire AddressCounter_INC;
	wire AddressCounter_DEC;
	
	//WordCountRegister
	wire WordCountRegister_PL;
	wire [7:0] WordCountRegister_DataOut;
	
	//WordCountMultiplexer
	wire WordCountMultiplexer_SEL;
	wire [7:0] WordCountMultiplexer_DataOut;
	
	//WordCounter
	wire WordCounter_Reset;
	wire WordCounter_Enable;
	wire WordCounter_PL;
	wire WordCounter_INC;
	wire WordCounter_DEC;
	wire [7:0] WordCounter_DataOut;
	
	//ControlRegister
	wire ControlRegister_PL;
	wire [2:0] ControlRegister_DataOut;
	
	//DataMultiplexer
	wire [1:0] DataMultiplexer_SEL;
	
	
	wire OEDATA;
	
	InstructionDecoder instructionDecoder(Instruction, ControlRegister_DataOut, ControlRegister_PL, AddressRegister_PL, 
										  WordCountRegister_PL, AddressMultiplexer_SEL, WordCountMultiplexer_SEL, AddressCounter_PL, AddressCounter_Enable,
										  AddressCounter_INC, AddressCounter_DEC, WordCounter_PL, WordCounter_Reset, WordCounter_Enable, WordCounter_INC,
 										  WordCounter_DEC, DataMultiplexer_SEL, OEDATA); 
	reg8     AddressRegister(clk, AddressRegister_PL, DataInput, AddressRegister_DataOut);
	mux12    AddressMultiplexer(DataInput, AddressRegister_DataOut, AddressMultiplexer_SEL, AddressMultiplexer_DataOut);
	Counter  AddressCounter(clk, AddressCounter_Reset, AddressCounter_Enable, AddressCounter_PL, AddressMultiplexer_DataOut, AddressCounter_INC, AddressCounter_DEC, ACI, ACO, AddressOut);
	reg8     WordCountRegister(clk, WordCountRegister_PL, DataInput, WordCountRegister_DataOut);
	mux12    WordCountMultiplexer(DataInput, WordCountRegister_DataOut, WordCountMultiplexer_SEL, WordCountMultiplexer_DataOut);
	Counter  WordCounter(clk, WordCounter_Reset, WordCounter_Enable, WordCounter_PL, WordCountMultiplexer_DataOut, WordCounter_INC, WordCounter_DEC, WCI, WCO, WordCounter_DataOut);
	reg3     ControlRegister(clk, ControlRegister_PL, DataInput[2:0], ControlRegister_DataOut);
	mux13    DataMultiplexer(AddressOut, WordCounter_DataOut, ControlRegister_DataOut, DataMultiplexer_SEL, DataOut);
	genDone  DoneGenerator(AddressOut, WordCounter_DataOut, WordCountRegister_DataOut, ControlRegister_DataOut[1:0], WCI, Done);
endmodule






module test_AM2940;
	reg clk, ACI, WCI;
	reg [7:0] DataInput;
	reg [2:0] Instruction;
	
	wire ACO, WCO, Done;
	wire [7:0] DataOut, AddressOut;

	
	AM2940 am2940(.clk(clk),.DataInput(DataInput),.ACI(ACI),.WCI(WCI),.Instruction(Instruction),.ACO(ACO),.WCO(WCO),.Done(Done),.DataOut(DataOut),.AddressOut(AddressOut));
	
	always #5 clk = ~clk;
	
	initial 
		begin
			#0
				clk = 1'b0;
				Instruction = 3'b000;   //0.Write Control Register
				WCI = 1'b0;
				ACI = 1'b0;
				DataInput = 8'b0000_1000;
			#50 
				Instruction = 3'b001;   //1.Read Control Register
			#50 
				Instruction = 3'b010;   //2.Read Word Counter
			#50 
				Instruction = 3'b011;   //3.Read Address Counter
			#50 
				Instruction = 3'b100;   //4.Reinitialize Counters
			#50 
				Instruction = 3'b101;   //5.Load Address
			#50 
				Instruction = 3'b110;   //6.Load Word Count
			#50 
				Instruction = 3'b111;	//7.Enable Counters
			#100 $finish;
		end
endmodule

