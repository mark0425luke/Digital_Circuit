`include "Router_FIFO.v"
// 

module Router
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
    // input
	clk,
	rst_n,
    INPUT_BRANCH_1_WRITE,
    INPUT_BRANCH_2_WRITE,
    INPUT_TRUNK_WRITE,
    SEL, // to select whether add or concatenate
    INPUT_BRANCH_1,
    INPUT_BRANCH_2,
    INPUT_TRUNK,

    // output
    // out_valid,
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
integer i,j;
localparam integer NUM_CYCLE = (BOTTLENECK* OU/DELTA_X);// which is $floor
localparam DATA_AMOUNT = K*OUT_CH;
localparam integer HOW_MANY_PIXEL = ((DATA_AMOUNT+NUM_CYCLE-1)/(NUM_CYCLE)); // which is $ceil(DATA_AMOUNT / NUM_CYCLE);
localparam WIRE_NUM = HOW_MANY_PIXEL * BIT_OFM;
// localparam integer WIRE_NUM = ((BIT_OFM*DATA_AMOUNT+NUM_CYCLE-1)/(NUM_CYCLE)); // which is $ceil(DATA_AMOUNT / NUM_CYCLE);





// ===============================================================
// reg & wire
// ===============================================================

reg sel;

wire [WIRE_NUM-1:0] input_branch_1 ;
wire [WIRE_NUM-1:0] input_branch_2 ;
wire [2*WIRE_NUM-1:0] input_trunk ;
reg [BIT_OFM-1:0] ib1 [0:HOW_MANY_PIXEL-1];
reg [BIT_OFM-1:0] ib2 [0:HOW_MANY_PIXEL-1];
reg [BIT_OFM-1:0] it  [0:2*HOW_MANY_PIXEL-1];

reg [BIT_OFM-1:0] add [0:HOW_MANY_PIXEL-1];// although ib1, ib2 are [BIT_OFM-1:0], [BIT_OFM-1:0] is enough  for add
reg [2*HOW_MANY_PIXEL*BIT_OFM-1:0] concatenate;


// empty signal from Router_FIFO output
wire input_branch_1_empty;
wire input_branch_2_empty;
wire input_trunk_empty;
// read signal for Router_FIFO, if not empty then read
wire input_branch_1_read = ~input_branch_1_empty;
wire input_branch_2_read = ~input_branch_2_empty;
wire input_trunk_read    = ~input_trunk_empty;



reg input_branch_1_read_1t;
reg input_branch_2_read_1t;
reg input_branch_1_read_2t;
reg input_branch_2_read_2t;


// ===============================================================
// Input & Output Declaration
// ===============================================================
input clk, rst_n;
input SEL;
input [WIRE_NUM-1:0]INPUT_BRANCH_1;
input [WIRE_NUM-1:0]INPUT_BRANCH_2;
input [2*WIRE_NUM-1:0]INPUT_TRUNK;
input INPUT_BRANCH_1_WRITE;
input INPUT_BRANCH_2_WRITE;
input INPUT_TRUNK_WRITE;

output reg [WIRE_NUM-1:0]output_branch_1;
output reg [WIRE_NUM-1:0]output_branch_2;
output reg [2*WIRE_NUM-1:0]output_trunk;
output reg output_branch_1_valid;
output reg output_branch_2_valid;
output reg output_trunk_valid;
output input_branch_1_full;
output input_branch_2_full;
output input_trunk_full;


//================================================================
// DESIGN
//================================================================



// get dataout from Router_FIFO, no need of using DFF to store
always@(*) begin
    for(i=0;i<HOW_MANY_PIXEL;i=i+1)begin
        ib1[i] = input_branch_1[i*BIT_OFM +: BIT_OFM];
    end
end
always@(*) begin
    for(i=0;i<HOW_MANY_PIXEL;i=i+1)begin
        ib2[i] = input_branch_2[i*BIT_OFM +: BIT_OFM];
    end
end
always@(*) begin
    for(i=0;i<2*HOW_MANY_PIXEL;i=i+1)begin
        it[i] = input_trunk[i*BIT_OFM +: BIT_OFM];
    end
end

// add, concatenate, branch
always@(posedge clk or negedge rst_n) begin
    if(!rst_n) begin

        for(i=0;i<HOW_MANY_PIXEL;i=i+1)begin
            add[i]<= 0;
        end

        concatenate <= 0;
        output_branch_1 <= 0;
        output_branch_2 <= 0;
        
    end
    else begin
        // add from input branch 1&2
        for(i=0;i<HOW_MANY_PIXEL;i=i+1)begin
            add[i]<= ib1[i]+ib2[i];
        end

        // concatenate from input branch 1&2
        for(i=0;i<HOW_MANY_PIXEL;i=i+1)begin
            concatenate[i*BIT_OFM +: BIT_OFM]<= ib1[i];
        end
        for(i=HOW_MANY_PIXEL;i<2*HOW_MANY_PIXEL;i=i+1)begin
            concatenate[i*BIT_OFM +: BIT_OFM]<= ib2[i];
        end

        // branch to output branch1&2 from input trunk
        for(i=0;i<HOW_MANY_PIXEL;i=i+1)begin
            output_branch_1[i*BIT_OFM +: BIT_OFM] <= it[i];
        end
        for(i=0;i<HOW_MANY_PIXEL;i=i+1)begin
            output_branch_2[i*BIT_OFM +: BIT_OFM] <= it[i+HOW_MANY_PIXEL];
        end
        
    end
end

// always@(*) begin
//     
// 
//     // branch to output branch1&2 from input trunk
//     for(i=0;i<HOW_MANY_PIXEL;i=i+1)begin
//         output_branch_1[i*BIT_OFM +: BIT_OFM] = it[i];
//     end
//     for(i=0;i<HOW_MANY_PIXEL;i=i+1)begin
//         output_branch_2[i*BIT_OFM +: BIT_OFM] = it[i+HOW_MANY_PIXEL];
//     end
//         
//     
// end




// output_trunk
// SEL, 0 for add, 1 for concatenate
reg [HOW_MANY_PIXEL*BIT_OFM-1:0] flatten_add;
always @(*) begin
    for(i=0;i<HOW_MANY_PIXEL;i=i+1)begin
        flatten_add[i*BIT_OFM +: BIT_OFM] = add[i];
    end
end
wire [2*HOW_MANY_PIXEL*BIT_OFM-1:0] output_trunk_next = 
        (sel)   ? {{flatten_add},{(WIRE_NUM){1'b0}}}
                : concatenate;
always@(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        sel <= 0;
    end
    else begin
        sel <= SEL;
    end
end
always@(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        output_trunk <= 0;
    end
    else begin
        output_trunk <= output_trunk_next;
    end
end



// out_valid
// always @(*) begin
//     output_branch_1_valid = input_trunk_read;
//     output_branch_2_valid = input_trunk_read;
// end
always@(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        output_branch_1_valid <= 0;
        output_branch_2_valid <= 0;

        
        input_branch_1_read_1t <= 0;
        // input_branch_1_read_2t <= 0;
        input_branch_2_read_1t <= 0;
        // input_branch_2_read_2t <= 0;
        output_trunk_valid <= 0;
    end
    else begin
        output_branch_1_valid <= input_trunk_read;
        output_branch_2_valid <= input_trunk_read;

        input_branch_1_read_1t <= input_branch_1_read;
        // input_branch_1_read_2t <= input_branch_1_read_1t;
        input_branch_2_read_1t <= input_branch_2_read;
        // input_branch_2_read_2t <= input_branch_2_read_1t;
        output_trunk_valid <= (input_branch_1_read_1t || input_branch_2_read_1t); // either input branch needs to output
    end
end






//  Router_FIFO of branch1, branch2, trunk 
Router_FIFO #( 
    .WIRE_NUM(WIRE_NUM),
    .FIFO_DEPTH(FIFO_DEPTH)

) IB1
(
    // input
	.clk(clk),
	.rst_n(rst_n),
    .DATAIN(INPUT_BRANCH_1),
    .READ(input_branch_1_read),
    .WRITE(INPUT_BRANCH_1_WRITE),

    // output
    .dataout(input_branch_1),
    .full(input_branch_1_full), 
    .empty(input_branch_1_empty)
);

Router_FIFO #( 
    .WIRE_NUM(WIRE_NUM),
    .FIFO_DEPTH(FIFO_DEPTH)

) IB2
(
    // input
	.clk(clk),
	.rst_n(rst_n),
    .DATAIN(INPUT_BRANCH_2),
    .READ(input_branch_2_read),
    .WRITE(INPUT_BRANCH_2_WRITE),

    // output
    .dataout(input_branch_2),
    .full(input_branch_2_full), 
    .empty(input_branch_2_empty)
);

Router_FIFO #( 
    .WIRE_NUM( 2*WIRE_NUM ), // 2 times WIRE_NUM
    .FIFO_DEPTH(FIFO_DEPTH)

) IT
(
    // input
	.clk(clk),
	.rst_n(rst_n),
    .DATAIN(INPUT_TRUNK),
    .READ(input_trunk_read),
    .WRITE(INPUT_TRUNK_WRITE),

    // output
    .dataout(input_trunk),
    .full(input_trunk_full), 
    .empty(input_trunk_empty)
);






endmodule
