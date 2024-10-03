//FSM + D

///////////////DU//////////////////////////////////////////////////
module DU (ldx,ldy,ldz,p,q,r,clk,rst,xin,yin,x);
  input ldx,ldy,ldz,p,q,r,clk,rst;
  input [3:0] xin,yin;
  output reg [7:0] x;
  reg [7:0] y,z;
  
  
  //x
  always @ (posedge clk, posedge rst)
    begin
      if (rst)
        begin
          x<=0;
        end
      
      else if (ldx)
        begin
          case (p)
            0: x <= xin;
            1: x <= ((x<<1)/3)-y;
          endcase
        end
    end
   
  
  //y
  always @ (posedge clk, posedge rst)
    begin
      if (rst)
        begin
          y<=0;
        end
      
      else if (ldy)
        begin
          case (q)
            0: y<=yin;
            1: y<= (r) ? y/3 : y/z;
          endcase
        end
      
    end
  
  
  //z
  always @ (posedge clk, posedge rst)
    begin
      if (rst)
        begin
          z<=0;
        end
      
      else
        begin
          z<=xin*xin;
        end
      
    end
  
endmodule


///////////////CU//////////////////////////////////////////////////
module CU(clk,rst,start,done,idle,ready,ldx,ldy,ldz,p,q,r);
  input clk,rst,start;
  output reg done,idle,ready;
  reg [1:0] ps,ns;
  output reg ldx,ldy,ldz,p,q,r;
  
  parameter [1:0] s1=0,s2=1,s3=2,s4=3;
  
  //state register
  always @ (posedge clk, posedge rst)
    begin
      if (rst)
        begin 
          ps<=s1;
        end
      else
        begin
          ps<=ns;
        end
      
    end
  
  
  
  //next state logic
  always @ (ps, start)
    begin
      case (ps)
        s1: if (start) begin ns=s2;end else begin ns=s1;end
        s2: ns=s3;
        s3: ns=s4;
        s4: ns=s1;
      endcase
    end
  
  //output logic
  always @(ps, start)
    begin
      done=0;
      idle=0;
      ready=0;
      {ldx,ldy,ldz,p,q,r} = 0;
      case (ps)
        s1: begin if (start) begin ldx=1;	ldy=1;	ldz=1;	p=0;	q=0;	r=0; done=0;	idle=0;	ready=0; end else begin idle=1;end end
        s2: begin 			ldy=1;					q=1;	r=1;							 end
        s3: begin			ldy=1;					q=1;									 end
        s4: begin ldx=1;					p=1;					done=1;			ready=1; end
      endcase
    end
  
endmodule


//////////////cu du///////////////////////
module cudu(clk,rst,start,xin,yin,done,idle,ready,x,X);
  input clk,rst,start;
  input [3:0] xin,yin;
  output done,idle,ready;
  output [7:0] x;
  output reg [7:0] X;
  
  wire ldx,ldy,ldz,p,q,r;
  
  
  
  DU dut1(ldx,ldy,ldz,p,q,r,clk,rst,xin,yin,x);
  CU dut2(clk,rst,start,done,idle,ready,ldx,ldy,ldz,p,q,r);
  
  //the upper case of X to show the final result
  always @(negedge ready)
    begin
      if (!ready) begin X <= x;
      end
    end
        
  
endmodule
