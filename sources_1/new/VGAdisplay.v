`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NSTU
// Engineer: Barsukov D. R.
//////////////////////////////////////////////////////////////////////////////////


module VGAdisplay(
    input [11:0] line,
    input [11:0] column,
    input reset,
    output reg [11:0] RGBsig,
    input [15:0] buttons
    );
    
    wire onoff;
    wire [7:0] symbolCode;
    reg [4:0] symbolX;
    reg [4:0] symbolY;
    reg [2:0] pixelX;
    reg [3:0] pixelY;
    reg [7:0] symbolNum;
    
    fontMem font(
        .x(pixelX),
        .y(pixelY),
        .symbolCode(symbolCode),
        .onoff(onoff)
    );

    textMem text(
        .symbolNum(symbolNum),
        .symbolCode(symbolCode)
    );

    always @(*)
    begin
        if(!reset)
        begin
            if(line < 1024 && column < 1280)
            begin

                symbolX = (column / 8) / 8;
                symbolY = (line / 8) / 16;

                symbolNum = symbolY * 20 + symbolX;

                pixelX = (column / 8) % 8;
                pixelY = (line / 8) % 16;

                if(onoff)
                    RGBsig = (buttons[15] * 15) + ((buttons[14] * 15) << 4) + ((buttons[13] * 15) << 8);
                else
                    RGBsig = (buttons[12] * 15) + ((buttons[11] * 15) << 4) + ((buttons[10] * 15) << 8);
            end
            else
            begin
                RGBsig = 12'h000;
            end
        end
        else
        begin
            RGBsig = 12'h000;
        end
    end
    
endmodule
