class counter_driver extends uvm_driver#(counter_trans);
	
	`uvm_component_utils(counter_driver);

	counter_env_config cfg;
	virtual counter_if.drv_mp drv_if;

	function new(string name = "counter_driver",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db#(counter_env_config)::get(this,"","counter_env_config",cfg))
			`uvm_fatal("counter_env_config","FAILED TO GET CONTENTS IN DRIVER");
	endfunction
	
	function void connect_phase(uvm_phase phase);
		drv_if=cfg.vif;
	endfunction

	task run_phase(uvm_phase phase);
		forever
		begin
			seq_item_port.get_next_item(req);
			drv_dut(req);
			seq_item_port.item_done();
		end
	endtask

	task drv_dut(counter_trans th);
		@(drv_if.drv_cb)
			`uvm_info("counter_drv",$sformatf("CONTENT OF DRIVER :- \n %s",th.sprint()),UVM_LOW);
			drv_if.drv_cb.rst <= th.rst;
			drv_if.drv_cb.load <= th.load;				
			drv_if.drv_cb.mode <= th.mode;		
			drv_if.drv_cb.data_in <= th.data_in;
	endtask

endclass
