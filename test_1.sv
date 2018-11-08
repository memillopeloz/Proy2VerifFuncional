`ifndef TEST_1_SV
`define TEST_1_SV

`include "env.sv"
`include "transaction.sv"

program test_1(sdrc_if intf);
	environment env = new(intf);
	transaction trans = new(32'h0004_0000,8'h4);
	
	initial begin
		$display("-------------------------------------- ");
		$display(" Case-1: Single Write/Read Case        ");
		$display("-------------------------------------- ");
		env.drv.reset();
		env.drv.drive(trans);
		#1000;
		env.mon.check();
        
        $display("###############################");
        if(env.sb.error_count == 0 && env.sb.loop_count != 0)
            $display("STATUS: Case-1: Single Write/Read Case TEST PASSED");
        else
            $display("ERROR:  Case-1: Single Write/Read Case TEST FAILED");
            $display("###############################");
    end
endprogram

`endif
