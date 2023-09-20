module matrix_calculator(
    input wire op,
    input wire [31:0] A, B,
    output reg [31:0]C );

always @(*) begin
    if(~op) begin
        C[31:24] <= A[31:24] * B[31:24] + A[23:16] * B[15:8];
        C[23:16] <= A[31:24] * B[23:16] + A[23:16] * B[7:0];
        C[15:8] <= A[15:8] * B[31:24] + A[7:0] * B[15:8];
        C[7:0] <= A[15:8] * B[23:16] + A[7:0] * B[7:0];
    end
    else begin
        C[31:24] <= A[31:24] + B[31:24] ;
        C[23:16] <= A[23:16] + B[23:16] ;
        C[15:8] <= A[15:8] + B[15:8];
        C[7:0] <= A[7:0] + B[7:0];
    end
end

endmodule