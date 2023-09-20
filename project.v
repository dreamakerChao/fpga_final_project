module project_dreamaker (
    input wire CLK_50M, reset,rx,
    input wire ROT_A,ROT_B,
    input wire switch,
    input wire left, right, up,edit,
    output wire strataflash_ce, // strataflash_ce =1 to enable
    // LCD for Spartan-3E
    output wire LCD_E, LCD_RS, LCD_RW,
    output wire [7:0] LCD_DB, // LCD_DB[3:0] = 1 for Spartan-3AN
    output wire [2:0] state_led,
    output wire slower_clk,rx_full,
    output wire [2:0] rrr

);

reg [31:0] matrix_a = 0, a_next = 0;
reg [31:0] matrix_b = 0, b_next = 0;
reg [2:0] state = 3'b000, state_next = 3'b000;

wire [31:0]data,alu_result;

wire left_signal,right_signal,ce_signal,edit_signal;
wire [31:0]counter_time_60;
assign state_led=state;

wire [31:0]data_32_bit;
wire clean_uart;
reg sure_return,sure_return_next;

assign clean_uart=ce_signal|sure_return;
 

localparam idle = 3'b000, 
           show_a = 3'b001,
           edit_a = 3'b101,
           show_b = 3'b010,
           edit_b = 3'b110,
           answer = 3'b111,
           power_off = 3'b100;

//---------
wire right_rotate,left_rotate;


reg [3:0]rr=0,rr_next;
wire [3:0]rr_succ,rr_dec;
assign rr_succ=rr+1;
assign rr_dec=rr-1;


wire off;
assign off=(state==power_off);

rotary_encoder rot1(CLK_50M,ROT_A,ROT_B,1'b1,right_rotate,left_rotate);

always@(right_rotate,left_rotate)
begin
    
    if(right_rotate) begin
        if(rr_succ==4'h0) begin
            rr_next=4'hf;
        end
        else begin
            rr_next=rr_succ;
        end
        end
    else if(left_rotate)begin
        if(rr_dec==4'hf) begin
            rr_next=4'h0;
        end
        else begin
            rr_next=rr_dec;
        end
        end

    else 
        rr_next=rr;
    

end
assign rrr=rr[3:1];

//---------


always @(posedge CLK_50M, posedge reset)
begin
    if (reset) begin
        state <= idle;
        matrix_a <= 0;
        matrix_b <= 0;
        sure_return <= 1'b0;
        rr<=0;

    end
    else begin
        state <= state_next;
        matrix_a <= a_next;
        matrix_b <= b_next;
        sure_return <= sure_return_next;
        rr<=rr_next;
    end
end

always @*
begin
    state_next = state;
    a_next = matrix_a;
    b_next = matrix_b;
    sure_return_next = 1'b0;

    case (state)
        idle: begin
            if(rr==4'hf)
                state_next = power_off;
            else if (right_signal)
                state_next = show_a;
            else
                state_next = idle;
        end

        show_a: begin
            if(rr==4'hf)
                state_next = power_off;
            else if (left_signal)
                state_next = idle;
            else if (right_signal)
                state_next = show_b;
            else if(edit_signal) begin
                state_next = edit_a;
                sure_return_next = 1'b1;
            end
            else 
                state_next = show_a;
        end

        edit_a: begin
            a_next = data_32_bit;
            if(rr==4'hf)
                state_next = power_off;
            else if (edit_signal)
                state_next = show_a;
            else
                state_next = edit_a;
        end

        show_b: begin
            if(rr==4'hf)
                state_next = power_off;
            else if (left_signal)
                state_next = show_a;
            else if (right_signal)
                state_next = answer;
            else if(edit_signal) begin
                state_next = edit_b;
                sure_return_next = 1'b1;
            end
            else 
                state_next = show_b;
        end

        edit_b: begin
            b_next = data_32_bit;
            if(rr==4'hf)
                state_next = power_off;
            else if (edit_signal)
                state_next = show_b;
            else
                state_next = edit_b;
        end

        answer: begin
            if(rr==4'hf)
                state_next = power_off;
            else if (left_signal)
                state_next = show_b;
            else
                state_next = answer;      
        end

        power_off: begin
            if(rr==0)
                state_next=idle;
            else 
                state_next=power_off;
        end

        default: state_next = idle;
    endcase
end
db_tick left_db(CLK_50M,left, left_signal);
db_tick right_db(CLK_50M,right, right_signal);
db_tick ce_db(CLK_50M,up, ce_signal);
db_tick edit_db(CLK_50M,edit, edit_signal);

lcd_contol lcd01(off,CLK_50M,slower_clk,switch,data, state,strataflash_ce, LCD_E, LCD_RS, LCD_RW, LCD_DB);
slower_2m_clock #(26,25000000) slowclk_unit(CLK_50M, slower_clk);
timer  time_unit01(slower_clk,reset,counter_time_60);
data_mux d_mux01(state[1:0],matrix_a,matrix_b,alu_result,counter_time_60,data);
matrix_calculator alu(switch,matrix_a,matrix_b,alu_result);
uart uart01(CLK_50M,clean_uart,rx,rx_full,data_32_bit);


endmodule
