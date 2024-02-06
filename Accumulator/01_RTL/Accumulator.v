

// ===============================================================
// TOP MODULE
// ===============================================================
module Accumulator
#(
    parameter IFM_BIT = 8,
    parameter W_BIT = 8,
    parameter K=3,
    parameter IN_CH=512
    // parameter out_ch = 512

)
(
    // input
	clk,
	rst_n,
    in_valid,
    PE,

    // output
    out_valid,
    Accumulator
    
);


// ===============================================================
// Parameter & Integer Declaration
// ===============================================================
integer i,idx_out_ch;
localparam BIT_PE           = IFM_BIT + W_BIT + $clog2(K*IN_CH);
localparam BIT_ACCUMULATOR  = IFM_BIT + W_BIT + $clog2(K*K*IN_CH);
reg [BIT_PE-1:0] pe[0:K-1];
reg [BIT_ACCUMULATOR-1:0] tmp_accumu;
parameter STATE_IDLE = 1'd0;
parameter STATE_CALCULATE = 1'd1;
reg cur_state, next_state;



// ===============================================================
// Input & Output Declaration
// ===============================================================
input clk, in_valid, rst_n;
input [K*BIT_PE-1 : 0] PE;
output reg out_valid;
output reg [BIT_ACCUMULATOR-1:0] Accumulator;


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

// distribute input signal
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        for(i=0;i<K;i=i+1)begin
            pe[i] <= 0;
        end
    end
    else if(in_valid)begin
        for(i=0;i<K;i=i+1)begin
            pe[i] <= PE[i*BIT_PE +: BIT_PE];
        end
    end
end

// accumulate over K PEs
always @(*) begin
    tmp_accumu = 0;
    for(i=0;i<K;i=i+1)begin
        tmp_accumu = tmp_accumu + pe[i]; // sum up all pe, won't have latch
    end
end

// output
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        out_valid <=0;
        Accumulator <= 0;
    end
    else if(cur_state==STATE_CALCULATE)begin
        out_valid <= 1;
        Accumulator <= tmp_accumu;
    end
    else begin
        out_valid <= 0;
        Accumulator <= 0;
    end
end



endmodule
