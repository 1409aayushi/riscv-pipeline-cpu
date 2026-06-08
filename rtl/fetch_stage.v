module fetch_stage(
    input  wire        clk,
    input  wire        rst_n,

    output wire [31:0] pc_out,
    output wire [31:0] instruction_out
);

    reg [31:0] pc;

    wire [31:0] instruction;

    instruction_memory imem (
        .addr(pc),
        .instruction(instruction)
    );

    always @(posedge clk or negedge rst_n)
    begin
        if (!rst_n)
            pc <= 32'b0;
        else
            pc <= pc + 32'd4;
    end

    assign pc_out = pc;
    assign instruction_out = instruction;

endmodule