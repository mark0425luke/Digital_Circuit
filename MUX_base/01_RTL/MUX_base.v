

// this module 
// ===============================================================
// TOP MODULE
// ===============================================================
module MUX_base
#(
    parameter BIT =27,
    parameter NUMBER_INPUT = 512

)
(
    
	clk,
    rst_n,
    sel,
    IN,
    out
    
);


// ===============================================================
// Parameter & Integer Declaration
// ===============================================================
integer i,j;




// ===============================================================
// wire & reg Declaration
// ===============================================================
reg [BIT-1 : 0] out_next;
// reg [NUMBER_INPUT-1 : 0]decode;
// reg [$clog2(NUMBER_INPUT)-1 : 0]decode;
// reg [NUMBER_INPUT*BIT-1:0] in;

// ===============================================================
// Input & Output Declaration
// ===============================================================
input clk, rst_n;
input [$clog2(NUMBER_INPUT)-1 : 0] sel;
input [NUMBER_INPUT*BIT-1:0] IN;
output reg [BIT-1:0]   out ;

//================================================================
// DESIGN
//================================================================
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        out <= 0;
    end
    else begin
        out <= out_next;
    end
end
// always @(*) begin
//     for(j=0;j<NUMBER_INPUT;j=j+1)begin
//         decode[j] = (sel==j) ? 1'b1 : 1'b0;
//     end
// end
// always @(posedge clk or negedge rst_n) begin
//     if(!rst_n)begin
//         decode <= 0;
//         in <= 0;
//     end
//     else begin
//         for(j=0;j<NUMBER_INPUT;j=j+1)begin
//             decode[j] <= (sel==j) ? 1'b1 : 1'b0;
//         end
//         in <= IN;
//     end
// end
// always @(posedge clk or negedge rst_n) begin
//     if(!rst_n)begin
//         decode <= 0;
//         in <= 0;
//     end
//     else begin
//         decode <= sel;
//         in <= IN;
//     end
// end
always @(*) begin
    out_next=0;
    // for(i=0;i<NUMBER_INPUT;i=i+1)begin
    //     if(decode[i]==1'b1)begin
    //         out_next =  in[i*BIT +: BIT];
    //     end
    //     
    // end

    // for(i=0;i<NUMBER_INPUT;i=i+1)begin
    //     if(sel==i)begin
    //         out_next =  in[i*BIT +: BIT];
    //     end
    //     
    // end


    out_next = IN[sel*BIT +: BIT];
    // out_next = in[decode*BIT +: BIT];
end

endmodule
