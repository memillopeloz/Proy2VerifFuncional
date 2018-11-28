`ifndef ASSERTIONS_V
`define ASSERTIONS_V

`include "whitebox_intf.sv"

module assertions(whitebox_intf wbox_intf);

sequence are_wb_sigs_known;
	!($isunknown({	wbox_intf.wb_stb_i	,	wbox_intf.wb_ack_o	,
					wbox_intf.wb_addr_i	,	wbox_intf.wb_we_i	,
					wbox_intf.wb_dat_i	,	wbox_intf.wb_sel_i	,
					wbox_intf.wb_dat_o	,	wbox_intf.wb_cyc_i	,
					wbox_intf.wb_cti_i	}));
endsequence

property prop_wb_sigs_init_during_rst;
	@(posedge wbox_intf.wb_clk_i) $rose(wbox_intf.wb_rst_i) |=> wbox_intf.wb_rst_i throughout are_wb_sigs_known;
endproperty

property prop_rst_at_least_one_cycle;
	@(posedge wbox_intf.wb_clk_i) $rose(wbox_intf.wb_rst_i) |=> wbox_intf.wb_rst_i [*1:$];
endproperty

wb_rule_3_00 : assert property (prop_wb_sigs_init_during_rst) $display("wishbone rule 3.00 passed");
	else $error("wishbone rule 3.00 Failed");
wb_rule_3_05 : assert property (prop_rst_at_least_one_cycle) $display("wishbone rule 3.05 passed");
	else $error("wishbone rule 3.05 Failed");

endmodule;

`endif