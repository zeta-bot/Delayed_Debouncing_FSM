`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.06.2024 17:01:57
// Design Name: 
// Module Name: deboucer
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


module deboucer(
    input clk,
    input timer_done,
    input noisy,
    input reset_n,
    output Q,
    output timer_reset
    );
    reg [1:0]s_reg,s_next;
    parameter s0 = 2'b00, s1 = 2'b01 ,s2 = 2'b10 , s3 = 2'b11;
    always @(negedge reset_n,posedge clk)
    begin
        if(!reset_n)
            s_reg <= 'b0;
        else
            s_reg <= s_next;
    end
    
    //next state logic
    always @(*)
    begin
        s_next = s_reg;
        case(s_reg)
            s0:
                if(!noisy)
                    s_next = s_reg;
                else if(noisy)
                    s_next = s1;
            s1:
                if(!noisy)
                    s_next = s0;
                else if(noisy & (!timer_done))
                    s_next = s1;
                else if(noisy & timer_done)
                    s_next = s2;
            s2:
                if(!noisy)
                    s_next = s3;
                else if(noisy)
                    s_next = s2;
            s3:
                if(noisy)
                    s_next = s2;
                else if(!noisy & !timer_done)
                    s_next = s3;
                else if(!noisy & timer_done)
                    s_next = s0;
             default:
                s_next = s0;
        endcase
    end
      assign Q = ((s_reg == s2) | (s_reg == s3));
      assign timer_reset = ((s_reg == s0) | (s_reg == s2));
    
    
endmodule
