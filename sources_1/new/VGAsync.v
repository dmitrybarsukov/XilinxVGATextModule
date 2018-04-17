`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NSTU
// Engineer: Barsukov D. R.
//////////////////////////////////////////////////////////////////////////////////

module VGAsync(
    input clk100,
    input reset,
    output reg hsync,
    output reg vsync,
    output reg [11:0] line,
    output reg [11:0] column
    );
    
    wire clk108;

    clk_wiz_0 clk_vga(
        .clk_out1(clk108),
        .reset(reset),
        .clk_in1(clk100)   
    );
    
    always @(posedge clk108)
    begin
        if(!reset)
        begin
            column = column + 1;
            
            if(column == 1688)
            begin
                column = 0;
                line = line + 1;
                
                if(line == 1066)
                    line = 0;
                
                if(line >= 1025 && line < 1028)
                    vsync = 1'b0;
                else
                    vsync = 1'b1;                
            end
            
            if(column >= 1328 && column < 1440)
                hsync = 1'b0;
            else
                hsync = 1'b1;                
        end
        else
        begin
            hsync = 1'b1;
            vsync = 1'b1;
        end
    end
    
endmodule
