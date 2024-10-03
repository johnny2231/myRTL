`timescale 10ns/1ns
module TBPGEN_V1();
  reg clk, rst, start, stop;
  wire[1:0] PS;
  wire pulse;

		//Instantiate the design-under-test (dut) into testbenchFA
  PGEN_V1 dut(.clk(clk), .rst(rst), .start(start), .stop(stop), .PS(PS), .pulse(pulse));
		
		//report the circuit response (display response)
			initial begin
				
              $monitor($time, "clk=%b, rst=%b, start=%b, stop=%b, PS=%b, pulse=%b", clk, rst, start, stop, PS, pulse);
			end
  
   initial begin
    clk=1'b0; forever #10 clk=~clk;
  end
		
		//provide input test vectored
			initial begin
              $dumpvars(1, TBPGEN_V1);
				#0	rst=0; start=0; stop=0;  //at time 0, all inputs initialized to low
				#10	rst=1; start=1; stop=0;
              	#10	start=0; stop=0;
              	#50	start=0; stop=1;
             	#50 start=0; stop=0;
              	#50	start=1; stop=0;
              	
				//#100 		start=0
              //	#50 		start=0; x=18; y=162;
				#1000 $finish;	//at this time, all active procedural blocks stop, simulation terminates
				end
endmodule
