//////////////////////////////////////////////////////////////////////////////////////////////////
///bcd7segDEC/////////////////////////////////////////////////////////////////////////////////////

module bcd7segDEC(bcd,led);

input[3:0] bcd;
output reg [1:7] led;

always @(bcd)
	begin
		case(bcd)
			0: led = 7'b0000001;
			1: led = 7'b1001111;
			2: led = 7'b0010010;
			3: led = 7'b0000110;
			4: led = 7'b1001100;
			5: led = 7'b0100100;
			6: led = 7'b0100000;
			7: led = 7'b0001111;
			8: led = 7'b0000000;
			9: led = 7'b0000100;
			default: led = 7'bxxxxxxx;
		endcase
	end
endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////
///ALU////////////////////////////////////////////////////////////////////////////////////////////

module ALU(Ain,Bin,ALUop,ALUout);

input [3:0] Ain,Bin;
input [2:0] ALUop;
output reg [3:0] ALUout;

always @(ALUop,Ain,Bin)
	begin
		case(ALUop)
			3'b000: ALUout = Ain;
			3'b001: ALUout = Ain | Bin;
			3'b010: ALUout = Ain ^ Bin;
			3'b011: ALUout = Ain & Bin;
			3'b100: ALUout = Ain - Bin;
			3'b101: ALUout = Ain + Bin;
			default: ALUout = Bin;
		endcase
	end
endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////
///debug_interface////////////////////////////////////////////////////////////////////////////////

module debug_interface(dsel,Ain,Bin,ALUout,ALUop,dout);

input [1:0] dsel;
input [3:0] Ain,Bin,ALUout;
input [2:0] ALUop;

output reg [7:0] dout;


always @(dsel,Ain,Bin,ALUout,ALUop)
	begin
		case(dsel)
			2'b00: dout = {4'b0000,Ain};
			2'b01: dout = {4'b0000,Bin};
			2'b10: dout = {4'b0000,ALUout};
			default: dout = {5'b0000,ALUop};
		endcase
	end

endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////
///DPU////////////////////////////////////////////////////////////////////////////////////////////

module DPU(din,dsel,seg,dout);
  input [15:0] din;
  input [1:0] dsel;
  output [1:7] seg;
  output [7:0] dout;
  wire [1:7] led;
  wire [3:0] Ain,Bin,ALUout;
  wire [2:0] ALUop;
  
  assign seg = led;
  assign Ain = din[3:0];
  assign Bin = din[7:4];
  assign ALUop = din[10:8];
  
  
  ALU u0(Ain,Bin,ALUop,ALUout);
  bcd7segDEC u1(ALUout,led);
  debug_interface u2(dsel,Ain,Bin,ALUout,ALUop,dout);
  
endmodule
