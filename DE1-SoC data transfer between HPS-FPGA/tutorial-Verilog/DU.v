//module DU(
//input CLOCK_50;
//input [1:0] CV;
//
//)
//reg wrdata, rddata;
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