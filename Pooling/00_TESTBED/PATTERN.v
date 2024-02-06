`ifdef RTL
    `define CYCLE_TIME 10
`endif
`ifdef GATE
    `define CYCLE_TIME 26.5625
`endif

module PATTERN
#(
    parameter BOTTLENECK = 32,
    parameter SIZE=2, // VGG-16, AlexNet size 2x2 and stride 2x2, ResNet-50 size 3x3 and stride 3x3 
    parameter STRIDE = 2,
    // parameter OFM_BIT = 29, // OFM_BIT for each convolution of VGG-16 is 21,26,26,27,27,28,28,28,29,29,29,29,29
    parameter DELTA_X = 4,
    parameter OU = 4,
    parameter IN_CH=512,
    parameter IFM_BIT = 8 // after output Activation, has been quantized to input feature map bit
    // parameter out_ch = 512
)
(
	
	
	clk,
	rst_n,
    in_valid,
    ACTIVATION,

    
    out_valid,
    Pooling
    
    
);


// ===============================================================
// Parameter & Integer Declaration
// ===============================================================
real CYCLE = `CYCLE_TIME;
localparam NUM_CYCLE = BOTTLENECK/DELTA_X * OU * STRIDE;
localparam NUM_POOLING = (IN_CH / (NUM_CYCLE));


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
// output reg [IN_CH*SIZE*SIZE*IFM_BIT-1:0] ACTIVATION;
output reg [NUM_POOLING*SIZE*SIZE*IFM_BIT-1:0] ACTIVATION;
input out_valid;
input [NUM_POOLING*IFM_BIT-1:0] Pooling;


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
    $display("  NUM_POOLING =   %5d", NUM_POOLING);

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
    ACTIVATION = 'dx;
    
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
        ACTIVATION = $random();
        @(negedge clk);
    end

    in_valid=0;
    ACTIVATION = 'dx;


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
