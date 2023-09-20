module slower_2m_clock   
#(parameter N=25, M=25000000)    // M <= 2^N-1
(
    input wire clk,
    output wire slower_clk
);

reg [N-1:0] r_reg;
reg [N-1:0] r_next;
reg clock;
reg clock_next;

//register
always @(posedge clk)
        begin
            r_reg <= r_next;
            clock <= clock_next;  
        end

// next-state logic
always @*
    if (r_reg == M-1)
        begin
            r_next = 0;
            clock_next = ~clock;
        end
    else
        begin
            r_next = r_reg + 1;
            clock_next = clock;
        end
    
// output logic
assign slower_clk = clock;
endmodule

