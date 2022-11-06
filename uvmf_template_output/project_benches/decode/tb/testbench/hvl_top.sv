module hvl_top();
    import decode_test_pkg::*;
    import uvm_pkg::*;
    
    `include "uvm_macros.svh"

    initial begin
        $display("Running Tests");
        run_test();
        #20;
    end
endmodule