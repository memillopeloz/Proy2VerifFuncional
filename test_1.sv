`ifndef TEST_1_SV
`define TEST_1_SV

`include "env.sv"
`include "transaction.sv"

program test_1(sdrc_if intf);
	environment env = new(intf);
	
	initial begin
		env.drv.reset();
		test_case_1();
        test_case_2();
    end
    
    task test_case_1();
        // Before start each test reset error_count and loop_count
        env.sb.error_count = 0;
        env.sb.loop_count = 0;
        
        $display("-------------------------------------- ");
		$display(" Test-1: Single Write/Read Case        ");
		$display("-------------------------------------- ");
        env.drv.Burst_write(32'h0004_0000,8'h4);
		#1000;
		env.mon.Burst_read();
        $display("###############################");
        if(env.sb.error_count == 0 && env.sb.loop_count != 0)
            $display("STATUS: Test-1: Single Write/Read PASSED");
        else
            $display("ERROR:  Test-1: Single Write/Read FAILED");
            $display("###############################");
    endtask
    
    task test_case_2();
        // Before start each test reset error_count and loop_count
        env.sb.error_count = 0;
        env.sb.loop_count = 0;
        
        $display("-------------------------------------- ");
		$display(" Test-2: Two Write/Read Case           ");
		$display("-------------------------------------- ");
        env.drv.Burst_write(32'h0004_0000,8'h4);
        env.mon.Burst_read();
        env.drv.Burst_write(32'h0040_0000,8'h5);
        env.mon.Burst_read();
        $display("###############################");
        if(env.sb.error_count == 0 && env.sb.loop_count != 0)
            $display("STATUS: Test-2: Two Write/Read PASSED");
        else
            $display("ERROR:  Test-2: Two Write/Read FAILED");
            $display("###############################");
    endtask
endprogram

`endif
