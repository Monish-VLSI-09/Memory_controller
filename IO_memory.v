module IO_memory(MEM_IN,CLK,RST,read_en,write_en,MEM_OUT);
  input [15:0] MEM_IN;
  input CLK,RST,read_en,write_en;
  output reg [15:0] MEM_OUT;
  
  reg [15:0] IO_data;
  
  always @(posedge CLK or posedge RST) begin
    if (RST) begin
	   MEM_OUT <= 16'b0;
	  end
	 else if (write_en) begin
	   IO_data <= MEM_IN;
		MEM_OUT <= IO_data;
     end		
	 else if (read_en) begin
	   MEM_OUT <= IO_data;
     end
   end
endmodule
		
	   
	 
		
		
	    
	   
	   
	   
		
    