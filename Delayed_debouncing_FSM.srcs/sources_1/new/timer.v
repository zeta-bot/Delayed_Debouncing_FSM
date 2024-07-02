`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.06.2024 16:13:31
// Design Name: 
// Module Name: timer
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


module timer
    #(parameter bits = 8)(
    input enable,
    input reset_n,
    input clk,
    input final_value,
    output tick
    );
    //localparam bits = $clog2(final_value);
    reg [bits-1:0]Q_next,Q_reg;
    wire done;
    always@(posedge clk, negedge reset_n)
    begin
        if(!reset_n)
            Q_reg <= 'b0;
        else if(enable)
            Q_reg <= Q_next;
        else
            Q_reg <= Q_reg;
    end
    always @(Q_reg,done)
    begin
        if(!done)
            Q_next = Q_reg + 1;
        else
            Q_next = 'b0;
    end
    assign done = ( Q_reg == final_value); 
    assign tick = done;
endmodule
