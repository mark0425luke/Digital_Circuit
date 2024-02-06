

// this module 
// ===============================================================
// TOP MODULE
// ===============================================================
module Decoder
#(
    // parameter K=3,
    parameter NUM_MACRO = 1,
    // parameter IN_CH = 512,
    parameter OUT_CH = 64,
    parameter MAX_NUM_FILTER = 1
    // parameter ADC_PRECISION = 4,
    // parameter BIT_W = 8,
    // parameter BIT_IFM = 8
    // parameter out_ch = 512

)
(
    // input
	clk,
	rst_n,
    in_valid,
    WHICH_FILTER,
    // SHIFT_AND_ADD,

    // // output
    out_valid,
    // PE_OB
    // which_filter, 
    demux
    
);


// ===============================================================
// Parameter & Integer Declaration
// ===============================================================
integer i,j,k;
genvar gen_idx;
// localparam BIT_INPUT_SHIFT = ADC_PRECISION + BIT_W + (BIT_IFM - 1);
localparam BIT_OUT_CH = $clog2(OUT_CH);
parameter STATE_IDLE = 2'd0;
parameter STATE_SEL = 2'd1;
parameter STATE_DISTRIBUTE = 2'd2;
parameter STATE_ADD = 2'd3;




// ===============================================================
// wire & reg Declaration
// ===============================================================
reg [1:0] cur_state, next_state;
// reg [BIT_INPUT_SHIFT-1:0]   shift_and_add [0:NUM_MACRO-1][0:MAX_NUM_FILTER-1];
reg [BIT_OUT_CH-1:0]        which_filter    [0:NUM_MACRO-1][0:MAX_NUM_FILTER-1];
// reg [(BIT_IFM + BIT_W + $clog2(K*IN_CH)) - 1:0] add [0:OUT_CH-1];

// reg [BIT_INPUT_SHIFT-1:0]   filter_choose_Shift_and_Add [0:NUM_MACRO-1][0:OUT_CH-1];
// reg [BIT_INPUT_SHIFT-1:0]   filter_choose_Shift_and_Add_next [0:NUM_MACRO-1][0:OUT_CH-1];
// reg [OUT_CH-1:0]            demux                                   [0:NUM_MACRO-1][0:MAX_NUM_FILTER-1];
reg [OUT_CH-1:0]            demux_reg                                   [0:NUM_MACRO-1][0:MAX_NUM_FILTER-1];
reg [MAX_NUM_FILTER-1:0]      sel_filter_choose_Shift_and_Add         [0:NUM_MACRO-1][0:OUT_CH-1];
reg [MAX_NUM_FILTER-1:0]      sel_filter_choose_Shift_and_Add_next    [0:NUM_MACRO-1][0:OUT_CH-1];



// 改成定值
// always @(*)begin
//     for(i=0;i<NUM_MACRO;i=i+1)begin
//         for(j=0;j<MAX_NUM_FILTER;j=j+1)begin
//             which_filter[i][j] = j;
//         end
//     end
// end

// ===============================================================
// Input & Output Declaration
// ===============================================================
input clk, in_valid, rst_n;
input [NUM_MACRO * MAX_NUM_FILTER * BIT_OUT_CH-1 : 0] WHICH_FILTER;
// input [NUM_MACRO * MAX_NUM_FILTER * BIT_INPUT_SHIFT-1 : 0] SHIFT_AND_ADD;

output reg out_valid;
// output reg [OUT_CH * (BIT_IFM + BIT_W + $clog2(K*IN_CH)) - 1:0] PE_OB;
// input  [BIT_OUT_CH-1:0]        which_filter    [0:NUM_MACRO-1][0:MAX_NUM_FILTER-1];
// output reg [OUT_CH-1:0]            demux                                   [0:NUM_MACRO-1][0:MAX_NUM_FILTER-1];
output reg [NUM_MACRO*MAX_NUM_FILTER*OUT_CH-1:0]            demux        ;


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
        if(in_valid)begin
            next_state = STATE_SEL;
        end
    end
    STATE_SEL:begin
        // next_state = STATE_DISTRIBUTE;
        next_state = STATE_IDLE;
    end
    // STATE_DISTRIBUTE:begin
    //     next_state = STATE_ADD;
    // end
    // STATE_ADD:begin
    //     next_state = STATE_IDLE;
    // end
    endcase
end





// distribute input signal
// always@(posedge clk or negedge rst_n)begin
//     if(!rst_n)begin
//         for(i=0;i<NUM_MACRO;i=i+1)begin
//             for(j=0;j<MAX_NUM_FILTER;j=j+1)begin
//                 // which_filter[i][j] <= 0;
//                 shift_and_add[i][j] <= 0;
//             end
//         end
//     end
//     else if(in_valid)begin
//         for(i=0;i<NUM_MACRO;i=i+1)begin
//             for(j=0;j<MAX_NUM_FILTER;j=j+1)begin
//                 // which_filter[i][j]  <= WHICH_FILTER[
//                 //                                         (i*MAX_NUM_FILTER*BIT_OUT_CH 
//                 //                                         +j*BIT_OUT_CH)
//                 //                                         +:
//                 //                                         BIT_OUT_CH];
//                 shift_and_add[i][j] <= SHIFT_AND_ADD[
//                                                         (i*MAX_NUM_FILTER*BIT_INPUT_SHIFT
//                                                         +j*BIT_INPUT_SHIFT)
//                                                         +: 
//                                                         BIT_INPUT_SHIFT];
//             end
//         end
//     end
// end




