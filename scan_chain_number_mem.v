module scan_chain_number_mem(clk, reset, wren, addr, chain_number, number);
	input wire clk, reset, wren;
	input wire [5 : 0] addr;
	input wire [10:0] chain_number;
	output wire [10:0] number;
	
	reg [10:0] regmem[0:15]; // create reg-file
	
	always @(posedge clk) begin
		if (reset) begin
			regmem[0] <= 0; 
			regmem[1] <= 12; 
			regmem[2] <= 11;
			regmem[3] <= 10;
			regmem[4] <= 9;
			regmem[5] <= 8;
			regmem[6] <= 7;
			regmem[7] <= 6; 
			regmem[8] <= 5; 
			regmem[9] <= 0; 
			regmem[10] <= 0;
			regmem[11] <= 0;
			regmem[12] <= 0; 
			regmem[13] <= 0; 
			regmem[14] <= 0;
			regmem[15] <= 0;
		end
		else begin
			if (wren) begin
				regmem[addr] <= chain_number;
				number <= chain_number;
			end
			else 
				number <= regmem[addr];
		end
	end
endmodule

