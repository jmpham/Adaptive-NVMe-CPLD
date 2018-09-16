`timescale 1ns / 10ps
module shiftRegInTB;
	parameter Total = 8;
	// Inputs
	reg serclk = 0;
	reg reset_n;
	reg ser_load_in_n;
	reg sdi;

	// Outputs
	wire [7:0] p_out;

	// Instantiate the Unit Under Test (UUT)
	shiftRegIn  #(8) s1  (
		.serclk(serclk), 
		.reset_n(reset_n), 
		.ser_load_in_n(ser_load_in_n),
		.ser_data_in(sdi),
		.p_out(p_out[7:0])

	);
 

 
always	  	#1 serclk = ~serclk;
	 
  
 
initial begin
 
$dumpfile("pvt_gpi.vcd");
$dumpvars(0,s1);
 
reset_n = 0;
ser_load_in_n = 0;
sdi = {8{1'b0}};
#5 reset_n = 1;
#5 sdi = 1;
#5 ser_load_in_n = 0;
#5 ser_load_in_n = 1;
#5 ser_load_in_n = 0;
#5 reset_n = 0;
#2 $finish;

 end  
 
		initial begin
		 $monitor("serclk=%d sdi=%d,p_out=%d, ser_load_in_n=%d",serclk, sdi, p_out, ser_load_in_n);
		 end
 
endmodule