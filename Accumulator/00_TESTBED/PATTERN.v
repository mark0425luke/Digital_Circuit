`ifdef RTL
    `define CYCLE_TIME 10
`endif
`ifdef GATE
    `define CYCLE_TIME 10
`endif

module PATTERN
#(
    parameter IFM_BIT = 8,
    parameter W_BIT = 8,
    parameter K=3,
    parameter IN_CH=512
)
(
	
	clk,
	rst_n,
    in_valid,
    PE,

    
    out_valid,
    Accumulator
    
    
);


// ===============================================================
// Parameter & Integer Declaration
// ===============================================================
real CYCLE = `CYCLE_TIME;
localparam BIT_PE           = IFM_BIT + W_BIT + $clog2(K*IN_CH);
localparam BIT_ACCUMULATOR  = IFM_BIT + W_BIT + $clog2(K*K*IN_CH);


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
output reg [K*BIT_PE-1 : 0] PE;
input out_valid;
input [BIT_ACCUMULATOR-1:0] Accumulator;


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
    PE = 'dx;
    
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
        PE = $random();
        @(negedge clk);
    end

    in_valid=0;
    PE = 'dx;


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
