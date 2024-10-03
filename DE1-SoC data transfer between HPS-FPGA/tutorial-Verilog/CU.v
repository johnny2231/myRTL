module CU (
input CLOCK_50,
input [31:0] hps_to_fpga_out_csr_readdata, fpga_to_hps_in_csr_readdata,
output reg fpga_to_hps_in_write, hps_to_fpga_read,
output reg [1:0] CV
);
reg [2:0] X,Y,Z,x,y,z,w,W;
reg Processing_state, data_buffer_valid;
parameter [2:0] s0=0,s1=1,s2=2,s3=3,s4=4;
parameter [2:0] sa=0,sb=1,sc=2;
parameter [2:0] sh=0,si=1,sj=2,sk=3;



initial
begin
	data_buffer_valid = 0;
	Processing_state = 0;
end
//

always @(posedge CLOCK_50)
begin
	y <= Y;
	x <= X;
	w <= W;
	
	CV = 0;
	
	case (y)
	s0:begin
			if((!(hps_to_fpga_out_csr_readdata[1])) && (!data_buffer_valid))
			begin
				Y = s1;
			end
			else
			begin
				Y = s0;
			end
		end
		
	s1:begin
			Y = s2;
			hps_to_fpga_read = 1;
		end
		
	s2:begin
			hps_to_fpga_read = 0;
			if (hps_to_fpga_read == 0)
			begin
				Y = s3;
			end
			else
			begin
				Y = s2;
			end
		end
		
	s3:begin
			Processing_state = 1;
			Y = s4;
		end
		
	s4:begin
			Y = s0;
		end
	endcase
	
	
	case (x)
	sa:begin
			CV = 0;
			if (Processing_state == 1)
			begin
				X = sb;
				Processing_state = 0;
			end
			else
			begin
				X = sa;
			end
		end
		
	sb:begin
			CV =2'b10;
			X = sc;
		end
		
	sc:begin
			CV = 0;
			X = sa;
			data_buffer_valid = 1;
		end
		
	endcase
	
	
	case (w)
	sh:begin
			CV = 0;
			if ((data_buffer_valid == 1) && (!(fpga_to_hps_in_csr_readdata[0])))
			begin
				W = sh;
			end
			else
			begin
				W = si;
			end
		end
		
	si:begin
			W = sj;
			CV = 2'b01;
			fpga_to_hps_in_write = 1;
		end
		  
	sj:begin
			CV = 0;
			if ((fpga_to_hps_in_write == 1))
			begin
				W = sk;
				fpga_to_hps_in_write = 0;
				data_buffer_valid = 0;
			end
			else
			begin
				W = sj;
			end
		end
		
	sk:begin
			CV = 0;
			if ((data_buffer_valid == 0))
			begin
				W = sh;
			end
			else
			begin
				W = sk;
			end
		end
		
	endcase
	
	
	
end
///
endmodule

