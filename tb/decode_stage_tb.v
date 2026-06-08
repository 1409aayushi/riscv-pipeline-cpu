`timescale 1ns/1ps

module decode_stage_tb;

reg clk;
reg rst_n;

reg [31:0] instruction;

reg wb_reg_write;
reg [4:0] wb_rd_addr;
reg [31:0] wb_rd_data;

wire [31:0] rs1_data;
wire [31:0] rs2_data;
wire [31:0] immediate;

wire [4:0] rd_addr;

wire reg_write;
wire mem_read;
wire mem_write;
wire branch;
wire alu_src;

wire [3:0] alu_control;

decode_stage DUT(

    .clk(clk),
    .rst_n(rst_n),

    .instruction(instruction),

    .wb_reg_write(wb_reg_write),
    .wb_rd_addr(wb_rd_addr),
    .wb_rd_data(wb_rd_data),

    .rs1_data(rs1_data),
    .rs2_data(rs2_data),

    .immediate(immediate),

    .rd_addr(rd_addr),

    .reg_write(reg_write),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .branch(branch),
    .alu_src(alu_src),

    .alu_control(alu_control)

);

always #5 clk = ~clk;

initial begin

    $dumpfile("decode_stage.vcd");
    $dumpvars(0,decode_stage_tb);

    clk = 0;
    rst_n = 0;

    instruction = 0;

    wb_reg_write = 0;
    wb_rd_addr = 0;
    wb_rd_data = 0;

    #20;
    rst_n = 1;

    //--------------------------------------------------
    // Write x1 = 10
    //--------------------------------------------------

    wb_reg_write = 1;
    wb_rd_addr = 5'd1;
    wb_rd_data = 32'd10;

    #10;

    wb_reg_write = 0;

    //--------------------------------------------------
    // addi x2,x1,5
    //--------------------------------------------------

    instruction = 32'h00508113;

    #50;

    $finish;

end

endmodule