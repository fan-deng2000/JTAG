module BSC_chain #(parameter width = 5)(inst_capture_clk, inst_update_clk, inst_capture_en,
                    inst_update_en, inst_shift_dr, inst_mode, inst_si,
                    inst_data_in, data_out_inst, so_inst);
						  
  input inst_capture_clk; //clock for the capture flipflop
  input inst_update_clk;  // clock for the update flipflop
  input inst_capture_en;  // capture flipflop enable
  input inst_update_en;  // update flipflop enable
  input inst_shift_dr;	// shift mux select
  input inst_mode; 		// test mux select
  input [width - 1 : 0]inst_si;			// data input
  input wire inst_data_in;	// instruction date input
  output reg data_out_inst;	// instruction date output
  output [width - 1 : 0] so_inst;			// data output
  
  reg [width : 0] hold; //1 more bit for holding the result
  
	always @(*) begin
		hold[0] = inst_data_in;
		data_out_inst = hold[width];
	end
  
  genvar i;
  generate 
			for (i = 0; i < width; i=i+1) begin: loop
				singleBSC (.capture_clk(inst_capture_clk),   .update_clk(inst_update_clk),
        .capture_en(inst_capture_en),   .update_en(inst_update_en),
        .shift_dr(inst_shift_dr),   .mode(inst_mode),   .si(inst_si[i]),
        .data_in(hold[i]),   .data_out(hold[i+1]),   .so(so_inst[i]) );
		end
	endgenerate 
  
  
endmodule
