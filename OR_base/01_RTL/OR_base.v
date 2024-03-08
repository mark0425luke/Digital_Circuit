

// this module 
// ===============================================================
// TOP MODULE
// ===============================================================
module OR_base
#(
    parameter BIT =29,
    parameter NUMBER_INPUT = 16

)
(
    
	clk,
    rst_n,
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
reg [BIT-1:0] in [0:NUMBER_INPUT-1];

// ===============================================================
// Input & Output Declaration
// ===============================================================
input clk, rst_n;
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

always @(*) begin
    
    
    for(i=0;i<NUMBER_INPUT;i=i+1)begin
        in[i] = IN[BIT*i +: BIT];
    end

end

always @(*) begin
    out_next=0;
    
    for(i=0;i<NUMBER_INPUT;i=i+1)begin
        out_next = out_next | in[i];
    end

end

endmodule
