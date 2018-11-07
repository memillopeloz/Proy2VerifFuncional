`ifndef TRANSACTION_SV
`define TRANSACTION_SV

class transaction;
	int address;
	int bl;
	
	function new(int address, int bl);
		this.address = address;
		this.bl = bl;
	endfunction
endclass

`endif