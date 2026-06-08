module decode_stage(

    input  wire        clk,
    input  wire        rst_n,

    //--------------------------------------------------
    // Instruction from IF stage
    //--------------------------------------------------
    input  wire [31:0] instruction,

    //--------------------------------------------------
    // Writeback interface
    //--------------------------------------------------
    input  wire        wb_reg_write,
    input  wire [4:0]  wb_rd_addr,
    input  wire [31:0] wb_rd_data,

    //--------------------------------------------------
    // Register outputs
    //--------------------------------------------------
    output wire [31:0] rs1_data,
    output wire [31:0] rs2_data,

    //--------------------------------------------------
    // Immediate
    //--------------------------------------------------
    output wire [31:0] immediate,

    //--------------------------------------------------
    // Destination Register
    //--------------------------------------------------
    output wire [4:0] rd_addr,

    //--------------------------------------------------
    // Control Signals
    //--------------------------------------------------
    output wire        reg_write,
    output wire        mem_read,
    output wire        mem_write,
    output wire        branch,
    output wire        alu_src,

    output wire [3:0]  alu_control

);

    //--------------------------------------------------
    // Instruction Fields
    //--------------------------------------------------

    wire [6:0] opcode;
    wire [4:0] rs1_addr;
    wire [4:0] rs2_addr;
    wire [2:0] funct3;
    wire [6:0] funct7;

    assign opcode   = instruction[6:0];

    assign rd_addr  = instruction[11:7];

    assign funct3   = instruction[14:12];

    assign rs1_addr = instruction[19:15];

    assign rs2_addr = instruction[24:20];

    assign funct7   = instruction[31:25];

    //--------------------------------------------------
    // Register File
    //--------------------------------------------------

    register_file regfile (

        .clk(clk),
        .rst_n(rst_n),

        .rs1_addr(rs1_addr),
        .rs1_data(rs1_data),

        .rs2_addr(rs2_addr),
        .rs2_data(rs2_data),

        .reg_write(wb_reg_write),
        .rd_addr(wb_rd_addr),
        .rd_data(wb_rd_data)

    );

    //--------------------------------------------------
    // Immediate Generator
    //--------------------------------------------------

    immediate_generator imm_gen(

        .instruction(instruction),
        .immediate(immediate)

    );

    //--------------------------------------------------
    // Control Unit
    //--------------------------------------------------

    control_unit ctrl(

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

endmodule