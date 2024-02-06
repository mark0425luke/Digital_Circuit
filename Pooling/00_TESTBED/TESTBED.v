
`timescale 1ns/1ps
`include "PATTERN.v"
`ifdef RTL
`include "Pooling.v"
`elsif GATE
`include "Pooling_SYN.v"
`endif



module TESTBED
#(
    parameter BOTTLENECK = 32,
    parameter SIZE=2, // VGG-16, AlexNet size 2x2 and stride 2x2, ResNet-50 size 3x3 and stride 3x3 
    parameter STRIDE = 2,
    // parameter OFM_BIT = 29, // OFM_BIT for each convolution of VGG-16 is 21,26,26,27,27,28,28,28,29,29,29,29,29
    parameter DELTA_X = 4,
    parameter OU = 4,
    parameter IN_CH=512,
    parameter IFM_BIT = 8 // after output Activation, has been quantized to input feature map bit
    // parameter out_ch = 512
)
(
    
);

// ===============================================================
// Parameter & Integer Declaration
// ===============================================================
localparam NUM_CYCLE = BOTTLENECK/DELTA_X * OU * STRIDE;
localparam NUM_POOLING = (IN_CH / (NUM_CYCLE));


// ===============================================================
// wire & reg Declaration
// ===============================================================
wire clk, rst_n, in_valid;
// wire [IN_CH*SIZE*SIZE*IFM_BIT-1:0] ACTIVATION;
wire [NUM_POOLING*SIZE*SIZE*IFM_BIT-1:0] ACTIVATION;
wire out_valid;
wire [NUM_POOLING*IFM_BIT-1:0] Pooling;
    



// ===============================================================
// Pattern
// ===============================================================
PATTERN 
#(
    .BOTTLENECK(BOTTLENECK),
    .SIZE(SIZE),
    .STRIDE(STRIDE),
    .DELTA_X(DELTA_X),
    .OU(OU),
    .IN_CH(IN_CH),
    .IFM_BIT(IFM_BIT)

) I_PATTERN
(
    // input
	.clk(clk),
	.rst_n(rst_n),
    .in_valid(in_valid),
    .ACTIVATION(ACTIVATION),

    // output
    .out_valid(out_valid),
    .Pooling(Pooling)
    
);

// ===============================================================
// DUT
// ===============================================================
`ifdef RTL
    Pooling 
    #(
        .BOTTLENECK(BOTTLENECK),
        .SIZE(SIZE),
        .STRIDE(STRIDE),
        .DELTA_X(DELTA_X),
        .OU(OU),
        .IN_CH(IN_CH),
        .IFM_BIT(IFM_BIT)

    ) I_Pooling
    (
        // input
        .clk(clk),
        .rst_n(rst_n),
        .in_valid(in_valid),
        .ACTIVATION(ACTIVATION),

        // output
        .out_valid(out_valid),
        .Pooling(Pooling)
        
        
    );

`elsif GATE
    Pooling 
//     #(
//         .IFM_BIT(IFM_BIT),
//         .W_BIT(W_BIT),
//         .K(K),
//         .IN_CH(IN_CH)
// 
//     ) 
    I_Pooling
    (
       // input
        .clk(clk),
        .rst_n(rst_n),
        .in_valid(in_valid),
        .ACTIVATION(ACTIVATION),

        // output
        .out_valid(out_valid),
        .Pooling(Pooling)
        
    );
`endif


// ===============================================================
// dump, sdf
// ===============================================================
initial begin
	`ifdef RTL
		$fsdbDumpfile("Pooling.fsdb");
		$fsdbDumpvars(0,"+mda");
	`elsif GATE
		$fsdbDumpfile("Pooling_SYN.fsdb");
		$sdf_annotate("Pooling_SYN.sdf",I_Pooling);
		$fsdbDumpvars(0,"+mda");
	`endif
end

endmodule
