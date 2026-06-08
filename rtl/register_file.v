module register_file(
    input  wire        clk,
    input  wire        rst_n,

    // Read Port 1
    input  wire [4:0]  rs1_addr,
    output wire [31:0] rs1_data,

    // Read Port 2
    input  wire [4:0]  rs2_addr,
    output wire [31:0] rs2_data,

    // Write Port
    input  wire        reg_write,
    input  wire [4:0]  rd_addr,
    input  wire [31:0] rd_data
);

    reg [31:0] registers [0:31];

    integer i;

    // Reset + Write Logic
    always @(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
        begin
            for(i = 0; i < 32; i = i + 1)
                registers[i] <= 32'b0;
        end
        else
        begin
            // x0 is hardwired to zero
            if(reg_write && (rd_addr != 5'd0))
                registers[rd_addr] <= rd_data;
        end
    end

    // Asynchronous Reads
    assign rs1_data = (rs1_addr == 5'd0) ?
                      32'b0 :
                      registers[rs1_addr];

    assign rs2_data = (rs2_addr == 5'd0) ?
                      32'b0 :
                      registers[rs2_addr];

endmodule