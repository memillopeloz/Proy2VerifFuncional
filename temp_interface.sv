 interface intf_cnt(input clk);

	logic sys_clk;

    logic wo_stb_i;
	logic wb_cyc_i;
	logic wb_we_i;
	logic wb_sel_i;
	logic wb_addr_i;
	logic wb_dat_i;
	logic wb_dat_o;

	logic wb_ack_o;

 endinterface
