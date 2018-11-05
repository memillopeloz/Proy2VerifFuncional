`include "sdrc_define.v"

interface sdrc_if #(
	parameter APP_AW=26,	// Application Address Width
	parameter SDR_DW=32,	// SDR Data Width 
	parameter SDR_BW=4,		// SDR Byte Width
	parameter dw=32);		// data width
	
	// SDRAM CONTROLLER CONFIG PORTS
	logic 	[1:0] cfg_sdr_width; 		// 2'b00 - 32 Bit SDR, 2'b01 - 16 Bit SDR, 2'b1x - 8 Bit
	logic 	[1:0] cfg_colbits; 			// 2'b00 - 8 Bit column address, 2'b01 - 9 Bit, 10 - 10 bit, 11 - 11Bits
	
	// WISH BONE BUS PORTS
	logic 	wb_rst_i;
	logic 	wb_clk_i;
	
	logic 	wb_stb_i;
	logic 	wb_ack_o;
	logic 	[APP_AW-1:0]	wb_addr_i;
	logic 	wb_we_i;
	logic 	[dw-1:0]		wb_dat_i;
	logic 	[dw/8-1:0]		wb_sel_i;
	logic 	[dw-1:0]		wb_dat_o;
	logic	wb_cyc_i;
	logic 	wb_cti_i;
	
	// SDRAM PORTS
	logic   sdram_clk;
    logic   sdram_resetn;
    logic   sdr_cs_n;
    logic   sdr_cke;
    logic   sdr_ras_n;
    logic   sdr_cas_n;
    logic   sdr_we_n;
    logic	[SDR_BW-1:0]	sdr_dqm;
    logic	[1:0]           sdr_ba;
    logic	[12:0]			sdr_addr;
    logic	[SDR_DW-1:0]    sdr_dq;
	
	// PARAMETERS
	logic 	sdr_init_done;
    logic	[1:0]			cfg_req_depth;
    logic 	cfg_sdr_en;
    logic	[12:0]			cfg_sdr_mode_reg;
    logic 	[3:0]			cfg_sdr_tras_d;
    logic 	[3:0]			cfg_sdr_trp_d;
    logic 	[3:0]			cfg_sdr_trcd_d;
    logic 	[2:0]			cfg_sdr_cas;
    logic 	[3:0]			cfg_sdr_trcar_d;
    logic	[3:0]           cfg_sdr_twr_d;
    logic 	[`SDR_RFSH_TIMER_W-1 : 0]		cfg_sdr_rfsh;
	logic 	[`SDR_RFSH_ROW_CNT_W -1 : 0] 	cfg_sdr_rfmax;
	
endinterface : sdrc_if