// sequential
// always@(posedge clk or negedge rst_n)begin
//     if(!rst_n)begin
//         for(i=0;i<NUM_MACRO;i=i+1)begin
//             for(j=0;j<OUT_CH;j=j+1)begin
//                 // sel_filter_choose_Shift_and_Add[i][j] <= 0;
//                 filter_choose_Shift_and_Add[i][j] <=0;
//             end
//         end


//     end
//     else begin
//         for(i=0;i<NUM_MACRO;i=i+1)begin
//             for(j=0;j<OUT_CH;j=j+1)begin
//                 // sel_filter_choose_Shift_and_Add[i][j] <= sel_filter_choose_Shift_and_Add_next[i][j]; 
//                 filter_choose_Shift_and_Add[i][j] <=filter_choose_Shift_and_Add_next[i][j];
//             end
//         end
//     end
// end



// distribute
// i : NUM_MACRO 
// j : OUT_CH
// k : MAX_NUM_FILTER



// STATE_SEL
// inside each Macro
//      which_filter[0]==0 => demux[0]==0000....0001
//      which_filter[0]==1 => demux[0]==0000....0010


always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        for(i=0;i<NUM_MACRO;i=i+1)begin
            for(j=0;j<MAX_NUM_FILTER;j=j+1)begin
                which_filter[i][j]  <= 0;
            end
        end
    
    end
    else if (in_valid) begin
        for(i=0;i<NUM_MACRO;i=i+1)begin
            for(j=0;j<MAX_NUM_FILTER;j=j+1)begin
                which_filter[i][j]  <= WHICH_FILTER[
                                        (i*MAX_NUM_FILTER*BIT_OUT_CH 
                                        +j*BIT_OUT_CH)
                                        +:
                                        BIT_OUT_CH];
            end
        end
    end
end



always @(*) begin
  
    for(i=0;i<NUM_MACRO;i=i+1)begin
        for(k=0;k<MAX_NUM_FILTER;k=k+1)begin
            for(j=0;j<OUT_CH;j=j+1)begin
                demux_reg[i][k][j] = (which_filter[i][k]==j) ? 1'b1 : 1'b0;
            end
        end
    end

    
    
end

// always @(*) begin
//     for(i=0;i<NUM_MACRO;i=i+1)begin
//         for(j=0;j<OUT_CH;j=j+1)begin
//             for(k=0;k<MAX_NUM_FILTER;k=k+1)begin
//                 sel_filter_choose_Shift_and_Add_next[i][j][k] = demux[i][k][j];
//             end
//         end
//     end
    
// end
// always @(*) begin
//     for(i=0;i<NUM_MACRO;i=i+1)begin
//         for(j=0;j<OUT_CH;j=j+1)begin
//             for(k=0;k<MAX_NUM_FILTER;k=k+1)begin
//                 sel_filter_choose_Shift_and_Add[i][j][k] = demux[i][k][j];
//             end
//         end
//     end
    
// end




// // STATE_DISTRIBUTE
// // inside each Macro
// //      filter_choose_Shift_and_Add[0] = 0 (default)
// //      {demux[0][0], demux[1][0], demux[2][0], ...demux[MAX_NUM_FILTER][0]} = 1000....0000 => filter_choose_Shift_and_Add[0] = shift_and_add[0]
// //      {demux[0][0], demux[1][0], demux[2][0], ...demux[MAX_NUM_FILTER][0]} = 0100....0000 => filter_choose_Shift_and_Add[0] = shift_and_add[1]
// //      {demux[0][0], demux[1][0], demux[2][0], ...demux[MAX_NUM_FILTER][0]} = 0010....0000 => filter_choose_Shift_and_Add[0] = shift_and_add[2]
// always @(*) begin
//     for(i=0;i<NUM_MACRO;i=i+1)begin
//         for(j=0;j<OUT_CH;j=j+1)begin
//             filter_choose_Shift_and_Add_next[i][j] = 0;
            
//             for(k=0;k<MAX_NUM_FILTER;k=k+1)begin
//                 if(sel_filter_choose_Shift_and_Add[i][j][k]==1'b1)begin
//                     filter_choose_Shift_and_Add_next[i][j] = shift_and_add[i][k];
//                 end
//             end
//         end
//     end
// end






// // add
// always@(*)begin
//     for(i=0;i<OUT_CH;i=i+1)begin
//         add[i] = 0;
//         add[i] = add[i] + PE_OB[i];
//         for(j=0;j<NUM_MACRO;j=j+1)begin

//             // filter_choose_Shift_and_Add is NUM_MACRO * OUT_CH,
//             // so need to [j][i] not [i][j]
//             add[i] = add[i] + filter_choose_Shift_and_Add[j][i]; // sum up all Macro along same out_ch, won't have latch
//         end
//     end
// end


// reg [OUT_CH-1:0]            demux_reg                                   [0:NUM_MACRO-1][0:MAX_NUM_FILTER-1];


// // output
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        out_valid <=0;
        // PE_OB <= 0;
        
        demux<=0;
       
    end
    else if(cur_state==STATE_SEL)begin
        out_valid <= 1;
        // for(i=0;i<OUT_CH;i=i+1)begin
        //     PE_OB[i*(BIT_IFM + BIT_W + $clog2(K*IN_CH)) +: (BIT_IFM + BIT_W + $clog2(K*IN_CH)) ] <= add[i];        
        // end
        for(i=0;i<NUM_MACRO;i=i+1)begin
            for(k=0;k<MAX_NUM_FILTER;k=k+1)begin
                
                demux[i*MAX_NUM_FILTER*OUT_CH + k*OUT_CH +: OUT_CH] <=demux_reg[i][k];
            end
        end
    end
    else begin
        out_valid <= 0;
   
        demux<=0;
       
    end
end



endmodule
