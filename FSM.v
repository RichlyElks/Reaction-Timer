/*
	The Finite State Machine has four states:
		A - Idle
		B - Start
		C - Finish
		D - High Score
	Idle represents the initial state which waits for the player to either
	hit the button, Key, to proceed to the Start state or the switch, SW, which
	displays the High Score state. The Start state waits until the Delay module
	has signaled that the countdown is complete before accepting the button as 
	a signal to transition to the Finish state. At any point, if Reset is pressed,
	the player returns to the Idle state.
*/

module FSM(Clock, Reset, Key, SW, Delay, z);
	input Clock, Reset, Key, SW, Delay;
	output [1:0] z;
	reg [1:0] y;
	parameter [1:0] A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
	
	always @(negedge Reset, posedge Key)
		if (Reset == 0) y <= A;
		else
			case (y)
				A: if (SW)
					begin
						if (Key)		y <= D;
					end
					else if (Key)	y <= B;
					else				y <= A;
				B: if (Delay)
					begin
						if (Key)		y <= C;
					end
					else				y <= B;
				C: if (Key)			y <= A;
					else 				y <= C;
				D: if (SW == 0)
					begin
						if (Key)		y <= A;
					end
					else				y <= D;

				default:		y <= 2'b00;
			endcase
			
	assign z = y;
	
endmodule 