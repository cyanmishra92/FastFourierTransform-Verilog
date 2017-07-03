`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2015 01:02:27 PM
// Design Name: 
// Module Name: fft_tb
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


module fft_tb();
reg [31:0] x0r,x0i,x1r,x1i,x2r,x2i,x3r,x3i,x4r,x4i,x5r,x5i,x6r,x6i,x7r,x7i;
wire [31:0] X0r,X0i,X1r,X1i,X2r,X2i,X3r,X3i,X4r,X4i,X5r,X5i,X6r,X6i,X7r,X7i;
    //input[31:0]wr,wi;
    reg clk;
   // wire z1r_c,z1i_c,z2r_c,z2i_c;
fft uut (.x0r(x0r),.x0i(x0i),.clk(clk),.x1r(x1r),.x1i(x1i),.x2r(x2r),.x2i(x2i),.x3r(x3r),.x3i(x3i),.x4r(x4r),.x4i(x4i),.x5r(x5r),.x5i(x5i),.x6r(x6r),.x6i(x6i),.x7r(x7r),.x7i(x7i),
.X0r(X0r),.X0i(X0i),.X1r(X1r),.X1i(X1i),.X2r(X2r),.X2i(X2i),
.X3r(X3r),.X3i(X3i),.X4r(X4r),
.X4i(X4i),.X5r(X5r),.X5i(X5i),
.X6r(X6r),.X6i(X6i),.X7r(X7r),.X7i(X7i));//,.z1r_c(z1r_c),.z1i_c(z1i_c),.z2r_c(z2r_c),.z2i_c(z2i_c));
    initial
         begin
         clk=1'b0;
         end
        always
         begin
         #5 clk = ~clk;
         end
       initial
              begin
              x0r<={ 16'd65535 , 16'b1100110011001101};//1.2
              x0i<={16'd1 , 16'b1001100110011001};//1.6
              x1r<={ 16'd1 , 16'b0011001100110011};//1.2
              x1i<={16'd1 , 16'b1001100110011001};//1.6
              x2r<={16'd0 , 16'b0101000111101011};//0.32
              x2i<={16'd0 , 16'b1110000101000111};//0.88
              x3r<={ 16'd65535 , 16'b1100110011001101};//1.2
              x3i<={16'd1 , 16'b1001100110011001};//1.6
              x4r<={ 16'd1 , 16'b0011001100110011};//1.2
              x4i<={16'd1 , 16'b1001100110011001};//1.6
              x5r<={16'd0 , 16'b0101000111101011};//0.32
              x5i<={16'd0 , 16'b1110000101000111};//0.88
              x6r<={ 16'd65535 , 16'b1100110011001101};//1.2
              x6i<={16'd1 , 16'b1001100110011001};//1.6
              x7r<={ 16'd1 , 16'b0011001100110011};//1.2
              x7i<={16'd1 , 16'b1001100110011001};//1.6
            // #10 $monitor("a1= %d, a2= %d, b1= %d, b2= %d , clk= %b , wr= %d, wi= %d , z1r= %d, z1i= %d , z2r= %d , z2i= %d, z1r_c= %b , z1i_c= %b , z2r_c= %b , z2i_c=%b",a1,a2,b1,b2,clk,,wr,wi,z1r,z1i,z2r,z2i,z1r_c,z1i_c,z2r_c,z2i_c);    
              /* a1<=1;
               a2<=-1;
               b1<=-1;
               b2<=1;
               wr<=32'b00111110101000111101011100001010;//0.32
               wi<=32'b00111111011000010100011110101110;//0.88*/
               //#10 $display("a1= %f, a2= %f, b1= %f, b2= %f , clk= %b , wr= %f, wi= %f , z1r= %f, z1i= %f , z2r= %f , z2i= %f, z1r_c= %b , z1i_c= %b , z2r_c= %b , z2i_c=%b",(a1 * 2.0**-32),(a2 * 2.0**-32),(b1 * 2.0**-32),(b2 * 2.0**-32),clk,,(wr * 2.0**-32),(wi * 2.0**-32),(z1r * 2.0**-32),(z1i * 2.0**-32),(z2r * 2.0**-32),(z2i * 2.0**-32),z1r_c,z1i_c,z2r_c,z2i_c);    
               end
          // initial    
            //   $display("a1= %f, a2= %f, b1= %f, b2= %f, wr= %f, wi= %f ",(a1 * 2.0**-16),(a2 * 2.0**-16),(b1 * 2.0**-16),(b2 * 2.0**-16),(wr * 2.0**-16),(wi * 2.0**-16));
 endmodule

