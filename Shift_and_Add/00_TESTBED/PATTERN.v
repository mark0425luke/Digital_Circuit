`ifdef RTL
    `define CYCLE_TIME 10
`endif
`ifdef GATE
    `define CYCLE_TIME 26.5625
`endif

module PATTERN
#(
    parameter BIT_CELL = 1,
    parameter BIT_DAC = 1,
    parameter BIT_W=8,
    parameter OUY=8,
    parameter BIT_IFM = 8,
    // parameter MAX_NUM_FILTER = 64
    parameter MAX_NUM_FILTER = 32
    // parameter out_ch = 512
)
(
	
	
	clk,
	rst_n,
    in_valid,
    ADC_RESULT,
    WEIGHT_BIT_POSITION, // for weight shift
    ONES_COUNTER, // for weight subtract
    INPUT_BIT_POSITION, // for input shift

    
    out_valid,
    Shift_and_Add
    
    
);


// ===============================================================
// Parameter & Integer Declaration
// ===============================================================
real CYCLE = `CYCLE_TIME;

localparam BIT_ONES_COUNTER = $clog2(OUY);
localparam BIT_INPUT_BIT_POSITION = $clog2(BIT_IFM);
localparam ADC_PRECISION = (BIT_CELL!=1 && BIT_DAC!=1) 
                            ? (BIT_CELL + BIT_DAC + $clog2(OUY))
                            : (BIT_CELL + BIT_DAC + $clog2(OUY)-1);
localparam BIT_INPUT_SHIFT = ADC_PRECISION + BIT_W + (BIT_IFM - 1);


integer i,j;
integer pat_num;
integer wait_cycle;
localparam MAXIMUM_WAIT_CYCLE = 100;

localparam IN_VALID_CYCLE = 1;
parameter PATNUM = 1000;



// ===============================================================
// Input & Output Declaration
// ===============================================================
output reg clk, in_valid, rst_n;
output reg [ADC_PRECISION-1:0]ADC_RESULT;
output reg [MAX_NUM_FILTER * BIT_W - 1:0] WEIGHT_BIT_POSITION; // for weight shift
output reg [BIT_ONES_COUNTER - 1:0] ONES_COUNTER; // for weight subtract
output reg [BIT_INPUT_BIT_POSITION - 1:0] INPUT_BIT_POSITION; // for input shift

input out_valid;
input [MAX_NUM_FILTER * BIT_INPUT_SHIFT - 1:0] Shift_and_Add;


// ===============================================================
// Clock
// ===============================================================
initial clk = 0;
always #(CYCLE/2.0) clk = ~clk;

//======================================
//              MAIN
//======================================
initial exe_task;

//======================================
//              TASKS
//======================================
task exe_task; begin

	reset_task;
	for (pat_num=0; pat_num<PATNUM; pat_num=pat_num+1)begin
        $display("send input#%3d", pat_num);
		input_task;
        wait_task;
        repeat(3) @(negedge clk);
    end
    
    $display("  END ");
	$finish;

end endtask


task reset_task; begin

    // force clk
	force clk = 0;
	rst_n = 1;
	in_valid = 0;
    ADC_RESULT = 'dx;
    WEIGHT_BIT_POSITION = 'dx;
    ONES_COUNTER = 'dx;
    INPUT_BIT_POSITION = 'dx;
    
	// rst_n 
	#CYCLE rst_n = 0;
	repeat(5) begin #CYCLE; end
	rst_n = 1;
	
    // release clk
	release clk;
	repeat(5) @(negedge clk);
	

end endtask

task input_task; begin

    repeat(5) @(negedge clk);
    for(i=0;i<IN_VALID_CYCLE;i=i+1)begin
        in_valid=1;
        ADC_RESULT = $random();
        WEIGHT_BIT_POSITION = $random();
        ONES_COUNTER = $random();
        INPUT_BIT_POSITION = $random();
        @(negedge clk);
    end

    in_valid=0;
    ADC_RESULT = 'dx;
    WEIGHT_BIT_POSITION = 'dx;
    ONES_COUNTER = 'dx;
    INPUT_BIT_POSITION = 'dx;


end endtask


task wait_task;begin
    wait_cycle = -1;
    while(out_valid!==1)begin
        
        if(wait_cycle==MAXIMUM_WAIT_CYCLE)begin
            $display("  WAIT TOO LONG");
            $finish;
        end
        wait_cycle = wait_cycle+1;
        @(negedge clk);
    end
end endtask


endmodule
