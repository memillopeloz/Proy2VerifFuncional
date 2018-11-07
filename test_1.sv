`ifndef TEST_1_SV
`define TEST_1_SV

`include "env.sv"

program test_1(sdrc_if intf);
	environment env = new(intf);
	
	initial begin
		$display("-------------------------------------- ");
		$display(" Case-1: Single Write/Read Case        ");
		$display("-------------------------------------- ");
		env.drv.reset();
	end
endprogram

`endif