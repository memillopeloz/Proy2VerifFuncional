`ifndef ASSERTIONS_V
`define ASSERTIONS_V

`include "whitebox_intf.sv"

module assertions(whitebox_intf wbox_intf);

sequence are_wb_sigs_in_default;
	!wbox_intf.wb_stb_i and !wbox_intf.wb_ack_o and (wbox_intf.wb_addr_i == 0) and !wbox_intf.wb_we_i  and (wbox_intf.wb_dat_i == 0) and (wbox_intf.wb_sel_i == 0) and
	!wbox_intf.wb_cyc_i and (wbox_intf.wb_cti_i == 0) and (wbox_intf.wb_dat_o == 0);
endsequence

sequence nop_cmd;
	wbox_intf.sdram_ras_n and wbox_intf.sdram_cas_n and wbox_intf.sdram_we_n;
endsequence;

sequence inhibit_cmd;
	wbox_intf.sdram_ras_n == 1'bx and wbox_intf.sdram_cas_n == 1'bx and wbox_intf.sdram_we_n == 1'bx;
endsequence;

sequence precharge_cmd;
	!wbox_intf.sdram_ras_n and wbox_intf.sdram_cas_n and !wbox_intf.sdram_we_n;
endsequence

sequence autorefresh_cmd;
	!wbox_intf.sdram_ras_n and !wbox_intf.sdram_cas_n and wbox_intf.sdram_we_n;
endsequence

property prop_sdram_correct_init;
	@(posedge wbox_intf.sdram_clk) $rose(wbox_intf.sdram_rst) |=> nop_cmd [*10000] ##1 nop_cmd[*0:$] ##1 precharge_cmd[*2] ##1 nop_cmd[*0:$] ##1 autorefresh_cmd[*2] ##1 nop_cmd[*0:$] ##1 autorefresh_cmd[*2];
endproperty;

property prop_wb_sigs_init_during_rst;
	@(posedge wbox_intf.wb_clk_i) $rose(wbox_intf.wb_rst_i) |=> wbox_intf.wb_rst_i[*1:$] |-> are_wb_sigs_in_default;
endproperty

property prop_rst_at_least_one_cycle;
	@(posedge wbox_intf.wb_clk_i) $rose(wbox_intf.wb_rst_i) |=> wbox_intf.wb_rst_i [*1:$];
endproperty

property prop_react_to_rst;
	@(posedge wbox_intf.wb_clk_i) $rose(wbox_intf.wb_rst_i) |=> are_wb_sigs_in_default;
endproperty

property prop_are_cyc_and_stb_equal;
	@(posedge wbox_intf.wb_clk_i) !$isunknown(wbox_intf.wb_we_i) |-> wbox_intf.wb_stb_i ==  wbox_intf.wb_cyc_i;
endproperty

property prop_wb_std_acknowledge;
	@(posedge wbox_intf.wb_clk_i) $rose(wbox_intf.wb_stb_i) and $rose(wbox_intf.wb_cyc_i) |=> wbox_intf.wb_stb_i and wbox_intf.wb_cyc_i and wbox_intf.wb_ack_o;
endproperty

sdram_init		: assert property (prop_sdram_correct_init)			else $error("sdram initialization Failed");
wb_rule_3_00 	: assert property (prop_wb_sigs_init_during_rst) 	else $error("wishbone rule 3.00 Failed");
wb_rule_3_05 	: assert property (prop_rst_at_least_one_cycle) 	else $error("wishbone rule 3.05 Failed");
wb_rule_3_10	: assert property (prop_react_to_rst)				else $error("wishbone rule 3.10 Failed");
wb_rule_3_25 	: assert property (prop_are_cyc_and_stb_equal) 		else $error("wishbone rule 3.25 Failed");
wb_rule_3_35 	: assert property (prop_wb_std_acknowledge)			else $error("wishbone rule 3.35 Failed");

endmodule;

`endif