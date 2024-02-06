

// ===============================================================
// TOP MODULE
// ===============================================================
module Add_base
#(
    parameter NUMBER_INPUT = 2,
    parameter BIT_INPUT = 21,
    parameter BIT_OUTPUT = 28

)
(
    // input
	clk,
	rst_n,
    // in_valid,
    in,

    out
    // out_valid,
    // Accumulator
    
);


// ===============================================================
// Parameter & Integer Declaration
// ===============================================================
integer i,idx_out_ch;




// ===============================================================
// wire & reg Declaration
// ===============================================================
reg [BIT_OUTPUT-1:0] out_next;

// ===============================================================
// Input & Output Declaration
// ===============================================================
input clk,  rst_n;
input [NUMBER_INPUT * BIT_INPUT-1 : 0]in;
output reg [BIT_OUTPUT-1:0] out;


//================================================================
// DESIGN
//================================================================
// FSM
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        out <= 0;
    end
    else begin
        out <= out_next;
    end
end
always@*begin
    out_next = 0;
    for(i=0;i<NUMBER_INPUT;i=i+1)begin
        out_next = out_next + in[i*BIT_INPUT +: BIT_INPUT];
    end
end

endmodule
