`timescale 1ns / 1ps


module gfx(
    input wire [15:0] i_x,
    input wire [15:0] i_y,
    input wire i_clk,
    input wire i_rst,
    input wire i_v_sync,
    input wire btn0,
    input wire btn1,
    input wire btn2,
    input wire btn3,
    output reg [7:0] o_red,
    output reg [7:0] o_green,
    output reg [7:0] o_blue,
    output reg o_done

    );
    wire bg_hit, sprite_hit;
    wire [7:0] bg_red;
    wire [7:0] bg_green;
    wire [7:0] bg_blue;
    wire done;
    wire [7:0] sprite_red;
    wire [7:0] sprite_green;
    wire [7:0] sprite_blue;
   
   test_card_simple test_card_simple_1(
            .i_x (i_x),
            .i_y (i_y),
            .i_clk (i_clk),
            .i_rst(i_rst),
            .o_red      (bg_red),
            .o_green    (bg_green),
            .o_blue     (bg_blue)
            );
  
     sprite_compositor sprite_compositor_1 (
        .i_x        (i_x),
        .i_y        (i_y),
        .i_v_sync   (i_v_sync),
        .btn0       (btn0),
        .btn1       (btn1),
        .btn2       (btn2),
        .btn3       (btn3),
        .o_red      (sprite_red),
        .o_green    (sprite_green),
        .o_blue     (sprite_blue),
        .o_sprite_hit   (sprite_hit)
    );
  
    always@(*) begin
        if(sprite_hit==1) begin
            o_red=sprite_red;
            o_green=sprite_green;
            o_blue=sprite_blue;
        end
        else begin
            o_red=bg_red;
            o_green=bg_green;
            o_blue=bg_blue;
        end
    end
    
    always@(posedge i_clk) begin
        o_done=done;
    end
    
endmodule