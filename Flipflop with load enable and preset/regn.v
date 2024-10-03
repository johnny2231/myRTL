// Code your design here
module regn (clk,rst,pst,en,d,q);
  
  parameter n=8;
  input clk,rst,pst,en;
  input [n-1:0] d;
  output reg[n-1:0] q;
  
  
  always @(negedge rst, posedge pst, negedge clk)
    begin
      if (rst ==0)
        begin
          q<=0;
        end
      
      else if (pst ==1)
        begin
          q<={n{1'b1}};
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

