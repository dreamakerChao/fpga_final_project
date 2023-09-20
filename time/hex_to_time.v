module hex_to_time (
    input wire [5:0]hour,
    input wire [5:0]min,
    input wire [5:0]second,
    output reg [31:0]time_data
);

wire [7:0]dec_hour,dec_min,dec_second;

bcd u1(hour,dec_hour[7:4],dec_hour[3:0]);
bcd u2(min,dec_min[7:4],dec_min[3:0]);
bcd u3(second,dec_second[7:4],dec_second[3:0]);

always@*
    begin
        time_data[31:28]=dec_hour[3:0];

        time_data[27:24]=4'b0;

        time_data[23:20]=dec_min[7:4];
        time_data[19:16]=dec_min[3:0];

        time_data[15:12]=4'b0;

        time_data[11:8]=dec_second[7:4];
        time_data[7:4]=dec_second[3:0];

        time_data[3:0]=4'b0;
        
    end

endmodule