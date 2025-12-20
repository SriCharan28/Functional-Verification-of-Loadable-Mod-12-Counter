class counter_env_config extends uvm_object;
	
	`uvm_object_utils(counter_env_config);

	virtual counter_if vif;
	bit has_scoreboard;
	bit has_write_agent;
	bit has_read_agent;
	uvm_active_passive_enum write_agent_is_active;
	uvm_active_passive_enum read_agent_is_active;

	function new(string name = "counter_env_config");
		super.new(name);
	endfunction

endclass