module writeback_stage(

    //--------------------------------------------------
    // Inputs
    //--------------------------------------------------

    input wire        mem_to_reg,

    input wire [31:0] alu_result,
    input wire [31:0] memory_data,

    //--------------------------------------------------
    // Output
    //--------------------------------------------------

    output wire [31:0] writeback_data

);

    assign writeback_data =
        (mem_to_reg) ? memory_data :
                       alu_result;

endmodule