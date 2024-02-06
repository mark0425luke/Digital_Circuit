

// this module 
// ===============================================================
// TOP MODULE
// ===============================================================
module Adder_mask
#(
    
    parameter NUM_MACRO=16,
    parameter OUT_CH=512

)
(
    // input
	clk,
	rst_n,
    WHICH_FILTER,

    // // output
    Adder_mask
    
);


// ===============================================================
// Parameter & Integer Declaration
// ===============================================================
integer i,j,k;
localparam BIT_OUT_CH = $clog2(OUT_CH);




// ===============================================================
// wire & reg Declaration
// ===============================================================
reg [BIT_OUT_CH-1:0]        which_filter                    [0:NUM_MACRO-1];
reg [NUM_MACRO-1:0]       comp_array                      [0:NUM_MACRO-1];
reg [NUM_MACRO-1:0]         unique_value_first_position;
reg [NUM_MACRO-1:0]         adder_mask                      [0:NUM_MACRO-1];

// ===============================================================
// Input & Output Declaration
// ===============================================================
input clk, rst_n;
input [NUM_MACRO * BIT_OUT_CH-1 : 0] WHICH_FILTER;
output reg [NUM_MACRO * NUM_MACRO-1 : 0] Adder_mask;


//================================================================
// DESIGN
//================================================================
always@(*)begin
    for(i=0;i<NUM_MACRO;i=i+1)begin
        which_filter[i] = WHICH_FILTER[i*BIT_OUT_CH +: BIT_OUT_CH];
    end
end

always@(*)begin
    for(i=0;i<NUM_MACRO;i=i+1)begin
        for(j=0;j<NUM_MACRO;j=j+1)begin
            comp_array[i][j] = (which_filter[j]==which_filter[i]) ? 1'b1 : 1'b0;
        end
    end
end


always@(*)begin
    
    unique_value_first_position = {NUM_MACRO{1'b1}};

    for(i=0;i<NUM_MACRO;i=i+1)begin
        for(j=0;j<i;j=j+1)begin
            if(which_filter[i] == which_filter[j])begin
                unique_value_first_position[i] = 1'b0;
            end
        end
    end
end


always@(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        for(i=0;i<NUM_MACRO;i=i+1)begin
            adder_mask[i] <=0;
        end
    end
    else begin
        for(i=0;i<NUM_MACRO;i=i+1)begin
            adder_mask[i] <= (unique_value_first_position[i]==1) ? comp_array[i] : 'd0;
        end
    end
end


always@(*)begin
    for(i=0;i<NUM_MACRO;i=i+1)begin
        Adder_mask[i*NUM_MACRO +: NUM_MACRO] = adder_mask[i];
    end
end

endmodule
