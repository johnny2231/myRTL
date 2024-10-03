// Code your design here
module M1 (rst,clk,sel,in1,in2,out,a);
  input rst, clk;
  input [1:0]sel;
  input [2:0]in1,in2;
  output reg [0:6]out;
  
  output reg [3:0]a;
  
  //combinational part
  always @(in1,in2)
    begin
      case (sel)
        0:a={1'b0,in2};
        1:a= in1+in2;
        2:a={1'b0,in1};
        default: a=4'bxxxx;
      endcase
    end
  
  //sequential part
  always @(posedge rst, posedge clk)
    begin
      if(rst==1)
        begin
          out <=0;
        end
      
      else
        begin
          out<=out+{3'b000,a};
        end
    end
endmodule
