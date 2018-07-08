// *****************************************************************************
// *                     C O P Y R I G H T   N O T I C E                       *
// *****************************************************************************
// *                                                                           *
// * Hewlett Packard Enterprise Confidential                                   *
// *                                                                           *
// * (c) Copyright 2015, 2017 Hewlett Packard Enterprise Development LP        *
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
// * Module Name : top_level.v                                                 *
// * Description : Top Module for the Adaptive NVMe card                       *
// *****************************************************************************


module top_level (
  
    // Input Clocks and Resets
    input 						AROC_SS_CLK, 
    input 						PGD_AROC,

    // Parallel Data In
    input 						ROC_ID_0,
    input 						ROC_ID_1,
    input 						ROC_ID_2,
    input 						ROC_ID_3,

    // Shift Control Bits
    input 						AROC_SS_LD_N,

    // Serial Output
    output 						AROS_SS_DATO
) 

wire [7:0] sas_cpld_ver_byte1;
wire [7:0] sas_cpld_ver_byte2; 

shiftReg pvt_gpo(
	.serclk 					(AROC_SS_CLK),
	.reset_n 					(PGD_AROC),
	.par_load_in_n				(AROC_SS_LD_N),
	.par_data_in				({// Byte5, From MSbit -> LSbit
                     			nc_aroc_pvt_gpi_b5[7:1],
		                     	aroc_id[3],

		                     	// Byte4, from MSbit -> LSbit
		                     	aroc_id[2],
		                     	aroc_id[1],
		                     	aroc_id[0],
		                     	sas_therm_pwrdown,
		                     	sas_therm,
		                     	sas_pgd_fault_fsm[2:0],

		                     	// Byte3, from MSbit -> LSbit
		                     	8'b0, // Used to be PGD faults for SAS, but adaptive NVMe doesn't have this - Jonathan

		                     	// Byte2, from MSbit -> LSbit
		                     	8'b0,

		                     	// Byte1, from MSbit -> LSbit - bootleg version - NEED TO CREATE GLOBAL DEFINITION FILE FOR THIS
		                     	sas_cpld_ver_byte1[7:0],

		                     	// Byte0, from MSbit -> LSbit - release version - NEED TO CREATE GLOBAL DEFINITION FILE FOR THIS
		                     	sas_cpld_ver_byte2[7:0]})
)


endmodule