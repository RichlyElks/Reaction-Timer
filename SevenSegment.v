module SevenSegment(bcd, d, seg, dec);
	input [4:0] bcd;
	input d;
	output reg [6:0] seg;
	output dec;
	
	always @(bcd)
		case(bcd)
			0: seg[6:0] = 7'b1000000;
			1: seg[6:0] = 7'b1111001;
			2: seg[6:0] = 7'b0100100;
			3: seg[6:0] = 7'b0110000;
			4: seg[6:0] = 7'b0011001;
			5: seg[6:0] = 7'b0010010;
			6: seg[6:0] = 7'b0000010;
			7: seg[6:0] = 7'b1111000;
			8: seg[6:0] = 7'b0000000;
			9: seg[6:0] = 7'b0010000;
			10: seg[6:0] = 7'b0001000;
			11: seg[6:0] = 7'b0000011;
			12: seg[6:0] = 7'b1000110;
			13: seg[6:0] = 7'b0100001;
			14: seg[6:0] = 7'b0000110;
			15: seg[6:0] = 7'b0001110;
			default: seg = 7'b1000000;
		endcase
	
	assign dec = d;

endmodule
