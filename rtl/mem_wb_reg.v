module mem_wb_reg(

    input wire clk,
    input wire rst_n,

    //--------------------------------------------------
    // Data
    //--------------------------------------------------

    input wire [31:0] memory_data_in,
    input wire [31:0] alu_result_in,

    input wire [4:0] rd_addr_in,

    //--------------------------------------------------
    // Control
    //--------------------------------------------------

    input wire reg_write_in,

    //--------------------------------------------------
    // Outputs
    //--------------------------------------------------

    output reg [31:0] memory_data_out,
    output reg [31:0] alu_result_out,

    output reg [4:0] rd_addr_out,

    output reg reg_write_out

);

always @(posedge clk or negedge rst_n)
begin

    if(!rst_n)
    begin

        memory_data_out <= 0;
        alu_result_out <= 0;

        rd_addr_out <= 0;

        reg_write_out <= 0;

    end
    else
    begin

        memory_data_out <= memory_data_in;
        alu_result_out <= alu_result_in;

        rd_addr_out <= rd_addr_in;

        reg_write_out <= reg_write_in;

    end

end

endmodule