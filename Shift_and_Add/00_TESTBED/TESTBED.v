
`timescale 1ns/1ps
`include "PATTERN.v"
`ifdef RTL
`include "Shift_and_Add.v"
`elsif GATE
`include "Shift_and_Add_SYN.v"
`endif



module TESTBED
#(
    
    parameter BIT_CELL = 1,
    parameter BIT_DAC = 1,
    parameter BIT_W=8,
    parameter OUY=32,
    parameter BIT_IFM = 8,
    // parameter MAX_NUM_FILTER = 64
    parameter MAX_NUM_FILTER = 32
    // parameter out_ch = 512
)
(
    
);

// ===============================================================
// Parameter & Integer Declaration
// ===============================================================
localparam BIT_ONES_COUNTER = $clog2(OUY);
localparam BIT_INPUT_BIT_POSITION = $clog2(BIT_IFM);
localparam ADC_PRECISION = (BIT_CELL!=1 && BIT_DAC!=1) 
                            ? (BIT_CELL + BIT_DAC + $clog2(OUY))
                            : (BIT_CELL + BIT_DAC + $clog2(OUY)-1);
localparam BIT_INPUT_SHIFT = ADC_PRECISION + BIT_W + (BIT_IFM - 1);



// ===============================================================
// wire & reg Declaration
// ===============================================================
wire clk, in_valid, rst_n;
wire [ADC_PRECISION-1:0]ADC_RESULT;
wire [MAX_NUM_FILTER * BIT_W - 1:0] WEIGHT_BIT_POSITION; // for weight shift
wire [BIT_ONES_COUNTER - 1:0] ONES_COUNTER; // for weight subtract
wire [BIT_INPUT_BIT_POSITION - 1:0] INPUT_BIT_POSITION; // for input shift

wire out_valid;
wire [MAX_NUM_FILTER * BIT_INPUT_SHIFT - 1:0] Shift_and_Add;
    



// ===============================================================
// Pattern
// ===============================================================
PATTERN 
#(
    .BIT_CELL(BIT_CELL),
    .BIT_DAC(BIT_DAC),
    .BIT_W(BIT_W),
    .OUY(OUY),
    .BIT_IFM(BIT_IFM),
    .MAX_NUM_FILTER(MAX_NUM_FILTER)

) I_PATTERN
(
   
	.clk(clk),
	.rst_n(rst_n),
    .in_valid(in_valid),
    .ADC_RESULT(ADC_RESULT),
    .WEIGHT_BIT_POSITION(WEIGHT_BIT_POSITION), // for weight shift
    .ONES_COUNTER(ONES_COUNTER), // for weight subtract
    .INPUT_BIT_POSITION(INPUT_BIT_POSITION), // for input shift

  
    .out_valid(out_valid),
    .Shift_and_Add(Shift_and_Add)
    
);

// ===============================================================
// DUT
// ===============================================================
`ifdef RTL
    Shift_and_Add 
    #(
        .BIT_CELL(BIT_CELL),
        .BIT_DAC(BIT_DAC),
        .BIT_W(BIT_W),
        .OUY(OUY),
        .BIT_IFM(BIT_IFM),
        .MAX_NUM_FILTER(MAX_NUM_FILTER)

    ) I_Shift_and_Add
    (
        .clk(clk),
        .rst_n(rst_n),
        .in_valid(in_valid),
        .ADC_RESULT(ADC_RESULT),
        .WEIGHT_BIT_POSITION(WEIGHT_BIT_POSITION), // for weight shift
        .ONES_COUNTER(ONES_COUNTER), // for weight subtract
        .INPUT_BIT_POSITION(INPUT_BIT_POSITION), // for input shift

    
        .out_valid(out_valid),
        .Shift_and_Add(Shift_and_Add)
        
    );

`elsif GATE
    Shift_and_Add 

    I_Shift_and_Add
    (
        .clk(clk),
        .rst_n(rst_n),
        .in_valid(in_valid),
        .ADC_RESULT(ADC_RESULT),
        .WEIGHT_BIT_POSITION(WEIGHT_BIT_POSITION), // for weight shift
        .ONES_COUNTER(ONES_COUNTER), // for weight subtract
        .INPUT_BIT_POSITION(INPUT_BIT_POSITION), // for input shift

    
        .out_valid(out_valid),
        .Shift_and_Add(Shift_and_Add)
        
    );
`endif


// ===============================================================
// dump, sdf
// ===============================================================
initial begin
	`ifdef RTL
		$fsdbDumpfile("Shift_and_Add.fsdb");
		$fsdbDumpvars(0,"+mda");
	`elsif GATE
		$fsdbDumpfile("Shift_and_Add_SYN.fsdb");
		$sdf_annotate("Shift_and_Add_SYN.sdf",I_Shift_and_Add);
		$fsdbDumpvars(0,"+mda");
	`endif
end

endmodule
