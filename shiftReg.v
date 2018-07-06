module shiftReg #(
	parameter TOTAL_BIT_COUNT = 8)(

    // Input Clocks and Resets
    input 						serclk, 
    input 						reset_n,

    // Parallel Data In
    input [TOTAL_BIT_COUNT-1:0] par_data_in,

    // Shift Control Bits
    input 						par_load_in_n,

    // Serial Output
    output 						s_out
   );
 	
 	// simulation
 	//wire	serclk;
 	//wire	reset_n;
 	//wire	[TOTAL_BIT_COUNT-1:0] par_data_in;
 	//wire	par_load_in_n;
 	//wire	s_out;

 	reg [TOTAL_BIT_COUNT-1:0]   shift_reg;

 	//------------------------------------------------------------------------------
	// Parallel to Serial Converter
	//------------------------------------------------------------------------------
   
    always@(posedge serclk or negedge reset_n)begin
    	if (!reset_n)begin
    		shift_reg = {TOTAL_BIT_COUNT{1'b0}};
    	end
    	else begin
    		if (!par_load_in_n)begin
    			shift_reg = par_data_in;
    		end
    		else begin
    			shift_reg = {1'b0,shift_reg[TOTAL_BIT_COUNT-1:1]};
    		end
    	end
    end
 	
 	assign s_out = shift_reg[0];
 
endmodule

