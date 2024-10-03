module tb;
  reg [15:0] din;
  reg [1:0] dsel;
  wire [1:7] seg;
  wire [7:0] dout;
  
  integer i,j,k;
  
  DPU dut(din,dsel,seg,dout);
  
  initial begin
    i=0;
    j=0;
    k=0;
    din=0;
    dsel=0;
    
    $monitor("t=%d, ALUop=%d, Ain=%d, Bin=%d, dsel=%d, seg=%b, dout=%d",$time,din[10:8],din[3:0],din[7:4],dsel,seg,dout);
    
    $dumpvars(1);
    for (i=0;i<=3;i=i+1)
      begin
        dsel=i;
        #50;
        
        for (j=0;j<=7;j=j+1)
          begin
            din[10:8]=j;  //ALUop
            #50;
            
            for (k=0; k<=15; k=k+3)
              begin
                din[3:0] = k; // Ain
                din[7:4] = 15-k+j;  // to randomize Bin
                #50;
              end
          end
      end
    
    dsel=0; din=8;#50
    
    // since din[15:11] is not used according to the question, here to test out what would happen if those bits are set.
    din= 2048; dsel=0; #50
    din= 18432; dsel=1; #50
    din= 22528; dsel=2; #50
    din= 55296; dsel=3; #50 $finish;
        
  end
  
endmodule
