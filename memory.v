module memory(
	input clock, write_enable, read_enable_1 , read_enable_2,
	input load_code,
	
	input [7:0] write_addr,
	input [7:0] read_addr_1,
	input [7:0] read_addr_2,
	
	input [31:0] write_data,
	output reg [31:0] read_data_1,
	output reg [31:0] read_data_2,
	
	output reg [31:0] output_last_word
	

);

reg [31:0] registers [63:0];


always @(posedge clock or posedge load_code) begin
	if(load_code) begin
		registers[0] <= 32'h 02108022;
		registers[1] <= 32'h 22140012;
		registers[2] <= 32'h 22110000;
		registers[3] <= 32'h 22120001;
		registers[4] <= 32'h 02329820;
		registers[5] <= 32'h 22510000;
		registers[6] <= 32'h 22720000;
		registers[7] <= 32'h 26940001;
		registers[8] <= 32'h ae1300fc;
		registers[9] <= 32'h 1690fffa;
		registers[10]<= 32'h 0012a080;
		registers[11]<= 32'h ae1400fc;
		registers[12]<= 32'h 0251a02c;
		registers[13]<= 32'h ae1400fc;

	end
	else if(write_enable)
		registers[write_addr[7:2]] <= write_data;

		
	// we use the last word as Output
	output_last_word <= registers[63];
	


end

always @(*) begin
	if(read_enable_1)
		read_data_1 <= registers[read_addr_1[7:2]];
	if(read_enable_2)
		read_data_2 <= registers[read_addr_2[7:2]];
end




endmodule
