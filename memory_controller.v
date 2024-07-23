module memory_controller(data_in, address, CPU_RD, CPU_WR, MEMR, MEMW, CLK, RST, data_out);
  input [15:0] data_in;      // 16-bit input data to be written to memory
  input [3:0] address;       // 4-bit address input for memory access
  input CLK, RST;            // Clock and reset signals
  input MEMR, MEMW;          // Memory read and write enable signals
  output reg CPU_RD, CPU_WR; // CPU read and write status signals
  output reg [15:0] data_out;// 16-bit output data from memory
  
  reg [15:0] mem [15:0];     // 16x16-bit memory array
  
  // Always block to handle CPU read/write status signals
  always @(posedge CLK or posedge RST) begin
    if (RST) begin
      // When reset is high, initialize CPU_RD and CPU_WR to zero
      CPU_RD <= 1'b0; 
      CPU_WR <= 1'b0;
    end
    else begin
      if (MEMW) begin
        // When write is enabled, set CPU_RD to 1 and CPU_WR to 0
        CPU_RD <= 1'b1;
        CPU_WR <= 1'b0;
      end
      else if (MEMR) begin
        // When read is enabled, set CPU_RD to 0 and CPU_WR to 1
        CPU_RD <= 1'b0;
        CPU_WR <= 1'b1;
      end
      else begin
        // Maintain the current state of CPU_RD and CPU_WR
        CPU_RD <= CPU_RD; 
        CPU_WR <= CPU_WR;
      end
    end
  end
  
  // Always block to handle data read/write operations
  always @(posedge CLK or posedge RST) begin
    if (RST) begin
      // When reset is high, initialize data_out to zero
      data_out <= 16'b0;
    end
    else if (MEMR) begin
      // When read is enabled, output the data from the memory at the given address
      data_out <= mem[address];
    end
    else if (MEMW) begin
      // When write is enabled, write the input data to the memory at the given address
      mem[address] <= data_in;
    end
    else begin
      // Maintain the current state of data_out
      data_out <= data_out;
    end
  end			   
endmodule
