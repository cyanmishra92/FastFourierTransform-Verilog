`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2015 10:40:14 PM
// Design Name: 
// Module Name: sp_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sp_tb();
reg clk,micData;
wire micLRSel,ampSD;//,ampPWM;
wire ampPWM;
wire micClk;
sp uut (.clk(clk),.micClk(micClk),.micData(micData),.micLRSel(micLRSel),.ampPWM(ampPWM),.ampSD(ampSD));

initial
begin
clk=0;
    forever
    begin
    #5 clk=!clk;
    end
end

initial
begin
micData = 1;
    repeat(64)
    begin
    @(posedge micClk);
    micData = !micData;
    $monitor ("x[0][16] = %b ",uut.x[0][16],"x[1][16] = %b ",uut.x[1][16],"x[2][16] = %b ",uut.x[2][16], "x[3][16] = %b ",uut.x[3][16],"x[4][16] = %b\n ",uut.x[4][16],
              "y[0][16] = %b ",uut.y[0][16],"y[1][16] = %b ",uut.y[1][16],"y[2][16] = %b ",uut.y[2][16], "y[3][16] = %b ",uut.y[3][16],"y[4][16] = %b\n ",uut.y[4][16],
              "z[0][16] = %b ",uut.z[0][19],"z[1][16] = %b ",uut.z[1][19],"z[2][16] = %b ",uut.z[2][19], "z[3][16] = %b ",uut.z[3][19],"z[4][16] = %b\n ",uut.z[4][19]);
    end
    #10 $finish;
    end
    
endmodule
