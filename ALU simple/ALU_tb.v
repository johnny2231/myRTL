module tb;
  
  reg [3:0] Ain,Bin;
  reg [2:0] ALUop;
  wire [3:0] ALUout;
  
  ALU du(Ain,Bin,ALUop,ALUout);
  
  
  initial begin

    $dumpvars(1);
    ALUop= 0; Ain = 8; Bin = 7; #50 //expecting ALUop=0x8
    ALUop= 1; Ain = 8; Bin = 7; #50 //expecting ALUop=0xf
    ALUop= 2; Ain = 8; Bin = 7; #50 //expecting ALUop=0x15
    ALUop= 3; Ain = 8; Bin = 7; #50 //expecting ALUop=0x0
    ALUop= 4; Ain = 8; Bin = 7; #50 //expecting ALUop=0x1
    ALUop= 5; Ain = 8; Bin = 7; #50 //expecting ALUop=0xf
    ALUop= 6; Ain = 8; Bin = 7; #50 //expecting ALUop=0x7
    ALUop= 7; Ain = 8; Bin = 7; #50 $finish; //expecting ALUop=0x7
  end
  
endmodule
