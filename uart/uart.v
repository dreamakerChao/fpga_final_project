//Listing 8.4
module uart
   #( // Default setting:
      // 19,200 baud, 8 data bits, 1 stop bit, 2^2 FIFO
      parameter DBIT = 8,     // # data bits
                SB_TICK = 16, // # ticks for stop bits, 16/24/32
                              // for 1/1.5/2 stop bits
                DVSR = 163,   // baud rate divisor
                              // DVSR = 50M/(16*baud rate)
                DVSR_BIT = 8, // # bits of DVSR
                FIFO_W = 2    // # addr bits of FIFO
                              // # words in FIFO=2^FIFO_W
   )
   (
    input wire clk, reset,
    input wire rx,
    output wire rx_full,
    output wire [31:0] data_32_bit
   );

// signal declaration
wire tick, rx_done_tick;
wire [7:0] rx_data_out;
reg [2:0] counter=0;
wire [2:0]counter_succ;
wire [3:0]hex;

assign counter_succ=counter+1;
//body
mod_m_counter #(.M(DVSR), .N(DVSR_BIT)) baud_gen_unit
    (.clk(clk), .reset(1'b0), .q(), .max_tick(tick));

uart_rx #(.DBIT(DBIT), .SB_TICK(SB_TICK)) uart_rx_unit
    (.clk(clk), .reset(1'b0), .rx(rx), .s_tick(tick),
    .rx_done_tick(rx_done_tick), .dout(rx_data_out));

ascii_to_hex ascii_to_hex01(rx_data_out,hex);
memory8x4bit mem(rx_done_tick,reset,counter,hex,data_32_bit);



always @(posedge rx_done_tick , posedge reset) begin
    if (reset) begin
        counter <= 3'b0;
    end
    else begin
        if (rx_done_tick && counter==3'b111) begin
            counter<=counter_succ-1;
        end
        else if(rx_done_tick)begin
            counter<= counter_succ;
        end
        
    end
end


assign rx_full=(counter==3'b111 );

endmodule