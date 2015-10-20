`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:29:04 10/19/2015 
// Design Name: 
// Module Name:    ssd 
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
module ssd(
				input wire CLK,
				input wire RST,
				input wire [3:0] in,
			   output reg [6:0] out
    );
	 
	 always @(posedge CLK) begin
		if(RST)
			out <= 0;
		else begin
			case(in)
				4'h0: out <= 7'b0111111;
				4'h1: out <= 7'b0000110;
				4'h2: out <= 7'b1011011;
				4'h3: out <= 7'b1001111;
				4'h4: out <= 7'b1100110;
				4'h5: out <= 7'b1101101;
				4'h6: out <= 7'b1111101;
				4'h7: out <= 7'b0000111;
				4'h8: out <= 7'b1111111;
				4'h9: out <= 7'b1101111;
				default: out <= 7'b1000000;
			endcase
		end
	 end

endmodule
