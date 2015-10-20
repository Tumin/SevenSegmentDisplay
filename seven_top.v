`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:35:42 10/19/2015 
// Design Name: 
// Module Name:    seven_top 
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
module seven_top(input wire CLK_50MHZ,
					  input wire RST,
					  output reg ssdsel,
					  output reg [6:0] ssdout
    );
	 
	wire ssdsel_en;
	wire ssdcount_en;
	
	reg [3:0] ssd1_in;
	wire [6:0] ssd1_out;
	
	reg [3:0] ssd2_in;
	wire [6:0] ssd2_out;
	
	// Instantiate the clock-divided enables, pulse high for one clock cycle every clock_div+1 cycles
	clk_div div0(.clk_in(CLK_50MHZ),.RST(RST),.clk_divider(32'd50000 - 1),.clk_out(ssdsel_en));
	clk_div div1(.clk_in(CLK_50MHZ),.RST(RST),.clk_divider(32'd50000000 - 1),.clk_out(ssdcount_en));
			
	// Instantiate the SSD decoders
	ssd ssd1(.CLK(CLK_50MHZ),.RST(RST),.in(ssd1_in),.out(ssd1_out));
	ssd ssd2(.CLK(CLK_50MHZ),.RST(RST),.in(ssd2_in),.out(ssd2_out));
	
	/*
		This block determines which digit is being serviced by which of the 
		SSD decoders during each refresh window
		
		Block diagram is a 2-to-1 mux with an enable
		that switches when the counter reaches switching value
	*/
	always @(posedge CLK_50MHZ) begin
		if(RST) begin
			ssdsel <= 0;
			ssdout <= 0;
		end
		else
		begin
			if(ssdsel_en) begin
				ssdsel <= ~ssdsel;
				ssdout <= ssdsel ? ssd1_out : ssd2_out;
			end
			else begin
			end
		end
	end
	
	/*
		Counter controls for both of the SSD decoders to form a
		2-digit value
	*/
	always @(posedge CLK_50MHZ) 
	begin
		if(RST)
		begin
			ssd1_in <= 0;
			ssd2_in <= 0;
		end
		else begin
			if(ssdcount_en) 
			begin
				if(ssd1_in == 9) 
				begin
					ssd1_in <= 0;
					if(ssd2_in == 9)
						ssd2_in <= 0;
					else
						ssd2_in <= ssd2_in + 1;
				end
				else
					ssd1_in <= ssd1_in + 1;
			end
			else
			begin
				ssd1_in <= ssd1_in;
				ssd2_in <= ssd2_in;
			end
		end
	end
	
endmodule
