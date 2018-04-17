`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NSTU
// Engineer: Barsukov D. R.
//////////////////////////////////////////////////////////////////////////////////

module MainModule(
    output [15:0] LedRow,
    input [15:0] ButtonRow,
    output [2:0] RGB1,
    output [2:0] RGB2,
    output reg [7:0] segmentAnodes,
    output reg [7:0] segments,
    input [4:0] ButtonX,
    input clk,
    input nreset,
    output [11:0] VGAsignal,
    output hsync,
    output vsync
    );


    wire greset;
    assign greset = !nreset;
    
    assign RGB1[2] = ButtonRow[13];
    assign RGB1[1] = ButtonRow[14];
    assign RGB1[0] = ButtonRow[15];
    assign RGB2[2] = ButtonRow[10];
    assign RGB2[1] = ButtonRow[11];
    assign RGB2[0] = ButtonRow[12];

    wire [11:0] line;
    wire [11:0] column;
    
    VGAsync vgasync(
        .clk100(clk),
        .reset(greset),
        .hsync(hsync),
        .vsync(vsync),
        .line(line),
        .column(column)
    );

    VGAdisplay VGAdisp(
        .reset(greset),
        .line(line),
        .column(column),
        .RGBsig(VGAsignal),
        .buttons(ButtonRow)
    );

    initial
    begin
        segments = 8'hFF;
        segmentAnodes = 8'hFF;
    end
    
endmodule
