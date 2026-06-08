module riscv_pipeline_top(

    input wire clk,
    input wire rst_n

);

    //--------------------------------------------------
    // FETCH STAGE
    //--------------------------------------------------

    wire [31:0] if_pc;
    wire [31:0] if_instruction;

    fetch_stage IF_STAGE(

        .clk(clk),
        .rst_n(rst_n),

        .pc_out(if_pc),
        .instruction_out(if_instruction)

    );

    //--------------------------------------------------
    // IF/ID REGISTER
    //--------------------------------------------------

    wire [31:0] id_pc;
    wire [31:0] id_instruction;

    if_id_reg IF_ID(

        .clk(clk),
        .rst_n(rst_n),

        .pc_in(if_pc),
        .instruction_in(if_instruction),

        .pc_out(id_pc),
        .instruction_out(id_instruction)

    );

    //--------------------------------------------------
    // DECODE STAGE
    //--------------------------------------------------

    wire [31:0] id_rs1_data;
    wire [31:0] id_rs2_data;
    wire [31:0] id_immediate;

    wire [4:0] id_rd_addr;

    wire id_reg_write;
    wire id_mem_read;
    wire id_mem_write;
    wire id_branch;
    wire id_alu_src;

    wire [3:0] id_alu_control;

    //--------------------------------------------------
    // WB Signals (fed back)
    //--------------------------------------------------

    wire wb_reg_write;
    wire [4:0] wb_rd_addr;
    wire [31:0] wb_write_data;

    decode_stage ID_STAGE(

        .clk(clk),
        .rst_n(rst_n),

        .instruction(id_instruction),

        .wb_reg_write(wb_reg_write),
        .wb_rd_addr(wb_rd_addr),
        .wb_rd_data(wb_write_data),

        .rs1_data(id_rs1_data),
        .rs2_data(id_rs2_data),

        .immediate(id_immediate),

        .rd_addr(id_rd_addr),

        .reg_write(id_reg_write),
        .mem_read(id_mem_read),
        .mem_write(id_mem_write),
        .branch(id_branch),
        .alu_src(id_alu_src),

        .alu_control(id_alu_control)

    );

    //--------------------------------------------------
    // ID/EX REGISTER
    //--------------------------------------------------

    wire [31:0] ex_rs1_data;
    wire [31:0] ex_rs2_data;
    wire [31:0] ex_immediate;

    wire [4:0] ex_rd_addr;

    wire ex_reg_write;
    wire ex_mem_read;
    wire ex_mem_write;
    wire ex_branch;
    wire ex_alu_src;

    wire [3:0] ex_alu_control;

    id_ex_reg ID_EX(

        .clk(clk),
        .rst_n(rst_n),

        .rs1_data_in(id_rs1_data),
        .rs2_data_in(id_rs2_data),
        .immediate_in(id_immediate),

        .rd_addr_in(id_rd_addr),

        .reg_write_in(id_reg_write),
        .mem_read_in(id_mem_read),
        .mem_write_in(id_mem_write),
        .branch_in(id_branch),
        .alu_src_in(id_alu_src),

        .alu_control_in(id_alu_control),

        .rs1_data_out(ex_rs1_data),
        .rs2_data_out(ex_rs2_data),
        .immediate_out(ex_immediate),

        .rd_addr_out(ex_rd_addr),

        .reg_write_out(ex_reg_write),
        .mem_read_out(ex_mem_read),
        .mem_write_out(ex_mem_write),
        .branch_out(ex_branch),
        .alu_src_out(ex_alu_src),

        .alu_control_out(ex_alu_control)

    );

    //--------------------------------------------------
    // EXECUTE STAGE
    //--------------------------------------------------

    wire [31:0] ex_alu_result;
    wire ex_zero;

    execute_stage EX_STAGE(

        .rs1_data(ex_rs1_data),
        .rs2_data(ex_rs2_data),

        .immediate(ex_immediate),

        .alu_src(ex_alu_src),
        .alu_control(ex_alu_control),

        .alu_result(ex_alu_result),
        .zero(ex_zero)

    );

    //--------------------------------------------------
    // EX/MEM REGISTER
    //--------------------------------------------------

    wire [31:0] mem_alu_result;
    wire [31:0] mem_rs2_data;

    wire [4:0] mem_rd_addr;

    wire mem_reg_write;
    wire mem_mem_read;
    wire mem_mem_write;

    ex_mem_reg EX_MEM(

        .clk(clk),
        .rst_n(rst_n),

        .alu_result_in(ex_alu_result),
        .rs2_data_in(ex_rs2_data),

        .rd_addr_in(ex_rd_addr),

        .reg_write_in(ex_reg_write),
        .mem_read_in(ex_mem_read),
        .mem_write_in(ex_mem_write),

        .alu_result_out(mem_alu_result),
        .rs2_data_out(mem_rs2_data),

        .rd_addr_out(mem_rd_addr),

        .reg_write_out(mem_reg_write),
        .mem_read_out(mem_mem_read),
        .mem_write_out(mem_mem_write)

    );

    //--------------------------------------------------
    // MEMORY STAGE
    //--------------------------------------------------

    wire [31:0] memory_data;
    wire [31:0] memory_address;

    memory_stage MEM_STAGE(

        .clk(clk),

        .mem_read(mem_mem_read),
        .mem_write(mem_mem_write),

        .alu_result(mem_alu_result),
        .rs2_data(mem_rs2_data),

        .memory_data(memory_data),
        .address_out(memory_address)

    );

    //--------------------------------------------------
    // MEM/WB REGISTER
    //--------------------------------------------------

    wire [31:0] wb_memory_data;
    wire [31:0] wb_alu_result;

    mem_wb_reg MEM_WB(

        .clk(clk),
        .rst_n(rst_n),

        .memory_data_in(memory_data),
        .alu_result_in(mem_alu_result),

        .rd_addr_in(mem_rd_addr),

        .reg_write_in(mem_reg_write),

        .memory_data_out(wb_memory_data),
        .alu_result_out(wb_alu_result),

        .rd_addr_out(wb_rd_addr),

        .reg_write_out(wb_reg_write)

    );

    //--------------------------------------------------
    // WRITEBACK STAGE
    //--------------------------------------------------

    // Temporary:
    // Assume ALU result writes back.
    // Later add mem_to_reg support.

    assign wb_write_data = wb_alu_result;

endmodule