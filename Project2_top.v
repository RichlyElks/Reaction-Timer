/*
	The core role of the Project2_top module, besides instantiating the submodules, is to control
	the triggers for which submodules should be executing based on the current state, as well as 
	controlling the output to the 7-segment displays. The player controls the state of the game
	with both buttons, KEY0 and KEY1, the first switch, SW0.
*/

module Project2_top(clk, KEY0, KEY1, SW0, LED0, HEX0, DEC0, HEX1, DEC1, HEX2, DEC2, HEX3, DEC3);
	input clk, KEY0, KEY1, SW0;
	output [6:0] HEX3, HEX2, HEX1, HEX0;
	output DEC3, DEC2, DEC1, DEC0, LED0;
	
	wire clk, delay_finished; 
  	wire [4:0] SEG3, SEG2, SEG1, SEG0;
	wire [4:0] c3, c2, c1, c0;
	wire [3:0] seed = 4'b1001;
	wire [11:0] delay, FinalD, countdown;
	wire [1:0] state;
	wire [3:0] curr3, curr2, curr1, curr0;
	
	reg init_LFSR, init_Delay, reset_BCD, init_BCD, init_HS, led;
	reg [3:0] temp3, temp2, temp1, temp0;

	parameter [1:0] Idle = 2'b00, Start = 2'b01, Finished = 2'b10, High_Score = 2'b11;

	assign SEG3 = temp3;
	assign SEG2 = temp2;
	assign SEG1 = temp1;
	assign SEG0 = temp0;
	assign LED0 = led;	
	
	FSM 				fsm0 	(clk, KEY1, KEY0, SW0, delay_finished, state);
	Clock_divider 	div 	(clk, clk_div);
	LFSR 				gen 	(clk_div, init_LFSR, seed, FinalD);
	Delay 			del 	(clk_div, init_Delay, FinalD, delay_finished, countdown);
	BCD_counter 	cnt 	(clk_div, reset_BCD, init_BCD, c3, c2, c1, c0);
	HighScore 		hs 	(clk, init_HS, temp3, temp2, temp1, temp0, curr3, curr2, curr1, curr0);
	
	SevenSegment sev3 (SEG3, 0, HEX3, DEC3);
	SevenSegment sev2 (SEG2, 1, HEX2, DEC2);
	SevenSegment sev1 (SEG1, 1, HEX1, DEC1);
	SevenSegment sev0 (SEG0, 1, HEX0, DEC0);
	
	always @(posedge clk)
	begin
		if (state == Idle)
		begin
			init_LFSR = 1;
			init_Delay = 0;
			reset_BCD = 1;
			init_BCD = 0;
			init_HS = 0;
			led = 0;
			temp3 = 1;
			temp2 = 0;
			temp1 = 0;
			temp0 = 0;
		end
		else if (state == Start)
		begin
			if (delay_finished)
			begin
				reset_BCD = 0;
				init_BCD = 1;
				led = 1;
				temp3 = c3;
				temp2 = c2;
				temp1 = c1;
				temp0 = c0;
			end
			else
			begin
				init_Delay = 1;
				temp3 = 0;
				temp2 = 0;
				temp1 = 0;
				temp0 = 0;
			end
		end
		else if (state == Finished)
		begin
			init_BCD = 0;
			init_HS = 1;
			led = 0;
		end 
		else if (state == High_Score)
		begin
			temp3 = curr3;
			temp2 = curr2;
			temp1 = curr1;
			temp0 = curr0;
		end
		else
		begin
			temp3 = 1;
			temp2 = 1;
			temp1 = 1;
			temp0 = 1;
		end
	end
	
endmodule 