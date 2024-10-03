module tb;
  reg [3:0] A, B;
  wire [3:0] max, min;
  
  sorter dut( .A(A), .B(B), .max(max), .min(min));
  
  initial begin
    $dumpvars(1);
        A =  1; B = 0;
	#10 A =  3; B = 5;
    #10 A = 10; B = -1;
    #10 A = 12; B = 12;
    #10 $finish;
  end
  
endmodule
