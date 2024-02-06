
// this module quantize and relu output feature map to input feature map
// using static quantization (no need to collect max and min to calculate scaling factor every time) during training
// batch normalization is already fused into convolution

module Activation 
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
integer i;
localparam SCALING_FACTOR = 2**(OFM_BIT-IFM_BIT);
parameter STATE_IDLE = 1'd0;
parameter STATE_CALCULATE = 1'd1;
reg cur_state, next_state;
reg signed [OFM_BIT-1:0] ofm;
wire signed [IFM_BIT-1:0] quantize;


// ===============================================================
// Input & Output Declaration
// ===============================================================
input clk, rst_n, in_valid;
input [OFM_BIT-1:0] OFM;
output reg out_valid;
output reg [IFM_BIT-1:0] Activation;

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
        next_state = STATE_IDLE;
        if(in_valid)begin
            next_state = STATE_CALCULATE;
        end
    end
    endcase
end

// input
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        ofm <= 0;
    end
    else if(in_valid)begin
        ofm <= OFM;
    end
end

// static quantization and relu
assign quantize = (ofm<0) ?0 : ofm/SCALING_FACTOR;

// output
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        out_valid <=0;
        Activation <= 0;
    end
    else if(cur_state==STATE_CALCULATE)begin
        out_valid <= 1;
        Activation <= quantize;
    end
    else begin
        out_valid <= 0;
        Activation <= 0;
    end
end
endmodule
