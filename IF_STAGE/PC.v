//==============================================================
// 32-bit Program Counter (PC) for RISC-V Processor
//==============================================================

module PC (
    input wire clk,             // Clock signal
    input wire rst,              // Active-high reset
    input wire hold,             // Hold PC (stall signal)
    input wire [31:0] next_pc,   // Branch/jump target
    input wire pc_sel,           // 0 = +4 increment, 1 = load next_pc
    output reg [31:0] pc         // Current Program Counter value
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pc <= 32'b0;                     // Reset to 0x00000000
        end 
        else if (!hold) begin                // Update only when not holding
            if (pc_sel)
                pc <= next_pc;               // Jump/branch address
            else if (pc == 32'hFFFFFFFC)     // Overflow protection
                pc <= 32'b0;                 // Wrap around
            else
                pc <= pc + 4;                // Normal sequential increment
        end
        // hold = 1 -> retain current value
    end

endmodule

