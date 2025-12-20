module counter_assertions
(
clk,rst,mode,load,data_in,
data_out
);

input logic clk,rst,mode,load;
input logic [3:0] data_in,data_out;

property reset;
	@(posedge clk)
		//rst |=> data_out==0;
		rst |-> data_out==0;
endproperty

property up_count;
	@(posedge clk)
		disable iff(rst)
			(mode && !load && data_out!=11)|=> data_out == $past(data_out,1) + 1;
endproperty

property down_count;
	@(posedge clk)		
		disable iff(rst)
			(!mode && !load && data_out!=0) |=> data_out == $past(data_out,1) - 1;
endproperty

property load_data;
	@(posedge clk)
		disable iff(rst)
			//load |=> data_out == data_in;	
			load |-> data_out == data_in;	
endproperty

property upper_bound;
	@(posedge clk)
		disable iff(rst)
			(data_out==11 && mode && !load)  |=> data_out == 0;
endproperty

property lower_bound;
	@(posedge clk)
		disable iff(rst)
			(data_out==0 && !mode && !load)  |=> data_out ==11;
endproperty

a_rst : assert property (reset)
		$display("Reset Assertion Pass at",$time);
	else
		$display("Reset Assertion Fail at",$time);

a_up : assert property (up_count)
		$display("Up Count Assertion Pass at",$time);
		//$strobe("Up Count Assertion Pass at",$time);
	else
		$display("Up Count Assertion Fail at",$time);
		//$strobe("Up Count Assertion Fail at",$time);

a_down : assert property (down_count)
		$display("Down Count Assertion Pass at",$time);
	else
		$display("Down Count Assertion Fail at",$time);

a_load : assert property (load_data)
		$display("Loading Data Assertion Pass at",$time);
	else
		$display("Loading Data Assertion Fail at",$time);

a_11_to_0 : assert property (upper_bound)
		$display("Upper Bound Wraparound Assertion Pass at",$time);
	else
		$display("Upper Bound Wraparound Assertion Fail at",$time);

a_0_to_11 : assert property (lower_bound)
		$display("Lower Bound Wraparound Assertion Pass at",$time);
	else
		$display("Lower Bound Wraparound Assertion Fail at",$time);
endmodule
