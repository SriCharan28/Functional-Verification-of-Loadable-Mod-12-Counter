module counter_top;

import counter_pkg::*;
import uvm_pkg::*;

bit clk;

counter_if sif(clk);

counter dut(.clk(clk),.rst(sif.rst),.load(sif.load),.mode(sif.mode),.data_in(sif.data_in),.data_out(sif.data_out));

bind counter counter_assertions duv(.clk(clk),.rst(sif.rst),.load(sif.load),.mode(sif.mode),.data_in(sif.data_in),.data_out(sif.data_out));

parameter period = 20;

always
begin
	clk=1'b0;
	#(period/2);
	clk=1'b1;
	#(period/2);
end

initial
begin
	uvm_config_db#(virtual counter_if)::set(null,"*","vif",sif);
	run_test();
end

endmodule
