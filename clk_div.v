`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:57:06 10/19/2015 
// Design Name: 
// Module Name:    clk_div 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module clk_div(input wire clk_in,
					input RST,
					input wire [31:0] clk_divider,
					output reg clk_out
    );
	 
	 reg [31:0] counter;
	 
	 always @(posedge clk_in) begin
		if(RST) 
		begin
			counter <= 0;
			clk_out <= 0;
		end
		else  
			if(counter == clk_divider)
			begin
				counter <= 0;
				clk_out <= 1;
			end
			else
			begin
				counter <= counter + 1;
				clk_out <= 0;
			end
				
	 end

endmodule
