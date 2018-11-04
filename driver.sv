class driver;
	scoreboard sb;
	virtual intf_cnt intf;

	function new(virtual intf_cnt intf,scoreboard sb);
		this.intf = intf;
		this.sb = sb;
	endfunction

	task reset();  // Reset method
		intf.data = 0;
		@ (negedge intf.clk);
			intf.reset = 1;
		@ (negedge intf.clk);
			intf.reset = 0;
		@ (negedge intf.clk);
			intf.reset = 1;
	endtask

	task drive;
	transaction trans;
		sb.afifo.push_back(trans.address);
		sb.bfifo.push_back(trans.bl);

		@ (negedge intf.sys_clk);
		$display("Write Address: %x, Burst Size: %d", trans.address, trans.bl);

		for(int i=0; i < trans.bl; i++)
		begin
			intf.wb_stb_i        = 1;
			intf.wb_cyc_i        = 1;
			intf.wb_we_i         = 1;
			intf.wb_sel_i        = 4'b1111;
			intf.wb_addr_i       = trans.address[31:2]+i;// ESTA PICHA QUE?, ojo que el write address se modifica con el valor del loop, ojo en el monitor
			intf.wb_dat_i        = trans.value;
			sb.dfifo.push_back(intf.wb_dat_i); // send written value to scoreboard

			do begin
				@ (posedge intf.sys_clk);
			end while(intf.wb_ack_o == 1'b0);

			@ (negedge intf.sys_clk);
			$display("Status: Burst-No: %d  WriteAddress: %x  WriteData: %x ", i, intf.wb_addr_i, intf.wb_dat_i);
		end
		intf.wb_stb_i        = 0;
		intf.wb_cyc_i        = 0;
		intf.wb_we_i         = 'hx;
		intf.wb_sel_i        = 'hx;
		intf.wb_addr_i       = 'hx;
		intf.wb_dat_i        = 'hx;
	endtask
endclass

