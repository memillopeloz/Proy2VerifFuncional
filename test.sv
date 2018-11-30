`ifndef TEST_SV
`define TEST_SV

`include "env.sv"

program test(sdrc_if intf);
    environment env = new(intf);
    
    
    initial begin
        int unsigned success = 1;
        int unsigned retVal = 1;
        env.drv.reset();

        test_case_1(retVal);//PASS
        success &= retVal;

        test_case_2(retVal);//PASS
        success &= retVal;
    
        //test_case_3(retVal);
        success &= retVal;

        test_case_4(retVal);//PASS
        success &= retVal;

        test_case_5(retVal);
        success &= retVal;

        test_case_6(retVal);
        success &= retVal;

        //env.drv.testRandomize();
        
        $display("###############################");
        if(success)
            $display("STATUS: All tests have PASSED");
        else
            $display("ERROR:  One or more tests FAILED");
        $display("###############################");
    end
    
    task test_case_1(output int ret);
        // Before start each test reset scoreboard
        env.sb.clear();
        
        $display("-------------------------------------- ");
        $display(" Test-1: Single Write/Read Case        ");
        $display("-------------------------------------- ");
        env.drv.single_write();
        #1000;
        env.mon.read();
        $display("###############################");
        if(env.sb.error_count == 0 && env.sb.loop_count != 0) begin
            $display("STATUS: Test-1: Single Write/Read PASSED");
            ret = 1;
        end
        else begin
            $display("ERROR:  Test-1: Single Write/Read FAILED");
            ret = 0;
        end
        $display("###############################");
    endtask
    
    task test_case_2(output int ret);
        // Before start each test reset scoreboard
        env.sb.clear();
        
        $display("-------------------------------------- ");
        $display(" Test-2: Two Write/Read Case           ");
        $display("-------------------------------------- ");
        
        env.drv.single_write(4);
        env.mon.read();
        
        env.drv.single_write(5);
        env.mon.read();
        
        $display("###############################");
        if(env.sb.error_count == 0 && env.sb.loop_count != 0) begin
            $display("STATUS: Test-2: Two Write/Read PASSED");
            ret = 1;
        end
        else begin
            $display("ERROR:  Test-2: Two Write/Read FAILED");
            ret = 0;
        end
        $display("###############################");
    endtask
    
    task test_case_3(output int ret);
        // Before start each test reset scoreboard
        env.sb.clear();
        
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
        env.mon.read();  
        env.mon.read();  
        env.mon.read();  
        env.mon.read();  
        env.mon.read();  
        env.mon.read();  
        env.mon.read();
        env.mon.read();
        env.mon.read();  
        env.mon.read();  
        env.mon.read();  
        env.mon.read();  
        env.mon.read();  
        env.mon.read();  
        env.mon.read();  
        env.mon.read();  
        env.mon.read();  
        env.mon.read();  
        env.mon.read();  
        env.mon.read();  
        env.mon.read();  
        env.mon.read();  
        env.mon.read();  
        env.mon.read();
        
        $display("###############################");
        if(env.sb.error_count == 0 && env.sb.loop_count != 0) begin
            $display("STATUS: Test-3: Create a Page Cross Over PASSED");
            ret = 1;
        end
        else begin
            $display("ERROR:  Test-3: Create a Page Cross Over FAILED");
            ret = 0;
        end
        $display("###############################");
    endtask

    task test_case_4(output int ret);
        // Before start each test reset scoreboard
        env.sb.clear();
        
        $display("-------------------------------------- ");
        $display(" Test-4: Four Write/Read Case           ");
        $display("-------------------------------------- ");
        
        env.drv.single_write(4);
        env.drv.single_write(5);
        env.drv.single_write(6);
        env.drv.single_write(7);
        
        env.mon.read(); 
        env.mon.read(); 
        env.mon.read();
        env.mon.read();  
        
        $display("###############################");
        if(env.sb.error_count == 0 && env.sb.loop_count != 0) begin
            $display("STATUS: Test-4: Four Write/Read PASSED");
            ret = 1;
        end
        else begin
            $display("ERROR:  Test-4: Four Write/Read FAILED");
            ret = 0;
        end
        $display("###############################");
    endtask

    task test_case_5(output int ret);
        // Before start each test reset scoreboard
        env.sb.clear();
        
        $display("--------------------------------------------------- ");
        $display(" Test-5: 24 write/read different bank and row       ");
        $display("--------------------------------------------------- ");
        
        env.drv.rowbank_write(0, 0);   // Row: 0 Bank : 0
        env.drv.rowbank_write(0, 1);   // Row: 0 Bank : 1
        env.drv.rowbank_write(0, 2);   // Row: 0 Bank : 2
        env.drv.rowbank_write(0, 3);   // Row: 0 Bank : 3
        env.drv.rowbank_write(1, 0);   // Row: 1 Bank : 0
        env.drv.rowbank_write(1, 1);   // Row: 1 Bank : 1
        env.drv.rowbank_write(1, 2);   // Row: 1 Bank : 2
        env.drv.rowbank_write(1, 3);   // Row: 1 Bank : 3
        
        env.mon.read();  
        env.mon.read(); 
        env.mon.read();
        env.mon.read();  
        env.mon.read();
        env.mon.read();
        env.mon.read();  
        env.mon.read();
        
        env.drv.rowbank_write(2, 0);   // Row: 2 Bank : 0
        env.drv.rowbank_write(2, 1);   // Row: 2 Bank : 1
        env.drv.rowbank_write(2, 2);   // Row: 2 Bank : 2
        env.drv.rowbank_write(2, 3);   // Row: 2 Bank : 3
        env.drv.rowbank_write(3, 0);   // Row: 3 Bank : 0
        env.drv.rowbank_write(3, 1);   // Row: 3 Bank : 1
        env.drv.rowbank_write(3, 2);   // Row: 3 Bank : 2
        env.drv.rowbank_write(3, 3);   // Row: 3 Bank : 3
        
        env.mon.read();  
        env.mon.read();  
        env.mon.read();  
        env.mon.read(); 
        env.mon.read();  
        env.mon.read();
        env.mon.read();  
        env.mon.read(); 
        
        env.drv.rowbank_write(4, 0);   // Row: 4 Bank : 0
        env.drv.rowbank_write(4, 1);   // Row: 4 Bank : 1
        env.drv.rowbank_write(4, 2);   // Row: 4 Bank : 2
        env.drv.rowbank_write(4, 3);   // Row: 4 Bank : 3
        env.drv.rowbank_write(5, 0);   // Row: 5 Bank : 0
        env.drv.rowbank_write(5, 1);   // Row: 5 Bank : 1
        env.drv.rowbank_write(5, 2);   // Row: 5 Bank : 2
        env.drv.rowbank_write(5, 3);   // Row: 5 Bank : 3
        
        env.mon.read();  
        env.mon.read(); 
        env.mon.read();
        env.mon.read();  
        env.mon.read();  
        env.mon.read();  
        env.mon.read(); 
        env.mon.read();  
        
        $display("###############################");
        if(env.sb.error_count == 0 && env.sb.loop_count != 0) begin
            $display("STATUS: Test-5: 24 write/read different bank and row PASSED");
            ret = 1;
        end
        else begin
            $display("ERROR:  Test-5: 24 write/read different bank and row FAILED");
            ret = 0;
        end
        $display("###############################");
    endtask
    
    task test_case_6(output int ret);
        // Before start each test reset scoreboard
        env.sb.clear();
        
        $display("-------------------------------------- ");
        $display(" Test-6: Random 2 write/read           ");
        $display("-------------------------------------- ");   

        for(int k=0; k < 20; k++) begin
            env.drv.all_rand_write();
            #100;
            env.drv.all_rand_write();
            #100;
            env.mon.read();
            #100;
            env.mon.read();
            #100;
        end
        
        $display("###############################");
        if(env.sb.error_count == 0 && env.sb.loop_count != 0) begin
            $display("STATUS: Test-6: Random 2 write/read PASSED");
            ret = 1;
        end
        else begin
            $display("ERROR:  Test-6: Random 2 write/read FAILED");
            ret = 0;
        end
        $display("###############################");
    endtask
    
endprogram

`endif
