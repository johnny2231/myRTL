module divby50(clk, rst, q);
  input clk, rst;
  output reg q;
  reg[4:0] cnt;

  always @(posedge clk, negedge rst)
    begin
      if(!rst)begin
        q <= 0;
        cnt <= 0;
      end
      else if (cnt <24)begin
        cnt <= cnt + 1;
      end
      else begin
        cnt <=0; q <= !q;
      end
    end
endmodule

module divby10(clk, rst, q);
  input clk, rst;
  output reg q;
  reg[4:0] cnt;

  always @(negedge clk, negedge rst)
    begin
      if(!rst)begin
        q <= 0;
        cnt <= 0;
      end
      else if (cnt < 9)begin
        cnt <= cnt + 1;
      end
      else begin
        cnt <=0; q <= !q;
      end
    end
endmodule

module divby5(clk, rst, q);
  input clk, rst;
  output reg q;
  reg[4:0] cnt;

  always @(negedge clk, negedge rst)
    begin
      if(!rst)begin
        q <= 0;
        cnt <= 0;
      end
      else if (cnt <4)begin
        cnt <= cnt + 1;
      end
      else begin
        cnt <=0; q <= !q;
      end
    end
endmodule


module clock_div(clk, rst,clk1M, clk100k, clk100kreal);
  input clk, rst;
  output clk1M, clk100k, clk100kreal;
  wire clk1Mwire;
  
  assign clk1M = clk1Mwire;
  
  divby50 d50(clk, rst, clk1Mwire);
  divby10 d10(clk1Mwire, rst, clk100k);
  divby5 d5(clk1Mwire, rst, clk100kreal);
  
endmodule
