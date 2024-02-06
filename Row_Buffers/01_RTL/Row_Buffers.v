
// 综合时filelist.f中不能添加sram的行为模型.v文件，只要把.db放到link library下就行；
// `include "./../04_MEM/sram_448word_12bit/sram_sp_hde.v"
// `include "./../04_MEM/sram_2400word_48bit/sram_sp_hde.v"
// `include "./../04_MEM/sram_1792word_32bit/sram_sp_hde.v"

// this module collects serial in input from activation
// then send to PEs and write to SRAM
module Row_Buffers
#( 
    parameter K = 3,
    parameter STRIDE = 1, // convolution stride
    parameter SRAM_WORD  = 256,
    parameter SRAM_WIDTH = 8
    
    // parameter OFM_ROW = 224,
    // parameter BOTTLENECK = 1668,
    // parameter DELTA_X = 16,
    // parameter OU = 8,
    // parameter IN_CH=64,
    // parameter BIT_IFM = 8, // after output Activation, has been quantized to input feature map bit
    // parameter PE_time_max = 45,

)
(

    // input
	clk,
	rst_n,
    in_valid,
    DATAIN, // from Activation or Pooling
    

    // output
    out_valid,
    toPEs
    
);


// ===============================================================
// Parameter & Integer Declaration
// ===============================================================
integer i,j;
genvar gen_i, gen_j;
// parameter STATE_IDLE = 1'd0;
// parameter STATE_SERIAL_IN = 1'd1;
// localparam integer NUM_CYCLE = (BOTTLENECK/DELTA_X * OU); // which is just $floor(BOTTLENECK/DELTA_X * OU);
// localparam DATA_AMOUNT = K*IN_CH;
// localparam integer HOW_MANY_PIXEL = ((DATA_AMOUNT+NUM_CYCLE-1)/(NUM_CYCLE)); // which is $ceil(DATA_AMOUNT / NUM_CYCLE);
// localparam WIRE_NUM = HOW_MANY_PIXEL * BIT_IFM; // for DATAIN
parameter STATE_IDLE = 2'd0;
parameter STATE_SRAM_WAIT = 2'd1;
parameter STATE_OUTPUT = 2'd2;
localparam WRITE = 0; 
localparam READ = 1; 




// ===============================================================
// reg & wire
// ===============================================================
// reg [$clog2(OFM_ROW)-1:0]       address;
// reg [$clog2(PE_time_max*OU)-1:0] cnt;
// reg cur_state, next_state;
// reg [WIRE_NUM-1:0]              datain [0:NUM_CYCLE-1];
// reg [NUM_CYCLE*WIRE_NUM-1 : 0]  flatten_datain;
// wire [(STRIDE * K - STRIDE + K)*IN_CH*BIT_IFM-1 : 0]    sram_input  = flatten_datain;
// wire [(STRIDE * K - STRIDE + K)*IN_CH*BIT_IFM-1 : 0]    sram_output;
// reg [(STRIDE * K - STRIDE + K)*IN_CH*BIT_IFM-1 : 0]    sram_output_DFF;
// reg [(STRIDE * K - STRIDE + K)-1 : 0] w;

reg [$clog2(SRAM_WORD)-1:0]       address;
reg [$clog2(SRAM_WORD)-1:0] cnt;
reg [1:0] cur_state, next_state;
reg [SRAM_WIDTH-1:0]              datain    [0:(K)-1];
reg [SRAM_WIDTH-1:0]              datain_1t [0:(K)-1];
reg [SRAM_WIDTH-1:0]              datain_2t [0:(K)-1];

reg [$clog2(K)-1:0]             sram_input_select           [0 : (STRIDE * K - STRIDE + K)-1];
reg [SRAM_WIDTH-1 : 0]    sram_input                  [0 : (STRIDE * K - STRIDE + K)-1];
wire [SRAM_WIDTH-1 : 0]   sram_output                 [0 : (STRIDE * K - STRIDE + K)-1];
reg [SRAM_WIDTH-1 : 0]    sram_output_DFF             [0 : (STRIDE * K - STRIDE + K)-1];
reg [(STRIDE * K - STRIDE + K)-1 : 0] w;





