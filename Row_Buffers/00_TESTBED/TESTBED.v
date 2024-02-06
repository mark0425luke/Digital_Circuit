
`timescale 1ns/1ps
`include "PATTERN.v"
`ifdef RTL
`include "Row_Buffers.v"
`elsif GATE
`include "Row_Buffers_SYN.v"
`endif



module TESTBED
#(
    parameter K = 3,
    parameter STRIDE = 1, // convolution stride
    parameter SRAM_WORD  = 256,
    parameter SRAM_WIDTH = 8
)
(
    
);

// ===============================================================
// Parameter & Integer Declaration
// ===============================================================

// ===============================================================
// wire & reg Declaration
// ===============================================================
wire clk, rst_n, in_valid;
wire [(K)*SRAM_WIDTH-1:0] DATAIN;
wire out_valid;
wire [(STRIDE * K - STRIDE + K) *SRAM_WIDTH-1 : 0] toPEs;
    



// ===============================================================
// Pattern
// ===============================================================
PATTERN 
#(
    .K(K),
    .STRIDE(STRIDE), // convolution stride
    .SRAM_WORD(SRAM_WORD),
    .SRAM_WIDTH(SRAM_WIDTH)


) I_PATTERN
(
    .clk(clk),
	.rst_n(rst_n),
    .in_valid(in_valid),
    .DATAIN(DATAIN), // from Activation or Pooling
    

    
    .out_valid(out_valid),
    .toPEs(toPEs)
    
);

// ===============================================================
// DUT
// ===============================================================
`ifdef RTL
    Row_Buffers 
    #(
        .K(K),
        .STRIDE(STRIDE), // convolution stride
        .SRAM_WORD(SRAM_WORD),
        .SRAM_WIDTH(SRAM_WIDTH)

    ) I_Row_Buffers
    (
        .clk(clk),
        .rst_n(rst_n),
        .in_valid(in_valid),
        .DATAIN(DATAIN), // from Activation or Pooling
        

        
        .out_valid(out_valid),
        .toPEs(toPEs)
        
    );

`elsif GATE
    Row_Buffers 

    I_Row_Buffers
    (
        .clk(clk),
        .rst_n(rst_n),
        .in_valid(in_valid),
        .DATAIN(DATAIN), // from Activation or Pooling
        

        
        .out_valid(out_valid),
        .toPEs(toPEs)
        
    );
`endif


// ===============================================================
// dump, sdf
// ===============================================================
initial begin
	`ifdef RTL
		$fsdbDumpfile("Row_Buffers.fsdb");
		$fsdbDumpvars(0,"+mda");
	`elsif GATE
		$fsdbDumpfile("Row_Buffers_SYN.fsdb");
		$sdf_annotate("Row_Buffers_SYN.sdf",I_Row_Buffers);
		$fsdbDumpvars(0,"+mda");
	`endif
end

endmodule
