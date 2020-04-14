module multiple_BSG_chain #(number = 4, total_number = 6, mux_length = 2) (clk, reset, mux_select, 
																									inst_capture_clk, inst_update_clk, inst_capture_en,
																								  inst_update_en, inst_shift_dr, inst_mode, inst_si,
																								  inst_data_in, data_out_inst, so_inst);
				
		input clk, reset;
		input [mux_length - 1 : 0] mux_select;	// input for mux select
		
		input inst_capture_clk; //clock for the capture flipflop
		input inst_update_clk;  // clock for the update flipflop
		input inst_capture_en;  // capture flipflop enable
		input inst_update_en;  // update flipflop enable
		input inst_shift_dr;	// shift mux select
		input inst_mode; 		// test mux select
		
		input [total_number - 1 : 0]inst_si;	// data input
		input wire inst_data_in;	// instruction date input
		output reg data_out_inst;	// instruction date output
		output reg [total_number - 1 : 0] so_inst;		// data output
		
		reg [number - 1 : 0] chain_number [10 : 0];  // store each chain scan cell number
		reg [number - 1 : 0] in; 	// store input to each chain
		reg [number - 1 : 0] out;	// store output to each chain
		
		always @(*) begin
			in[mux_select] = inst_data_in;  //mux_select choose which chain to give input
			data_out_inst = out[mux_select]; //mux_select select chain output
		end
		
		genvar i;
		generate 
			for (i = 0; i < number; i=i+1) begin: mem  // read each chain scan cell number from the memory
				scan_chain_number(.clk(clk), .reset(reset), .wren(1'b0), .addr(i), .chain_number(0), .number(chain_number[i]));
			end
		endgenerate 
		
		genvar j;
		generate 
			for (j = 0; j < number; j=j+1) begin: BSG_chain  // creat multiple chain 
				BSC_chain #(chain_number[j]) (.inst_capture_clk(inst_capture_clk), .inst_update_clk(inst_update_clk), .inst_capture_en(inst_capture_en),
							  .inst_update_en(inst_update_en), .inst_shift_dr(inst_shift_dr), .inst_mode(inst_mode), .inst_si(inst_si[chain_number[j]]),
							  .inst_data_in(in[j]), .data_out_inst(out[j]), .so_inst(so_inst[chain_number[j]]));
			end
		endgenerate 
		
endmodule
