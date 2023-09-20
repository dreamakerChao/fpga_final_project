module timer(
    input wire clk, reset,
    output wire [31:0] time_data
);

reg [5:0] hour = 0, min = 0, second = 0;
wire[5:0] hour_succ, min_succ, second_succ;
reg [5:0] hour_next = 0, min_next = 0, second_next = 0;

assign hour_succ=hour+1;
assign min_succ=min+1;
assign second_succ=second+1;

always @(posedge clk, posedge reset)
begin
    if (reset) begin
        hour <= 6'b00_0000;
        min <= 6'b00_0000;
        second <= 6'b00_0000;
    end
    else begin
        hour <= hour_next;
        min <= min_next;
        second <= second_next;
    end
end

always @*
begin
    if (second_succ == 60) begin
            second_next = 0;
            if (min_succ == 60) begin
                min_next = 0;
                hour_next = hour_succ;
            end
            else begin
                min_next = min_succ;
                hour_next = hour;
            end
        end
        else begin
            second_next = second_succ;
            min_next = min;
            hour_next = hour;
        end

end

hex_to_time hex01(hour, min, second, time_data);

endmodule
