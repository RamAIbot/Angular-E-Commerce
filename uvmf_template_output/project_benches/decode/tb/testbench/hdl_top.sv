module hdl_top();
    import decode_test_pkg::*;
    import uvm_pkg::*;
    
    `include "uvm_macros.svh"

    logic clock; 
    logic reset;
    tri  enable_decode;
    tri [15:0] dout;
    tri [15:0] npc_in;

    tri [15:0] IR;
    tri [5:0] E_control;
    tri [15:0] npc_out;
    tri  Mem_Control;
    tri [1:0] W_Control;

    //Added for project2b
    // logic enable_decode_outer;
    // always @(posedge clock)
    //     enable_decode_outer = dif.enable_decode;
    // assign dout_if.enable_decode = enable_decode_outer;
    //Ends

    // Decode in interface
    decode_in_if dif(clock,reset,enable_decode,dout,npc_in);
    decode_in_driver_bfm dbfm(dif.initiator_port);
    decode_in_monitor_bfm mbfm(dif.monitor_port);


    // Decode out interface
    decode_out_if dout_if(clock,reset,IR,E_control,npc_out,Mem_Control,W_Control);
    decode_out_driver_bfm dout_bfm(dout_if.responder_port);
    decode_out_monitor_bfm mout_bfm(dout_if.monitor_port);


    initial begin
        uvm_config_db#(virtual decode_in_driver_bfm)::set(null,"","decode_in_BFM",dbfm);
        uvm_config_db#(virtual decode_in_monitor_bfm)::set(null,"","decode_in_BFM",mbfm);

        uvm_config_db#(virtual decode_out_driver_bfm)::set(null,"","decode_out_BFM",dout_bfm);
        uvm_config_db#(virtual decode_out_monitor_bfm)::set(null,"","decode_out_BFM",mout_bfm);

        
    end

    initial begin
        clock = 1;
        reset = 1;
        #10;
        reset = 0;
    end
   
    always #5 clock = ~clock;

    Decode DUT (
    .clock(clock),
    .reset(reset),
    .enable_decode(dif.enable_decode),
    .dout(dif.dout),
    .npc_in(dif.npc_in),

    .W_Control(dout_if.W_Control),
    .Mem_Control(dout_if.Mem_Control),
    .E_Control(dout_if.E_control),
    .IR(dout_if.IR),
    .npc_out(dout_if.npc_out)
   );
    

endmodule