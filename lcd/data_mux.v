module data_mux (
    input wire [1:0]op,
    input wire [31:0]A,B,C,counter,
    output reg [31:0]data
);

always @(op)
    case(op)
        2'b00 : data<=counter;
        2'b01 : data<=A;
        2'b10 : data<=B;
        2'b11: data<=C;

    endcase

endmodule