`timescale 1ns/1ps

module register_file_tb;

    reg clk;
    reg rst_n;

    reg [4:0] rs1_addr;
    reg [4:0] rs2_addr;

    wire [31:0] rs1_data;
    wire [31:0] rs2_data;

    reg reg_write;
    reg [4:0] rd_addr;
    reg [31:0] rd_data;

    register_file DUT(
        .clk(clk),
        .rst_n(rst_n),

        .rs1_addr(rs1_addr),
        .rs1_data(rs1_data),

        .rs2_addr(rs2_addr),
        .rs2_data(rs2_data),

        .reg_write(reg_write),
        .rd_addr(rd_addr),
        .rd_data(rd_data)
    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("register_file.vcd");
        $dumpvars(0, register_file_tb);

        clk = 0;
        rst_n = 0;

        rs1_addr = 0;
        rs2_addr = 0;

        reg_write = 0;
        rd_addr = 0;
        rd_data = 0;

        #20;
        rst_n = 1;

        // Write x5 = 100
        #10;
        reg_write = 1;
        rd_addr = 5;
        rd_data = 100;

        #10;
        reg_write = 0;

        // Read x5
        rs1_addr = 5;

        #20;

        // Attempt to write x0
        reg_write = 1;
        rd_addr = 0;
        rd_data = 999;

        #10;
        reg_write = 0;

        rs1_addr = 0;

        #20;

        $finish;
    end

endmodule