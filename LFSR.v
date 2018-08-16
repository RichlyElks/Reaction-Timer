/*
	The Linear Feedback Shift Register accepts the divided clock as input as well
	as an enable signals which triggers the output to be the current shifted values
	of the given seed.
*/

module LFSR(Clock, Enable, Seed, FinalD);
	input Clock, Enable;
	input [3:0] Seed;
	reg [3:0] Delay;
	output reg [11:0] FinalD;
	
	always @(posedge Clock)
	begin
		if (Delay == 0)
			Delay <= Seed;
		else
			Delay <= {Delay[2], Delay[1], Delay[0], (Delay[3] ^ Delay[2])};
	end
	
	always @(posedge Clock)
	begin
		if (Enable)
		begin
			FinalD[11:8] 	<= Delay;
			FinalD[7:4]		<= ~Delay;
			FinalD[3:0]		<= 0;
		end
	end
	
endmodule 