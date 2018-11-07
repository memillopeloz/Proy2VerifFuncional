`ifndef TEST_1_SV
`define TEST_1_SV

`include "env.sv"
`include "transaction.sv"

program test_1(sdrc_if intf);
	environment env = new(intf);
	transaction trans = new(0,4);
	
	initial begin
		$display("-------------------------------------- ");
		$display(" Case-1: Single Write/Read Case        ");
		$display("-------------------------------------- ");
		env.drv.reset();
		env.drv.drive(trans);
		#1000;
		env.mon.check();
	end
endprogram

`endif
