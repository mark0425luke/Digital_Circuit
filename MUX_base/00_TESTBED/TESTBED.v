
`timescale 1ns/1ps
`include "PATTERN.v"
`ifdef RTL
`include "MUX_base.v"
`elsif GATE
`include "MUX_base_SYN.v"
`endif



module TESTBED
#(
    
    parameter BIT = 27,
    parameter NUMBER_INPUT = 512
)
(
    
);

// ===============================================================
// Parameter & Integer Declaration
// ===============================================================



// ===============================================================
// wire & reg Declaration
// ===============================================================
wire clk, rst_n;
wire [$clog2(NUMBER_INPUT)-1 : 0] sel;
wire [NUMBER_INPUT*BIT-1:0] IN;
wire [BIT-1:0]   out ;



// ===============================================================
// Pattern
// ===============================================================
PATTERN 
#(
    .BIT(BIT),
    .NUMBER_INPUT(NUMBER_INPUT)

) I_PATTERN
(
   
	.clk(clk),
    .rst_n(rst_n),
    .sel(sel),
    .IN(IN),
    .out(out)
    
);

// ===============================================================
// DUT
// ===============================================================
`ifdef RTL
    MUX_base 
    #(
        .BIT(BIT),
        .NUMBER_INPUT(NUMBER_INPUT)

    ) I_MUX_base
    (
        .clk(clk),
        .rst_n(rst_n),
        .sel(sel),
        .IN(IN),
        .out(out)

        
    );

`elsif GATE
    MUX_base 

    I_MUX_base
    (
        .clk(clk),
        .rst_n(rst_n),
        .sel(sel),
        .IN(IN),
        .out(out)

        
    );
`endif


// ===============================================================
// dump, sdf
// ===============================================================
initial begin
	`ifdef RTL
		$fsdbDumpfile("MUX_base.fsdb");
		$fsdbDumpvars(0,"+mda");
	`elsif GATE
		$fsdbDumpfile("MUX_base_SYN.fsdb");
		$sdf_annotate("MUX_base_SYN.sdf",I_MUX_base);
		$fsdbDumpvars(0,"+mda");
	`endif
end

endmodule
