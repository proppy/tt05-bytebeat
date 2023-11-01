// Copyright 2023 Google LLC.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none
`timescale 1us/100ns

module tb (
    );

    initial begin
        $dumpfile ("tb.vcd");
        $dumpvars (0, tb);
        #1;
    end

    // wire up inputs and outputs. Use reg for inputs that will be driven by the testbench.
    reg  clk;
    reg  rst_n;
    reg  ena;
    reg  [7:0] ui_in;
    reg  [7:0] uio_in;

    wire [7:0] uo_out;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;

    tt_um_proppy_bytebeat tt_um_proppy_bytebeat0 (
        `ifdef GL_TEST
            .VPWR( 1'b1),
            .VGND( 1'b0),
        `endif
        .ui_in      (ui_in),    // Dedicated inputs
        .uo_out     (uo_out),   // Dedicated outputs
        .uio_in     (uio_in),   // IOs: Input path
        .uio_out    (uio_out),  // IOs: Output path
        .uio_oe     (uio_oe),   // IOs: Enable path (active high: 0=input, 1=output)
        .ena        (ena),      // enable - goes high when design is selected
        .clk        (clk),      // clock
        .rst_n      (rst_n)     // not reset
    );

endmodule
