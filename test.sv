`ifndef TEST_SV
`define TEST_SV

`include "env.sv"

program test(sdrc_if intf);
	environment env = new(intf);
	
	initial begin
		env.drv.reset();
		test_case_1();
        test_case_2();
        test_case_4();
        test_case_6();
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

    task test_case_4();
        // Before start each test reset error_count and loop_count
        env.sb.error_count = 0;
        env.sb.loop_count = 0;
        
        $display("-------------------------------------- ");
		$display(" Test-4: Four Write/Read Case           ");
		$display("-------------------------------------- ");
        
        env.drv.Burst_write(32'h4_0000,8'h4);
        env.drv.Burst_write(32'h5_0000,8'h5);
        env.drv.Burst_write(32'h6_0000,8'h6);
        env.drv.Burst_write(32'h7_0000,8'h7);
        
        env.mon.Burst_read(); 
        env.mon.Burst_read(); 
        env.mon.Burst_read();
        env.mon.Burst_read();  
        
        $display("###############################");
        if(env.sb.error_count == 0 && env.sb.loop_count != 0)
            $display("STATUS: Test-4: Four Write/Read PASSED");
        else
            $display("ERROR:  Test-4: Four Write/Read FAILED");
        $display("###############################");
    endtask
    
    task test_case_6();
        // Before start each test reset error_count and loop_count
        env.sb.error_count = 0;
        env.sb.loop_count = 0;
        
        $display("-------------------------------------- ");
		$display(" Test-6: Random 2 write/read           ");
		$display("-------------------------------------- ");
        
        for(int k=0, int unsigned start_addr = 0; k < 20; k++) begin
            start_addr = $random & 32'h003FFFFF;
            env.drv.Burst_write(start_addr,($random & 8'h0f)+1);  
            #100;
            
            start_addr = $random & 32'h003FFFFF;
            env.drv.Burst_write(start_addr,($random & 8'h0f)+1);  
            #100;
            env.mon.Burst_read();   
            #100;
            env.mon.Burst_read();
            #100;
        end
        
        $display("###############################");
        if(env.sb.error_count == 0 && env.sb.loop_count != 0)
            $display("STATUS: Test-6: Random 2 write/read PASSED");
        else
            $display("ERROR:  Test-6: Random 2 write/read FAILED");
        $display("###############################");
    endtask
    
endprogram

`endif
