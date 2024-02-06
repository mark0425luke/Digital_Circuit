
`timescale 1ns/1ps
`include "PATTERN.v"
`ifdef RTL
`include "Router.v"
`elsif GATE
`include "Router_SYN.v"
`endif



module TESTBED
#(
    parameter K = 3,
    parameter BOTTLENECK = 1668,
    parameter BIT_OFM = 29, // BIT_OFM for each convolution of VGG-16 is 21,26,26,27,27,28,28,28,29,29,29,29,29
    parameter DELTA_X = 16,
    parameter OU = 8,
    parameter OUT_CH = 64,
    parameter FIFO_DEPTH = 2
)
(
    
);

// ===============================================================
// Parameter & Integer Declaration
// ===============================================================
localparam integer NUM_CYCLE = (BOTTLENECK* OU/DELTA_X);// which is $floor
localparam DATA_AMOUNT = K*OUT_CH;
localparam integer HOW_MANY_PIXEL = ((DATA_AMOUNT+NUM_CYCLE-1)/(NUM_CYCLE)); // which is $ceil(DATA_AMOUNT / NUM_CYCLE);
localparam WIRE_NUM = HOW_MANY_PIXEL * BIT_OFM;


// ===============================================================
// wire & reg Declaration
// ===============================================================
wire clk, rst_n;
wire SEL;
wire [WIRE_NUM-1:0]INPUT_BRANCH_1;
wire [WIRE_NUM-1:0]INPUT_BRANCH_2;
wire [2*WIRE_NUM-1:0]INPUT_TRUNK;
wire INPUT_BRANCH_1_WRITE;
wire INPUT_BRANCH_2_WRITE;
wire INPUT_TRUNK_WRITE;

wire [WIRE_NUM-1:0]output_branch_1;
wire [WIRE_NUM-1:0]output_branch_2;
wire [2*WIRE_NUM-1:0]output_trunk;
wire output_branch_1_valid;
wire output_branch_2_valid;
wire output_trunk_valid;
wire input_branch_1_full;
wire input_branch_2_full;
wire input_trunk_full;
    



// ===============================================================
// Pattern
// ===============================================================
PATTERN 
#(
    .K(K),
    .BOTTLENECK(BOTTLENECK),
    .BIT_OFM(BIT_OFM), // BIT_OFM for each convolution of VGG-16 is 21,26,26,27,27,28,28,28,29,29,29,29,29
    .DELTA_X(DELTA_X),
    .OU(OU),
    .OUT_CH(OUT_CH),
    .FIFO_DEPTH(FIFO_DEPTH)

) I_PATTERN
(
    .clk(clk), 
    .rst_n(rst_n),
    .SEL(SEL),
    .INPUT_BRANCH_1(INPUT_BRANCH_1),
    .INPUT_BRANCH_2(INPUT_BRANCH_2),
    .INPUT_TRUNK(INPUT_TRUNK),
    .INPUT_BRANCH_1_WRITE(INPUT_BRANCH_1_WRITE),
    .INPUT_BRANCH_2_WRITE(INPUT_BRANCH_2_WRITE),
    .INPUT_TRUNK_WRITE(INPUT_TRUNK_WRITE),

    .output_branch_1(output_branch_1),
    .output_branch_2(output_branch_2),
    .output_trunk(output_trunk),
    .output_branch_1_valid(output_branch_1_valid),
    .output_branch_2_valid(output_branch_2_valid),
    .output_trunk_valid(output_trunk_valid),
    .input_branch_1_full(input_branch_1_full),
    .input_branch_2_full(input_branch_2_full),
    .input_trunk_full(input_trunk_full)
    
);

// ===============================================================
// DUT
// ===============================================================
`ifdef RTL
    Router 
    #(
        .K(K),
        .BOTTLENECK(BOTTLENECK),
        .BIT_OFM(BIT_OFM), // BIT_OFM for each convolution of VGG-16 is 21,26,26,27,27,28,28,28,29,29,29,29,29
        .DELTA_X(DELTA_X),
        .OU(OU),
        .OUT_CH(OUT_CH),
        .FIFO_DEPTH(FIFO_DEPTH)

    ) I_Router
    (
        .clk(clk), 
        .rst_n(rst_n),
        .SEL(SEL),
        .INPUT_BRANCH_1(INPUT_BRANCH_1),
        .INPUT_BRANCH_2(INPUT_BRANCH_2),
        .INPUT_TRUNK(INPUT_TRUNK),
        .INPUT_BRANCH_1_WRITE(INPUT_BRANCH_1_WRITE),
        .INPUT_BRANCH_2_WRITE(INPUT_BRANCH_2_WRITE),
        .INPUT_TRUNK_WRITE(INPUT_TRUNK_WRITE),

        .output_branch_1(output_branch_1),
        .output_branch_2(output_branch_2),
        .output_trunk(output_trunk),
        .output_branch_1_valid(output_branch_1_valid),
        .output_branch_2_valid(output_branch_2_valid),
        .output_trunk_valid(output_trunk_valid),
        .input_branch_1_full(input_branch_1_full),
        .input_branch_2_full(input_branch_2_full),
        .input_trunk_full(input_trunk_full)
        
        
    );

`elsif GATE
    Router 
//     #(
//         .IFM_BIT(IFM_BIT),
//         .W_BIT(W_BIT),
//         .K(K),
//         .IN_CH(IN_CH)
// 
//     ) 
    I_Router
    (
       .clk(clk), 
        .rst_n(rst_n),
        .SEL(SEL),
        .INPUT_BRANCH_1(INPUT_BRANCH_1),
        .INPUT_BRANCH_2(INPUT_BRANCH_2),
        .INPUT_TRUNK(INPUT_TRUNK),
        .INPUT_BRANCH_1_WRITE(INPUT_BRANCH_1_WRITE),
        .INPUT_BRANCH_2_WRITE(INPUT_BRANCH_2_WRITE),
        .INPUT_TRUNK_WRITE(INPUT_TRUNK_WRITE),

        .output_branch_1(output_branch_1),
        .output_branch_2(output_branch_2),
        .output_trunk(output_trunk),
        .output_branch_1_valid(output_branch_1_valid),
        .output_branch_2_valid(output_branch_2_valid),
        .output_trunk_valid(output_trunk_valid),
        .input_branch_1_full(input_branch_1_full),
        .input_branch_2_full(input_branch_2_full),
        .input_trunk_full(input_trunk_full)
        
    );
`endif


// ===============================================================
// dump, sdf
// ===============================================================
initial begin
	`ifdef RTL
		$fsdbDumpfile("Router.fsdb");
		$fsdbDumpvars(0,"+mda");
	`elsif GATE
		$fsdbDumpfile("Router_SYN.fsdb");
		$sdf_annotate("Router_SYN.sdf",I_Router);
		$fsdbDumpvars(0,"+mda");
	`endif
end

endmodule
