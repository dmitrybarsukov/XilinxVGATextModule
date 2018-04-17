`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NSTU
// Engineer: Barsukov D. R.
//////////////////////////////////////////////////////////////////////////////////


module textMem(
    input [7:0] symbolNum,		// number of symbol on display (0...160)
    output [7:0] symbolCode		// ASCII code of symbol
    );
    
    reg [7:0] textM [255:0];

    initial
    begin 
        $readmemh("../text/text.mif", textM); 
    end
    
    assign symbolCode = textM[symbolNum];
endmodule
