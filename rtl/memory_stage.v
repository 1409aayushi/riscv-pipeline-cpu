module memory_stage(

    input wire clk,

    //--------------------------------------------------
    // Inputs from Execute Stage
    //--------------------------------------------------

    input wire mem_read,
    input wire mem_write,

    input wire [31:0] alu_result,
    input wire [31:0] rs2_data,

    //--------------------------------------------------
    // Outputs
    //--------------------------------------------------

    output wire [31:0] memory_data,
    output wire [31:0] address_out

);

    data_memory dmem(

        .clk(clk),

        .mem_read(mem_read),
        .mem_write(mem_write),

        .address(alu_result),

        .write_data(rs2_data),

        .read_data(memory_data)

    );

    assign address_out = alu_result;

endmodule