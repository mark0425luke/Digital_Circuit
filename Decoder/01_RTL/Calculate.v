// ===============================================================
// TOP MODULE
// ===============================================================
module Calculate
#(
    parameter BIT_CELL = 1,
    parameter BIT_DAC = 1,
    parameter BIT_W=8,
    parameter OUY=8,
    parameter BIT_IFM = 8

)
(
    // input
    clk,
    rst_n,
	ADC_RESULT,
    WEIGHT_BIT_POSITION, // for weight shift
    ONES_COUNTER, // for weight subtract
    INPUT_BIT_POSITION, // for input shift

    // output
    input_shift
    
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
localparam BIT_INPUT_SHIFT = ADC_PRECISION + BIT_W + (BIT_IFM - 1);
// localparam signed OFFSET = 2**(BIT_W-1);
wire [BIT_W:0] OFFSET = 2**(BIT_W-1);

// ===============================================================
// wire & reg Declaration
// ===============================================================
reg signed [ADC_PRECISION + BIT_W-1 : 0] weight_shift;
reg signed [ADC_PRECISION + BIT_W-1 : 0] weight_subtract;
wire signed [BIT_INPUT_SHIFT-1 : 0] tmp_input_shift;


reg  [BIT_ONES_COUNTER - 1:0]         ones_counter_1t;
reg signed [BIT_INPUT_BIT_POSITION - 1:0]   input_bit_position_1t, input_bit_position_2t;


// ===============================================================
// Input & Output Declaration
// ===============================================================
input clk, rst_n;
input  [ADC_PRECISION-1:0]ADC_RESULT;
input  [BIT_W - 1:0] WEIGHT_BIT_POSITION; // for weight shift
input signed [BIT_ONES_COUNTER - 1:0] ONES_COUNTER; // for weight subtract
input signed [BIT_INPUT_BIT_POSITION - 1:0] INPUT_BIT_POSITION; // for input shift

output reg [BIT_INPUT_SHIFT-1:0] input_shift;


//================================================================
// DESIGN
//================================================================


// delay
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        ones_counter_1t <=0;
        input_bit_position_1t <=0;
        input_bit_position_2t <=0;
    end
    else begin
        ones_counter_1t <=ONES_COUNTER;
        input_bit_position_1t <=INPUT_BIT_POSITION;
        input_bit_position_2t <=input_bit_position_1t;
    end
end


// pipeline 1, STATE_WEIGHT_SHIFT
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        weight_shift <= 0;
    end
    else begin
        weight_shift <= ADC_RESULT * WEIGHT_BIT_POSITION;
    end
end

// pipeline 2, STATE_WEIGHT_SUBTRACT
wire  signed [ADC_PRECISION + BIT_W-1 : 0] multiple = ones_counter_1t * OFFSET;
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        weight_subtract <= 0;
    end
    else begin
        // weight_subtract <= weight_shift - ones_counter_1t * OFFSET;
        weight_subtract <= weight_shift - multiple;
    end
end

// pipeline 3, STATE_INPUT_SHIFT
assign tmp_input_shift = weight_subtract  << input_bit_position_2t;
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        input_shift <= 0;
    end
    else begin
        input_shift  <= 
            (input_bit_position_2t==(BIT_IFM-1)) 
            ? (-tmp_input_shift) 
            : tmp_input_shift;
    end
end

endmodule