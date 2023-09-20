module led_s (
    input wire CLK_50M,
    output wire [1:0]slower_clk
);
   slower_2m_clock  #(23,5000000) uu11(CLK_50M,slower_clk[1]); 
	slower_2m_clock  #(26,50000000) uu61(CLK_50M,slower_clk[0]); 
endmodule