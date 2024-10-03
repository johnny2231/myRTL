module HA (a,b,s,c);
  input a,b;
  output s,c;
  
  assign s = a ^ b;
  assign c = a & b;
  
endmodule

//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////

module FA (cin,a,b,s,cout);
  input cin,a,b;
  output s,cout;
  wire s1,s2,s3;
  
  HA u1(a,b,s1,s2);
  HA u2(s1,cin,s,s3);
  
  assign cout = s2 | s3;
  
endmodule

//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////

module RCA44 (cin, x, y, s, cout);
  
  parameter bit_size = 4;
  
  input cin;
  input [bit_size-1:0] x,y;
  output [bit_size-1:0] s;
  output cout;
  wire [bit_size-1:1] c;
  genvar i;

  generate
    for (i=0;i<=bit_size-1;i=i+1)
      begin
        if (i==0)
          begin
            FA u0(cin, x[i], y[i], s[i], c[i+1]);
          end

        else if (i==bit_size-1)
          begin
            FA ulast(c[i], x[i], y[i], s[i], cout);
          end

        else
          begin
            FA uN(c[i], x[i], y[i], s[i], c[i+1]);
          end
      end
  endgenerate

  
endmodule

//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////

module RCA8 (sub,a,b,z);
  
  parameter bit_size = 8;
  input sub;
  input [bit_size-1:0] a,b;
  output [bit_size:0] z;
  
  wire [bit_size-1:0] y,ztemp;
  wire cout;
  

  assign z = {cout,ztemp};
  
  genvar i;
  
  generate
    for (i=0;i<=bit_size-1;i=i+1)
      begin
        assign y[i] = sub ^ b[i];
      end
  endgenerate
  
  RCA44 #(bit_size) Ra(sub, a,y,ztemp, cout);
  
endmodule

          
  
