module lcd(
    input  wire off,CLK_50M,wink,calculator_mode,
    input wire [87:0]data,
    output reg strataflash_ce, // strataflash_ce =1 to enable
    // LCD for Spartan-3E
    output reg LCD_E, LCD_RS, LCD_RW,
    output reg [7:0] LCD_DB // LCD_DB[3:0] = 1 for Spartan-3AN
);

reg off_c;
//localparam data_bit=64,each_bit=4;
reg [23:0] count_next;
reg [23:0] count = 0; // 23-bit count, 0-(2^23-1), less than 0.2 s
reg [5:0] code; // {LCD_RS, LCD_RW, LCD_DB[7:4]}
reg refresh; // refresh LCD rate @ about 200Hz
reg init=1'b0;

always @(init)
    begin
    count_next = count + 1;
    refresh = count[17];

    if(~init) begin 
     
        
        // refresh (enable) the LCD when bit 17 of the count is 1
        // (it flips when counted up to 2^17, and flips again after another 2^17)
        // flip rate about 200 (50MHz/(2^18))
        
        case (count [23:18]) // every 2^19 clocks = 10 ms (0 for 5 ms, 1 for 5 ms)
            // 5 ms > 4.1 ms
            0: code = 6'h03; // power-on initializatoin sequence
            1: code = 6'h03;
            2: code = 6'h03;
            3: code = 6'h02;
            4: code = 6'h02; // configuration
            5: code = 6'h08;
            6: code = 6'h00;
            7: code = 6'h06;
            8: code = 6'h00;
            9: code = 6'h0C;
            10: code = 6'h00;
            11: code = 6'h01;
            // wirte data
            12: code = 6'b000100;  //define smile
            13: code = 6'h00;
            14: code = 6'h20;
            15: code = 6'h20;
            16: code = 6'h20;
            17: code = 6'h2a;
            18: code = 6'h20;
            19: code = 6'h2a;
            20: code = 6'h20;
            21: code = 6'h2a;
            22: code = 6'h20;
            23: code = 6'h20;
            24: code = 6'h21;
            25: code = 6'h21;
            26: code = 6'h21;
            27: code = 6'h21;
            28: code = 6'h20;
            29: code = 6'h2e;
            //30: code = 6'b000100;  //define wink
            31: code = 6'h08;
            32: code = 6'h20;
            33: code = 6'h20;
            34: code = 6'h21;
            35: code = 6'h20;
            36: code = 6'h2a;
            37: code = 6'h20;
            38: code = 6'h21;
            39: code = 6'h20;
            40: code = 6'h20;
            43: code = 6'h21;
            44: code = 6'h21;
            45: code = 6'h21;
            46: code = 6'h21;
            47: code = 6'h20;
            48: code = 6'h2e;
            49: init = 1'b1;
            default: code = 6'h10;

            endcase
        end
        else if(off_c) begin
            case(count[23:18])
            0:code = 6'h00;
            1:code = 6'h01;
            default : code = 6'h10;

            endcase

        end

        else begin
            case(count [23:18])
            /*0: code = 6'h00;
            1: code = 6'h0c;*/
            2: code = 6'b001000;  // '\r'
            3: code = 6'b000000;
            4: code = {2'b10,data[87:84]};
            5: code = {2'b10,data[83:80]};
            6: code = {2'b10,data[79:76]};
            7: code = {2'b10,data[75:72]};
            8: code = {2'b10,data[71:68]};
            9: code = {2'b10,data[67:64]};
            10: code = {2'b10,data[63:60]};
            11: code = {2'b10,data[59:56]};
            12: code = {2'b10,data[55:52]};
            13: code = {2'b10,data[51:48]};
            14: code = {2'b10,data[47:44]};
            15: code = {2'b10,data[43:40]};
            16: code = {2'b10,data[39:36]};
            17: code = {2'b10,data[35:32]};
            18: code = {2'b10,data[31:28]};
            19: code = {2'b10,data[27:24]};
            20: code = {2'b10,data[23:20]};
            21: code = {2'b10,data[19:16]};
            22: code = {2'b10,data[15:12]};
            23: code = {2'b10,data[11:8]};
            24: code = {2'b10,data[7:4]};
            25: code = {2'b10,data[3:0]};

            26: code = 6'b001100;  // \n
            27: code = 6'b000000;

            28: code = 6'h20;
            29: code = {2'b10,3'b000,wink};

            30: code = 6'b001100;  // middle of 2nd row
            31: code = 6'b000111;

            32: begin
                if(calculator_mode)
                    code = 6'h22;
                else
                    code = 6'h27;            
            end
            33: begin
                if(calculator_mode)
                    code = 6'h2b;
                else
                    code = 6'h28;      
            end

            34: code = 6'b001100;  // the last char
            35: code = 6'b001111;
            36: code = 6'h20;
            37: code = {2'b10,3'b000,wink};

            38: code =6'h00;

            39: code =6'h0c;            
            default:code = 6'h10;

            endcase

        end
    end

always @(posedge count[23]) begin
    if(off) begin
        off_c<=1'b1;
    end
    else begin
        off_c<=1'b0;
    end
end

always @ (posedge CLK_50M)
    begin
    //if(enable) begin
    count <= count_next;
    strataflash_ce <= 1; // for Spartan 3E
    LCD_E <= refresh;
    LCD_RS <= code[5];
    LCD_RW <= code[4];
    LCD_DB[7] <= code[3];
    LCD_DB[6] <= code[2];
    LCD_DB[5] <= code[1];
    LCD_DB[4] <= code[0];
    LCD_DB[3] <= 1;
    LCD_DB[2] <= 1;
    LCD_DB[1] <= 1;
    LCD_DB[0] <= 1;
    //end
    end

endmodule