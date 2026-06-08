module hazard_detection_unit(

    //--------------------------------------------------
    // ID Stage Registers
    //--------------------------------------------------

    input wire [4:0] id_rs1,
    input wire [4:0] id_rs2,

    //--------------------------------------------------
    // EX Stage Load
    //--------------------------------------------------

    input wire       ex_mem_read,
    input wire [4:0] ex_rd,

    //--------------------------------------------------
    // Outputs
    //--------------------------------------------------

    output reg pc_write,
    output reg if_id_write,
    output reg stall

);

always @(*)
begin

    //--------------------------------------------------
    // Defaults
    //--------------------------------------------------

    pc_write   = 1'b1;
    if_id_write = 1'b1;
    stall      = 1'b0;

    //--------------------------------------------------
    // Load-Use Hazard
    //--------------------------------------------------

    if(ex_mem_read &&
       ((ex_rd == id_rs1) ||
        (ex_rd == id_rs2)) &&
       (ex_rd != 0))
    begin

        pc_write    = 1'b0;
        if_id_write = 1'b0;
        stall       = 1'b1;

    end

end

endmodule