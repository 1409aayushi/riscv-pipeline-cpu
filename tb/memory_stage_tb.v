`timescale 1ns/1ps

module memory_stage_tb;

reg clk;

reg mem_read;
reg mem_write;

reg [31:0] alu_result;
reg [31:0] rs2_data;

wire [31:0] memory_data;
wire [31:0] address_out;

memory_stage DUT(

    .clk(clk),

    .mem_read(mem_read),
    .mem_write(mem_write),

    .alu_result(alu_result),
    .rs2_data(rs2_data),

    .memory_data(memory_data),
    .address_out(address_out)

);

always #5 clk = ~clk;

initial begin

    $dumpfile("memory_stage.vcd");
    $dumpvars(0,memory_stage_tb);

    clk = 0;

    //--------------------------------------------------
    // Read memory[1]
    //--------------------------------------------------

    mem_read = 1;
    mem_write = 0;

    alu_result = 32'd4;

    #20;

    //--------------------------------------------------
    // Write memory[2]
    //--------------------------------------------------

    mem_read = 0;
    mem_write = 1;

    alu_result = 32'd8;
    rs2_data = 32'd999;

    #20;

    //--------------------------------------------------
    // Read memory[2]
    //--------------------------------------------------

    mem_read = 1;
    mem_write = 0;

    alu_result = 32'd8;

    #20;

    $finish;

end

endmodule