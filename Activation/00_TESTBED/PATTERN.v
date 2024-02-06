`ifdef RTL
    `define CYCLE_TIME 10
`endif
`ifdef GATE
    `define CYCLE_TIME 3.125
`endif

module PATTERN
#(
    // parameter K=3,
    parameter OFM_BIT = 29, // OFM_BIT for each convolution of VGG-16 is 21,26,26,27,27,28,28,28,29,29,29,29,29
    // parameter in_ch=512,
    parameter IFM_BIT = 8 // for output Activation
    // parameter out_ch = 512
)
(
	
	// input
	clk,
	rst_n,
    in_valid,
    OFM,

    // output
    out_valid,
    Activation
    
    
);


// ===============================================================
// Parameter & Integer Declaration
// ===============================================================
real CYCLE = `CYCLE_TIME;


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
output reg [OFM_BIT-1:0] OFM;
input out_valid;
input [IFM_BIT:0] Activation;


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
    OFM = 'dx;
    
	// rst_n 
	#CYCLE rst_n = 0;
	repeat(5) begin #CYCLE; end
	rst_n = 1;
	
    // release clk
    repeat(5) begin #CYCLE; end
	release clk;
	repeat(5) @(negedge clk);
	

end endtask

task input_task; begin

    repeat(5) @(negedge clk);
    for(i=0;i<IN_VALID_CYCLE;i=i+1)begin
        in_valid=1;
        OFM = $random();
        @(negedge clk);
    end

    in_valid=0;
    OFM = 'dx;


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
