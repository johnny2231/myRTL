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

