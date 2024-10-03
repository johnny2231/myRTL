///////////////////////////////////////////////////////
/// reg ///////////////////////////////////////////////
///////////////////////////////////////////////////////
module regn (clk,rst,en,d,q);
  
  parameter n=8;
  input clk,rst,en;
  input [n-1:0] d;
  output reg[n-1:0] q;
  
  
  always @(posedge rst, posedge clk)
    begin
      if (rst ==1)
        begin
          q<=0;
        end
      
      else if (en==1)
        begin
          q<=d;
        end
      
      else
        begin
          q<=q;
        end
    end
  
endmodule
///////////////////////////////////////////////////////
///////////////////////////////////////////////////////

///////////////////////////////////////////////////////
/// shiftleftreg8 /////////////////////////////////////
///////////////////////////////////////////////////////
module sl (d,clk,rst,en,ldsh,so,q);
  parameter n=8;
  input [n-1:0]d;
  input clk,rst,en,ldsh;
  output so;
  output reg [n-1:0]q;
  
  always @(posedge rst, posedge clk)
    begin
      if (rst==1)
        begin
          q<=0;
        end
      
      else if (en)
        begin
          if (ldsh)
            begin
              q<=d;
            end
          else
            begin
              q<={q[n-2:0],1'b0};
            end
        end
      
      else
        begin
          q<=q;
        end
    end
  
  assign so = q[n-1];
endmodule
///////////////////////////////////////////////////////
///////////////////////////////////////////////////////

///////////////////////////////////////////////////////
/// shiftrightreg4 ////////////////////////////////////
///////////////////////////////////////////////////////
module sr (d,clk,rst,en,ldsh,so,q);
  parameter n=4;
  input [n-1:0]d;
  input clk,rst,en,ldsh;
  output so;
  output reg [n-1:0]q;
  
  always @(posedge rst, posedge clk)
    begin
      if (rst==1)
        begin
          q<=0;
        end
      
      else if (en)
        begin
          if (ldsh)
            begin
              q<=d;
            end
          else
            begin
              q<={1'b0,q[n-1:1]};
            end
        end
      
      else
        begin
          q<=q;
        end
    end
  
  assign so = q[0];
endmodule
///////////////////////////////////////////////////////
///////////////////////////////////////////////////////

///////////////////////////////////////////////////////
/// DU ////////////////////////////////////////////////
///////////////////////////////////////////////////////
module du (clk,rst,ctrlA,ctrlB,ldA,ldB,Psel,ldP,dataA,dataB,b0,z,P);
  input clk,rst,ctrlA,ctrlB,ldA,ldB,Psel,ldP;
  input [3:0] dataA, dataB;
  output b0,z;
  output [7:0] P;
  wire [7:0] A,dataP,Ain;
  wire [3:0] B;
  wire P;
  
  
  assign dataP = (Psel) ? A + P : 0;
  regn reg8(clk,rst,ldP,dataP,P);
  
  assign Ain={4'b0000,dataA};
  sl sl8(Ain,clk,rst,ldA,ctrlA,so,A);
  
  sr sr4(dataB,clk,rst,ldB,ctrlB,b0,B);
  assign z= !(|B);
endmodule
