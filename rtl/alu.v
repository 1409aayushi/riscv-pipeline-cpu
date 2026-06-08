module alu(
    input  wire [31:0] operand_a,
    input  wire [31:0] operand_b,
    input  wire [3:0]  alu_control,

    output reg  [31:0] result,
    output wire        zero
);

always @(*)
begin
    case(alu_control)

        4'b0000: result = operand_a + operand_b;   // ADD

        4'b0001: result = operand_a - operand_b;   // SUB

        4'b0010: result = operand_a & operand_b;   // AND

        4'b0011: result = operand_a | operand_b;   // OR

        4'b0100: result = operand_a ^ operand_b;   // XOR

        4'b0101:
        begin
            if($signed(operand_a) < $signed(operand_b))
                result = 32'd1;
            else
                result = 32'd0;
        end

        default:
            result = 32'd0;

    endcase
end

assign zero = (result == 32'd0);

endmodule