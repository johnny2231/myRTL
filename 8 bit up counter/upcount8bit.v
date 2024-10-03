module upcount8bit(clk,rst,ld,inc,data,q);
  input clk,rst,ld,inc;
  input [7:0] data;
  output reg [7:0] q;
  
  always @ (posedge clk, negedge rst)
    begin
      
      if (!rst)
        begin
          q<=0;
        end
      
      else if (ld==1)
        begin
          q<=data;
        end
      
      else if (inc==1)
        begin
          q<=q+1;
        end
      
      else
        begin
          q<=q;
        end
    end
  
endmodule
