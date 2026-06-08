module control_unit(

    input wire [6:0] opcode,
    input wire [2:0] funct3,
    input wire [6:0] funct7,

    output reg       reg_write,
    output reg       mem_read,
    output reg       mem_write,
    output reg       branch,
    output reg       alu_src,

    output reg [3:0] alu_control

);

always @(*)
begin

    //--------------------------------------------------
    // Defaults
    //--------------------------------------------------

    reg_write  = 0;
    mem_read   = 0;
    mem_write  = 0;
    branch     = 0;
    alu_src    = 0;
    alu_control = 4'b0000;

    case(opcode)

    //--------------------------------------------------
    // R-Type
    //--------------------------------------------------
    7'b0110011:
    begin

        reg_write = 1;

        case({funct7,funct3})

            {7'b0000000,3'b000}:
                alu_control = 4'b0000; // ADD

            {7'b0100000,3'b000}:
                alu_control = 4'b0001; // SUB

            {7'b0000000,3'b111}:
                alu_control = 4'b0010; // AND

            {7'b0000000,3'b110}:
                alu_control = 4'b0011; // OR

            default:
                alu_control = 4'b0000;

        endcase

    end

    //--------------------------------------------------
    // ADDI
    //--------------------------------------------------
    7'b0010011:
    begin
        reg_write = 1;
        alu_src   = 1;
        alu_control = 4'b0000;
    end

    //--------------------------------------------------
    // LW
    //--------------------------------------------------
    7'b0000011:
    begin
        reg_write = 1;
        mem_read  = 1;
        alu_src   = 1;
        alu_control = 4'b0000;
    end

    //--------------------------------------------------
    // SW
    //--------------------------------------------------
    7'b0100011:
    begin
        mem_write = 1;
        alu_src   = 1;
        alu_control = 4'b0000;
    end

    //--------------------------------------------------
    // BEQ
    //--------------------------------------------------
    7'b1100011:
    begin
        branch = 1;
        alu_control = 4'b0001; // SUB
    end

    default:
    begin
        reg_write  = 0;
        mem_read   = 0;
        mem_write  = 0;
        branch     = 0;
        alu_src    = 0;
        alu_control = 4'b0000;
    end

    endcase

end

endmodule