module ascii_to_hex (
    input wire [7:0]ascii,
    output reg [3:0]hex
);

always @(ascii) begin
    if(ascii>8'h2f && ascii<8'h3a) //0-9
        hex<=ascii[3:0];
    else if(ascii>8'h40 && ascii<8'h47) //A-F
        hex<=(ascii[3:0]+9);
    
    else if(ascii>8'h60 && ascii<8'h67) //a-f
        hex<=(ascii[3:0]+9);
    else 
        hex<=8'h00;

end
endmodule