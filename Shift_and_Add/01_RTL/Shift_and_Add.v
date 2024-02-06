`include "Calculate.v"

// this module do weight shift, weight substract (due to signed offset to unsgined), and input shift


// ===============================================================
// TOP MODULE
// ===============================================================
module Shift_and_Add
#(
    
    parameter BIT_CELL = 1,
    parameter BIT_DAC = 1,
    parameter BIT_W=8,
    parameter OUY=32,
    parameter BIT_IFM = 8,
    // parameter MAX_NUM_FILTER = 64
    parameter MAX_NUM_FILTER = 1
    // parameter out_ch = 512

)
(
    // input
	clk,
	rst_n,
    in_valid,
    ADC_RESULT,
    WEIGHT_BIT_POSITION, // for weight shift
    ONES_COUNTER, // for weight subtract
    INPUT_BIT_POSITION, // for input shift

    // output
    out_valid,
    Shift_and_Add
    
);


// ===============================================================
// Parameter & Integer Declaration
// ===============================================================
integer i;
genvar gen_idx;
localparam BIT_ONES_COUNTER = $clog2(OUY);
localparam BIT_INPUT_BIT_POSITION = $clog2(BIT_IFM);
localparam ADC_PRECISION = (BIT_CELL!=1 && BIT_DAC!=1) 
                            ? (BIT_CELL + BIT_DAC + $clog2(OUY))
                            : (BIT_CELL + BIT_DAC + $clog2(OUY)-1);
localparam BIT_INPUT_SHIFT = ADC_PRECISION + BIT_W + (BIT_IFM - 1); // -1 是因為假設 8-bit IFM, 最多可以左移 7
parameter STATE_IDLE = 2'd0;
parameter STATE_WEIGHT_SHIFT = 2'd1;
parameter STATE_WEIGHT_SUBTRACT = 2'd2;
parameter STATE_INPUT_SHIFT = 2'd3;




// ===============================================================
// wire & reg Declaration
// ===============================================================
reg [1:0] cur_state, next_state;
reg [ADC_PRECISION-1:0] adc_result;
reg [BIT_W-1:0] weight_bit_position [0:MAX_NUM_FILTER-1]; // for weight shift
reg [BIT_ONES_COUNTER-1:0] ones_counter; // for weight subtract
reg [BIT_INPUT_BIT_POSITION-1:0] input_bit_position; // for input shift
wire [BIT_INPUT_SHIFT-1:0] input_shift [0:MAX_NUM_FILTER-1];



// ===============================================================
// Input & Output Declaration
// ===============================================================
input clk, in_valid, rst_n;
input [ADC_PRECISION-1:0]ADC_RESULT;
input [MAX_NUM_FILTER * BIT_W - 1:0] WEIGHT_BIT_POSITION; // for weight shift
input [BIT_ONES_COUNTER - 1:0] ONES_COUNTER; // for weight subtract
input [BIT_INPUT_BIT_POSITION - 1:0] INPUT_BIT_POSITION; // for input shift

output reg out_valid;
output reg [MAX_NUM_FILTER * BIT_INPUT_SHIFT - 1:0] Shift_and_Add;


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
            next_state = STATE_WEIGHT_SHIFT;
        end
    end
    STATE_WEIGHT_SHIFT:begin
        next_state = STATE_WEIGHT_SUBTRACT;  
    end
    STATE_WEIGHT_SUBTRACT:begin
        next_state = STATE_INPUT_SHIFT;
    end
    STATE_INPUT_SHIFT:begin
        next_state = STATE_IDLE;
    end
    endcase
end

// distribute input signal
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin

        adc_result <= 0;

        for(i=0;i<MAX_NUM_FILTER;i=i+1)begin
            weight_bit_position[i] <=0; // for weight shift
        end
        
        ones_counter <=0; // for weight subtract
        input_bit_position <=0; // for input shift
    end
    else if(in_valid)begin
        adc_result <= ADC_RESULT;


        for(i=0;i<MAX_NUM_FILTER;i=i+1)begin
            weight_bit_position[i] <= WEIGHT_BIT_POSITION[i*BIT_W +: BIT_W]; // for weight shift
        end
        ones_counter <=ONES_COUNTER; // for weight subtract
        input_bit_position <=INPUT_BIT_POSITION; // for input shift
    end
end

// generate MAX_NUM_FILTER submodules
generate
    for(gen_idx=0;gen_idx<MAX_NUM_FILTER;gen_idx=gen_idx+1)begin
        Calculate #(
            .BIT_CELL(BIT_CELL),
            .BIT_DAC(BIT_DAC),
            .BIT_W(BIT_W),
            .OUY(OUY),
            .BIT_IFM(BIT_IFM)

        ) U0
        (
            // input
            .clk(clk),
            .rst_n(rst_n),
            .ADC_RESULT(adc_result),
            .WEIGHT_BIT_POSITION(weight_bit_position[gen_idx]), 
            .ONES_COUNTER(ones_counter), 
            .INPUT_BIT_POSITION(input_bit_position), 

            // output
            .input_shift(input_shift[gen_idx])
            
        );
    end
endgenerate

// output
always @(*) begin
    for(i=0;i<MAX_NUM_FILTER;i=i+1)begin
        Shift_and_Add[i*BIT_INPUT_SHIFT +: BIT_INPUT_SHIFT] = input_shift[i]; // sinsce output of calculate is already DFF
    end 
end
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        out_valid <=0;
       
    end
    else if(cur_state==STATE_INPUT_SHIFT)begin
        out_valid <= 1;
        
    end
    else begin
        out_valid <= 0;
        
    end
end



endmodule
