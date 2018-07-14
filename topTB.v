`timescale 1ns / 10ps
module topTB;

    // Input Clocks and Resets
    reg 						AROC_SS_CLK = 0; 
    reg 						PGD_AROC;

    // Parallel Data In
    reg 						ROC_ID_0;
    reg 						ROC_ID_1;
    reg 						ROC_ID_2;
    reg 						ROC_ID_3;

    // Shift Control Bits
    reg 						AROC_SS_LD_N;

    // Serial Output
    wire 						AROS_SS_DATO;

    

    top_level top(
    	// Input Clocks and Resets
	    .AROC_SS_CLK 						(AROC_SS_CLK), 
	    .PGD_AROC 							(PGD_AROC),
	    // Parallel Data In
	    .ROC_ID_0 							(ROC_ID_0),
	    .ROC_ID_1 							(ROC_ID_1),
	    .ROC_ID_2 							(ROC_ID_2),
	    .ROC_ID_3 							(ROC_ID_3),
	    .AROC_SS_LD_N 						(AROC_SS_LD_N),
	    .AROC_SS_DATO 						(AROC_SS_DATO)
    );



    always #1 AROC_SS_CLK = ~AROC_SS_CLK;

    initial begin

    $dumpfile("testTop.vcd");
    $dumpvars(1, top); 		// '0' to dump all variables instantiated from top module. '1' for only variables in top module

    //Standby
    PGD_AROC = 0;
    ROC_ID_0 = 1;
    ROC_ID_1 = 0;
    ROC_ID_2 = 0;
    ROC_ID_3 = 1;
    AROC_SS_LD_N = 0;

    //Main Power
    #5 PGD_AROC = 1;
    PGD_AROC = 1;

    //SHIFT
    #5 AROC_SS_LD_N = 1;
    #100 $finish;
    end


endmodule