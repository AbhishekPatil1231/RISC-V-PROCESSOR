//==============================================================
// Instruction Fetch (IF) Stage
//==============================================================

module IF_stage(
    input clk,
    input rst,
    output [31:0] instr,
    output [31:0] pc_out
);

    wire [31:0] pc_wire;

    // Program Counter (PC)
    PC  (
        .clk(clk),
        .rst(rst),
        .hold(1'b0),         // no stall
        .next_pc(32'b0),     // not branching yet
        .pc_sel(1'b0),       // always increment by 4
        .pc(pc_wire)
    );

    // Instruction Memory
    inst_mem im_inst (
        .addr(pc_wire),
        .instr(instr)
    );

    // Output current PC
    assign pc_out = pc_wire;

endmodule
