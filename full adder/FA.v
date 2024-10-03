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
