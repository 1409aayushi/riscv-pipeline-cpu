module execute_stage(

    //--------------------------------------------------
    // Inputs from Decode Stage
    //--------------------------------------------------

    input wire [31:0] rs1_data,
    input wire [31:0] rs2_data,

    input wire [31:0] immediate,

    input wire        alu_src,
    input wire [3:0]  alu_control,

    //--------------------------------------------------
    // Outputs
    //--------------------------------------------------

    output wire [31:0] alu_result,
    output wire        zero

);

    //--------------------------------------------------
    // ALU Operand B MUX
    //--------------------------------------------------

    wire [31:0] operand_b;

    assign operand_b =
        (alu_src) ? immediate :
                    rs2_data;

    //--------------------------------------------------
    // ALU
    //--------------------------------------------------

    alu alu_inst (

        .operand_a(rs1_data),
        .operand_b(operand_b),

        .alu_control(alu_control),

        .result(alu_result),
        .zero(zero)

    );

endmodule