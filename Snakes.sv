module Snakes (clk, btn, led);

input clk;						// clock
input btn;						// button to switch between patterns
output wire led [41:0];		// array of leds

wire stat[41:0];				// status of leds


reg btn_prev;					// to record button state
wire re_btn; 					// rising edge of btn

int pat[0:5][0:40];	// 2d array of patterns

reg [31:0] i = 32'b0, j = 32'b1, k = 32'b10, l, ctr = 32'b0, mod = 32'b0;

/*
variables used:
  
  i, j, k for controlling head, body, tail of the snake
  l for using in a loop
  ctr for counting 
  mod for modes 
 
 */

int mdl[0:5] = '{16,30,37,30,20,39}; // mode limit (the index where it loops back to zero)

initial
begin

	// Some cool patterns
	// led mapping of numbers: https://imgur.com/a/UvzqaCH
	
	pat[0] = '{0,7,14,21,28,35,36,37,38,31,24,17,10,3,4,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
	pat[1] = '{3,2,6,5,0,7,8,13,11,10,17,16,20,19,14,21,22,27,25,24,31,30,34,33,28,35,36,41,39,38,0,0,0,0,0,0,0,0,0,0,0};
	pat[2] = '{0,1,2,3,4,5,7,8,9,10,11,12,14,15,16,17,18,19,21,22,23,24,25,26,28,29,30,31,32,33,35,36,37,38,39,40,35,0,0,0,0};
	pat[3] = '{4,5,0,1,2,11,12,7,8,9,18,19,14,15,16,25,26,21,22,23,32,33,28,29,30,39,40,35,36,37,0,0,0,0,0,0,0,0,0,0,0};
	pat[4] = '{3,10,17,24,31,38,37,41,34,27,20,13,6,5,0,7,14,21,28,35,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
	pat[5] = '{6,13,8,7,12,11,10,9,13,6,5,0,1,2,3,4,6,13,20,27,34,41,36,35,40,39,38,37,41,34,33,28,29,30,31,32,34,41,0,0,0};

end

always @ (posedge clk)
	begin	
	
	btn_prev = btn; // to keep track of button state
	
	if(re_btn)	    // if button on rising edge then...
	begin
		
		// initialize positions for head, body, tail of the snake
		i = 32'b0;
		j = 32'b1;
		k = 32'b10;
		
		// initialize all leds to be off
		for(l = 0; l < 42; l = l + 1)
			stat[l] = 1'b1;
	
		// change the moving pattern
		if(mod == 0)		 mod = 1;
		else if (mod == 1) mod = 2;
		else if (mod == 2) mod = 3;
		else if (mod == 3) mod = 4;
		else if (mod == 4) mod = 5;
		else mod = 0;
	
	end
	
		ctr = ctr + 1'b1;  // always increase the counter
		
		if (ctr > 5000000) // clock is 50 Mhz, change state every 0.1 sec approximately
		begin
		
			// turn off current values
			stat[pat[mod][i]] = 1'b1;
			stat[pat[mod][j]] = 1'b1;
			stat[pat[mod][k]] = 1'b1;
			
			// turn on next values, loop back to zero if reached the limit
			i = i + 1;    		    
			if (i == mdl[mod]) i = 0;
			stat[pat[mod][i]] = 1'b0;
				
			j = j + 1;
			if (j == mdl[mod]) j = 0;
			stat[pat[mod][j]] = 1'b0;
				
			k = k + 1;
			if (k == mdl[mod]) k = 0;
			stat[pat[mod][k]] = 1'b0;
			
			// reset the counter
			ctr = 32'b0;
		
		end

end

// to indicate rising edge of button
assign re_btn = ~btn_prev & btn;

// assign led to their states
assign led[0] = stat[0];
assign led[1] = stat[1];
assign led[2] = stat[2];
assign led[3] = stat[3];
assign led[4] = stat[4];
assign led[5] = stat[5];
assign led[6] = stat[6];
assign led[7] = stat[7];
assign led[8] = stat[8];
assign led[9] = stat[9];
assign led[10] = stat[10];
assign led[11] = stat[11];
assign led[12] = stat[12];
assign led[13] = stat[13];
assign led[14] = stat[14];
assign led[15] = stat[15];
assign led[16] = stat[16];
assign led[17] = stat[17];
assign led[18] = stat[18];
assign led[19] = stat[19];
assign led[20] = stat[20];
assign led[21] = stat[21];
assign led[22] = stat[22];
assign led[23] = stat[23];
assign led[24] = stat[24];
assign led[25] = stat[25];
assign led[26] = stat[26];
assign led[27] = stat[27];
assign led[28] = stat[28];
assign led[29] = stat[29];
assign led[30] = stat[30];
assign led[31] = stat[31];
assign led[32] = stat[32];
assign led[33] = stat[33];
assign led[34] = stat[34];
assign led[35] = stat[35];
assign led[36] = stat[36];
assign led[37] = stat[37];
assign led[38] = stat[38];
assign led[39] = stat[39];
assign led[40] = stat[40];
assign led[41] = stat[41];
	
endmodule 