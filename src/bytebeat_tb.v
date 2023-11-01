// Copyright 2023 Google LLC.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none
`timescale 1us/100ns

module bytebeat_tb;
  reg clk;
  reg rst;

  reg[3:0] a;
  reg[3:0] b;
  reg[3:0] c;
  reg[3:0] d;
  wire[7:0] out0;
  wire out0_valid;

  bytebeat bytebeat0(
    .clk(clk),
    .reset(rst),
    .bytebeat__a_r(a),
    .bytebeat__a_r_vld(1'b1),
    .bytebeat__b_r(b),
    .bytebeat__b_r_vld(1'b1),
    .bytebeat__c_r(c),
    .bytebeat__c_r_vld(1'b1),
    .bytebeat__d_r(d),
    .bytebeat__d_r_vld(1'b1),
    .bytebeat__output_s_rdy(1'b1),
    .bytebeat__output_s(out0),
    .bytebeat__output_s_vld(out0_valid));

  // clock period is 62.5 * 2 = 0.125ms == 8000hz
  always #62.5 clk = !clk; 

  initial begin
    $dumpfile("test.vcd");
    $dumpvars(0,bytebeat_tb);
    clk <= 0;
    rst <= 1;
    a <= 4'd5;
    b <= 4'd7;
    c <= 4'd3;
    d <= 4'd10;
    #125 rst <= 0;
    #8192000 rst <= 1;
    a <= 4'd3;
    b <= 4'd6;
    c <= 4'd2;
    d <= 4'd9;
    #125 rst <= 0;
    #8192000  $finish;
  end
endmodule
