module lcd_contol(
    input  wire off,CLK_50M,wink,calculator_mode,
    input wire [31:0]data, //data in
    input wire [2:0]op,
    output wire strataflash_ce, // strataflash_ce =1 to enable
    // LCD for Spartan-3E
    output wire LCD_E, LCD_RS, LCD_RW,
    output wire [7:0] LCD_DB // LCD_DB[3:0] = 1 for Spartan-3AN
);
reg [87:0]lcd_signal;
wire [7:0] out0,out1,out2,out3,out4,out5,out6,out7;
wire [23:0]mode;

lcd uu1(off,CLK_50M,wink,calculator_mode,lcd_signal,strataflash_ce,LCD_E, LCD_RS, LCD_RW,LCD_DB);
hex_to_lcd_encoder uu2(data[31:28],out0);
hex_to_lcd_encoder uu4(data[27:24],out1);
hex_to_lcd_encoder uu5(data[23:20],out2);
hex_to_lcd_encoder uu6(data[19:16],out3);
hex_to_lcd_encoder uu7(data[15:12],out4);
hex_to_lcd_encoder uu8(data[11:8],out5);
hex_to_lcd_encoder uu9(data[7:4],out6);
hex_to_lcd_encoder uu10(data[3:0],out7);
lcd_print_top uu11(op,mode);

always @(op) begin
    if (op[1:0] == 2'b00) begin
        lcd_signal[55:48] = 8'h68;
        lcd_signal[31:24] = 8'h6d;
        lcd_signal[7:0] = 8'h73;
    end
    else begin
        lcd_signal[55:48] = out1;
        lcd_signal[31:24] = out4;
        lcd_signal[7:0] = out7;
    end

    lcd_signal[63:56]=out0;
    lcd_signal[47:40]=out2;
    lcd_signal[39:32]=out3;
    lcd_signal[23:16]=out5;
    lcd_signal[15:8]=out6;
    lcd_signal[87:64]=mode;   

end
endmodule