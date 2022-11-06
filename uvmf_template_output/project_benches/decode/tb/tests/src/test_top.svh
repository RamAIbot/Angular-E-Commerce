typedef decode_env_configuration decode_env_configuration_t;
// typedef decode_environment decode_environment_t;

class test_top extends uvm_test;   //_base #(.CONFIG_T(decode_env_configuration),
                                        // .ENV_T(decode_environment),
                                        // .TOP_LEVEL_SEQ_T(decode_env_sequence_base));
    `uvm_component_utils(test_top);

    function new(input string inst="TEST",uvm_component c);
        super.new(inst,c);
    endfunction

    //decode_in_agent din_agent;
    decode_environment decode_env;
    decode_in_random_sequence din_gen;
    //decode_env_sequence_base din_seq;

    //decode_out_agent dout_agent;
    //decode_out_configuration dout_config;
    uvmf_sim_level_t sim_level = BLOCK; 
    decode_env_configuration decode_env_config;

    // import print_component::*;
    print_component pc;

   uvmf_active_passive_t interface_activities[] = { 
    ACTIVE /* decode_in_agent     [0] */ , 
    PASSIVE /* decode_out_agent     [1] */ 
    };

    string interface_names[2] = {
    "decode_in_BFM" /* decode_in     [0] */ , 
    "decode_out_BFM" /* decode_out     [1] */ 
    };
    int flag = 0;
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        din_gen = decode_in_random_sequence::type_id::create("GEN",this);
        //din_seq = decode_env_sequence_base#(decode_env_configuration_t)::type_id::create("GEN",this);
        decode_env = decode_environment::type_id::create("DECODE_ENV",this);
        decode_env_config = decode_env_configuration::type_id::create("ENV_CONFIG",this);
        // decode_env_config.initialize(interface_activities,"uvm_test_top.DECODE_ENV",".AGENT_IN",".AGENT_OUT",interface_names);
        decode_env.set_config(decode_env_config);
        decode_env_config.initialize(sim_level,"uvm_test_top.DECODE_ENV",interface_names,null,interface_activities);
        
        pc = print_component::type_id::create("PRINT_COMP",this);
        
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        decode_env.decode_in_agent.monitored_ap.connect(pc.analysis_imp_a);
        decode_env.decode_out_agent.monitored_ap.connect(pc.analysis_imp_b);
    endfunction : connect_phase

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        decode_env.decode_scoreboard.enable_wait_for_scoreboard_empty();
        //decode_env.decode_scoreboard.disable_entry_compare = 1;
        
        decode_env_config.decode_in_agent_config.wait_for_reset();
        //decode_env_config.decode_out_agent_config.wait_for_reset();

        repeat(25) begin
            din_gen.start(decode_env.decode_in_agent.sequencer); 
            $display("HERE-TEST") ;
        end
        
        //decode_env_config.decode_out_agent_config.wait_for_num_clocks(1);
        //decode_env_config.decode_in_agent_config.disable_decode();
        #20;//We may not receive last response without adding this
        phase.drop_objection(this);
  endtask

endclass