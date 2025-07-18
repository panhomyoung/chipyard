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

module PipelinedMulUnit(
  input         clock,
                reset,
                io_req_valid,
  input  [3:0]  io_req_bits_uop_ctrl_op_fcn,
  input         io_req_bits_uop_ctrl_fcn_dw,
  input  [15:0] io_req_bits_uop_br_mask,
  input  [7:0]  io_req_bits_uop_rob_idx,
  input  [5:0]  io_req_bits_uop_pdst,
  input         io_req_bits_uop_bypassable,
                io_req_bits_uop_is_amo,
                io_req_bits_uop_uses_stq,
  input  [1:0]  io_req_bits_uop_dst_rtype,
  input  [63:0] io_req_bits_rs1_data,
                io_req_bits_rs2_data,
  input         io_req_bits_kill,
  input  [15:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  output        io_resp_valid,
  output [7:0]  io_resp_bits_uop_rob_idx,
  output [5:0]  io_resp_bits_uop_pdst,
  output        io_resp_bits_uop_bypassable,
                io_resp_bits_uop_is_amo,
                io_resp_bits_uop_uses_stq,
  output [1:0]  io_resp_bits_uop_dst_rtype,
  output [63:0] io_resp_bits_data
);

  reg        r_valids_0;	// @[functional-unit.scala:226:27]
  reg        r_valids_1;	// @[functional-unit.scala:226:27]
  reg        r_valids_2;	// @[functional-unit.scala:226:27]
  reg [15:0] r_uops_0_br_mask;	// @[functional-unit.scala:227:23]
  reg [7:0]  r_uops_0_rob_idx;	// @[functional-unit.scala:227:23]
  reg [5:0]  r_uops_0_pdst;	// @[functional-unit.scala:227:23]
  reg        r_uops_0_bypassable;	// @[functional-unit.scala:227:23]
  reg        r_uops_0_is_amo;	// @[functional-unit.scala:227:23]
  reg        r_uops_0_uses_stq;	// @[functional-unit.scala:227:23]
  reg [1:0]  r_uops_0_dst_rtype;	// @[functional-unit.scala:227:23]
  reg [15:0] r_uops_1_br_mask;	// @[functional-unit.scala:227:23]
  reg [7:0]  r_uops_1_rob_idx;	// @[functional-unit.scala:227:23]
  reg [5:0]  r_uops_1_pdst;	// @[functional-unit.scala:227:23]
  reg        r_uops_1_bypassable;	// @[functional-unit.scala:227:23]
  reg        r_uops_1_is_amo;	// @[functional-unit.scala:227:23]
  reg        r_uops_1_uses_stq;	// @[functional-unit.scala:227:23]
  reg [1:0]  r_uops_1_dst_rtype;	// @[functional-unit.scala:227:23]
  reg [15:0] r_uops_2_br_mask;	// @[functional-unit.scala:227:23]
  reg [7:0]  r_uops_2_rob_idx;	// @[functional-unit.scala:227:23]
  reg [5:0]  r_uops_2_pdst;	// @[functional-unit.scala:227:23]
  reg        r_uops_2_bypassable;	// @[functional-unit.scala:227:23]
  reg        r_uops_2_is_amo;	// @[functional-unit.scala:227:23]
  reg        r_uops_2_uses_stq;	// @[functional-unit.scala:227:23]
  reg [1:0]  r_uops_2_dst_rtype;	// @[functional-unit.scala:227:23]
  always @(posedge clock) begin
    if (reset) begin
      r_valids_0 <= 1'h0;	// @[functional-unit.scala:226:27]
      r_valids_1 <= 1'h0;	// @[functional-unit.scala:226:27]
      r_valids_2 <= 1'h0;	// @[functional-unit.scala:226:27]
    end
    else begin
      r_valids_0 <= io_req_valid & (io_brupdate_b1_mispredict_mask & io_req_bits_uop_br_mask) == 16'h0 & ~io_req_bits_kill;	// @[functional-unit.scala:226:27, :230:{84,87}, util.scala:118:{51,59}]
      r_valids_1 <= r_valids_0 & (io_brupdate_b1_mispredict_mask & r_uops_0_br_mask) == 16'h0 & ~io_req_bits_kill;	// @[functional-unit.scala:226:27, :227:23, :230:87, :236:83, util.scala:118:{51,59}]
      r_valids_2 <= r_valids_1 & (io_brupdate_b1_mispredict_mask & r_uops_1_br_mask) == 16'h0 & ~io_req_bits_kill;	// @[functional-unit.scala:226:27, :227:23, :230:87, :236:83, util.scala:118:{51,59}]
    end
    r_uops_0_br_mask <= io_req_bits_uop_br_mask & ~io_brupdate_b1_resolve_mask;	// @[functional-unit.scala:227:23, util.scala:85:{25,27}]
    r_uops_0_rob_idx <= io_req_bits_uop_rob_idx;	// @[functional-unit.scala:227:23]
    r_uops_0_pdst <= io_req_bits_uop_pdst;	// @[functional-unit.scala:227:23]
    r_uops_0_bypassable <= io_req_bits_uop_bypassable;	// @[functional-unit.scala:227:23]
    r_uops_0_is_amo <= io_req_bits_uop_is_amo;	// @[functional-unit.scala:227:23]
    r_uops_0_uses_stq <= io_req_bits_uop_uses_stq;	// @[functional-unit.scala:227:23]
    r_uops_0_dst_rtype <= io_req_bits_uop_dst_rtype;	// @[functional-unit.scala:227:23]
    r_uops_1_br_mask <= r_uops_0_br_mask & ~io_brupdate_b1_resolve_mask;	// @[functional-unit.scala:227:23, util.scala:85:{25,27}]
    r_uops_1_rob_idx <= r_uops_0_rob_idx;	// @[functional-unit.scala:227:23]
    r_uops_1_pdst <= r_uops_0_pdst;	// @[functional-unit.scala:227:23]
    r_uops_1_bypassable <= r_uops_0_bypassable;	// @[functional-unit.scala:227:23]
    r_uops_1_is_amo <= r_uops_0_is_amo;	// @[functional-unit.scala:227:23]
    r_uops_1_uses_stq <= r_uops_0_uses_stq;	// @[functional-unit.scala:227:23]
    r_uops_1_dst_rtype <= r_uops_0_dst_rtype;	// @[functional-unit.scala:227:23]
    r_uops_2_br_mask <= r_uops_1_br_mask & ~io_brupdate_b1_resolve_mask;	// @[functional-unit.scala:227:23, util.scala:85:{25,27}]
    r_uops_2_rob_idx <= r_uops_1_rob_idx;	// @[functional-unit.scala:227:23]
    r_uops_2_pdst <= r_uops_1_pdst;	// @[functional-unit.scala:227:23]
    r_uops_2_bypassable <= r_uops_1_bypassable;	// @[functional-unit.scala:227:23]
    r_uops_2_is_amo <= r_uops_1_is_amo;	// @[functional-unit.scala:227:23]
    r_uops_2_uses_stq <= r_uops_1_uses_stq;	// @[functional-unit.scala:227:23]
    r_uops_2_dst_rtype <= r_uops_1_dst_rtype;	// @[functional-unit.scala:227:23]
  end // always @(posedge)
  `ifndef SYNTHESIS
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM_0;
    logic [31:0] _RANDOM_1;
    logic [31:0] _RANDOM_2;
    logic [31:0] _RANDOM_3;
    logic [31:0] _RANDOM_4;
    logic [31:0] _RANDOM_5;
    logic [31:0] _RANDOM_6;
    logic [31:0] _RANDOM_7;
    logic [31:0] _RANDOM_8;
    logic [31:0] _RANDOM_9;
    logic [31:0] _RANDOM_10;
    logic [31:0] _RANDOM_11;
    logic [31:0] _RANDOM_12;
    logic [31:0] _RANDOM_13;
    logic [31:0] _RANDOM_14;
    logic [31:0] _RANDOM_15;
    logic [31:0] _RANDOM_16;
    logic [31:0] _RANDOM_17;
    logic [31:0] _RANDOM_18;
    logic [31:0] _RANDOM_19;
    logic [31:0] _RANDOM_20;
    logic [31:0] _RANDOM_21;
    logic [31:0] _RANDOM_22;
    logic [31:0] _RANDOM_23;
    logic [31:0] _RANDOM_24;
    logic [31:0] _RANDOM_25;
    logic [31:0] _RANDOM_26;
    logic [31:0] _RANDOM_27;
    logic [31:0] _RANDOM_28;
    logic [31:0] _RANDOM_29;
    logic [31:0] _RANDOM_30;
    logic [31:0] _RANDOM_31;
    logic [31:0] _RANDOM_32;
    logic [31:0] _RANDOM_33;
    logic [31:0] _RANDOM_34;
    logic [31:0] _RANDOM_35;
    logic [31:0] _RANDOM_36;
    logic [31:0] _RANDOM_37;
    initial begin
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        _RANDOM_0 = `RANDOM;
        _RANDOM_1 = `RANDOM;
        _RANDOM_2 = `RANDOM;
        _RANDOM_3 = `RANDOM;
        _RANDOM_4 = `RANDOM;
        _RANDOM_5 = `RANDOM;
        _RANDOM_6 = `RANDOM;
        _RANDOM_7 = `RANDOM;
        _RANDOM_8 = `RANDOM;
        _RANDOM_9 = `RANDOM;
        _RANDOM_10 = `RANDOM;
        _RANDOM_11 = `RANDOM;
        _RANDOM_12 = `RANDOM;
        _RANDOM_13 = `RANDOM;
        _RANDOM_14 = `RANDOM;
        _RANDOM_15 = `RANDOM;
        _RANDOM_16 = `RANDOM;
        _RANDOM_17 = `RANDOM;
        _RANDOM_18 = `RANDOM;
        _RANDOM_19 = `RANDOM;
        _RANDOM_20 = `RANDOM;
        _RANDOM_21 = `RANDOM;
        _RANDOM_22 = `RANDOM;
        _RANDOM_23 = `RANDOM;
        _RANDOM_24 = `RANDOM;
        _RANDOM_25 = `RANDOM;
        _RANDOM_26 = `RANDOM;
        _RANDOM_27 = `RANDOM;
        _RANDOM_28 = `RANDOM;
        _RANDOM_29 = `RANDOM;
        _RANDOM_30 = `RANDOM;
        _RANDOM_31 = `RANDOM;
        _RANDOM_32 = `RANDOM;
        _RANDOM_33 = `RANDOM;
        _RANDOM_34 = `RANDOM;
        _RANDOM_35 = `RANDOM;
        _RANDOM_36 = `RANDOM;
        _RANDOM_37 = `RANDOM;
        r_valids_0 = _RANDOM_0[0];	// @[functional-unit.scala:226:27]
        r_valids_1 = _RANDOM_0[1];	// @[functional-unit.scala:226:27]
        r_valids_2 = _RANDOM_0[2];	// @[functional-unit.scala:226:27]
        r_uops_0_br_mask = {_RANDOM_4[31], _RANDOM_5[14:0]};	// @[functional-unit.scala:227:23]
        r_uops_0_rob_idx = _RANDOM_7[8:1];	// @[functional-unit.scala:227:23]
        r_uops_0_pdst = _RANDOM_7[26:21];	// @[functional-unit.scala:227:23]
        r_uops_0_bypassable = _RANDOM_10[30];	// @[functional-unit.scala:227:23]
        r_uops_0_is_amo = _RANDOM_11[9];	// @[functional-unit.scala:227:23]
        r_uops_0_uses_stq = _RANDOM_11[11];	// @[functional-unit.scala:227:23]
        r_uops_0_dst_rtype = _RANDOM_12[10:9];	// @[functional-unit.scala:227:23]
        r_uops_1_br_mask = {_RANDOM_17[31:23], _RANDOM_18[6:0]};	// @[functional-unit.scala:227:23]
        r_uops_1_rob_idx = {_RANDOM_19[31:25], _RANDOM_20[0]};	// @[functional-unit.scala:227:23]
        r_uops_1_pdst = _RANDOM_20[18:13];	// @[functional-unit.scala:227:23]
        r_uops_1_bypassable = _RANDOM_23[22];	// @[functional-unit.scala:227:23]
        r_uops_1_is_amo = _RANDOM_24[1];	// @[functional-unit.scala:227:23]
        r_uops_1_uses_stq = _RANDOM_24[3];	// @[functional-unit.scala:227:23]
        r_uops_1_dst_rtype = _RANDOM_25[2:1];	// @[functional-unit.scala:227:23]
        r_uops_2_br_mask = _RANDOM_30[30:15];	// @[functional-unit.scala:227:23]
        r_uops_2_rob_idx = _RANDOM_32[24:17];	// @[functional-unit.scala:227:23]
        r_uops_2_pdst = _RANDOM_33[10:5];	// @[functional-unit.scala:227:23]
        r_uops_2_bypassable = _RANDOM_36[14];	// @[functional-unit.scala:227:23]
        r_uops_2_is_amo = _RANDOM_36[25];	// @[functional-unit.scala:227:23]
        r_uops_2_uses_stq = _RANDOM_36[27];	// @[functional-unit.scala:227:23]
        r_uops_2_dst_rtype = _RANDOM_37[26:25];	// @[functional-unit.scala:227:23]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // not def SYNTHESIS
  PipelinedMultiplier imul (	// @[functional-unit.scala:705:20]
    .clock             (clock),
    .reset             (reset),
    .io_req_valid      (io_req_valid),
    .io_req_bits_fn    (io_req_bits_uop_ctrl_op_fcn),
    .io_req_bits_dw    (io_req_bits_uop_ctrl_fcn_dw),
    .io_req_bits_in1   (io_req_bits_rs1_data),
    .io_req_bits_in2   (io_req_bits_rs2_data),
    .io_resp_bits_data (io_resp_bits_data)
  );
  assign io_resp_valid = r_valids_2 & (io_brupdate_b1_mispredict_mask & r_uops_2_br_mask) == 16'h0;	// @[functional-unit.scala:226:27, :227:23, :247:47, util.scala:118:{51,59}]
  assign io_resp_bits_uop_rob_idx = r_uops_2_rob_idx;	// @[functional-unit.scala:227:23]
  assign io_resp_bits_uop_pdst = r_uops_2_pdst;	// @[functional-unit.scala:227:23]
  assign io_resp_bits_uop_bypassable = r_uops_2_bypassable;	// @[functional-unit.scala:227:23]
  assign io_resp_bits_uop_is_amo = r_uops_2_is_amo;	// @[functional-unit.scala:227:23]
  assign io_resp_bits_uop_uses_stq = r_uops_2_uses_stq;	// @[functional-unit.scala:227:23]
  assign io_resp_bits_uop_dst_rtype = r_uops_2_dst_rtype;	// @[functional-unit.scala:227:23]
endmodule

