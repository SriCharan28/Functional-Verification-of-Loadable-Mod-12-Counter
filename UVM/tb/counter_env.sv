class counter_env extends uvm_env;
 	
	`uvm_component_utils(counter_env);
	
	counter_wagent wagth;
	counter_ragent ragth;
	counter_scoreboard sbh;
	counter_env_config cfg;

	function new(string name = "counter_env",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(counter_env_config)::get(this,"","counter_env_config",cfg))
			`uvm_fatal("CONFIGURATION CLASS","FAILED TO GET CONTENTS IN ENVIRONMENT");
		if(cfg.has_write_agent)
			wagth=counter_wagent::type_id::create("counter_wagent",this);
		if(cfg.has_read_agent)
			ragth=counter_ragent::type_id::create("counter_ragent",this);
		if(cfg.has_scoreboard)
			sbh=counter_scoreboard::type_id::create("counter_scoreboard",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		if(cfg.has_scoreboard && cfg.has_write_agent)
			wagth.wmonh.wap.connect(sbh.fwep.analysis_export);
		if(cfg.has_scoreboard && cfg.has_read_agent)
			ragth.rmonh.rap.connect(sbh.frep.analysis_export);
	endfunction

endclass