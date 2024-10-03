module HA (a,b,s,c);
  input a,b;
  output s,c;
  
  assign s = a ^ b;
  assign c = a & b;
  
endmodule



module FA (cin,a,b,s,cout);
  input cin,a,b;
  output s,cout;
  wire s1,s2,s3;
  
  HA u1(a,b,s1,s2);
  HA u2(s1,cin,s,s3);
  
  assign cout = s2 | s3;
  
endmodule


module RCA44 (cin, x, y, s, cout);
  input cin;
  input [3:0] x,y;
  output [3:0] s;
  output cout;
  wire c1, c2, c3;
  
  FA u0(cin, x[0], y[0], s[0], c1);
  FA u1(c1, x[1], y[1], s[1], c2);
  FA u2(c2, x[2], y[2], s[2], c3);
  FA u3(c3, x[3], y[3], s[3], cout);
  
endmodule

