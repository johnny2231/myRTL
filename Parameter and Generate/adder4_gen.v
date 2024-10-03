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

module adder4_gen (ci,a,b,sum);
  
  parameter n=4;
  input [n-1:0] a,b;
  input ci;
  output [n:0] sum;
  wire [n:0] c;
  
  assign c[0] = ci, sum[4] = c[n];
  
  genvar i;
  generate
    for (i=0;i<n;i=i+1)
      begin: adder_1bit
        FA fa_gen (c[i],a[i],b[i],sum[i],c[i+1]);
      end
  endgenerate
endmodule


