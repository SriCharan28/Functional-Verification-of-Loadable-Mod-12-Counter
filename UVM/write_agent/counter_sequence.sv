class counter_sequence extends uvm_sequence#(counter_trans);

	`uvm_object_utils(counter_sequence);

	function new(string name = "counter_sequence");
		super.new(name);
	endfunction
	
	task body();
		repeat(no_of_trans)
		begin
			req=counter_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize());
			finish_item(req);
		end
	endtask

endclass

class extended_counter_sequence extends counter_sequence;

	`uvm_object_utils(extended_counter_sequence);

	function new(string name = "extended_counter_sequence");
		super.new(name);
	endfunction
	
	task body();
		repeat(no_of_trans)
		begin
			req=counter_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize() with {load==1; data_in=={2,8,9};});
			finish_item(req);
		end
	endtask

endclass
