class counter_wmon extends uvm_monitor;

	`uvm_component_utils(counter_wmon);

	uvm_analysis_port #(counter_trans) wap;

	virtual counter_if.wmon_mp wmon_if;
	counter_env_config cfg;
	counter_trans th;

	function new(string name = "counter_rmon",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db#(counter_env_config)::get(this,"","counter_env_config",cfg))
			`uvm_fatal("counter_env_config","FAILED TO GET CONTENTS IN WRITE MONITOR");

		wap=new("wap",this);
	endfunction
	
	function void connect_phase(uvm_phase phase);
		wmon_if=cfg.vif;
	endfunction

	task run_phase(uvm_phase phase);
		forever
		begin
			wmon_dut();
		end
	endtask

	task wmon_dut();
		@(wmon_if.wmon_cb)
			th=counter_trans::type_id::create("counter_trans_wmon");
			th.data_in=wmon_if.wmon_cb.data_in;
			th.mode=wmon_if.wmon_cb.mode;
			th.load=wmon_if.wmon_cb.load;
			th.rst=wmon_if.wmon_cb.rst;
			`uvm_info("counter_wmon",$sformatf("CONTENT OF WRITE MONITOR :- \n %s",th.sprint()),UVM_LOW);

		wap.write(th);
	endtask

endclass