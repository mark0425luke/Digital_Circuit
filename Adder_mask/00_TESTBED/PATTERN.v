`ifdef RTL
    `define CYCLE_TIME 10
`endif
`ifdef GATE
    `define CYCLE_TIME 26.5625
`endif

module PATTERN
#(
    parameter NUM_MACRO=16,
    parameter OUT_CH=512
)
(
	
	

	clk,
	rst_n,
    WHICH_FILTER,

  
    Adder_mask
    
    
);


// ===============================================================
// Parameter & Integer Declaration
// ===============================================================
real CYCLE = `CYCLE_TIME;

// localparam BIT_INPUT_SHIFT = ADC_PRECISION + BIT_W + (BIT_IFM - 1);
localparam BIT_OUT_CH = $clog2(OUT_CH);

localparam inMAX = 2**BIT_OUT_CH - 1;

integer i,j;
integer pat_num;
integer wait_cycle;
localparam MAXIMUM_WAIT_CYCLE = 100;

localparam IN_VALID_CYCLE = 1;
parameter PATNUM = 100;

// ===============================================================
// wire & reg Declaration
// ===============================================================
reg [BIT_OUT_CH-1:0]        which_filter                    [0:NUM_MACRO-1];

// ===============================================================
// Input & Output Declaration
// ===============================================================
output reg clk, rst_n;
output reg [NUM_MACRO * BIT_OUT_CH-1 : 0] WHICH_FILTER;
output reg [NUM_MACRO * NUM_MACRO-1 : 0] Adder_mask;

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
        
        for(j=0;j<NUM_MACRO;j=j+1)begin
            which_filter[j] = {$random()} % inMAX;
        end
        
        for(j=0;j<NUM_MACRO;j=j+1)begin
            WHICH_FILTER[j*BIT_OUT_CH +: BIT_OUT_CH] = which_filter[j];
        end

        @(negedge clk);
    end


    WHICH_FILTER  ='dx;


end endtask


task wait_task;begin
    // wait_cycle = -1;
    // while(out_valid!==1)begin
    //     
    //     if(wait_cycle==MAXIMUM_WAIT_CYCLE)begin
    //         $display("  WAIT TOO LONG");
    //         $finish;
    //     end
    //     wait_cycle = wait_cycle+1;
    //     @(negedge clk);
    // end
end endtask


endmodule
