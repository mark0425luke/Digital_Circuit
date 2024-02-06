`ifdef RTL
    `define CYCLE_TIME 10
`endif
`ifdef GATE
    `define CYCLE_TIME 26.5625
`endif

module PATTERN
#(
    parameter K = 3,
    parameter BOTTLENECK = 1668,
    parameter BIT_OFM = 29, // BIT_OFM for each convolution of VGG-16 is 21,26,26,27,27,28,28,28,29,29,29,29,29
    parameter DELTA_X = 16,
    parameter OU = 8,
    parameter OUT_CH = 64,
    parameter FIFO_DEPTH = 2
)
(
	
	
	
	clk,
	rst_n,
    INPUT_BRANCH_1_WRITE,
    INPUT_BRANCH_2_WRITE,
    INPUT_TRUNK_WRITE,
    SEL, // to select whether add or concatenate
    INPUT_BRANCH_1,
    INPUT_BRANCH_2,
    INPUT_TRUNK,

   
    output_branch_1, // input_trunk -> output_branch_1
    output_branch_2, // input_trunk -> output_branch_2
    output_trunk, // input_branch1, input_branch2 -> output_trunk
    output_branch_1_valid,
    output_branch_2_valid,
    output_trunk_valid,
    input_branch_1_full,
    input_branch_2_full,
    input_trunk_full
    
    
);


// ===============================================================
// Parameter & Integer Declaration
// ===============================================================
real CYCLE = `CYCLE_TIME;

localparam integer NUM_CYCLE = (BOTTLENECK* OU/DELTA_X);// which is $floor
localparam DATA_AMOUNT = K*OUT_CH;
localparam integer HOW_MANY_PIXEL = ((DATA_AMOUNT+NUM_CYCLE-1)/(NUM_CYCLE)); // which is $ceil(DATA_AMOUNT / NUM_CYCLE);
localparam WIRE_NUM = HOW_MANY_PIXEL * BIT_OFM;

integer output_branch_1_valid_flag ;
integer output_branch_2_valid_flag ;
integer output_trunk_valid_flag ;
integer i,j;
integer pat_num;
integer wait_cycle;
localparam MAXIMUM_WAIT_CYCLE = 100;

localparam IN_VALID_CYCLE = 1;
parameter PATNUM = 1000;



// ===============================================================
// Input & Output Declaration
// ===============================================================
output reg clk, rst_n;
output reg SEL;
output reg [WIRE_NUM-1:0]INPUT_BRANCH_1;
output reg [WIRE_NUM-1:0]INPUT_BRANCH_2;
output reg [2*WIRE_NUM-1:0]INPUT_TRUNK;
output reg INPUT_BRANCH_1_WRITE;
output reg INPUT_BRANCH_2_WRITE;
output reg INPUT_TRUNK_WRITE;

input [WIRE_NUM-1:0]output_branch_1;
input [WIRE_NUM-1:0]output_branch_2;
input [2*WIRE_NUM-1:0]output_trunk;
input output_branch_1_valid;
input output_branch_2_valid;
input output_trunk_valid;
input input_branch_1_full;
input input_branch_2_full;
input input_trunk_full;


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


    $display("  NUM_CYCLE   =   %5d", NUM_CYCLE);
    $display("  DATA_AMOUNT =   %5d", DATA_AMOUNT);
    $display("  HOW_MANY_PIXEL =   %5d", HOW_MANY_PIXEL);
    $display("  WIRE_NUM =   %5d", WIRE_NUM);

	reset_task;
	for (pat_num=0; pat_num<PATNUM; pat_num=pat_num+1)begin
        $display("send input#%5d", pat_num);
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
    SEL = 1;
    INPUT_BRANCH_1 = 'dx;
    INPUT_BRANCH_2 = 'dx;
    INPUT_TRUNK = 'dx;
    INPUT_BRANCH_1_WRITE = 'dx;
    INPUT_BRANCH_2_WRITE = 'dx;
    INPUT_TRUNK_WRITE = 'dx;
    
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
        INPUT_BRANCH_1 = $random();
        INPUT_BRANCH_2 = $random();
        INPUT_TRUNK = $random();
        INPUT_BRANCH_1_WRITE = 1;
        INPUT_BRANCH_2_WRITE = 1;
        INPUT_TRUNK_WRITE = 1;
        @(negedge clk);
    end

    INPUT_BRANCH_1 = 'dx;
    INPUT_BRANCH_2 = 'dx;
    INPUT_TRUNK = 'dx;
    INPUT_BRANCH_1_WRITE = 'dx;
    INPUT_BRANCH_2_WRITE = 'dx;
    INPUT_TRUNK_WRITE = 'dx;


end endtask


task wait_task;begin
    wait_cycle = -1;
    output_branch_1_valid_flag = 0;
    output_branch_2_valid_flag = 0;
    output_trunk_valid_flag = 0;


    while(  output_branch_1_valid_flag!==1 
            && output_branch_2_valid_flag!==1
            && output_trunk_valid_flag!==1)begin

        if(output_branch_1_valid!==1) output_branch_1_valid_flag=1;
        if(output_branch_2_valid!==1) output_branch_2_valid_flag=1;
        if(output_trunk_valid!==1) output_trunk_valid_flag=1;
        
        if(wait_cycle==MAXIMUM_WAIT_CYCLE)begin
            $display("  WAIT TOO LONG");
            $finish;
        end
        wait_cycle = wait_cycle+1;
        @(negedge clk);
    end
end endtask


endmodule
