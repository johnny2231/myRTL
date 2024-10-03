//module DU (
//
//)
//reg [2:0] X,Y,Z,x,y,z;
//parameter [2:0] s0=0;s1=1;s2=2;s3=3;s4=4;
//parameter [2:0] sa=0;sb=1;sc=2;
//parameter [2:0] sh=0;si=1;sj=2;sk=3;
//assign {rddata, wrdata} = CV;
/////
//
//always @(posedge CLOCK_50)
//begin
//	if (rddata == 1 )
//	begin
//		memo[0] <= hps_to_fpga_readdata;
//	end
//	else
//	begin
//		memo[0] <= memo[0];
//end
/////
//always @(posedge CLOCK_50)
//begin
//	if (wrdata == 1 )
//	begin
//		fpga_to_hps_in_writedata <= memo[0];
//	end
//	else
//	begin
//		fpga_to_hps_in_writedata <= fpga_to_hps_in_writedata;
//	end
//end
/////
//
//module CU (
//
//)
//initial
//begin:initialization
//	sram_write = 1'b0 ;
//	hex3_hex0[3:0] = 4'd0;		
//	hex3_hex0[7:4] = 4'd0;
//	hex3_hex0[11:8] = 4'd0;
//	hex3_hex0[15:12] = 4'd0;
//	commandCount <= 0 ;
//	data_buffer_valid = 1'b0;
//	HPS_to_FPGA_state = 8'd3 ;
//	FPGA_to_HPS_state = 8'd0 ; 
//	Processing_state = 8'd0 ;
//end
/////
//always @(posedge CLOCK_50)
//begin
//	y <= Y;
//	x <= X;
//	w <= W;
//end
/////
//
//always @(y, hps_to_fpga_read, data_buffer_valid, hps_to_fpga_out_csr_readdata[1])
//begin
//	CV = 0;
//
//	
//	case (y)
//	s0:begin
//			CV = 0;
//			if((!(hps_to_fpga_out_csr_readdata[1])) && (!data_buffer_valid))
//			begin
//				Y = s1;
//			end
//			else
//			begin
//				Y = s0;
//			end
//		end
//		
//	s1:begin
//			CV = 0;
//			Y = s2;
//			hps_to_fpga_read = 1;
//		end
//		
//	s2:begin
//			CV = 0;
//			hps_to_fpga_read = 0;
//			if (hps_to_fpga_read == 0)
//			begin
//				Y = s3;
//			end
//			else
//			begin
//				Y = s2;
//			end
//		end
//		
//	s3:begin
//			CV = 0;
//			rddata = 1;
//			Processing_state = 1;
//			Y = s4;
//		end
//		
//	s4:begin
//			CV = 0;
//			Y = s0;
//		end
//	endcase
//end
/////
//
//always @(x, Processing_state)
//begin
//	CV = 0;
// 
//	
//	case (x)
//	sa:begin
//			CV = 0;
//			if (Processing_state = 1)
//			begin
//				X = sb;
//				Processing_state = 0;
//			end
//			else
//			begin
//				X = sa;
//			end
//		end
//		
//	sb:begin
//			CV =2'b10;
//			X = sc;
//		end
//		
//	sc:begin
//			CV = 0;
//			X = sa;
//			data_buffer_valid = 1;
//		end
//		
//	endcase
//end
/////
//
//always @(w, data_buffer_valid, fpga_to_hps_in_csr_readdata[0])
//begin
//	CV = 0;
//
//	
//
//	case (w)
//	sh:begin
//			CV = 0;
//			if ((data_buffer_valid == 1) && (!(fpga_to_hps_in_csr_readdata[0])))
//			begin
//				W = sh;
//			end
//			else
//			begin
//				W = si;
//			end
//		
//	si:begin
//			W = sj;
//			CV = 2'b01;
//			fpga_to_hps_in_write = 1;
//		end
//		  
//	sj:begin
//			CV = 0;
//			if ((fpga_to_hps_in_write == 1)
//			begin
//				W = sk;
//				fpga_to_hps_in_write = 0;
//				data_buffer_valid = 0;
//		end
//		
//	sk:begin
//			CV = 0;
//			if ((data_buffer_valid == 0)
//			begin
//				W = sh;
//			end
//		end
//		
//	endcase
//end
/////