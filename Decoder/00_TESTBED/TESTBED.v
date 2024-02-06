
`timescale 1ns/1ps
`include "PATTERN.v"
`ifdef RTL
`include "Decoder.v"
`elsif GATE
`include "Decoder_SYN.v"
`endif



module TESTBED
#(
    
    // parameter K=3,
    parameter NUM_MACRO = 1,
    // parameter IN_CH = 512,
    parameter OUT_CH = 64,
    parameter MAX_NUM_FILTER = 1
    // parameter ADC_PRECISION = 4,
    // parameter BIT_W = 8,
    // parameter BIT_IFM = 8
    // parameter out_ch = 512
)
(
    
);

// ===============================================================
// Parameter & Integer Declaration
// ===============================================================
// localparam BIT_INPUT_SHIFT = ADC_PRECISION + BIT_W + (BIT_IFM - 1);
localparam BIT_OUT_CH = $clog2(OUT_CH);



// ===============================================================
// wire & reg Declaration
// ===============================================================
wire clk, in_valid, rst_n;
wire [NUM_MACRO * MAX_NUM_FILTER * BIT_OUT_CH-1 : 0] WHICH_FILTER;
wire out_valid;
wire [OUT_CH*NUM_MACRO*MAX_NUM_FILTER-1:0]            demux  ;


// ===============================================================
// Pattern
// ===============================================================
PATTERN 
#(
    // .K(K),
    .NUM_MACRO(NUM_MACRO),
    // .IN_CH(IN_CH),
    .OUT_CH(OUT_CH),
    .MAX_NUM_FILTER(MAX_NUM_FILTER)
    // .ADC_PRECISION(ADC_PRECISION),
    // .BIT_W(BIT_W),
    // .BIT_IFM(BIT_IFM)

) I_PATTERN
(
   

	.clk(clk),
	.rst_n(rst_n),
    .in_valid(in_valid),
    .WHICH_FILTER(WHICH_FILTER),
    .demux(demux),
    .out_valid(out_valid)
    
);

// ===============================================================
// DUT
// ===============================================================
`ifdef RTL
    Decoder 
    #(
        // .K(K),
        .NUM_MACRO(NUM_MACRO),
        // .IN_CH(IN_CH),
        .OUT_CH(OUT_CH),
        .MAX_NUM_FILTER(MAX_NUM_FILTER)
        // .ADC_PRECISION(ADC_PRECISION),
        // .BIT_W(BIT_W),
        // .BIT_IFM(BIT_IFM)

    ) I_Decoder
    (
        .clk(clk),
        .rst_n(rst_n),
        .in_valid(in_valid),
        .WHICH_FILTER(WHICH_FILTER),
        .demux(demux),
        .out_valid(out_valid)

        
    );

`elsif GATE
    Decoder 

    I_Decoder
    (
        .clk(clk),
        .rst_n(rst_n),
        .in_valid(in_valid),
        .WHICH_FILTER(WHICH_FILTER),
        .demux(demux),
        .out_valid(out_valid)

        
    );
`endif


// ===============================================================
// dump, sdf
// ===============================================================
initial begin
	`ifdef RTL
		$fsdbDumpfile("Decoder.fsdb");
		$fsdbDumpvars(0,"+mda");
	`elsif GATE
		$fsdbDumpfile("Decoder_SYN.fsdb");
		$sdf_annotate("Decoder_SYN.sdf",I_Decoder);
		$fsdbDumpvars(0,"+mda");
	`endif
end

endmodule
