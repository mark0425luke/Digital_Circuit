
`timescale 1ns/1ps
`include "PATTERN.v"
`ifdef RTL
`include "OR_base.v"
`elsif GATE
`include "OR_base_SYN.v"
`endif



module TESTBED
#(
    
    parameter BIT = 29,
    parameter NUMBER_INPUT = 16
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
    .IN(IN),
    .out(out)
    
);

// ===============================================================
// DUT
// ===============================================================
`ifdef RTL
    OR_base 
    #(
        .BIT(BIT),
        .NUMBER_INPUT(NUMBER_INPUT)

    ) I_MUX_base
    (
        .clk(clk),
        .rst_n(rst_n),
        .IN(IN),
        .out(out)

        
    );

`elsif GATE
    OR_base 

    I_OR_base
    (
        .clk(clk),
        .rst_n(rst_n),
        .IN(IN),
        .out(out)

        
    );
`endif


// ===============================================================
// dump, sdf
// ===============================================================
initial begin
	`ifdef RTL
		$fsdbDumpfile("OR_base.fsdb");
		$fsdbDumpvars(0,"+mda");
	`elsif GATE
		$fsdbDumpfile("OR_base_SYN.fsdb");
		$sdf_annotate("OR_base_SYN.sdf",I_OR_base);
		$fsdbDumpvars(0,"+mda");
	`endif
end

endmodule
