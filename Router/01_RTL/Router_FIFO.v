

// 

module Router_FIFO
#( 
    // parameter K = 3,
    // parameter BOTTLENECK = 32,
    // parameter OFM_BIT = 29, // OFM_BIT for each convolution of VGG-16 is 21,26,26,27,27,28,28,28,29,29,29,29,29
    // parameter DELTA_X = 4,
    // parameter OU = 4,
    // parameter IN_CH=512,
    // parameter IFM_BIT = 8, // after output Activation, has been quantized to input feature map bit
    // parameter OUT_CH = 512,
    parameter WIRE_NUM = 29,
    parameter FIFO_DEPTH = 4

)
(

    
    // input
	clk,
	rst_n,
    // in_valid,
    DATAIN,
    READ,
    WRITE,

    // output
    dataout,
    full, 
    empty
    
);

// ===============================================================
// Parameter & Integer Declaration
// ===============================================================
integer i,j;

reg [$clog2(FIFO_DEPTH):0] write_pointer, read_pointer; // need to plus one more bit for wrap around
reg [WIRE_NUM-1:0] mem [0:FIFO_DEPTH-1];



// ===============================================================
// Input & Output Declaration
// ===============================================================
input clk, rst_n;
input [WIRE_NUM-1:0] DATAIN;
input READ, WRITE;
output [WIRE_NUM-1:0] dataout;
output full, empty;


// fifo read 
assign dataout = mem[read_pointer];

// fifo write
always@(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        for(i=0;i<FIFO_DEPTH;i=i+1)begin
            mem[i] <= 0;
        end
        
    end
    else if(WRITE && ~full)  begin
        mem[write_pointer] <= DATAIN;
    end
end


// full , MSB not same because of wrap around, rest is same
assign full  = 
    (write_pointer[$clog2(FIFO_DEPTH)] != read_pointer[$clog2(FIFO_DEPTH)]) 
    && 
    (write_pointer[$clog2(FIFO_DEPTH)-1:0] == read_pointer[$clog2(FIFO_DEPTH)-1:0]);



// empty signal
assign  empty = (write_pointer==read_pointer) ? 1'b1 : 1'b0;


// write pointer
always@(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
       write_pointer <= 0; 
    end
    else if(WRITE && !full)begin // write signal and not full
        write_pointer <= write_pointer+1; 
    end
end

// read pointer
always@(posedge clk or negedge rst_n)begin
    if(!rst_n) begin
       read_pointer <= 0; 
    end
    else if(READ && !empty)begin // read signal and not empty
        read_pointer <= read_pointer+1;
    end
end


endmodule