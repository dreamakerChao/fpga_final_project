module db_tick (
    input wire clk,
    input wire sw,
    output reg db_tick
);

reg db_prev;
wire db;

db_fsm db_fsm_inst(clk, 1'b0, sw, db);

always @(posedge clk) begin
    db_prev <= db;
    if (db_prev == 1'b0 && db == 1'b1)
        db_tick <= 1'b1;

    else
        db_tick <= 1'b0;
end


endmodule
