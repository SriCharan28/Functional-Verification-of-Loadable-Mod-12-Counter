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


