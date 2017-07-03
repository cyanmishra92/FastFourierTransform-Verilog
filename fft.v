`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: Cyan Subhra Mishra 
// Email: cyanmishra92@gmail.com
// Create Date: 11/27/2015 12:52:36 PM
// Design Name: 
// Module Name: fft
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

module sp (clk,micClk,micData,micLRSel,ampPWM,ampSD);
input wire clk,micData;
output wire micLRSel,ampSD,ampPWM;
wire [31:0] x [15:0];
//reg [7:0] x1;
wire [31:0] y [15:0];
wire [31:0] z [15:0];
//reg [31:0] z [15:0];
//output wire [31:0] ampPWM;
output wire micClk;
reg [4:0] clk_cntr_reg = 0;
reg [15:0] a;
reg pwm_val_reg;
reg [15:0] in =0;
integer counter = 0,i=15;
reg out,change =0;

//SIPO uut1 (pwm_val_reg,in,clk);
//PISO uut2 (sipo_out,piso_out,clk);
always @(posedge clk)
    begin
        clk_cntr_reg <= clk_cntr_reg + 1;
    end
    
    //micClk = 100MHz / 32 = 3.125 MHz
   assign  micClk = clk_cntr_reg[4];
    
    always @(posedge clk)
    begin
        if (clk_cntr_reg == 5'b01110) 
        begin
          pwm_val_reg <= micData;
        end 
    end
    
always @(posedge micClk)
    begin
    counter = counter +1;
        a[15:1] = a[14:0];
        a[0] = pwm_val_reg;
        if (counter > 15)
        begin
        in = a;
        counter =0;
        change = 1'b1;
        end
    end
    
 assign x[0]={15'd0,in[0],16'd0};
 assign x[1]={15'd0,in[1],16'd0};
 assign x[2]={15'd0,in[2],16'd0};
 assign x[3]={15'd0,in[3],16'd0};
 assign x[4]={15'd0,in[4],16'd0};
 assign x[5]={15'd0,in[5],16'd0};
 assign x[6]={15'd0,in[6],16'd0};
 assign x[7]={15'd0,in[7],16'd0};
 assign x[8]={15'd0,in[8],16'd0};
 assign x[9]={15'd0,in[9],16'd0};
 assign x[10]={15'd0,in[10],16'd0};
 assign x[11]={15'd0,in[11],16'd0};
 assign x[12]={15'd0,in[12],16'd0};
 assign x[13]={15'd0,in[13],16'd0};
 assign x[14]={15'd0,in[14],16'd0};
 assign x[15]={15'd0,in[15],16'd0};
           
 fft uut (x[0],x[1],x[2],x[3],x[4],x[5],x[6],x[7],x[8],x[9],x[10],x[11],x[12],x[13],x[14],x[15],
          y[0],y[1],y[2],y[3],y[4],y[5],y[6],y[7],y[8],y[9],y[10],y[11],y[12],y[13],y[14],y[15],clk);

ifft uut1 (y[0],y[1],y[2],y[3],y[4],y[5],y[6],y[7],y[8],y[9],y[10],y[11],y[12],y[13],y[14],y[15],
           z[0],z[1],z[2],z[3],z[4],z[5],z[6],z[7],z[8],z[9],z[10],z[11],z[12],z[13],z[14],z[15],clk);
           
always @(posedge micClk)
begin
//if(change ==1)
//begin
    out = z[i][19];
    if(i == 0)
    begin
    //change =1'b0;
    i=16;
    end
     i=i-1;
//end
end
    
    assign micLRSel = 1'd0;
    assign ampPWM = out;
    assign ampSD = 1'd1;
endmodule

module fft(x0r,x0i,x1r,x1i,x2r,x2i,x3r,x3i,x4r,x4i,x5r,x5i,x6r,x6i,x7r,x7i,
           X0r,X0i,X1r,X1i,X2r,X2i,X3r,X3i,X4r,X4i,X5r,X5i,X6r,X6i,X7r,X7i,clk);
          // X1r_c,X1i_c,X2r_c,X2i_c,X3r_c,X3i_c,X4r_c,X4i_c,X5r_c,X5i_c,X6r_c,X6i_c,X7r_c,X7i_c,X8r_c,X8i_c);
input [31:0] x0r,x0i,x1r,x1i,x2r,x2i,x3r,x3i,x4r,x4i,x5r,x5i,x6r,x6i,x7r,x7i;
output [31:0] X0r,X0i,X1r,X1i,X2r,X2i,X3r,X3i,X4r,X4i,X5r,X5i,X6r,X6i,X7r,X7i;
input clk;
wire [31:0] y0r,y0i,y1r,y1i,y2r,y2i,y3r,y3i,y4r,y4i,y5r,y5i,y6r,y6i,y7r,y7i;
wire [31:0] z0r,z0i,z1r,z1i,z2r,z2i,z3r,z3i,z4r,z4i,z5r,z5i,z6r,z6i,z7r,z7i;
reg [31:0] w0r,w0i,w1r,w1i,w2r,w2i,w3r,w3i;
initial
begin
 w0r = { 16'd1 , 16'd0};
 w0i = 32'd0;
 w1r = { 16'd0 , 16'b1011010100000100};
 w1i = { 16'd65535 , 16'b0100101011111100};
 w2r = 32'd0;
 w2i = {16'd65535 , 16'd0};
 w3r = { 16'd65535 , 16'b0100101011111100};
 w3i = { 16'd65535 , 16'b0100101011111100};
end
butterfly a1(x0r,x4r,x0i,x4i,clk,y0r,y0i,y4r,y4i,w0r,w0i);
butterfly a2(x2r,x6r,x2i,x6i,clk,y2r,y2i,y6r,y6i,w0r,w0i);
butterfly a3(x1r,x5r,x1i,x5i,clk,y1r,y1i,y5r,y5i,w0r,w0i);
butterfly a4(x3r,x7r,x3i,x7i,clk,y3r,y3i,y7r,y7i,w0r,w0i);

butterfly b1(y0r,y2r,y0i,y2i,clk,z0r,z0i,z2r,z2i,w0r,w0i);
butterfly b2(y4r,y6r,y4i,y6i,clk,z4r,z4i,z6r,z6i,w2r,w2i);
butterfly b3(y1r,y3r,y1i,y3i,clk,z1r,z1i,z3r,z3i,w0r,w0i);
butterfly b4(y5r,y7r,y5i,y7i,clk,z5r,z5i,z7r,z7i,w2r,w2i);

butterfly c1(z0r,z1r,z0i,z1i,clk,X0r,X0i,X4r,X4i,w0r,w0i);
butterfly c2(z4r,z5r,z4i,z5i,clk,X1r,X1i,X5r,X5i,w1r,w1i);
butterfly c3(z2r,z3r,z2i,z3i,clk,X2r,X2i,X6r,X6i,w2r,w2i);
butterfly c4(z6r,z7r,z6i,z7i,clk,X3r,X3i,X7r,X7i,w3r,w3i);
endmodule

module ifft(x0r,x0i,x1r,x1i,x2r,x2i,x3r,x3i,x4r,x4i,x5r,x5i,x6r,x6i,x7r,x7i,
           X0r,X0i,X1r,X1i,X2r,X2i,X3r,X3i,X4r,X4i,X5r,X5i,X6r,X6i,X7r,X7i,clk);
          // X1r_c,X1i_c,X2r_c,X2i_c,X3r_c,X3i_c,X4r_c,X4i_c,X5r_c,X5i_c,X6r_c,X6i_c,X7r_c,X7i_c,X8r_c,X8i_c);
input [31:0] x0r,x0i,x1r,x1i,x2r,x2i,x3r,x3i,x4r,x4i,x5r,x5i,x6r,x6i,x7r,x7i;
output [31:0] X0r,X0i,X1r,X1i,X2r,X2i,X3r,X3i,X4r,X4i,X5r,X5i,X6r,X6i,X7r,X7i;
//reg [31:0] X0rh,X0ih,X1rh,X1ih,X2rh,X2ih,X3rh,X3ih,X4rh,X4ih,X5rh,X5ih,X6rh,X6ih,X7rh,X7ih;
input clk;
wire [31:0] y0r,y0i,y1r,y1i,y2r,y2i,y3r,y3i,y4r,y4i,y5r,y5i,y6r,y6i,y7r,y7i;
wire [31:0] z0r,z0i,z1r,z1i,z2r,z2i,z3r,z3i,z4r,z4i,z5r,z5i,z6r,z6i,z7r,z7i;
//wire X0r,X0i,X1r,X1i,X2r,X2i,X3r,X3i,X4r,X4i,X5r,X5i,X6r,X6i,X7r,X7i;
reg [31:0] w0r,w0i,w1r,w1i,w2r,w2i,w3r,w3i;
initial
begin
 w0r = { 16'd1 , 16'd0};
 w0i = 32'd0;
 w1r = { 16'd0 , 16'b1011010100000100};
 w1i = { 16'd0 , 16'b1011010100000100};
 w2r = 32'd0;
 w2i = {16'd1 , 16'd0};
 w3r = { 16'd65535 , 16'b0100101011111100};
 w3i = { 16'd0 , 16'b1011010100000100};
end

butterfly a1(x0r,x4r,x0i,x4i,clk,y0r,y0i,y4r,y4i,w0r,w0i);
butterfly a2(x2r,x6r,x2i,x6i,clk,y2r,y2i,y6r,y6i,w0r,w0i);
butterfly a3(x1r,x5r,x1i,x5i,clk,y1r,y1i,y5r,y5i,w0r,w0i);
butterfly a4(x3r,x7r,x3i,x7i,clk,y3r,y3i,y7r,y7i,w0r,w0i);

butterfly b1(y0r,y2r,y0i,y2i,clk,z0r,z0i,z2r,z2i,w0r,w0i);
butterfly b2(y4r,y6r,y4i,y6i,clk,z4r,z4i,z6r,z6i,w2r,w2i);
butterfly b3(y1r,y3r,y1i,y3i,clk,z1r,z1i,z3r,z3i,w0r,w0i);
butterfly b4(y5r,y7r,y5i,y7i,clk,z5r,z5i,z7r,z7i,w2r,w2i);

butterfly c1(z0r,z1r,z0i,z1i,clk,X0r,X0i,X4r,X4i,w0r,w0i);
butterfly c2(z4r,z5r,z4i,z5i,clk,X1r,X1i,X5r,X5i,w1r,w1i);
butterfly c3(z2r,z3r,z2i,z3i,clk,X2r,X2i,X6r,X6i,w2r,w2i);
butterfly c4(z6r,z7r,z6i,z7i,clk,X3r,X3i,X7r,X7i,w3r,w3i);
endmodule


module butterfly(a1,b1,a2,b2,clk,z1r,z1i,z2r,z2i,wr,wi );
input [31:0]a1,b1,a2,b2,wr,wi;
//input[31:0]wr,wi;
input clk;
output [31:0] z1r,z1i,z2r,z2i;
//output z1r_c,z1i_c,z2r_c,z2i_c;
wire [31:0] x1,x2,x3,x4,z_t_i,z_t_r;
//wire [63:0] x1a,x2a,x3a,x4a;
wire z_t_i_c,z_t_r_c,z1i_c,z2r_c,z2i_c,z1r_c;
// this one is to multiply twiddle factor with the second number
//this is a complex number multiplication so it needs 4 normal multiplications
//to separate the real & complex parts
//parameter wr=32'b00111111100000000000000000000000;
//parameter wi=32'b0;
booth_mul s1(b1,wr,x1,1);//
//assign x1 [31:0] = x1a [47:16];
booth_mul s2(b2,wi,x2,1);//
//assign x2 [31:0] = x2a [47:16];
booth_mul s3(b1,wi,x3,1);//
//assign x3 [31:0] = x3a [47:16];
booth_mul s4(b2,wr,x4,1);//
//assign x4 [31:0] = x4a [47:16];
// This stage is to add/sub the product of multiplication to the first number
cla32 s5(x3,x4,clk,0,z_t_i,z_t_i_c);
cla32 s6(x1,x2,clk,1,z_t_r,z_t_r_c);
cla32 s7(z_t_r,a1,clk,0,z1r,z1r_c);
cla32 s8(z_t_i,a2,clk,0,z1i,z1i_c);
cla32 s9(a1,z_t_r,clk,1,z2r,z2r_c);
cla32 s10(a2,z_t_i,clk,1,z2i,z2i_c);
endmodule

module cla32(
    input [31:0] d1,
    input [31:0] d2,
    input clk,
    input cin,
    output [31:0] sum,
    output cout
    );
    wire c0,c1,c2,c3,c4,c5,c6;
    reg [31:0] b;
    always@(posedge clk)
    begin
     if(cin==1)
     b<=-d2-1;
     else
     b<=d2;
     end
    cla4 n1(d1[3:0],b[3:0],cin,sum[3:0],c0);
    cla4 n2(d1[7:4],b[7:4],c0,sum[7:4],c1);
    cla4 n3(d1[11:8],b[11:8],c1,sum[11:8],c2);
    cla4 n4(d1[15:12],b[15:12],c2,sum[15:12],c3);
    cla4 n5(d1[19:16],b[19:16],c3,sum[19:16],c4);
    cla4 n6(d1[23:20],b[23:20],c4,sum[23:20],c5);
    cla4 n7(d1[27:24],b[27:24],c5,sum[27:24],c6);
    cla4 n8(d1[31:28],b[31:28],c6,sum[31:28],cout);
    endmodule
module cla4(
        input [3:0] a,
        input [3:0] b,
        input cin,
        output [3:0] s,
        output cout
        );
        wire[3:0] g,p; 
        wire[13:0] z;
        xor21 x1  (.a(a[0]), .b(b[0]), .z(p[0]));
        and21 x2  (.a(a[0]), .b(b[0]), .z(g[0]));
        xor21 x3  (.a(a[1]), .b(b[1]), .z(p[1]));
        and21 x4  (.a(a[1]), .b(b[1]), .z(g[1]));
        xor21 x5  (.a(a[2]), .b(b[2]), .z(p[2]));
        and21 x6  (.a(a[2]), .b(b[2]), .z(g[2]));
        xor21 x7  (.a(a[3]), .b(b[3]), .z(p[3]));
        and21 x8  (.a(a[3]), .b(b[3]), .z(g[3]));
        xor21 x9  (.a(cin),  .b(p[0]), .z(s[0]));
        and21 x10 (.a(cin),  .b(p[0]), .z(z[0]));
        or21  x11 (.a(z[0]), .b(g[0]), .z(z[1]));
        xor21 x12 (.a(z[1]), .b(p[1]), .z(s[1]));
        and31 x13 (.a(cin),  .b(p[0]), .c(p[1]),.z(z[2]));
        and21 x14 (.a(g[0]), .b(p[1]), .z(z[3]));
        or31  x15 (.a(z[2]), .b(z[3]), .c(g[1]),.z(z[4]));
        xor21 x16 (.a(z[4]), .b(p[2]), .z(s[2]));
        and41 x17 (.a(cin),  .b(p[0]), .c(p[1]),.d(p[2]),.z(z[5]));
        and31 x18 (.a(g[0]), .b(p[1]), .c(p[2]),.z(z[6]));
        and21 x19 (.a(g[1]), .b(p[2]), .z(z[7]));
        or41  x20 (.a(z[5]), .b(z[6]), .c(z[7]),.d(g[2]),.z(z[8]));
        xor21 x21 (.a(z[8]), .b(p[3]), .z(s[3]));
        and41 x22 (.a(cin),  .b(p[0]), .c(p[1]),.d(p[2]),.z(z[9]));
        and31 x23 (.a(g[0]), .b(p[1]), .c(p[2]),.z(z[10]));
        and21 x24 (.a(g[1]), .b(p[2]), .z(z[11]));
        or41  x25 (.a(z[9]), .b(z[10]),.c(z[11]),.d(g[2]),.z(z[12]));
        and21 x26 (.a(z[12]),.b(p[3]), .z(z[13]));
        or21  x27 (.a(z[13]),.b(g[3]), .z(cout));
    endmodule
    module and21(a,b,z);
    input a,b;
    output z;
    assign z = a&b;
    endmodule
    
    module and31(a,b,c,z);
    input a,b,c;
    output z;
    assign z = a & b & c;
    endmodule
    
    module and41(a,b,c,d,z);
    input a,b,c,d;
    output z;
    assign z = a & b & c & d;
    endmodule
    
    module or21(a,b,z);
    input a,b;
    output z;
    assign z = a|b;
    endmodule
    
    module or31(a,b,c,z);
    input a,b,c;
    output z;
    assign z = a|b|c;
    endmodule
    
    module or41(a,b,c,d,z);
    input a,b,c,d;
    output z;
    assign z = a|b|c|d;
    endmodule
    
    module xor21(a,b,z);
    input a,b;
    output z;
    assign z = a^b;
    endmodule
module booth_mul(X,Y,M,en);
        input signed [31:0] X, Y;
           input en;
               output signed [31:0] M;
               //output signed [63:0] Z;
               reg signed [63:0] Z;
               reg signed [31:0] M;
               reg [1:0] temp;
               integer i;
               reg E1;
               reg [31:0] Y1;
               always @ (X, Y,en)
               begin
               Z = 64'd0;
               E1 = 1'd0;
               if (en == 1'b1)
               begin
               Z [31 : 0] = Z [31 : 0]+X;
               for (i = 0; i < 32; i = i + 1)
               begin
               temp = {X[i], E1};
               //The above statement is catenation
                     
                      Y1 = - Y;
                     
                          //Y1 is the 2' complement of Y
                     
                      case (temp)
                      2'd2 : Z [63 : 32] = Z [63 : 32] + Y1;
                      2'd1 : Z [63 : 32] = Z [63 : 32] + Y;
                      default : begin end
                      endcase
                      Z = Z >> 1;
                      /*The above statement is a logical shift of one position to
                          the right*/
                     
                      Z[63] = Z[62];
                      /*The above two statements perform arithmetic shift where
                      the sign of the number is preserved after the shift. */
                     
                      E1 = X[i];
                          end
                      if(Y==32'd2147483648)
                     
                      /*If Y = 10000000000000000000000000000000; then according to our code,
                      Y1 = 10000000000000000000000000000000 (-2147483648 not 2147483648, because Y1 is 32 bits only).
                      The statement sum = - sum adjusts the answer.*/
                     
                          begin
                              Z = - Z;
                          end
                          M[31:0]=Z[47:16];
                          end
                     
                      end
                     
    endmodule
