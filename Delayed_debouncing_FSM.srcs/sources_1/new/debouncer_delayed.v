`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.06.2024 18:01:59
// Design Name: 
// Module Name: debouncer_delayed
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


module debouncer_delayed
    #(parameter clk_tp = (1/1000000000))(
    input clk,
    input noisy,
    input reset_n,
    output Q
    );
    wire timer_done,timer_reset;
    //value is final value of clk
    localparam value = (20.0 / 1000000.0) / clk_tp - 1;
    deboucer D(
    .clk(clk),
    .timer_done(timer_done),
    .noisy(noisy),
    .reset_n(reset_n),
    .Q(Q),
    .timer_reset(timer_reset)
    );
    timer #(.final_value(value))T(
    .enable(!timer_reset),
    .reset_n(!timer_reset),
    .clk(clk),
    .tick(timer_done)
    );
endmodule
