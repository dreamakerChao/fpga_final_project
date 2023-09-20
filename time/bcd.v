module bcd(
    input wire [5:0]binary,
    output reg [3:0]decimal1,decimal2
);
    

always @*
begin
case(binary)
6'b000000: begin
    decimal1 = 4'd0;
    decimal2 = 4'd0;
end
6'b000001: begin
    decimal1 = 4'd0;
    decimal2 = 4'd1;
end
6'b000010: begin
    decimal1 = 4'd0;
    decimal2 = 4'd2;
end
6'b000011: begin
    decimal1 = 4'd0;
    decimal2 = 4'd3;
end
6'b000100: begin
    decimal1 = 4'd0;
    decimal2 = 4'd4;
end
6'b000101: begin
    decimal1 = 4'd0;
    decimal2 = 4'd5;
end
6'b000110: begin
    decimal1 = 4'd0;
    decimal2 = 4'd6;
end
6'b000111: begin
    decimal1 = 4'd0;
    decimal2 = 4'd7;
end
6'b001000: begin
    decimal1 = 4'd0;
    decimal2 = 4'd8;
end
6'b001001: begin
    decimal1 = 4'd0;
    decimal2 = 4'd9;
end
6'b001010: begin
    decimal1 = 4'd1;
    decimal2 = 4'd0;
end
6'b001011: begin
    decimal1 = 4'd1;
    decimal2 = 4'd1;
end
6'b001100: begin
    decimal1 = 4'd1;
    decimal2 = 4'd2;
end
6'b001101: begin
    decimal1 = 4'd1;
    decimal2 = 4'd3;
end
6'b001110: begin
    decimal1 = 4'd1;
    decimal2 = 4'd4;
end
6'b001111: begin
    decimal1 = 4'd1;
    decimal2 = 4'd5;
end
6'b010000: begin
    decimal1 = 4'd1;
    decimal2 = 4'd6;
end
6'b010001: begin
    decimal1 = 4'd1;
    decimal2 = 4'd7;
end
6'b010010: begin
    decimal1 = 4'd1;
    decimal2 = 4'd8;
end
6'b010011: begin
    decimal1 = 4'd1;
    decimal2 = 4'd9;
end
6'b010100: begin
    decimal1 = 4'd2;
    decimal2 = 4'd0;
end
6'b010101: begin
    decimal1 = 4'd2;
    decimal2 = 4'd1;
end
6'b010110: begin
    decimal1 = 4'd2;
    decimal2 = 4'd2;
end
6'b010111: begin
    decimal1 = 4'd2;
    decimal2 = 4'd3;
end
6'b011000: begin
    decimal1 = 4'd2;
    decimal2 = 4'd4;
end
6'b011001: begin
    decimal1 = 4'd2;
    decimal2 = 4'd5;
end
6'b011010: begin
    decimal1 = 4'd2;
    decimal2 = 4'd6;
end
6'b011011: begin
    decimal1 = 4'd2;
    decimal2 = 4'd7;
end
6'b011100: begin
    decimal1 = 4'd2;
    decimal2 = 4'd8;
end
6'b011101: begin
    decimal1 = 4'd2;
    decimal2 = 4'd9;
end
6'b011110: begin
    decimal1 = 4'd3;
    decimal2 = 4'd0;
end
6'b011111: begin
    decimal1 = 4'd3;
    decimal2 = 4'd1;
end
6'b100000: begin
    decimal1 = 4'd3;
    decimal2 = 4'd2;
end
6'b100001: begin
    decimal1 = 4'd3;
    decimal2 = 4'd3;
end
6'b100010: begin
    decimal1 = 4'd3;
    decimal2 = 4'd4;
end
6'b100011: begin
    decimal1 = 4'd3;
    decimal2 = 4'd5;
end
6'b100100: begin
    decimal1 = 4'd3;
    decimal2 = 4'd6;
end
6'b100101: begin
    decimal1 = 4'd3;
    decimal2 = 4'd7;
end
6'b100110: begin
    decimal1 = 4'd3;
    decimal2 = 4'd8;
end
6'b100111: begin
    decimal1 = 4'd3;
    decimal2 = 4'd9;
end
6'b101000: begin
    decimal1 = 4'd4;
    decimal2 = 4'd0;
end
6'b101001: begin
    decimal1 = 4'd4;
    decimal2 = 4'd1;
end
6'b101010: begin
    decimal1 = 4'd4;
    decimal2 = 4'd2;
end
6'b101011: begin
    decimal1 = 4'd4;
    decimal2 = 4'd3;
end
6'b101100: begin
    decimal1 = 4'd4;
    decimal2 = 4'd4;
end
6'b101101: begin
    decimal1 = 4'd4;
    decimal2 = 4'd5;
end
6'b101110: begin
    decimal1 = 4'd4;
    decimal2 = 4'd6;
end
6'b101111: begin
    decimal1 = 4'd4;
    decimal2 = 4'd7;
end
6'b110000: begin
    decimal1 = 4'd4;
    decimal2 = 4'd8;
end
6'b110001: begin
    decimal1 = 4'd4;
    decimal2 = 4'd9;
end
6'b110010: begin
    decimal1 = 4'd5;
    decimal2 = 4'd0;
end
6'b110011: begin
    decimal1 = 4'd5;
    decimal2 = 4'd1;
end
6'b110100: begin
    decimal1 = 4'd5;
    decimal2 = 4'd2;
end
6'b110101: begin
    decimal1 = 4'd5;
    decimal2 = 4'd3;
end
6'b110110: begin
    decimal1 = 4'd5;
    decimal2 = 4'd4;
end
6'b110111: begin
    decimal1 = 4'd5;
    decimal2 = 4'd5;
end
6'b111000: begin
    decimal1 = 4'd5;
    decimal2 = 4'd6;
end
6'b111001: begin
    decimal1 = 4'd5;
    decimal2 = 4'd7;
end
6'b111010: begin
    decimal1 = 4'd5;
    decimal2 = 4'd8;
end
6'b111011: begin
    decimal1 = 4'd5;
    decimal2 = 4'd9;
end
endcase
end

endmodule
