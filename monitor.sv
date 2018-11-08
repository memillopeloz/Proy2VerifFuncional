`ifndef MONITOR_SV
`define MONITOR_SV

`include "sdrc_intf.sv"
`include "scoreboard.sv"

class monitor;
	scoreboard sb;
	virtual sdrc_if intf;
	
	function new(virtual sdrc_if intf, scoreboard sb);
		this.intf = intf;
		this.sb = sb;
	endfunction
	
	task Burst_read();
		int unsigned exp_addr;
		int unsigned exp_data;
		int j;
		reg [7:0]  bl;
		bl = sb.bfifo.pop_front(); 
		@ (negedge intf.sys_clk);
        
		for(j=0; j < bl; j++)
		begin
			exp_addr	= sb.afifo.pop_front();
			exp_data	= sb.dfifo.pop_front(); // Expected Read Data
			
			intf.wb_stb_i        = 1;
			intf.wb_cyc_i        = 1;
			intf.wb_we_i         = 0;
			intf.wb_addr_i       = exp_addr;
			do begin
			 @ (posedge intf.sys_clk);
			end while(intf.wb_ack_o == 1'b0);
			if(exp_data != intf.wb_dat_o || exp_addr != intf.wb_addr_i) begin // Compare expected value from scoreboard and compare with DUT output, addresses as well
				$display(" * ERROR * Read [ value/addr ] -> [ %x,%x ] ::: SB [ value/addr ] -> [ %x,%x ] ", intf.wb_dat_o, intf.wb_addr_i, exp_data, exp_addr );
                this.sb.error_count += 1;
			end 
			else begin
				$display(" *SUCCESS* Read [ value/addr ] -> [ %x,%x ] ::: SB [ value/addr ] -> [ %x,%x ] ", intf.wb_dat_o, intf.wb_addr_i, exp_data, exp_addr );
			end
            this.sb.loop_count += 1;
			@ (negedge intf.sdram_clk);
		end
		intf.wb_stb_i        = 0;
		intf.wb_cyc_i        = 0;
		intf.wb_we_i         = 'hx;
		intf.wb_addr_i       = 'hx;
		
	endtask

endclass

`endif
