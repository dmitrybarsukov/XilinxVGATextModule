`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NSTU
// Engineer: Barsukov D. R.
//////////////////////////////////////////////////////////////////////////////////


module fontMem(
    input [7:0] symbolCode, // ASCII code
    input [2:0] x,          // pixel x position
    input [3:0] y,          // pixel y position
    output onoff            // pixel on or off
    );
    
    reg [7:0] glyphMem [4095:0];

    initial
    begin 
        $readmemh("../fonts/vgafont.mif", glyphMem); 
    end
    
    assign onoff = glyphMem[symbolCode * 16 + y][7 - x];

endmodule
