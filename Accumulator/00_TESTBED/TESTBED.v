
`timescale 1ns/1ps
`include "PATTERN.v"
`ifdef RTL
`include "Accumulator.v"
`elsif GATE
`include "Accumulator_SYN.v"
`endif



module TESTBED
#(
    parameter IFM_BIT = 8,
    parameter W_BIT = 8,
    parameter K=3,
    parameter IN_CH=512
    // parameter out_ch = 512
)
(
    
);

// ===============================================================
// Parameter & Integer Declaration
// ===============================================================
localparam BIT_PE           = IFM_BIT + W_BIT + $clog2(K*IN_CH);
localparam BIT_ACCUMULATOR  = IFM_BIT + W_BIT + $clog2(K*K*IN_CH);


// ===============================================================
// wire & reg Declaration
// ===============================================================
wire clk;
wire rst_n;
wire in_valid;
wire [K*BIT_PE-1 : 0] PE;
wire out_valid;
wire [BIT_ACCUMULATOR-1:0] Accumulator;
    



// ===============================================================
// Pattern
// ===============================================================
PATTERN 
#(
    .IFM_BIT(IFM_BIT),
    .W_BIT(W_BIT),
    .K(K),
    .IN_CH(IN_CH)

) I_PATTERN
(
    // input
    .clk(clk),
    .rst_n(rst_n),
    .in_valid(in_valid),
    .PE(PE),

    // output
    .out_valid(out_valid),
    .Accumulator(Accumulator)
    
);

// ===============================================================
// DUT
// ===============================================================
`ifdef RTL
    Accumulator 
    #(
        .IFM_BIT(IFM_BIT),
        .W_BIT(W_BIT),
        .K(K),
        .IN_CH(IN_CH)

    ) I_Accumulator
    (
        // input
        .clk(clk),
        .rst_n(rst_n),
        .in_valid(in_valid),
        .PE(PE),

        // output
        .out_valid(out_valid),
        .Accumulator(Accumulator)
        
    );

`elsif GATE
    Accumulator 
//     #(
//         .IFM_BIT(IFM_BIT),
//         .W_BIT(W_BIT),
//         .K(K),
//         .IN_CH(IN_CH)
// 
//     ) 
    I_Accumulator
    (
        // input
        .clk(clk),
        .rst_n(rst_n),
        .in_valid(in_valid),
        .PE(PE),

        // output
        .out_valid(out_valid),
        .Accumulator(Accumulator)
        
    );
`endif


// ===============================================================
// dump, sdf
// ===============================================================
initial begin
	`ifdef RTL
		$fsdbDumpfile("Accumulator.fsdb");
		$fsdbDumpvars(0,"+mda");
	`elsif GATE
		$fsdbDumpfile("Accumulator_SYN.fsdb");
		$sdf_annotate("Accumulator_SYN.sdf",I_Accumulator);
		$fsdbDumpvars(0,"+mda");
	`endif
end

endmodule
