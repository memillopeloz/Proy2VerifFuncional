`ifndef DRIVER_SV
`define DRIVER_SV

`include "sdrc_intf.sv"
`include "scoreboard.sv"
`include "stimulusAllRand.sv"

class driver;
    scoreboard sb;
    stimulus sti;
    virtual sdrc_if intf;
    
    function new(virtual sdrc_if intf,scoreboard sb);
        this.intf = intf;
        this.sb = sb;
    endfunction

    function setStimulus(stimulus st);
        this.sti = st;
    endfunction
    
    task reset();  // Reset method
        intf.wb_addr_i = 0;
        intf.wb_dat_i  = 0;
        intf.wb_sel_i  = 4'h0;
        intf.wb_we_i   = 0;
        intf.wb_stb_i  = 0;
        intf.wb_cyc_i  = 0;

        intf.wb_rst_i = 1'h1;
        #100
        intf.wb_rst_i = 1'h0;
        #10000;
        intf.wb_rst_i = 1'h1;
        #1000;
        wait(intf.sdr_init_done == 1);
        #1000;
    endtask

    task testRandomize();
        for(int i = 0; i < 20; i++)
        begin
            assert(sti.randomize());
            sti.burst_length = i + 1;
            $display("---------------------------------------------");
            $display("row: %d, col: %d, bank: %d", sti.getRow(0), sti.getCol(0), sti.getBank(0));
            //$display("row: %d, col: %d, bank: %d", sti.row, sti.col, sti.bank);
            $display("Randomized val: 0x%x, burst: %d", sti.getAddress(), sti.getBurstLength());
            $display("---------------------------------------------");
        end
    endtask
    
    task Burst_write(input int unsigned address, input int unsigned bl);
        if(sti.randomize() != 1) begin
            $display("failed randomize()");
        end
        
        address = sti.getAddress();
        bl = sti.getBurstLength();

        sb.bfifo.push_back(bl);
        
        @ (negedge intf.sys_clk);
        $display("Base Write Address: %x, Burst Size: %d", address, bl);
        
        for(int i=0; i < bl; i++)
        //for(int i=0; i < sti.burst_length; i++)
        begin
            address = sti.popAddress();   

            intf.wb_stb_i        = 1;
            intf.wb_cyc_i        = 1;
            intf.wb_we_i         = 1;
            intf.wb_sel_i        = 4'b1111;
            intf.wb_addr_i       = address;//address[31:2]+i;
            intf.wb_dat_i        = $random & 32'hFFFFFFFF;
            
            sb.afifo.push_back(intf.wb_addr_i);
            //sb.dfifo.push_back(intf.wb_dat_i); // send written value to scoreboard
            sb.dfifo[intf.wb_addr_i] = intf.wb_dat_i;

            do begin
                @ (posedge intf.sys_clk);
            end while(intf.wb_ack_o == 1'b0);

            @ (negedge intf.sys_clk);
            $display("Status: Burst-No: %d  WriteAddress: %x  WriteData: %x ", i, intf.wb_addr_i, intf.wb_dat_i);
        end
        intf.wb_stb_i        = 0;
        intf.wb_cyc_i        = 0;
        intf.wb_we_i         = 'hx;
        intf.wb_sel_i        = 'hx;
        intf.wb_addr_i       = 'hx;
        intf.wb_dat_i        = 'hx;
    endtask
    
endclass

`endif
