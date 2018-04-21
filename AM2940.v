module AM2940(clk, DataInput, ACI, WCI, Instruction, ACO, WCO, Done, DataOut, AddressOut);
	input clk, ACI, WCI;
	input [7:0] DataInput;
	input [2:0] Instruction;
	
	output ACO, WCO, Done;
	output [7:0] DataOut;
	output [7:0] AddressOut;
	
	

endmodule


