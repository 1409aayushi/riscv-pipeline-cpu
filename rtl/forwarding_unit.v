module forwarding_unit(

    //--------------------------------------------------
    // Source Registers from ID/EX
    //--------------------------------------------------

    input wire [4:0] rs1,
    input wire [4:0] rs2,

    //--------------------------------------------------
    // Destination Register from EX/MEM
    //--------------------------------------------------

    input wire ex_mem_reg_write,
    input wire [4:0] ex_mem_rd,

    //--------------------------------------------------
    // Destination Register from MEM/WB
    //--------------------------------------------------

    input wire mem_wb_reg_write,
    input wire [4:0] mem_wb_rd,

    //--------------------------------------------------
    // Forwarding Control
    //--------------------------------------------------

    output reg [1:0] forward_a,
    output reg [1:0] forward_b

);

always @(*)
begin

    //--------------------------------------------------
    // Defaults
    //--------------------------------------------------

    forward_a = 2'b00;
    forward_b = 2'b00;

    //--------------------------------------------------
    // EX Hazard
    //--------------------------------------------------

    if(ex_mem_reg_write &&
       (ex_mem_rd != 0) &&
       (ex_mem_rd == rs1))
    begin
        forward_a = 2'b10;
    end

    if(ex_mem_reg_write &&
       (ex_mem_rd != 0) &&
       (ex_mem_rd == rs2))
    begin
        forward_b = 2'b10;
    end

    //--------------------------------------------------
    // MEM Hazard
    //--------------------------------------------------

    if(mem_wb_reg_write &&
       (mem_wb_rd != 0) &&
       !(ex_mem_reg_write &&
         (ex_mem_rd != 0) &&
         (ex_mem_rd == rs1)) &&
       (mem_wb_rd == rs1))
    begin
        forward_a = 2'b01;
    end

    if(mem_wb_reg_write &&
       (mem_wb_rd != 0) &&
       !(ex_mem_reg_write &&
         (ex_mem_rd != 0) &&
         (ex_mem_rd == rs2)) &&
       (mem_wb_rd == rs2))
    begin
        forward_b = 2'b01;
    end

end

endmodule