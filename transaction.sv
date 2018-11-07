`ifndef TRANSACTION_SV
`define TRANSACTION_SV

class transaction;
	int address;
	int bl;
	int value;
	
	function new(int address, int bl, int value);
		this.address = address;
		this.bl = bl;
		this.value = value;
	endfunction
endclass

`endif