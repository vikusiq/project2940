module AM2940(clk, DataInput, ACI, WCI, Instruction, OEDATA, ACO, WCO, Done, DataOut, AddressOut);  
	input clk, ACI, WCI, OEDATA;
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
	wire AddressCounter_Reset;  // ->>>>>>>>>>>>>>>>>>>>>>>Nu a fost inclus la curs in tabel
	wire AddressCounter_Enable;
	wire AddressCounter_PL;
	wire AddressCounter_INC;
	wire AddressCounter_DEC;
	wire [7:0] AddressCounter_DataOut;
	
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
	wire [7:0] DataMultiplexer_DataOut;


	InstructionDecoder instructionDecoder(Instruction, ControlRegister_DataOut, ControlRegister_PL, AddressRegister_PL, 
										  WordCountRegister_PL, AddressMultiplexer_SEL, WordCountMultiplexer_SEL, AddressCounter_PL, AddressCounter_Enable,
										  AddressCounter_INC, AddressCounter_DEC, WordCounter_PL, WordCounter_Reset, WordCounter_Enable, WordCounter_INC,
 										  WordCounter_DEC, DataMultiplexer_SEL, OEDATA);
	reg8     AddressRegister(clk, AddressRegister_PL, DataInput, AddressRegister_DataOut);
	MUX1_2   AddressMultiplexer(DataInput, AddressRegister_DataOut, AddressMultiplexer_SEL, AddressMultiplexer_DataOut);
	Counter  AddressCounter(clk, AddressCounter_Reset, AddressCounter_Enable, AddressCounter_PL, AddressMultiplexer_DataOut, AddressCounter_INC, AddressCounter_DEC, ACI, ACO, AddressCounter_DataOut);
	reg8     WordCountRegister(clk, WordCountRegister_PL, DataInput, WordCountRegister_DataOut);
	MUX1_2   WordCountMultiplexer(DataInput, WordCountRegister_DataOut, WordCountMultiplexer_SEL, WordCountMultiplexer_DataOut);
	Counter  WordCounter(clk, WordCounter_Reset, WordCounter_Enable, WordCounter_PL, WordCountMultiplexer_DataOut, WordCounter_INC, WordCounter_DEC, WCI, WCO, WordCounter_DataOut);
	reg3     ControlRegister(clk, ControlRegister_PL, DataInput[2:0], ControlRegister_DataOut);
	mux13    DataMultiplexer(AddressCounter_DataOut, WordCounter_DataOut, ControlRegister_DataOut, DataMultiplexer_SEL, DataMultiplexer_DataOut);
endmodule






module test_AM2940;



endmodule

