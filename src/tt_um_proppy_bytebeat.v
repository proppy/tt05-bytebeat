// Copyright 2023 Google LLC.
// SPDX-License-Identifier: Apache-2.0
`default_nettype none

module tt_um_proppy_bytebeat (
			      input wire [7:0] 	ui_in, // Dedicated inputs
			      output wire [7:0] uo_out, // Dedicated outputs
			      input wire [7:0] 	uio_in, // IOs: Input path
			      output wire [7:0] uio_out, // IOs: Output path
			      output wire [7:0] uio_oe, // IOs: Enable path (active high: 0=input, 1=output)
			      input wire 	ena, // will go high when the design is enabled
			      input wire 	clk, // clock
			      input wire 	rst_n     // reset_n - low to reset
			      );
   wire 					rst = ! rst_n;
   wire [3:0] 					a = ui_in[3:0];
   wire 					a_rdy;
   wire [3:0] 					b = ui_in[7:4];
   wire 					b_rdy;
   wire [3:0] 					c = uio_in[3:0];
   wire 					c_rdy;
   wire [3:0] 					d = uio_in[7:4];
   wire 					d_rdy;
   wire [7:0] 					pcm;
   wire 					pcm_vld;

   bytebeat bytebeat0(.clk(clk),
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
		      .bytebeat__output_s(pcm),
		      .bytebeat__output_s_vld(pcm_vld),
		      .bytebeat__a_r_rdy(a_rdy),
		      .bytebeat__b_r_rdy(b_rdy),
		      .bytebeat__c_r_rdy(c_rdy),
		      .bytebeat__d_r_rdy(d_rdy));

   assign uio_oe = 8'b00000000; // set uio as inputs.
   assign uo_out = pcm; // feed pcm samples to output pins.
endmodule
