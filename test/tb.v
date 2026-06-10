`timescale 1ns / 1ps

module tb;

    reg  [7:0] ui_in;
    wire [7:0] uo_out;

    reg  [7:0] uio_in;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;

    reg ena;
    reg clk;
    reg rst_n;

    // DUT
    tt_um_i2c_master dut (
        .ui_in(ui_in),
        .uo_out(uo_out),

        .uio_in(uio_in),
        .uio_out(uio_out),
        .uio_oe(uio_oe),

        .ena(ena),
        .clk(clk),
        .rst_n(rst_n)
    );

    // Clock generation (100 MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin

        $dumpfile("tb.vcd");
        $dumpvars(0, tb);

        // Initial values
        ui_in  = 8'h00;
        uio_in = 8'h00;
        ena    = 1'b1;
        rst_n  = 1'b0;

        // Reset
        #20;
        rst_n = 1'b1;

        // Wait a few cycles
        #20;

        // Data to transmit = A5h
        // Bit0 acts as start signal in this design
        ui_in = 8'hA5;

        #100;

        // Clear start
        ui_in = 8'h00;

        #500;

        // Check status
        $display("--------------------------------");
        $display("busy = %b", uo_out[0]);
        $display("done = %b", uo_out[1]);
        $display("ack  = %b", uo_out[2]);
        $display("--------------------------------");

        if (uo_out[1] == 1'b1)
            $display("TEST PASSED");
        else
            $display("TEST FAILED");

        #50;
        $finish;
    end

endmodule
