`ifndef MONITOR_SV
`define MONITOR_SV

`include "sdrc_intf.sv"
`include "scoreboard.sv"

class monitor;
	scoreboard sb;
	virtual sdrc_if intf;
	reg [31:0]   exp_data;
	
	function new(virtual sdrc_if intf, scoreboard sb);
		this.intf = intf;
		this.sb = sb;
	endfunction
	
	/*
	task check();
		logic exp_addr;
		logic exp_data;
		forever
		@ (negedge intf.sys_clk)
		exp_data        = sb.dfifo.pop_front(); // Expected Read Data
		exp_addr		= sb.afifo.pop_front(); // Expected Read Address
		
		if(exp_data != intf.wb_dat_o && exp_addr != intf.wb_addr_i) // Compare expected value from scoreboard and compare with DUT output, addresses as well
			$display(" * ERROR * Read [ value/addr ] -> [ %b,%b ] ::: SB [ value/addr ] -> [ %b,%b ] ", intf.wb_addr_i, intf.wb_dat_o, exp_data, exp_addr );
		else
			$display(" *SUCCESS* Read [ value/addr ] -> [ %b,%b ] ::: SB [ value/addr ] -> [ %b,%b ] ", intf.wb_addr_i, intf.wb_dat_o, exp_data, exp_addr );
	endtask
	*/

endclass

`endif