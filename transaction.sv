`ifndef TRANSACTION_SV
`define TRANSACTION_SV

class transaction;
	int unsigned address;
	int unsigned bl;
	
	function new(int unsigned address, int unsigned bl);
		this.address = address;
		this.bl = bl;
	endfunction
endclass

`endif
