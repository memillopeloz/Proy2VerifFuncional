`ifndef DRIVER_SV
`define DRIVER_SV

`include "transaction.sv"
`include "sdrc_intf.sv"
`include "scoreboard.sv"

class driver;
	scoreboard sb;
	virtual sdrc_if intf;
	
	function new(virtual sdrc_if intf,scoreboard sb);
		this.intf = intf;
		this.sb = sb;
	endfunction
	
	task reset();  // Reset method
		intf.wb_rst_i = 1'h1;
		#100
		intf.wb_rst_i = 1'h0;
		#10000;
		intf.wb_rst_i = 1'h1;
		#1000;
		wait(intf.sdr_init_done == 1);
		#1000;
	endtask
	
	task drive(input transaction trans);
		
		sb.bfifo.push_back(trans.bl);
		
		@ (negedge intf.sys_clk);
		$display("Write Address: %x, Burst Size: %d", trans.address, trans.bl);
		
		for(int i=0; i < trans.bl; i++)
		begin
			
			intf.wb_stb_i        = 1;
			intf.wb_cyc_i        = 1;
			intf.wb_we_i         = 1;
			intf.wb_sel_i        = 4'b1111;
			intf.wb_addr_i       = trans.address+i;
			intf.wb_dat_i        = $random & 32'hFFFFFFFF;
			
			sb.afifo.push_back(intf.wb_addr_i);
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

`endif
