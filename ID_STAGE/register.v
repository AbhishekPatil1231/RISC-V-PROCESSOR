`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2025 06:27:35 PM
// Design Name: 
// Module Name: register
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//==============================================================
// 32x32 Register File for RISC-V Processor
//==============================================================
module register (
    input wire clk,
    input wire rst,
    input wire RegWrite,           // Control: Write enable
    input wire [4:0] rs1,          // Source register 1
    input wire [4:0] rs2,          // Source register 2
    input wire [4:0] rd,           // Destination register
    input wire [31:0] write_data,  // Data to write
    output wire [31:0] rdata1,     // Output from rs1
    output wire [31:0] rdata2      // Output from rs2
);

    // 32 Registers, each 32-bit
    reg [31:0] registers [31:0];
    integer i;

    // Write operation (on positive clock edge)
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            
            for (i = 0; i < 32; i = i + 1)
                registers[i] <= 32'b0;
        end
        else if (RegWrite && rd != 0) begin
            registers[rd] <= write_data;
        end
    end

    // Continuous read (combinational)
    assign rdata1 = (rs1 == 0) ? 32'b0 : registers[rs1];
    assign rdata2 = (rs2 == 0) ? 32'b0 : registers[rs2];

endmodule
