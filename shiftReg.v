// *****************************************************************************
// *                     C O P Y R I G H T   N O T I C E                       *
// *****************************************************************************
// *                                                                           *
// * Confidential                                                              *
// *                                                                           *
// * (c) Copyright 2011-2016 Hewlett Packard Enterprise Development LP         *
// *                                                                           *
// * Copyrights. You may not duplicate, install or use software in violation   *
// * of its copyright or applicable license terms, including the software      *
// * installed on your computer or on network areas under your control. Unless *
// * proper permission has been obtained from the copyright owner, you may not *
// * copy for any reason any copyrighted materials, including text, artwork,   *
// * images, photographs, videos, music, web pages and other forms of          *
// * expression, whether they are in hardcopy or electronic media.             *
// *                                                                           *
// *****************************************************************************
// * HPE Engineer: Jonathan Pham                                               *
// * Design Name : Adaptive NVMe code                                          *
// * Description : Parallel to Serial Data Output to System CPLD               *
// *****************************************************************************

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

