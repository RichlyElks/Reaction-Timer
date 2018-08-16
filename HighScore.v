/*
	The HighScore module executes when the Compare input signal is set to high,
	at which point it concatenates the four input values, New(0-3), to a single 
	value, n[15:0]. This value represents the most recent time which is then
	compared to the current quickest time, c[15:0]. If it is a smaller value,
	it is replaced as the current high score. The current high score is fed as 
	output to Current(0-3).
*/

module HighScore(Clock, Compare, New3, New2, New1, New0, Current3, Current2, Current1, Current0);
	input Clock, Compare;
	input [3:0] New3, New2, New1, New0;
	output [3:0] Current3, Current2, Current1, Current0;
	
	assign n[15:12] = New3;
	assign n[11:8] = New2;
	assign n[7:4] = New1;
	assign n[3:0] = New0;
	
	assign Current3 = c[15:12];
	assign Current2 = c[11:8];
	assign Current1 = c[7:4];
	assign Current0 = c[3:0];
	
	wire [15:0] n;
	reg [15:0] c;
	
	always @(posedge Compare)
	begin
		if (Compare)
		begin
			// Ensure the initial high score isn't 0
			if (c == 0)
				c = n;
			else if (n < c)
				c = n;
			else
				c = c;
		end
	end
	
endmodule 