class counter_rmon extends uvm_monitor;

	`uvm_component_utils(counter_rmon);

	uvm_analysis_port #(counter_trans) rap;

	virtual counter_if.rmon_mp rmon_if;
	counter_env_config cfg;
	counter_trans th;

	function new(string name = "counter_rmon",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db#(counter_env_config)::get(this,"","counter_env_config",cfg))
			`uvm_fatal("counter_env_config","FAILED TO GET CONTENTS IN READ MONITOR");

		rap=new("rap",this);
	endfunction
	
	function void connect_phase(uvm_phase phase);
		rmon_if=cfg.vif;
	endfunction

	task run_phase(uvm_phase phase);
		forever
		begin
			rmon_dut();
		end
	endtask

	task rmon_dut();
		@(rmon_if.rmon_cb)
			th=counter_trans::type_id::create("counter_trans_rmon");
			th.data_out=rmon_if.rmon_cb.data_out;
			`uvm_info("counter_rmon",$sformatf("OUTPUT DATA SAMPLED BY READ MONITOR = %d",th.data_out),UVM_LOW);
		rap.write(th);
	endtask

endclass
