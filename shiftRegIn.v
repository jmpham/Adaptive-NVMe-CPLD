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
// * Description : Serial to Parallel input data to Adaptive NVMe Card's CPLD  *
// *****************************************************************************

module shiftRegIn #(
	parameter TOTAL_BIT_COUNT = 8)(

    // Input Clocks and Resets
    input 						 serclk, 
    input 						 reset_n,

    // SERIAL Data In from baseboard
    input                        ser_data_in,

    // Shift Control Bits
    input 						 ser_load_in_n,

    // PARALLEL Output
    output reg [TOTAL_BIT_COUNT-1:0] p_out
   );
 	

 	reg [TOTAL_BIT_COUNT-1:0]   shift_reg;

 	//------------------------------------------------------------------------------
	// Parallel to Serial Converter
    // When in reset: shift register contains all 0s
    // When out of reset:
    //          When load_n is enabled:  Grab serial data in 1 by 1 into shift register
    //          When load_n not enabled: push out all bits in shift register simultaneously
	//------------------------------------------------------------------------------
   
    always@(posedge serclk or negedge reset_n)begin
    	if (!reset_n)begin
            p_out     <= {TOTAL_BIT_COUNT{1'b0}}; 
    		shift_reg <= {TOTAL_BIT_COUNT{1'b0}};
             
    	end
    	else begin
    		if (!ser_load_in_n)begin
    			shift_reg = {ser_data_in,shift_reg[TOTAL_BIT_COUNT-1:1]};
    		end
    		else begin
    			p_out = shift_reg;
    		end
    	end
    end
    

endmodule

