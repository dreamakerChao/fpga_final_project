module rotary_encoder(
    input wire clk, A, B,
    input wire enable,
    output reg right, left
);

    wire A_tick, B_tick;
    debounce_explicit #(.N(11)) db_a (.clk(clk), .reset(1'b0), .sw(A), .db_level(A_tick), .db_tick());
    debounce_explicit #(.N(11)) db_b (.clk(clk), .reset(1'b0), .sw(B), .db_level(B_tick), .db_tick());

    reg a_prev, b_prev;

    always @(posedge clk) begin
        if (enable) begin
            a_prev <= A_tick;
            b_prev <= B_tick;
            
            if (a_prev && !A_tick && !b_prev && !B_tick)
                right <= 1'b1;
            else
                right <= 1'b0;

            if (b_prev && !B_tick && !a_prev && !A_tick)
                left <= 1'b1;
            else
                left <= 1'b0;
        end else begin
            a_prev <= 1'b0;
            b_prev <= 1'b0;
            right <= 1'b0;
            left <= 1'b0;
        end

    end

endmodule
