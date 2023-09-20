module lcd_print_top
    (
        input wire [2:0]op,
        output reg [23:0]top_chac
    );

always@* begin
    case(op)
        3'b000: begin  //timer
            top_chac[23:16]=8'hfe;
            top_chac[15:8]=8'hfe;
            top_chac[7:0]=8'hfe;
        end

        3'b001: begin  //show a
            top_chac[23:16]=8'h41;
            top_chac[15:8]=8'h3a;
            top_chac[7:0]=8'hfe;
        end

        3'b101: begin  //edit a
            top_chac[23:16]=8'h41;
            top_chac[15:8]=8'h3f;
            top_chac[7:0]=8'hfe;
        end

        3'b010: begin  //show b
            top_chac[23:16]=8'h42;
            top_chac[15:8]=8'h3a;
            top_chac[7:0]=8'hfe;
        end

        3'b110: begin  //edit b
            top_chac[23:16]=8'h42;
            top_chac[15:8]=8'h3f;
            top_chac[7:0]=8'hfe;
        end


        3'b111: begin   //answer 
            top_chac[23:16]=8'h41;
            top_chac[15:8]=8'h73;
            top_chac[7:0]=8'hfe;
        end

        default: begin
            top_chac[23:16]=8'hfe;
            top_chac[15:8]=8'hfe;
            top_chac[7:0]=8'hfe;
        end

    endcase
end

endmodule