
// 

module Pooling
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
    // input
	clk,
	rst_n,
    in_valid,
    ACTIVATION,

    // output
    out_valid,
    Pooling
    
);

// ===============================================================
// Parameter & Integer Declaration
// ===============================================================
integer i,j;
localparam NUM_CYCLE = BOTTLENECK/DELTA_X * OU * STRIDE;
localparam NUM_POOLING = (IN_CH / (NUM_CYCLE));
parameter STATE_IDLE = 1'd0;
parameter STATE_CALCULATE = 1'd1;
reg cur_state, next_state;
reg [$clog2(NUM_CYCLE)-1:0] cnt;
reg signed [IFM_BIT-1:0] pooling [0:NUM_POOLING-1];
// reg signed [SIZE*SIZE*IFM_BIT-1:0] activation [0:IN_CH-1]; // separated by input channel
reg signed [SIZE*SIZE*IFM_BIT-1:0] activation [0:NUM_POOLING-1]; // separated by input channel
reg signed [IFM_BIT-1:0] activation_pixel [0:NUM_POOLING-1][0:SIZE*SIZE-1];

// ===============================================================
// Input & Output Declaration
// ===============================================================
input clk, rst_n, in_valid;
// input [IN_CH*SIZE*SIZE*IFM_BIT-1:0] ACTIVATION;
input [NUM_POOLING*SIZE*SIZE*IFM_BIT-1:0] ACTIVATION;
output reg out_valid;
output reg [NUM_POOLING*IFM_BIT-1:0] Pooling;



//================================================================
// DESIGN
//================================================================
// FSM
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cur_state <= STATE_IDLE;
    end
    else begin
        cur_state <= next_state;
    end
end
always@*begin
    next_state = cur_state;

    case(cur_state)
    STATE_IDLE:begin
        next_state = STATE_IDLE;
        if(in_valid)begin
            next_state = STATE_CALCULATE;
        end
    end
    STATE_CALCULATE:begin
        // next_state = STATE_CALCULATE;
        // if(cnt==NUM_CYCLE)begin // cnt=0 : still calculating, cnt=1~NUM_CYCLE give output
        //     next_state = STATE_IDLE;
        // end
        next_state = STATE_IDLE;
    end
    endcase
end

// counter
// always@(posedge clk or negedge rst_n)begin
//     if(!rst_n)begin
//         cnt<=0;
//     end
//     else if(cur_state==STATE_CALCULATE)begin
//         cnt<=cnt+1; // default
//         if(cnt==NUM_CYCLE)begin
//             cnt<=0;
//         end
//     end
// end


// input
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        // for(i=0;i<IN_CH;i=i+1)begin
        //     activation[i]<=0;
        // end

        for(i=0;i<NUM_POOLING;i=i+1)begin
            activation[i]<=0;
        end
    end
    else if(in_valid)begin
        // for(i=0;i<IN_CH;i=i+1)begin
        //     
        //     // separated by input channel
        //     activation[i]<=ACTIVATION[ 
        //         i*SIZE*SIZE*IFM_BIT +: SIZE*SIZE*IFM_BIT ];
        // end

        for(i=0;i<NUM_POOLING;i=i+1)begin
            activation[i]<=ACTIVATION[ 
                i*SIZE*SIZE*IFM_BIT +: SIZE*SIZE*IFM_BIT ];
        end
    end
end



// Pooling combinational
always @(*) begin
    for(i=0;i<NUM_POOLING;i=i+1)begin

        // ex. SIZE*SIZE=2*2, IFM_BIT=8, IN_CH=512, NUM_POOLING=8, and maxpooling
        // when cnt==0
        //      pooling[0] = max(activation[0][7:0], activation[0][15:8], activation[0][23:16], activation[0][31:24])
        //      pooling[1] = max(activation[1][7:0], activation[1][15:8], activation[1][23:16], activation[1][31:24])
        //      ......
        // when cnt==1
        //      pooling[0] = max(activation[8][7:0], activation[8][15:8], activation[8][23:16], activation[8][31:24])
        //      pooling[1] = max(activation[9][7:0], activation[9][15:8], activation[9][23:16], activation[9][31:24])
        //      ......
        // pooling[i] = activation[cnt*NUM_POOLING+i][IFM_BIT-1:0]; // default to activation[i][7:0]
        // for(j=1;j<SIZE*SIZE;j=j+1)begin // iterate rest of activation to find the max
        //     if( activation[cnt*NUM_POOLING+i][j*IFM_BIT +: IFM_BIT] > pooling[i] )begin
        //         pooling[i] = activation[cnt*NUM_POOLING+i][j*IFM_BIT +: IFM_BIT];
        //     end
        // end

        // need to break into SIZE*SIZE　pixel
        // otherwise 不能 signed 比大小
        for(j=0;j<SIZE*SIZE;j=j+1)begin
            activation_pixel[i][j] = activation[i][j*IFM_BIT +: IFM_BIT];
        end

        pooling[i] = activation_pixel[i][0]; // default to activation[i][7:0]
        for(j=1;j<SIZE*SIZE;j=j+1)begin // iterate rest of activation to find the max
            if( activation_pixel[i][j] > pooling[i] )begin
                pooling[i] = activation_pixel[i][j];
            end
        end
    end
end



// output
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        out_valid <=0;
        Pooling <= 0;
    end
    else if(cur_state==STATE_CALCULATE)begin
        out_valid <= 1;
        for(i=0;i<NUM_POOLING;i=i+1)begin
            Pooling[i*IFM_BIT +: IFM_BIT] <= pooling[i];
        end
        
        // end of output, next_state = STATE_IDLE
        // if(cnt==NUM_CYCLE)begin
        //     out_valid <=0;
        //     Pooling <= 0;
        // end
    end
    else begin
        out_valid <=0;
        Pooling <= 0;
    end
end
endmodule
