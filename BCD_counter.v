/*
	The BCD_counter module begins and outputs a counter across four
	digits, BCD0-3, when the input signal Enable is set high. The
	count is synchronized to the input clock signal, and can be reset if 
	Reset signal is set high.
*/

module BCD_counter(Clock, Reset, Enable, BCD3, BCD2, BCD1, BCD0);
	input Clock, Reset, Enable;
	output reg [4:0] BCD3, BCD2, BCD1, BCD0;
	
	reg initiate;
	
	always @(posedge Enable)
	begin
		if (Enable == 1)
			initiate = 1;
		else
			initiate = 0;
	end
	
	always @(posedge Clock)
	begin 
		if (Reset)
		begin
			BCD0 <= 0;
			BCD1 <= 0;
			BCD2 <= 0;
			BCD3 <= 0;
		end
		// A series of conditionals increments the adjacent digit once
		// it reaches a desired value, '9' in this case
		else if (initiate == 1)
		begin
			if (BCD0 == 4'b1001)
			begin
				BCD0 <= 0;
				if (BCD1 == 4'b1001)
				begin 
					BCD1 <= 0;
					if (BCD2 == 4'b1001)
					begin
						BCD2 <= 0;
						if (BCD3 == 4'b1001)
							BCD3 <= 0;
						else
							BCD3 = BCD3 + 1;
					end
					else
						BCD2 = BCD2 + 1;
				end
				else
					BCD1 = BCD1 + 1;
			end
			else
				BCD0 <= BCD0 + 1;
		end
	end
	
endmodule
			