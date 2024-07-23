module MC_block(CLK,RST,read_en,write_en,address,CPU_RD,CPU_WR,MEMR,MEMW);
 input CLK,RST,read_en,write_en;
 input [3:0] address;
 input MEMR,MEMW;
 output CPU_RD,CPU_WR;

 wire [15:0] dataout_to_MEMIN, MEMOUT_to_datain;
 
 IO_memory MC1(.MEM_IN(dataout_to_MEMIN),.CLK(CLK),.RST(RST),.read_en(read_en),.write_en(write_en),.MEM_OUT(MEMOUT_to_datain));
 memory_controller MC2(.data_in(MEMOUT_to_datain),.address(address),.CPU_RD(CPU_RD),.CPU_WR(CPU_WR),.MEMR(MEMR),.MEMW(MEMW),.CLK(CLK),.RST(RST),.data_out(dataout_to_MEMIN));
 
endmodule