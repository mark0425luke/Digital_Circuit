`ifdef RTL
    `define CYCLE_TIME 10
`endif
`ifdef GATE
    `define CYCLE_TIME 0.78125
`endif

module PATTERN
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
	
	
	// input
	clk,
	rst_n,
    in_valid,
    WHICH_FILTER,
    // SHIFT_AND_ADD,

    // // output
    out_valid,
    // PE_OB
    // which_filter, 
    demux
    
    
);


// ===============================================================
// Parameter & Integer Declaration
// ===============================================================
real CYCLE = `CYCLE_TIME;

// localparam BIT_INPUT_SHIFT = ADC_PRECISION + BIT_W + (BIT_IFM - 1);
localparam BIT_OUT_CH = $clog2(OUT_CH);


integer i,j;
integer pat_num;
integer wait_cycle;
localparam MAXIMUM_WAIT_CYCLE = 100;

localparam IN_VALID_CYCLE = 1;
parameter PATNUM = 100;



// ===============================================================
// Input & Output Declaration
// ===============================================================
output reg clk, in_valid, rst_n;
output reg [NUM_MACRO * MAX_NUM_FILTER * BIT_OUT_CH-1 : 0] WHICH_FILTER;

input out_valid;
input [OUT_CH*NUM_MACRO*MAX_NUM_FILTER-1:0]            demux;

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
    WHICH_FILTER = 'dx;
    
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
        WHICH_FILTER = $random();

        @(negedge clk);
    end

    in_valid=0;
    WHICH_FILTER  ='dx;


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
