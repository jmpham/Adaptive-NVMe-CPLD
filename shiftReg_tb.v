`timescale 1ns / 10ps
module shiftRegTB;
	parameter Total = 8;
	// Inputs
	reg serclk = 0;
	reg reset_n;
	reg par_load_in_n;
	reg [7:0] par_data_in;

	// Outputs
	wire s_out;

	// Instantiate the Unit Under Test (UUT)
	shiftReg  #(8) s1  (
		.serclk(serclk), 
		.reset_n(reset_n), 
		.par_load_in_n(par_load_in_n),
		.par_data_in(par_data_in[7:0]),
		.s_out(s_out)

	);
 

 
always	  	#1 serclk = ~serclk;
	 
 
 
initial begin
 
$dumpfile("test.vcd");
$dumpvars(0,s1);
 
reset_n = 0;
par_load_in_n = 0;
par_data_in = {8{1'b0}};
#5 reset_n = 1;
#5 par_data_in = {8{1'b1}};
#5 par_load_in_n = 0;
#5 par_load_in_n = 1;
#5 par_load_in_n = 0;
#1 par_load_in_n = 1;
#5 reset_n = 0;
#2 $finish;

 end  
 
		initial begin
		 $monitor("serclk=%d par_data_in=%d,s_out=%d, par_load_in_n=%d",serclk, par_data_in, s_out, par_load_in_n);
		 end
 
endmodule