`timescale 1ns/1ps

module execute_stage_tb;

reg [31:0] rs1_data;
reg [31:0] rs2_data;

reg [31:0] immediate;

reg alu_src;
reg [3:0] alu_control;

wire [31:0] alu_result;
wire zero;

execute_stage DUT(

    .rs1_data(rs1_data),
    .rs2_data(rs2_data),

    .immediate(immediate),

    .alu_src(alu_src),
    .alu_control(alu_control),

    .alu_result(alu_result),
    .zero(zero)

);

initial begin

    $dumpfile("execute_stage.vcd");
    $dumpvars(0,execute_stage_tb);

    //--------------------------------------------------
    // ADD
    //--------------------------------------------------

    rs1_data = 10;
    rs2_data = 20;

    immediate = 5;

    alu_src = 0;
    alu_control = 4'b0000;

    #20;

    //--------------------------------------------------
    // ADDI
    //--------------------------------------------------

    alu_src = 1;
    alu_control = 4'b0000;

    #20;

    //--------------------------------------------------
    // SUB
    //--------------------------------------------------

    rs1_data = 10;
    rs2_data = 10;

    alu_src = 0;
    alu_control = 4'b0001;

    #20;

    //--------------------------------------------------
    // AND
    //--------------------------------------------------

    rs1_data = 15;
    rs2_data = 7;

    alu_control = 4'b0010;

    #20;

    $finish;

end

endmodule