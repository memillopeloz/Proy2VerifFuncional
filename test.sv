`ifndef TEST_SV
`define TEST_SV

`include "env.sv"

program test(sdrc_if intf);
	environment env = new(intf);
    
	
	initial begin
		env.drv.reset();
        env.drv.setStimulus(env.stAllRand);
		//test_case_1();
        //test_case_2();
		//test_case_3();
        //test_case_4();
        //test_case_5();
        //test_case_6();
        env.drv.testRandomize();
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
    
    task test_case_3();
        // Before start each test reset error_count and loop_count
        env.sb.error_count = 0;
        env.sb.loop_count = 0;
        
        $display("-------------------------------------- ");
	$display(" Test-3: Create a Page Cross Over      ");
	$display("-------------------------------------- ");
        
	env.drv.Burst_write(32'h0000_0FF0,8'h8);
	env.drv.Burst_write(32'h0001_0FF4,8'hF);  
	env.drv.Burst_write(32'h0002_0FF8,8'hF);  
	env.drv.Burst_write(32'h0003_0FFC,8'hF);  
	env.drv.Burst_write(32'h0004_0FE0,8'hF);  
	env.drv.Burst_write(32'h0005_0FE4,8'hF);  
	env.drv.Burst_write(32'h0006_0FE8,8'hF);  
	env.drv.Burst_write(32'h0007_0FEC,8'hF);  
	env.drv.Burst_write(32'h0008_0FD0,8'hF);  
	env.drv.Burst_write(32'h0009_0FD4,8'hF);  
	env.drv.Burst_write(32'h000A_0FD8,8'hF);  
	env.drv.Burst_write(32'h000B_0FDC,8'hF);  
	env.drv.Burst_write(32'h000C_0FC0,8'hF);  
	env.drv.Burst_write(32'h000D_0FC4,8'hF);  
	env.drv.Burst_write(32'h000E_0FC8,8'hF);  
	env.drv.Burst_write(32'h000F_0FCC,8'hF);  
	env.drv.Burst_write(32'h0010_0FB0,8'hF);  
	env.drv.Burst_write(32'h0011_0FB4,8'hF);  
	env.drv.Burst_write(32'h0012_0FB8,8'hF);  
	env.drv.Burst_write(32'h0013_0FBC,8'hF);  
	env.drv.Burst_write(32'h0014_0FA0,8'hF);  
	env.drv.Burst_write(32'h0015_0FA4,8'hF);  
	env.drv.Burst_write(32'h0016_0FA8,8'hF);  
	env.drv.Burst_write(32'h0017_0FAC,8'hF);  
	env.mon.Burst_read();  
	env.mon.Burst_read();  
	env.mon.Burst_read();  
	env.mon.Burst_read();  
	env.mon.Burst_read();  
	env.mon.Burst_read();  
	env.mon.Burst_read();
	env.mon.Burst_read();
	env.mon.Burst_read();  
	env.mon.Burst_read();  
	env.mon.Burst_read();  
	env.mon.Burst_read();  
	env.mon.Burst_read();  
	env.mon.Burst_read();  
	env.mon.Burst_read();  
	env.mon.Burst_read();  
	env.mon.Burst_read();  
	env.mon.Burst_read();  
	env.mon.Burst_read();  
	env.mon.Burst_read();  
	env.mon.Burst_read();  
	env.mon.Burst_read();  
	env.mon.Burst_read();  
	env.mon.Burst_read();
        
        $display("###############################");
        if(env.sb.error_count == 0 && env.sb.loop_count != 0)
            $display("STATUS: Test-3: Create a Page Cross Over PASSED");
        else
            $display("ERROR:  Test-3: Create a Page Cross Over FAILED");
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

    task test_case_5();
        // Before start each test reset error_count and loop_count
        env.sb.error_count = 0;
        env.sb.loop_count = 0;
        
        $display("--------------------------------------------------- ");
		$display(" Test-5: 24 write/read different bank and row       ");
		$display("--------------------------------------------------- ");
        
        env.drv.Burst_write({12'h000,2'b00,8'h00,2'b00},8'h4);   // Row: 0 Bank : 0
        env.drv.Burst_write({12'h000,2'b01,8'h00,2'b00},8'h5);   // Row: 0 Bank : 1
        env.drv.Burst_write({12'h000,2'b10,8'h00,2'b00},8'h6);   // Row: 0 Bank : 2
        env.drv.Burst_write({12'h000,2'b11,8'h00,2'b00},8'h7);   // Row: 0 Bank : 3
        env.drv.Burst_write({12'h001,2'b00,8'h00,2'b00},8'h4);   // Row: 1 Bank : 0
        env.drv.Burst_write({12'h001,2'b01,8'h00,2'b00},8'h5);   // Row: 1 Bank : 1
        env.drv.Burst_write({12'h001,2'b10,8'h00,2'b00},8'h6);   // Row: 1 Bank : 2
        env.drv.Burst_write({12'h001,2'b11,8'h00,2'b00},8'h7);   // Row: 1 Bank : 3
        
        env.mon.Burst_read();  
        env.mon.Burst_read(); 
        env.mon.Burst_read();
        env.mon.Burst_read();  
        env.mon.Burst_read();
        env.mon.Burst_read();
        env.mon.Burst_read();  
        env.mon.Burst_read();
        
        env.drv.Burst_write({12'h002,2'b00,8'h00,2'b00},8'h4);   // Row: 2 Bank : 0
        env.drv.Burst_write({12'h002,2'b01,8'h00,2'b00},8'h5);   // Row: 2 Bank : 1
        env.drv.Burst_write({12'h002,2'b10,8'h00,2'b00},8'h6);   // Row: 2 Bank : 2
        env.drv.Burst_write({12'h002,2'b11,8'h00,2'b00},8'h7);   // Row: 2 Bank : 3
        env.drv.Burst_write({12'h003,2'b00,8'h00,2'b00},8'h4);   // Row: 3 Bank : 0
        env.drv.Burst_write({12'h003,2'b01,8'h00,2'b00},8'h5);   // Row: 3 Bank : 1
        env.drv.Burst_write({12'h003,2'b10,8'h00,2'b00},8'h6);   // Row: 3 Bank : 2
        env.drv.Burst_write({12'h003,2'b11,8'h00,2'b00},8'h7);   // Row: 3 Bank : 3
        
        env.mon.Burst_read();  
        env.mon.Burst_read();  
        env.mon.Burst_read();  
        env.mon.Burst_read(); 
        env.mon.Burst_read();  
        env.mon.Burst_read();
        env.mon.Burst_read();  
        env.mon.Burst_read(); 
        
        env.drv.Burst_write({12'h002,2'b00,8'h00,2'b00},8'h4);   // Row: 2 Bank : 0
        env.drv.Burst_write({12'h002,2'b01,8'h01,2'b00},8'h5);   // Row: 2 Bank : 1
        env.drv.Burst_write({12'h002,2'b10,8'h02,2'b00},8'h6);   // Row: 2 Bank : 2
        env.drv.Burst_write({12'h002,2'b11,8'h03,2'b00},8'h7);   // Row: 2 Bank : 3
        env.drv.Burst_write({12'h003,2'b00,8'h04,2'b00},8'h4);   // Row: 3 Bank : 0
        env.drv.Burst_write({12'h003,2'b01,8'h05,2'b00},8'h5);   // Row: 3 Bank : 1
        env.drv.Burst_write({12'h003,2'b10,8'h06,2'b00},8'h6);   // Row: 3 Bank : 2
        env.drv.Burst_write({12'h003,2'b11,8'h07,2'b00},8'h7);   // Row: 3 Bank : 3
        
        env.mon.Burst_read();  
        env.mon.Burst_read(); 
        env.mon.Burst_read();
        env.mon.Burst_read();  
        env.mon.Burst_read();  
        env.mon.Burst_read();  
        env.mon.Burst_read(); 
        env.mon.Burst_read();  
        
        $display("###############################");
        if(env.sb.error_count == 0 && env.sb.loop_count != 0)
            $display("STATUS: Test-5: 24 write/read different bank and row PASSED");
        else
            $display("ERROR:  Test-5: 24 write/read different bank and row FAILED");
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
