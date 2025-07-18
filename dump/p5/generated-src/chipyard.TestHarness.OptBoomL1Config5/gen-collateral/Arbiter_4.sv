// Generated by CIRCT unknown git version
// Standard header to adapt well known macros to our needs.
`ifndef RANDOMIZE
  `ifdef RANDOMIZE_REG_INIT
    `define RANDOMIZE
  `endif // RANDOMIZE_REG_INIT
`endif // not def RANDOMIZE
`ifndef RANDOMIZE
  `ifdef RANDOMIZE_MEM_INIT
    `define RANDOMIZE
  `endif // RANDOMIZE_MEM_INIT
`endif // not def RANDOMIZE

// RANDOM may be set to an expression that produces a 32-bit random unsigned value.
`ifndef RANDOM
  `define RANDOM $random
`endif // not def RANDOM

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

// Users can define 'ASSERT_VERBOSE_COND' to add an extra gate to assert error printing.
`ifndef ASSERT_VERBOSE_COND_
  `ifdef ASSERT_VERBOSE_COND
    `define ASSERT_VERBOSE_COND_ (`ASSERT_VERBOSE_COND)
  `else  // ASSERT_VERBOSE_COND
    `define ASSERT_VERBOSE_COND_ 1
  `endif // ASSERT_VERBOSE_COND
`endif // not def ASSERT_VERBOSE_COND_

// Users can define 'STOP_COND' to add an extra gate to stop conditions.
`ifndef STOP_COND_
  `ifdef STOP_COND
    `define STOP_COND_ (`STOP_COND)
  `else  // STOP_COND
    `define STOP_COND_ 1
  `endif // STOP_COND
`endif // not def STOP_COND_

// Users can define INIT_RANDOM as general code that gets injected into the
// initializer block for modules with registers.
`ifndef INIT_RANDOM
  `define INIT_RANDOM
`endif // not def INIT_RANDOM

// If using random initialization, you can also define RANDOMIZE_DELAY to
// customize the delay used, otherwise 0.002 is used.
`ifndef RANDOMIZE_DELAY
  `define RANDOMIZE_DELAY 0.002
`endif // not def RANDOMIZE_DELAY

// Define INIT_RANDOM_PROLOG_ for use in our modules below.
`ifndef INIT_RANDOM_PROLOG_
  `ifdef RANDOMIZE
    `ifdef VERILATOR
      `define INIT_RANDOM_PROLOG_ `INIT_RANDOM
    `else  // VERILATOR
      `define INIT_RANDOM_PROLOG_ `INIT_RANDOM #`RANDOMIZE_DELAY begin end
    `endif // VERILATOR
  `else  // RANDOMIZE
    `define INIT_RANDOM_PROLOG_
  `endif // RANDOMIZE
`endif // not def INIT_RANDOM_PROLOG_

module Arbiter_4(
  input         io_in_0_valid,
  input  [19:0] io_in_0_bits_tag,
  input  [5:0]  io_in_0_bits_idx,
  input  [2:0]  io_in_0_bits_param,
  input  [7:0]  io_in_0_bits_way_en,
  input         io_in_1_valid,
  input  [19:0] io_in_1_bits_tag,
  input  [5:0]  io_in_1_bits_idx,
  input  [2:0]  io_in_1_bits_param,
  input  [7:0]  io_in_1_bits_way_en,
  input         io_in_2_valid,
  input  [19:0] io_in_2_bits_tag,
  input  [5:0]  io_in_2_bits_idx,
  input  [2:0]  io_in_2_bits_param,
  input  [7:0]  io_in_2_bits_way_en,
  input         io_in_3_valid,
  input  [19:0] io_in_3_bits_tag,
  input  [5:0]  io_in_3_bits_idx,
  input  [2:0]  io_in_3_bits_param,
  input  [7:0]  io_in_3_bits_way_en,
  input         io_in_4_valid,
  input  [19:0] io_in_4_bits_tag,
  input  [5:0]  io_in_4_bits_idx,
  input  [2:0]  io_in_4_bits_param,
  input  [7:0]  io_in_4_bits_way_en,
  input         io_in_5_valid,
  input  [19:0] io_in_5_bits_tag,
  input  [5:0]  io_in_5_bits_idx,
  input  [2:0]  io_in_5_bits_param,
  input  [7:0]  io_in_5_bits_way_en,
  input         io_in_6_valid,
  input  [19:0] io_in_6_bits_tag,
  input  [5:0]  io_in_6_bits_idx,
  input  [2:0]  io_in_6_bits_param,
  input  [7:0]  io_in_6_bits_way_en,
  input         io_in_7_valid,
  input  [19:0] io_in_7_bits_tag,
  input  [5:0]  io_in_7_bits_idx,
  input  [2:0]  io_in_7_bits_param,
  input  [7:0]  io_in_7_bits_way_en,
  input         io_out_ready,
  output        io_in_0_ready,
                io_in_1_ready,
                io_in_2_ready,
                io_in_3_ready,
                io_in_4_ready,
                io_in_5_ready,
                io_in_6_ready,
                io_in_7_ready,
                io_out_valid,
  output [19:0] io_out_bits_tag,
  output [5:0]  io_out_bits_idx,
  output [2:0]  io_out_bits_param,
  output [7:0]  io_out_bits_way_en
);

  wire _grant_T = io_in_0_valid | io_in_1_valid;	// @[Arbiter.scala:45:68]
  wire _grant_T_1 = _grant_T | io_in_2_valid;	// @[Arbiter.scala:45:68]
  wire _grant_T_2 = _grant_T_1 | io_in_3_valid;	// @[Arbiter.scala:45:68]
  wire _grant_T_3 = _grant_T_2 | io_in_4_valid;	// @[Arbiter.scala:45:68]
  wire _grant_T_4 = _grant_T_3 | io_in_5_valid;	// @[Arbiter.scala:45:68]
  wire _grant_T_5 = _grant_T_4 | io_in_6_valid;	// @[Arbiter.scala:45:68]
  assign io_in_0_ready = io_out_ready;
  assign io_in_1_ready = ~io_in_0_valid & io_out_ready;	// @[Arbiter.scala:45:78, :146:19]
  assign io_in_2_ready = ~_grant_T & io_out_ready;	// @[Arbiter.scala:45:{68,78}, :146:19]
  assign io_in_3_ready = ~_grant_T_1 & io_out_ready;	// @[Arbiter.scala:45:{68,78}, :146:19]
  assign io_in_4_ready = ~_grant_T_2 & io_out_ready;	// @[Arbiter.scala:45:{68,78}, :146:19]
  assign io_in_5_ready = ~_grant_T_3 & io_out_ready;	// @[Arbiter.scala:45:{68,78}, :146:19]
  assign io_in_6_ready = ~_grant_T_4 & io_out_ready;	// @[Arbiter.scala:45:{68,78}, :146:19]
  assign io_in_7_ready = ~_grant_T_5 & io_out_ready;	// @[Arbiter.scala:45:{68,78}, :146:19]
  assign io_out_valid = _grant_T_5 | io_in_7_valid;	// @[Arbiter.scala:45:68, :147:31]
  assign io_out_bits_tag = io_in_0_valid ? io_in_0_bits_tag : io_in_1_valid ? io_in_1_bits_tag : io_in_2_valid ? io_in_2_bits_tag : io_in_3_valid ? io_in_3_bits_tag : io_in_4_valid ? io_in_4_bits_tag : io_in_5_valid ? io_in_5_bits_tag : io_in_6_valid ? io_in_6_bits_tag : io_in_7_bits_tag;	// @[Arbiter.scala:136:15, :138:26, :140:19]
  assign io_out_bits_idx = io_in_0_valid ? io_in_0_bits_idx : io_in_1_valid ? io_in_1_bits_idx : io_in_2_valid ? io_in_2_bits_idx : io_in_3_valid ? io_in_3_bits_idx : io_in_4_valid ? io_in_4_bits_idx : io_in_5_valid ? io_in_5_bits_idx : io_in_6_valid ? io_in_6_bits_idx : io_in_7_bits_idx;	// @[Arbiter.scala:136:15, :138:26, :140:19]
  assign io_out_bits_param = io_in_0_valid ? io_in_0_bits_param : io_in_1_valid ? io_in_1_bits_param : io_in_2_valid ? io_in_2_bits_param : io_in_3_valid ? io_in_3_bits_param : io_in_4_valid ? io_in_4_bits_param : io_in_5_valid ? io_in_5_bits_param : io_in_6_valid ? io_in_6_bits_param : io_in_7_bits_param;	// @[Arbiter.scala:136:15, :138:26, :140:19]
  assign io_out_bits_way_en = io_in_0_valid ? io_in_0_bits_way_en : io_in_1_valid ? io_in_1_bits_way_en : io_in_2_valid ? io_in_2_bits_way_en : io_in_3_valid ? io_in_3_bits_way_en : io_in_4_valid ? io_in_4_bits_way_en : io_in_5_valid ? io_in_5_bits_way_en : io_in_6_valid ? io_in_6_bits_way_en : io_in_7_bits_way_en;	// @[Arbiter.scala:136:15, :138:26, :140:19]
endmodule