// ===============================================================
// Input & Output Declaration
// ===============================================================
input clk, rst_n, in_valid;
input [(K)*SRAM_WIDTH-1:0] DATAIN;
output reg out_valid;
output reg [(STRIDE * K - STRIDE + K) *SRAM_WIDTH-1 : 0] toPEs;


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
    //default
    next_state = cur_state;

    //
    case(cur_state)
    STATE_IDLE:begin
        if(in_valid)begin
            next_state = STATE_SRAM_WAIT;
        end
    end
    STATE_SRAM_WAIT:begin
        if(cnt=='d2)begin
            next_state = STATE_OUTPUT;
        end
    end
    STATE_OUTPUT:begin
        if(cnt==SRAM_WORD-1)begin
            next_state = STATE_IDLE;
        end
    end
    endcase
end
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt <= 0;
    end
    else if(cur_state==STATE_SRAM_WAIT) begin
        cnt <= cnt+1;
        if(cnt=='d2)begin
            cnt <= 0;
        end
    end
    else if(cur_state==STATE_OUTPUT) begin
        cnt <= cnt+1;
        if(cnt==SRAM_WORD-1)begin
            cnt <= 0;
        end
    end
end

// input, and write/read signal
always@(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        for(i=0;i<K;i=i+1)begin
            datain[i] <=0;
        end
        
    end
    else if(in_valid) begin
        for(i=0;i<K;i=i+1)begin
            datain[i] <=DATAIN[i*SRAM_WIDTH +: SRAM_WIDTH];
        end
    end
end



// delay
always@(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        for(i=0;i<K;i=i+1)begin
            datain_1t[i] <=0;
            datain_2t[i] <=0;
        end
 
    end
    else begin
        for(i=0;i<K;i=i+1)begin
            datain_1t[i] <=datain[i];
            datain_2t[i] <=datain_1t[i];
        end
    end
end


// sram address
// sram input select
// SRAM read write control, can use Johnson counter
// ex. (if WRITE=0)
// when cycle is 0
// w[0] = w[1] = w[2] = write
// w[3] = w[4] = read
// 
// when cycle is 1, next 3 is 1, 
// but since only 5 signals so wrap around
// w[3] = w[4] = w[0] = 0
// w[1] = w[2] = 1
// 
// when cycle is 2, again next 3 is 1, 
// w[1] = w[2] = w[3] = 0
// w[4] = w[0] = 1
// 
// so there are STRIDE * K - STRIDE + K signals
// the first K are WRITE, rest are READ
// ex.  0th time : 00011 
//      1st time : 01100
//      2nd time : 10001
// meaning w[3]<=w[0], w[4]<=w[1], w[0]<=w[2], w[1]<=w[3], w[2]<=w[4]
//
// same idea for input select
// ex. 0th time
//          sram[0] = datain[0]
//          sram[1] = datain[1]
//          sram[2] = datain[2]
//          sram[3] = datain[0], but is read
//          sram[4] = datain[1], but is read
// ex. 1wt time
//          sram[0] = datain[2]
//          sram[1] = datain[0], but is read
//          sram[2] = datain[1], but is read
//          sram[3] = datain[0]
//          sram[4] = datain[1]
always@(posedge clk or negedge rst_n) begin
    if(!rst_n)begin

        // initialize to [0:4] = 11000 so that when in_valid come
        // can reset to 00011
        for(i=((STRIDE * K - STRIDE + K)-K); i< STRIDE * K - STRIDE + K ;i=i+1)begin
            w[i] <= WRITE;
        end
        for (i=0; i<((STRIDE * K - STRIDE + K)-K) ; i=i+1) begin
            w[i] <= READ;
        end

        // initialize to [0:4] = 00012, so that when in_valid come
        // can reset to 01200
        for(i=((STRIDE * K - STRIDE + K)-K); i< STRIDE * K - STRIDE + K ;i=i+1)begin
            sram_input_select[i] <= i-(K-1);
        end
        for (i=0; i<((STRIDE * K - STRIDE + K)-K) ; i=i+1) begin
            sram_input_select[i] <= i%K;
        end
        
    end
    else if(cur_state!=STATE_IDLE && address<SRAM_WORD-1)begin
        
        address <= address+1; // keep going until reach SRAM_WORD-1, then stop
        
        // w no need to change
    end

    else if(cur_state==STATE_IDLE && in_valid)begin
        
        address <= 0;

        for (i=0; i<STRIDE * K - STRIDE + K ; i=i+1) begin
            w[ (i+K)%(STRIDE * K - STRIDE + K) ] <= w[i];
            sram_input_select[ (i+K)%(STRIDE * K - STRIDE + K) ] <= sram_input_select[i];
        end

    end
end




// sram input
always@(*) begin
    for (i=0; i<STRIDE * K - STRIDE + K ; i=i+1) begin
        sram_input[i] = datain[sram_input_select[i]];
    end
end


// sram output blocked 
always@(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        for (i=0; i<STRIDE * K - STRIDE + K ; i=i+1) begin
            sram_output_DFF[i] <=0;
        end
    end
    else begin
        for (i=0; i<STRIDE * K - STRIDE + K ; i=i+1) begin
            sram_output_DFF[i] <= sram_output[i];
        end
    end
end


// SRAM，要 (STRIDE * K - STRIDE + K) 個，每次 K 個拿來寫，剩下讀
wire ceny;
wire weny;
wire [$clog2(SRAM_WORD)-1:0]ay;
wire [$clog2(SRAM_WORD)-1:0] ta='d0;
wire [SRAM_WIDTH-1:0] dy;
wire [SRAM_WIDTH-1:0] td='d0;
wire [SRAM_WIDTH-1:0] tq='d0;
generate
    for(gen_i=0; gen_i< STRIDE * K - STRIDE + K; gen_i=gen_i+1)begin
        
        sram_sp_hde S0 (
        // 這邊就好，跟 iclab 一樣
        .Q(sram_output[gen_i]), // output
        .CLK(clk),
        .CEN(1'b0),
        .WEN(w[gen_i]),
        .A(address),
        .D(sram_input[gen_i]),// input
        
        // 隨便用 wire 接
        .CENY(ceny), 
        .WENY(weny), 
        .AY(ay), 
        .DY(dy), 
        
        // 照著這邊設定，看是給1 或 0
        .EMA    (3'd0), 
        .EMAW   (2'd0), 
        .EMAS   (1'd0), 
        .TEN    (1'd1), 
        .BEN    (1'd1), 
        .TCEN   (1'd1), 
        .TWEN   (1'd1), 
        .TA     (ta), 
        .TD     (td), 
        .TQ     (tq), 
        .RET1N  (1'd1), 
        .STOV   (1'd0));
        
    end
endgenerate





// output
always@(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        out_valid <= 0;
        toPEs <= 0;
    end
    else if(next_state==STATE_OUTPUT)  begin
        out_valid <= 1;
        
        // 0~K-1 : sram_input
        // 剩下 K~STRIDE * K - STRIDE + K-1 : sram_output
        // 寫 sram 的拿 sram_output_DFF
        // 讀 sram 的拿 sram_input
        for(i=0;i<STRIDE * K - STRIDE + K ;i=i+1)begin
            toPEs[i*SRAM_WIDTH +: SRAM_WIDTH] 
                <= (w[i]==READ) 
                ?  sram_output_DFF[i] 
                :  datain_2t[sram_input_select[i]]; // SRAM write, so take sram input

        end
        
    end
    else begin
        out_valid <= 0;
    end
end



endmodule