
`timescale 1ns/1ps
`include "PATTERN.v"
`ifdef RTL
`include "Add_base.v"
`elsif GATE
`include "Add_base_SYN.v"
`endif



module TESTBED
#(
    parameter NUMBER_INPUT = 2,
    parameter BIT_INPUT = 21,
    parameter BIT_OUTPUT = 28
)
(
    
);

// ===============================================================
// Parameter & Integer Declaration
// ===============================================================

// ===============================================================
// wire & reg Declaration
// ===============================================================
wire clk;
wire rst_n;
wire [NUMBER_INPUT * BIT_INPUT-1 : 0]in;
wire [BIT_OUTPUT-1:0] out;





// ===============================================================
// Pattern
// ===============================================================
PATTERN 
#(
    .NUMBER_INPUT(NUMBER_INPUT),
    .BIT_INPUT(BIT_INPUT),
    .BIT_OUTPUT(BIT_OUTPUT)

) I_PATTERN
(

	.clk(clk),
	.rst_n(rst_n),
    .in(in),
    .out(out)
    
);

// ===============================================================
// DUT
// ===============================================================
`ifdef RTL
    Add_base 
    #(
        .NUMBER_INPUT(NUMBER_INPUT),
        .BIT_INPUT(BIT_INPUT),
        .BIT_OUTPUT(BIT_OUTPUT)

    ) I_Add_base
    (
        .clk(clk),
        .rst_n(rst_n),
        .in(in),
        .out(out)
        
    );

`elsif GATE
    Add_base 
    I_Add_base
    (
        .clk(clk),
        .rst_n(rst_n),
        .in(in),
        .out(out)
        
    );
`endif


// ===============================================================
// dump, sdf
// ===============================================================
initial begin
	`ifdef RTL
		$fsdbDumpfile("Add_base.fsdb");
		$fsdbDumpvars(0,"+mda");
	`elsif GATE
		$fsdbDumpfile("Add_base_SYN.fsdb");
		$sdf_annotate("Add_base_SYN.sdf",I_Add_base);
		$fsdbDumpvars(0,"+mda");
	`endif
end

endmodule
