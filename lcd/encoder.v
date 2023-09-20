module hex_to_lcd_encoder (
    input wire [3:0]data,
    output reg [7:0] lcd_signal 
);

always @*
    begin

            if(data>9) begin
                lcd_signal[7:4] = 4'b0110;
                case(data[2:0])
                    3'b010:lcd_signal[3:0] = 4'd0;
                    3'b011:lcd_signal[3:0] = 4'd1;
                    3'b100:lcd_signal[3:0] = 4'd2;
                    3'b101:lcd_signal[3:0] = 4'd3;
                    3'b110:lcd_signal[3:0] = 4'd4;
                    3'b111:lcd_signal[3:0] = 4'd5;
                
                endcase
                lcd_signal[3:0] = {data[3:0]-4'b1001};
            end
            else begin
                lcd_signal[7:4] = 4'b0011;
                lcd_signal[3:0] = {data[3:0]};
            end
            end

    
endmodule