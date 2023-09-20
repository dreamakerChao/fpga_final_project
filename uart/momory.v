module memory8x4bit(
    input wire clk,reset,
    input wire [2:0] addr,
    input wire [3:0] data_in,
    output wire [31:0] data_out
);

reg [3:0] mem [0:7];

initial begin

    mem[0]<= 0;
    mem[1]<= 0;
    mem[2]<= 0;
    mem[3]<= 0;

    mem[4]<= 0;
    mem[5]<= 0;
    mem[6]<= 0;
    mem[7]<= 0;
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        mem[0]<= 0;
        mem[1]<= 0;
        mem[2]<= 0;
        mem[3]<= 0;

        mem[4]<= 0;
        mem[5]<= 0;
        mem[6]<= 0;
        mem[7]<= 0;
        end
    else 
        mem[addr] <= data_in;
end

assign data_out = {mem[0],mem[1],mem[2],mem[3],mem[4],mem[5],mem[6],mem[7]};

endmodule
