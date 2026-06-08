module id_ex_reg(

    input wire clk,
    input wire rst_n,

    //--------------------------------------------------
    // Data Signals
    //--------------------------------------------------

    input wire [31:0] rs1_data_in,
    input wire [31:0] rs2_data_in,
    input wire [31:0] immediate_in,

    input wire [4:0] rd_addr_in,

    //--------------------------------------------------
    // Control Signals
    //--------------------------------------------------

    input wire reg_write_in,
    input wire mem_read_in,
    input wire mem_write_in,
    input wire branch_in,
    input wire alu_src_in,

    input wire [3:0] alu_control_in,

    //--------------------------------------------------
    // Outputs
    //--------------------------------------------------

    output reg [31:0] rs1_data_out,
    output reg [31:0] rs2_data_out,
    output reg [31:0] immediate_out,

    output reg [4:0] rd_addr_out,

    output reg reg_write_out,
    output reg mem_read_out,
    output reg mem_write_out,
    output reg branch_out,
    output reg alu_src_out,

    output reg [3:0] alu_control_out

);

always @(posedge clk or negedge rst_n)
begin

    if(!rst_n)
    begin

        rs1_data_out <= 0;
        rs2_data_out <= 0;
        immediate_out <= 0;

        rd_addr_out <= 0;

        reg_write_out <= 0;
        mem_read_out <= 0;
        mem_write_out <= 0;
        branch_out <= 0;
        alu_src_out <= 0;

        alu_control_out <= 0;

    end
    else
    begin

        rs1_data_out <= rs1_data_in;
        rs2_data_out <= rs2_data_in;
        immediate_out <= immediate_in;

        rd_addr_out <= rd_addr_in;

        reg_write_out <= reg_write_in;
        mem_read_out <= mem_read_in;
        mem_write_out <= mem_write_in;
        branch_out <= branch_in;
        alu_src_out <= alu_src_in;

        alu_control_out <= alu_control_in;

    end

end

endmodule