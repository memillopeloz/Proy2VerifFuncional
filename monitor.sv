class monitor;
	scoreboard sb;
	virtual intf_cnt intf;
	reg [31:0]   exp_data;

	function new(virtual intf_cnt intf, scoreboard sb);
		this.intf = intf;
		this.sb = sb;
	endfunction

	task check();
		forever
		@ (negedge intf.sys_clk)
		exp_data        = sb.dfifo.pop_front(); // Expected Read Data
		exp_addr		= sb.afifo.pop_front(); // Expected Read Address

		if(exp_data != intf.app_rd_data && exp_addr != intf.app_last_rd) // Compare expected value from scoreboard and compare with DUT output, addresses as well
			$display(" * ERROR * Read [ value/addr ] -> [ %b,%b ] ::: SB [ value/addr ] -> [ %b,%b ] ", intf.wb_addr_i, intf.wb_dat_o, exp_data, exp_addr );
		else
			$display(" *SUCCESS* Read [ value/addr ] -> [ %b,%b ] ::: SB [ value/addr ] -> [ %b,%b ] ", intf.wb_addr_i, intf.wb_dat_o, exp_data, exp_addr );
	endtask

endclass

