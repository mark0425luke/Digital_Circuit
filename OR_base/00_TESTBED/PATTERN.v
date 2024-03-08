`ifdef RTL
    `define CYCLE_TIME 10
`endif
`ifdef GATE
    `define CYCLE_TIME 0.78125
`endif

module PATTERN
#(
    parameter BIT =19,
    parameter NUMBER_INPUT = 8
)
(
	
	
	clk,
    rst_n,
    IN,
    out
    
    
);


// ===============================================================
// Parameter & Integer Declaration
// ===============================================================
real CYCLE = `CYCLE_TIME;


localparam inMAX = 2**BIT - 1;
localparam selMAX = NUMBER_INPUT-1;


integer i,j;
integer pat_num;
integer wait_cycle;
localparam MAXIMUM_WAIT_CYCLE = 100;

localparam IN_VALID_CYCLE = 1;
parameter PATNUM = 100;


// ===============================================================
// wire & reg Declaration
// ===============================================================
reg [BIT-1:0] in_array [0:NUMBER_INPUT-1];


// ===============================================================
// Input & Output Declaration
// ===============================================================
output reg clk, rst_n;
output reg [NUMBER_INPUT*BIT-1:0] IN;
input [BIT-1:0]   out ;



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
        // repeat(3) @(negedge clk);
    end
    
    $display("  END ");
	$finish;

end endtask


task reset_task; begin

    // force clk
	force clk = 0;
	rst_n = 1;
	IN = 'dx;

    
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

    // repeat(5) @(negedge clk);
    for(i=0;i<IN_VALID_CYCLE;i=i+1)begin


        for(j=0;j<NUMBER_INPUT;j=j+1)begin
            in_array[j] = {$random} % inMAX;
        end

        for(j=0;j<NUMBER_INPUT;j=j+1)begin
            IN[j*BIT +: BIT] = in_array[j];
        end

        


        @(negedge clk);
        
        // @(posedge clk);
        // #(0.05);
    end

    IN = 'dx;



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
