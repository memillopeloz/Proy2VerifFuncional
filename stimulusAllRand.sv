`ifndef STIMULUS_ALLRAND_SV
`define STIMULUS_ALLRAND_SV

class stimulusAllRand;
    rand  logic[11:0] row;
    rand  logic[1:0]  bank;
    rand  logic[11:0] col;

    constraint memoryrange {
        //bank dist { 0 := 1 , 1 := 1 };
        bank >= 0; bank < 5;
        row >= 0; row < 12;
        col >= 0; col < 8;
    };

    // memory layout
    // sdram controller supports the following amount of rows, banks, and columns:
    //                              4M*16 Config ->       12     4           8
    //                              2M*32 Config ->       11     4           8
    
    // Row Address[11:0] Bank Address[1:0] Column Address[11:0]
    //  function getStimulus(int row, int bank, int col;

endclass

`endif
