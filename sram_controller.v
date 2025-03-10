module sram_controller (
    input clk, we, oe, ce, // Control signals
    input [15:0] addr, // 16-bit address
    inout [7:0] data // 8-bit bidirectional data bus
);

    reg [7:0] memory [0:65535]; // 64K x 8-bit SRAM
    reg [7:0] data_out;
    
    assign data = (!oe && ce) ? data_out : 8'bz; // Tri-state bus for read

    always @(posedge clk) begin
        if (!ce) begin
            if (we) 
                memory[addr] <= data; // Write operation
            else if (!oe) 
                data_out <= memory[addr]; // Read operation
        end
    end

endmodule
