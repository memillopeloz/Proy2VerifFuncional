`ifndef SCOREBOARD_SV
`define SCOREBOARD_SV

class scoreboard;
	int unsigned dfifo[$]; // data fifo
	int unsigned afifo[$]; // address  fifo
	int unsigned bfifo[$]; // Burst Length fifo
    
    // Control flags
    int unsigned error_count;
    int unsigned loop_count;
    
    function new();
		this.error_count = 0;
        this.loop_count = 0;
	endfunction
endclass

`endif
