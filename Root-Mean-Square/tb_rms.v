module tb();
  
  parameter width = 8;
  reg [(width+1)/2-1:0] a,b,c,d,e;
  wire [(width+1)/2-1:0] RMS;
  
  rms dut(a,b,c,d,e,RMS);
  
  initial begin
    $dumpvars(1);
    #0	a=1;	b=2;	c=3;	d=4;	e=5;
    #20	a=9;	b=2;	c=3;	d=4;	e=5;
    #20	a=9;	b=2;	c=3;	d=4;	e=10;
    #20	$finish;
  end
endmodule
