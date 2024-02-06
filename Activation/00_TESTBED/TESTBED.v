
`timescale 1ns/1ps
`include "PATTERN.v"
`ifdef RTL
`include "Activation.v"
`elsif GATE
`include "Activation_SYN.v"
`endif



module TESTBED
#(
    parameter OFM_BIT = 29, // OFM_BIT for each convolution of VGG-16 is 21,26,26,27,27,28,28,28,29,29,29,29,29
    // parameter in_ch=512,
    parameter IFM_BIT = 8 // for output Activation
    // parameter out_ch = 512
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
wire [OFM_BIT-1:0] OFM;
wire out_valid;
wire [IFM_BIT-1:0] Activation;
    



// ===============================================================
// Pattern
// ===============================================================
PATTERN 
#(
    .OFM_BIT(OFM_BIT),
    .IFM_BIT(IFM_BIT)


) I_PATTERN
(
    // input
    .clk(clk),
    .rst_n(rst_n),
    .in_valid(in_valid),
    .OFM(OFM),

    // output
    .out_valid(out_valid),
    .Activation(Activation)
    
);

// ===============================================================
// DUT
// ===============================================================
`ifdef RTL
    Activation 
    #(
        .OFM_BIT(OFM_BIT),
        .IFM_BIT(IFM_BIT)

    ) I_Activation
    (
        // input
        .clk(clk),
        .rst_n(rst_n),
        .in_valid(in_valid),
        .OFM(OFM),

        // output
        .out_valid(out_valid),
        .Activation(Activation)
        
    );

`elsif GATE
    Activation 
//     #(
//         .IFM_BIT(IFM_BIT),
//         .W_BIT(W_BIT),
//         .K(K),
//         .IN_CH(IN_CH)
// 
//     ) 
    I_Activation
    (
        // input
        .clk(clk),
        .rst_n(rst_n),
        .in_valid(in_valid),
        .OFM(OFM),

        // output
        .out_valid(out_valid),
        .Activation(Activation)
        
    );
`endif


// ===============================================================
// dump, sdf
// ===============================================================
initial begin
	`ifdef RTL
		$fsdbDumpfile("Activation.fsdb");
		$fsdbDumpvars(0,"+mda");
	`elsif GATE
		$fsdbDumpfile("Activation_SYN.fsdb");
		$sdf_annotate("Activation_SYN.sdf",I_Activation);
		$fsdbDumpvars(0,"+mda");
	`endif
end

endmodule
