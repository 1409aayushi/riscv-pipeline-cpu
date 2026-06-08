`timescale 1ns/1ps

module immediate_generator_tb;

    reg  [31:0] instruction;
    wire [31:0] immediate;

    immediate_generator DUT(
        .instruction(instruction),
        .immediate(immediate)
    );

    initial
    begin

        $dumpfile("immediate_generator.vcd");
        $dumpvars(0, immediate_generator_tb);

        //--------------------------------------------------
        // ADDI x1,x0,5
        //--------------------------------------------------
        instruction = 32'h00500093;
        #10;

        //--------------------------------------------------
        // LW x1,4(x0)
        //--------------------------------------------------
        instruction = 32'h00402083;
        #10;

        //--------------------------------------------------
        // SW x1,8(x0)
        //--------------------------------------------------
        instruction = 32'h00102423;
        #10;

        //--------------------------------------------------
        // BEQ example
        //--------------------------------------------------
        instruction = 32'h00208463;
        #10;

        $finish;
    end

endmodule