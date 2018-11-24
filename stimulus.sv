`ifndef STIMULUS_SV
`define STIMULUS_SV

class stimulus;
    int burst_length;

    rand  logic[11:0] row;
    rand  logic[1:0]  bank;
    rand  logic[11:0] col;

    // memory layout
    // sdram controller supports the following amount of rows, banks, and columns:
    //                              4M*16 Config ->       12     4           8
    //                              2M*32 Config ->       11     4           8
    
    // Row Address[11:0] Bank Address[1:0] Column Address[11:0]

endclass

`endif
