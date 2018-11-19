`ifndef STIMULUS_ALLRAND_SV
`define STIMULUS_ALLRAND_SV

class stimulusAllRand;
  rand  logic[11:0] row;
  rand  logic[1:0]  bank;
  rand  logic[11:0] col;
  //constraint distribution {value dist { 0  := 1 , 1 := 1 }; };

	// memory layout
	// Row Address[11:0] Bank Address[1:0] Column Address[11:0]
//  function getStimulus(int row, int bank, int col;

endclass

`endif
