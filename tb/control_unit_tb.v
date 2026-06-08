`timescale 1ns/1ps

module control_unit_tb;

reg [6:0] opcode;
reg [2:0] funct3;
reg [6:0] funct7;

wire reg_write;
wire mem_read;
wire mem_write;
wire branch;
wire alu_src;
wire [3:0] alu_control;

control_unit DUT(
    .opcode(opcode),
    .funct3(funct3),
    .funct7(funct7),

    .reg_write(reg_write),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .branch(branch),
    .alu_src(alu_src),
    .alu_control(alu_control)
);

initial begin

    $dumpfile("control_unit.vcd");
    $dumpvars(0,control_unit_tb);

    // ADD
    opcode = 7'b0110011;
    funct3 = 3'b000;
    funct7 = 7'b0000000;
    #10;

    // SUB
    funct7 = 7'b0100000;
    #10;

    // LW
    opcode = 7'b0000011;
    #10;

    // SW
    opcode = 7'b0100011;
    #10;

    // BEQ
    opcode = 7'b1100011;
    #10;

    $finish;

end

endmodule