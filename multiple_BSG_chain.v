module multiple_BSG_chain #(number = 4, chain_number0 = 6, chain_number1 = 5, chain_number2 = 0, chain_number3 = 0) 
										(clk, reset, mux_select, inst_capture_clk, inst_update_clk, inst_capture_en,
										inst_update_en, inst_shift_dr, inst_mode, inst_data_in, data_out_inst, inst_si0, so_inst0,
										inst_si1, so_inst1, inst_si2, so_inst2, inst_si3, so_inst3);
				
		input clk, reset;
		input [1 : 0] mux_select;	// input for mux select
		
		input inst_capture_clk; //clock for the capture flipflop
		input inst_update_clk;  // clock for the update flipflop
		input inst_capture_en;  // capture flipflop enable
		input inst_update_en;  // update flipflop enable
		input inst_shift_dr;	// shift mux select
		input inst_mode; 		// test mux select
		
		input wire inst_data_in;	// instruction date input
		output reg data_out_inst;	// instruction date output
		
		input [chain_number0 - 1 : 0]inst_si0;	// data input chain1 
		output reg [chain_number0 - 1 : 0] so_inst0;		// data output chain1
		input [chain_number1 - 1 : 0]inst_si1;	// data input chain1 
		output reg [chain_number1 - 1 : 0] so_inst1;		// data output chain1
		input [chain_number2- 1 : 0]inst_si2;	// data input chain1 
		output reg [chain_number2 - 1 : 0] so_inst2;		// data output chain1
		input [chain_number3 - 1 : 0]inst_si3;	// data input chain1 
		output reg [chain_number3 - 1 : 0] so_inst3;		// data output chain1
		
		reg [3:0] in;
		reg [3:0] out;
		
		always @(*) begin
			in[mux_select] = inst_data_in;  //mux_select choose which chain to give input
			data_out_inst = out[mux_select]; //mux_select select chain output
		end
		
		BSC_chain #(chain_number0) A (.inst_capture_clk(inst_capture_clk), .inst_update_clk(inst_update_clk), .inst_capture_en(inst_capture_en),
					  .inst_update_en(inst_update_en), .inst_shift_dr(inst_shift_dr), .inst_mode(inst_mode), .inst_si(inst_si0),
					  .inst_data_in(in[0]), .data_out_inst(out[0]), .so_inst(so_inst0));
					  
		BSC_chain #(chain_number1) B (.inst_capture_clk(inst_capture_clk), .inst_update_clk(inst_update_clk), .inst_capture_en(inst_capture_en),
					  .inst_update_en(inst_update_en), .inst_shift_dr(inst_shift_dr), .inst_mode(inst_mode), .inst_si(inst_si1),
					  .inst_data_in(in[1]), .data_out_inst(out[1]), .so_inst(so_inst1));
		BSC_chain #(chain_number2) C (.inst_capture_clk(inst_capture_clk), .inst_update_clk(inst_update_clk), .inst_capture_en(inst_capture_en),
					  .inst_update_en(inst_update_en), .inst_shift_dr(inst_shift_dr), .inst_mode(inst_mode), .inst_si(inst_si2),
					  .inst_data_in(in[2]), .data_out_inst(out[2]), .so_inst(so_inst2));
		BSC_chain #(chain_number3) D (.inst_capture_clk(inst_capture_clk), .inst_update_clk(inst_update_clk), .inst_capture_en(inst_capture_en),
					  .inst_update_en(inst_update_en), .inst_shift_dr(inst_shift_dr), .inst_mode(inst_mode), .inst_si(inst_si3),
					  .inst_data_in(in[3]), .data_out_inst(out[3]), .so_inst(so_inst3));
		
endmodule
