`timescale 1ns / 1ps
`default_nettype none

module test_card_simple #(H_RES=800, V_RES=600) (
    input wire signed [15:0] i_x,
    input wire signed [15:0] i_y,
    input wire i_clk,
    input wire i_rst,
    output wire [7:0] o_red,
    output wire [7:0] o_green,
    output wire [7:0] o_blue,
    output wire o_done
    );

    // Registers to store z value
    reg signed [31:0] zn_Re;
    reg signed [31:0] zn_Im;
    
    // Register for counter
    reg [6:0] n;
    reg done;
    // Register for RGB
    reg [7:0] red;
    reg [7:0] green;
    reg [7:0] blue;
    
    // Scaling x axis into [-2, 1.125], divider: 64*4
    wire signed [31:0] scaled_x = (i_x - 512);
    
    // Scaling y axis into [-1.171875, 1.171875], divider: 64*4
    wire signed [31:0] scaled_y = (300 - i_y);
    
    // Absolute value of z
    wire signed [31:0] abs_z_sq = (((zn_Re*zn_Re) + (zn_Im*zn_Im)) >>> 16);
    
    // Boolean value to determine convergence or divergence, 2^2->1024
    wire is_convergence = (abs_z_sq <= 3'd4) ? 1'b1 : 1'b0;
    
    // Wires to store c value
    wire signed [31:0] z0_Re = scaled_x;
    wire signed [31:0] z0_Im = scaled_y;
    
   //---------------Sequential--------------//
    // Sequantial logic for updating z value and output value
    always @ (posedge i_clk) begin
        if (done) begin
            zn_Re <= 1'b0;
            zn_Im <= 1'b0;
            n <= 1'b0;
            done <= 1'b0;
        end
        else begin
            if (n==0) begin
                zn_Re <= z0_Re;
                zn_Im <= z0_Im;
                n <= n+1;
            end
            else begin
                if (abs_z_sq <= 3'd4 && n <= 100) begin
                    zn_Re <= (((zn_Re*zn_Re) - (zn_Im*zn_Im))>>>8) + z0_Re;
                    zn_Im <= ((2*zn_Re*zn_Im)>>>8) + z0_Im;
                    n <= n+1;
                end
                else begin
                    done <= 1'b1;
                end
            end
        end    
    end
    
    always @ (posedge i_clk) begin
//        if (is_convergence) begin   //수렴하는 경우
//            red <= 8'd82;
//            green <= 8'd34;
//            blue <= 8'd5;
//        end
//        else begin                  //발산하는 경우
        if (done) begin 
            if (n==0) begin
                red <= 8'd0;
                green <= 8'd0;
                blue <= 8'd0;
            end
            else if (n==1) begin
                red <= 8'd0;
                green <= 8'd0;
                blue <= 8'd8;
            end
            else if (n==2) begin
                red <= 8'd0;
                green <= 8'd0;
                blue <= 8'd16;
            end
            else if (n==3) begin
                red <= 8'd4;
                green <= 8'd0;
                blue <= 8'd31;
            end
            else if (n==4) begin
                red <= 8'd9;
                green <= 8'd1;
                blue <= 8'd47;
            end
            else if (n==5) begin
                red <= 8'd6;
                green <= 8'd2;
                blue <= 8'd60;
            end
            else if (n==6) begin
                red <= 8'd4;
                green <= 8'd4;
                blue <= 8'd73;
            end
            else if (n==7) begin
                red <= 8'd2;
                green <= 8'd5;
                blue <= 8'd86;
            end
            else if (n==8) begin
                red <= 8'd0;
                green <= 8'd7;
                blue <= 8'd100;
            end
            else if (n==9) begin
                red <= 8'd6;
                green <= 8'd25;
                blue <= 8'd119;
            end
            else if (n==10) begin
                red <= 8'd12;
                green <= 8'd44;
                blue <= 8'd138;
            end
            else if (n==11) begin
                red <= 8'd18;
                green <= 8'd63;
                blue <= 8'd157;
            end
            else if (n==12) begin
                red <= 8'd24;
                green <= 8'd82;
                blue <= 8'd177;
            end
            else if (n==13) begin
                red <= 8'd40;
                green <= 8'd103;
                blue <= 8'd193;
            end
            else if (n==14) begin
                red <= 8'd57;
                green <= 8'd125;
                blue <= 8'd209;
            end
            else if (n==15) begin
                red <= 8'd95;
                green <= 8'd153;
                blue <= 8'd219;
            end
            else if (n==16) begin
                red <= 8'd134;
                green <= 8'd181;
                blue <= 8'd229;
            end
            else if (n==17) begin
                red <= 8'd172;
                green <= 8'd208;
                blue <= 8'd238;
            end
            else if (n==18) begin
                red <= 8'd211;
                green <= 8'd236;
                blue <= 8'd248;
            end
            else if (n==19) begin
                red <= 8'd226;
                green <= 8'd234;
                blue <= 8'd219;
            end
            else if (n==20) begin
                red <= 8'd241;
                green <= 8'd233;
                blue <= 8'd191;
            end
            else if (n==21) begin
                red <= 8'd244;
                green <= 8'd217;
                blue <= 8'd143;
            end
            else if (n==22) begin
                red <= 8'd248;
                green <= 8'd201;
                blue <= 8'd95;
            end
            else if (n==23) begin
                red <= 8'd251;
                green <= 8'd185;
                blue <= 8'd47;
            end
            else if (n==24) begin
                red <= 8'd255;
                green <= 8'd170;
                blue <= 8'd0;
            end
            else if (n==25) begin
                red <= 8'd255;
                green <= 8'd170;
                blue <= 8'd0;
            end
            else if (n==26) begin
                red <= 8'd204;
                green <= 8'd128;
                blue <= 8'd0;
            end
            else if (n==27) begin
                red <= 8'd178;
                green <= 8'd107;
                blue <= 8'd0;
            end
            else if (n==28) begin
                red <= 8'd153;
                green <= 8'd87;
                blue <= 8'd0;
            end
            else if (n==29) begin
                red <= 8'd130;
                green <= 8'd70;
                blue <= 8'd1;
            end
            else if (n==30) begin
                red <= 8'd106;
                green <= 8'd52;
                blue <= 8'd3;
            end
            else if (n>=31) begin
                red <= 8'd82;
                green <= 8'd34;
                blue <= 8'd5;
            end
        end
    end
    
    assign o_red = red;
    assign o_green = green;
    assign o_blue = blue;
    assign o_done = done;
    
endmodule
//nogada
