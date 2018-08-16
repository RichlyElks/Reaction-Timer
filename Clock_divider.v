/*
	To divide the 50MHz clock on the DE10-Lite, assign parameter n as
	the value by which you would like to divide the clock (must be less 
	than 32-bits). For example, n = 50000 equates to a 1kHz clock signal.
*/

module Clock_divider(clk_50MHz, clk_Mod);
	parameter n = 50000;	
	input clk_50MHz;
	output reg clk_Mod;
	reg [31:0] count;

always @(posedge clk_50MHz)
begin
	count = count + 1;
	if (count == n)
	begin
		clk_Mod = 1;
		count = 0;
	end
	else
		clk_Mod = 0;
end

endmodule