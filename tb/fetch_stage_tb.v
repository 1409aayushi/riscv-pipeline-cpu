`timescale 1ns/1ps

module fetch_stage_tb;

    reg clk;
    reg rst_n;

    wire [31:0] pc_out;
    wire [31:0] instruction_out;

    fetch_stage DUT(
        .clk(clk),
        .rst_n(rst_n),
        .pc_out(pc_out),
        .instruction_out(instruction_out)
    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("fetch_stage.vcd");
        $dumpvars(0, fetch_stage_tb);

        clk = 0;
        rst_n = 0;

        #20;
        rst_n = 1;

        #100;

        $finish;
    end

endmodule