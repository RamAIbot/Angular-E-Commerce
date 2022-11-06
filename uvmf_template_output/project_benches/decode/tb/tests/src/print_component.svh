`uvm_analysis_imp_decl(_decode_in)
`uvm_analysis_imp_decl(_decode_out)

class print_component extends uvm_component;
    `uvm_component_utils(print_component)

    decode_in_transaction trans1;
    decode_out_transaction trans2;
    uvm_analysis_imp_decode_in #(decode_in_transaction,print_component) analysis_imp_a;  
    uvm_analysis_imp_decode_out #(decode_out_transaction,print_component) analysis_imp_b; 

    
    function new(input string instr="PRINT",uvm_component c);
        super.new(instr,c);
        analysis_imp_a = new("decode_in_analysis_imp_a", this);
        analysis_imp_b = new("decode_out_analysis_imp_b", this);
    endfunction


    //---------------------------------------
  // Analysis port write method
  //---------------------------------------
    virtual function void write_decode_in(decode_in_transaction trans);
        //`uvm_info(get_type_name(),$sformatf(" Inside decode_in method. Recived trans On Analysis Imp Port"),UVM_LOW)
        `uvm_info(get_type_name(),$sformatf("Decode_in Printing trans, \t %s \n",trans.convert2string()),UVM_LOW)
    endfunction 
    
  //---------------------------------------
  // Analysis port write method
  //---------------------------------------
    virtual function void write_decode_out(decode_out_transaction trans);
       // `uvm_info(get_type_name(),$sformatf(" Inside decode_out method. Recived trans On Analysis Imp Port"),UVM_LOW)
        `uvm_info(get_type_name(),$sformatf("Decode_out Printing trans, \t %s \n",trans.convert2string()),UVM_LOW)
    endfunction 
    
endclass