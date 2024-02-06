
`timescale 1ns/1ps
`include "PATTERN.v"
`ifdef RTL
`include "Adder_mask.v"
`elsif GATE
`include "Adder_mask_SYN.v"
`endif



module TESTBED
#(
    
    parameter NUM_MACRO=16,
    parameter OUT_CH=512
)
(
    
);

// ===============================================================
// Parameter & Integer Declaration
// ===============================================================
localparam BIT_OUT_CH = $clog2(OUT_CH);



// ===============================================================
// wire & reg Declaration
// ===============================================================
wire clk, rst_n;
wire [NUM_MACRO * BIT_OUT_CH-1 : 0] WHICH_FILTER;
wire [NUM_MACRO * NUM_MACRO-1 : 0] Adder_mask;


// ===============================================================
// Pattern
// ===============================================================
PATTERN 
#(
    .NUM_MACRO(NUM_MACRO),
    .OUT_CH(OUT_CH)

) I_PATTERN
(
	.clk(clk),
	.rst_n(rst_n),
    .WHICH_FILTER(WHICH_FILTER),
    .Adder_mask(Adder_mask)    
);

// ===============================================================
// DUT
// ===============================================================
`ifdef RTL
    Adder_mask 
    #(
        .NUM_MACRO(NUM_MACRO),
    .OUT_CH(OUT_CH)

    ) I_Adder_mask
    (
        .clk(clk),
        .rst_n(rst_n),
        .WHICH_FILTER(WHICH_FILTER),
        .Adder_mask(Adder_mask)   

        
    );

`elsif GATE
    Adder_mask 

    I_Adder_mask
    (
        .clk(clk),
        .rst_n(rst_n),
        .WHICH_FILTER(WHICH_FILTER),
        .Adder_mask(Adder_mask)   

        
    );
`endif


// ===============================================================
// dump, sdf
// ===============================================================
initial begin
	`ifdef RTL
		$fsdbDumpfile("Adder_mask.fsdb");
		$fsdbDumpvars(0,"+mda");
	`elsif GATE
		$fsdbDumpfile("Adder_mask_SYN.fsdb");
		$sdf_annotate("Adder_mask_SYN.sdf",I_Adder_mask);
		$fsdbDumpvars(0,"+mda");
	`endif
end

endmodule
