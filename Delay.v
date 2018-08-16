/*
	The Delay module creates a countdown of the amount given as Delay[11:0]
	synchronized to the input clock. When the countdown is completed, the finished
	value is set high. The count output is available for debugging purposes.
*/

module Delay(Clock, Control, Delay, finished, count);
	input Clock, Control;
	input [11:0] Delay;
	
	reg initiate, Z;
	output reg finished;
	output reg [11:0] count;	
	
	// Initiate acts as the impetus for the second always block to execute
	always @(Control)
	begin
		if (Control == 1)
			initiate = 1;
		else
			initiate = 0;
	end
	
	always @(posedge Clock)
	begin
		if (initiate == 1)
		begin
			if (count == 0)
				finished = 1;
			else
				count = count - 1;
		end
		else
		begin
			count = Delay;
			finished = 0;
		end
	end

endmodule 