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

module ALUUnit(
  input         clock,
                reset,
                io_req_valid,
  input  [6:0]  io_req_bits_uop_uopc,
  input         io_req_bits_uop_is_rvc,
  input  [3:0]  io_req_bits_uop_ctrl_br_type,
  input  [1:0]  io_req_bits_uop_ctrl_op1_sel,
  input  [2:0]  io_req_bits_uop_ctrl_op2_sel,
                io_req_bits_uop_ctrl_imm_sel,
  input  [3:0]  io_req_bits_uop_ctrl_op_fcn,
  input         io_req_bits_uop_ctrl_fcn_dw,
                io_req_bits_uop_is_br,
                io_req_bits_uop_is_jalr,
                io_req_bits_uop_is_jal,
                io_req_bits_uop_is_sfb,
  input  [15:0] io_req_bits_uop_br_mask,
  input  [3:0]  io_req_bits_uop_br_tag,
  input  [5:0]  io_req_bits_uop_ftq_idx,
  input         io_req_bits_uop_edge_inst,
  input  [5:0]  io_req_bits_uop_pc_lob,
  input         io_req_bits_uop_taken,
  input  [19:0] io_req_bits_uop_imm_packed,
  input  [7:0]  io_req_bits_uop_rob_idx,
  input  [4:0]  io_req_bits_uop_ldq_idx,
                io_req_bits_uop_stq_idx,
  input  [5:0]  io_req_bits_uop_pdst,
                io_req_bits_uop_prs1,
  input         io_req_bits_uop_bypassable,
                io_req_bits_uop_is_amo,
                io_req_bits_uop_uses_stq,
  input  [1:0]  io_req_bits_uop_dst_rtype,
  input  [63:0] io_req_bits_rs1_data,
                io_req_bits_rs2_data,
  input         io_req_bits_kill,
  input  [15:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  input         io_get_ftq_pc_entry_cfi_idx_valid,
  input  [2:0]  io_get_ftq_pc_entry_cfi_idx_bits,
  input         io_get_ftq_pc_entry_start_bank,
  input  [39:0] io_get_ftq_pc_pc,
  input         io_get_ftq_pc_next_val,
  input  [39:0] io_get_ftq_pc_next_pc,
  output        io_resp_valid,
  output [7:0]  io_resp_bits_uop_rob_idx,
  output [5:0]  io_resp_bits_uop_pdst,
  output        io_resp_bits_uop_bypassable,
                io_resp_bits_uop_is_amo,
                io_resp_bits_uop_uses_stq,
  output [1:0]  io_resp_bits_uop_dst_rtype,
  output [63:0] io_resp_bits_data,
  output        io_bypass_0_valid,
  output [5:0]  io_bypass_0_bits_uop_pdst,
  output [1:0]  io_bypass_0_bits_uop_dst_rtype,
  output [63:0] io_bypass_0_bits_data,
  output        io_bypass_1_valid,
  output [5:0]  io_bypass_1_bits_uop_pdst,
  output [1:0]  io_bypass_1_bits_uop_dst_rtype,
  output [63:0] io_bypass_1_bits_data,
  output        io_bypass_2_valid,
  output [5:0]  io_bypass_2_bits_uop_pdst,
  output [1:0]  io_bypass_2_bits_uop_dst_rtype,
  output [63:0] io_bypass_2_bits_data,
  output        io_brinfo_uop_is_rvc,
  output [15:0] io_brinfo_uop_br_mask,
  output [3:0]  io_brinfo_uop_br_tag,
  output [5:0]  io_brinfo_uop_ftq_idx,
  output        io_brinfo_uop_edge_inst,
  output [5:0]  io_brinfo_uop_pc_lob,
  output [7:0]  io_brinfo_uop_rob_idx,
  output [4:0]  io_brinfo_uop_ldq_idx,
                io_brinfo_uop_stq_idx,
  output        io_brinfo_valid,
                io_brinfo_mispredict,
                io_brinfo_taken,
  output [2:0]  io_brinfo_cfi_type,
  output [1:0]  io_brinfo_pc_sel,
  output [39:0] io_brinfo_jalr_target,
  output [20:0] io_brinfo_target_offset
);

  wire [63:0] _alu_io_out;	// @[functional-unit.scala:317:19]
  reg         r_valids_0;	// @[functional-unit.scala:226:27]
  reg         r_valids_1;	// @[functional-unit.scala:226:27]
  reg         r_valids_2;	// @[functional-unit.scala:226:27]
  reg  [15:0] r_uops_0_br_mask;	// @[functional-unit.scala:227:23]
  reg  [7:0]  r_uops_0_rob_idx;	// @[functional-unit.scala:227:23]
  reg  [5:0]  r_uops_0_pdst;	// @[functional-unit.scala:227:23]
  reg         r_uops_0_bypassable;	// @[functional-unit.scala:227:23]
  reg         r_uops_0_is_amo;	// @[functional-unit.scala:227:23]
  reg         r_uops_0_uses_stq;	// @[functional-unit.scala:227:23]
  reg  [1:0]  r_uops_0_dst_rtype;	// @[functional-unit.scala:227:23]
  reg  [15:0] r_uops_1_br_mask;	// @[functional-unit.scala:227:23]
  reg  [7:0]  r_uops_1_rob_idx;	// @[functional-unit.scala:227:23]
  reg  [5:0]  r_uops_1_pdst;	// @[functional-unit.scala:227:23]
  reg         r_uops_1_bypassable;	// @[functional-unit.scala:227:23]
  reg         r_uops_1_is_amo;	// @[functional-unit.scala:227:23]
  reg         r_uops_1_uses_stq;	// @[functional-unit.scala:227:23]
  reg  [1:0]  r_uops_1_dst_rtype;	// @[functional-unit.scala:227:23]
  reg  [15:0] r_uops_2_br_mask;	// @[functional-unit.scala:227:23]
  reg  [7:0]  r_uops_2_rob_idx;	// @[functional-unit.scala:227:23]
  reg  [5:0]  r_uops_2_pdst;	// @[functional-unit.scala:227:23]
  reg         r_uops_2_bypassable;	// @[functional-unit.scala:227:23]
  reg         r_uops_2_is_amo;	// @[functional-unit.scala:227:23]
  reg         r_uops_2_uses_stq;	// @[functional-unit.scala:227:23]
  reg  [1:0]  r_uops_2_dst_rtype;	// @[functional-unit.scala:227:23]
  wire [15:0] _T_7 = io_brupdate_b1_mispredict_mask & io_req_bits_uop_br_mask;	// @[util.scala:118:51]
  wire        _imm_xprlen_i4_1_T = io_req_bits_uop_ctrl_imm_sel == 3'h3;	// @[util.scala:274:27]
  wire [10:0] imm_xprlen_i30_20 = _imm_xprlen_i4_1_T ? io_req_bits_uop_imm_packed[18:8] : {11{io_req_bits_uop_imm_packed[19]}};	// @[util.scala:273:18, :274:{21,27,39}]
  wire        _imm_xprlen_i11_T_1 = io_req_bits_uop_ctrl_imm_sel == 3'h4;	// @[util.scala:275:44]
  wire [7:0]  imm_xprlen_i19_12 = _imm_xprlen_i4_1_T | _imm_xprlen_i11_T_1 ? io_req_bits_uop_imm_packed[7:0] : {8{io_req_bits_uop_imm_packed[19]}};	// @[util.scala:273:18, :274:27, :275:{21,36,44,56}]
  wire        imm_xprlen_i11 = ~_imm_xprlen_i4_1_T & (_imm_xprlen_i11_T_1 | io_req_bits_uop_ctrl_imm_sel == 3'h2 ? io_req_bits_uop_imm_packed[8] : io_req_bits_uop_imm_packed[19]);	// @[util.scala:273:18, :274:27, :275:44, :276:21, :277:{21,36,44,56}]
  wire [4:0]  imm_xprlen_i10_5 = _imm_xprlen_i4_1_T ? 5'h0 : io_req_bits_uop_imm_packed[18:14];	// @[util.scala:274:27, :278:{21,44}]
  wire [4:0]  imm_xprlen_i4_1 = _imm_xprlen_i4_1_T ? 5'h0 : io_req_bits_uop_imm_packed[13:9];	// @[util.scala:274:27, :278:21, :279:{21,44}]
  wire        imm_xprlen_i0 = (io_req_bits_uop_ctrl_imm_sel == 3'h1 | io_req_bits_uop_ctrl_imm_sel == 3'h0) & io_req_bits_uop_imm_packed[8];	// @[util.scala:277:56, :280:{21,27,36,44}]
  wire [39:0] uop_pc = (~(~io_get_ftq_pc_pc | 40'h3F) | {34'h0, io_req_bits_uop_pc_lob}) - {38'h0, io_req_bits_uop_edge_inst, 1'h0};	// @[functional-unit.scala:300:{28,42}, util.scala:237:{5,7,11}]
  wire        killed = io_req_bits_kill | (|_T_7);	// @[functional-unit.scala:328:26, util.scala:118:{51,59}]
  wire        br_eq = io_req_bits_rs1_data == io_req_bits_rs2_data;	// @[functional-unit.scala:334:21]
  wire        br_ltu = io_req_bits_rs1_data < io_req_bits_rs2_data;	// @[functional-unit.scala:335:28]
  wire        br_lt = (io_req_bits_rs1_data[63] ^ ~(io_req_bits_rs2_data[63])) & br_ltu | io_req_bits_rs1_data[63] & ~(io_req_bits_rs2_data[63]);	// @[functional-unit.scala:335:28, :336:{17,22,36,46,55}, :337:{29,31}]
  wire [1:0]  brinfo_pc_sel = io_req_bits_uop_ctrl_br_type == 4'h8 ? 2'h2 : io_req_bits_uop_ctrl_br_type == 4'h7 ? 2'h1 : {1'h0, io_req_bits_uop_ctrl_br_type == 4'h6 ? br_ltu : io_req_bits_uop_ctrl_br_type == 4'h5 ? br_lt : io_req_bits_uop_ctrl_br_type == 4'h4 ? ~br_ltu : io_req_bits_uop_ctrl_br_type == 4'h3 ? ~br_lt : io_req_bits_uop_ctrl_br_type == 4'h2 ? br_eq : io_req_bits_uop_ctrl_br_type == 4'h1 & ~br_eq};	// @[Mux.scala:81:{58,61}, functional-unit.scala:300:47, :334:21, :335:28, :336:55, :341:{38,39}, :343:39, :344:39]
  wire        is_br = io_req_valid & ~killed & io_req_bits_uop_is_br & ~io_req_bits_uop_is_sfb;	// @[functional-unit.scala:328:26, :352:20, :359:{61,64}]
  wire        is_jalr = io_req_valid & ~killed & io_req_bits_uop_is_jalr;	// @[functional-unit.scala:328:26, :352:20, :361:48]
  wire        brinfo_valid = is_br | is_jalr;	// @[functional-unit.scala:359:61, :361:48, :363:15]
  wire [63:0] jalr_target_xlen = io_req_bits_rs1_data + {{44{imm_xprlen_i30_20[0]}}, imm_xprlen_i19_12, imm_xprlen_i11, imm_xprlen_i10_5, imm_xprlen_i4_1, imm_xprlen_i0};	// @[functional-unit.scala:392:33, :408:43, util.scala:274:21, :275:21, :276:21, :278:21, :279:21, :280:21]
  wire [39:0] brinfo_jalr_target = {jalr_target_xlen[63:39] == 25'h0 | (&(jalr_target_xlen[63:39])) ? jalr_target_xlen[39] : ~(jalr_target_xlen[38]), jalr_target_xlen[38:0]} & 40'hFFFFFFFFFE;	// @[Cat.scala:33:92, functional-unit.scala:400:25, :401:{20,23,31,36,48,61,64}, :402:18, :408:43, :409:88]
  reg         r_val_0;	// @[functional-unit.scala:436:23]
  reg         r_val_1;	// @[functional-unit.scala:436:23]
  reg  [63:0] r_data_0;	// @[functional-unit.scala:437:19]
  reg  [63:0] r_data_1;	// @[functional-unit.scala:437:19]
  reg  [63:0] r_data_2;	// @[functional-unit.scala:437:19]
  wire        _alu_out_T_5 = io_req_bits_uop_uopc == 7'h6D;	// @[functional-unit.scala:441:30]
  always @(posedge clock) begin
    if (reset) begin
      r_valids_0 <= 1'h0;	// @[functional-unit.scala:226:27]
      r_valids_1 <= 1'h0;	// @[functional-unit.scala:226:27]
      r_valids_2 <= 1'h0;	// @[functional-unit.scala:226:27]
      r_val_0 <= 1'h0;	// @[functional-unit.scala:436:23]
      r_val_1 <= 1'h0;	// @[functional-unit.scala:436:23]
    end
    else begin
      r_valids_0 <= io_req_valid & _T_7 == 16'h0 & ~io_req_bits_kill;	// @[functional-unit.scala:226:27, :230:{84,87}, util.scala:118:{51,59}]
      r_valids_1 <= r_valids_0 & (io_brupdate_b1_mispredict_mask & r_uops_0_br_mask) == 16'h0 & ~io_req_bits_kill;	// @[functional-unit.scala:226:27, :227:23, :230:87, :236:83, util.scala:118:{51,59}]
      r_valids_2 <= r_valids_1 & (io_brupdate_b1_mispredict_mask & r_uops_1_br_mask) == 16'h0 & ~io_req_bits_kill;	// @[functional-unit.scala:226:27, :227:23, :230:87, :236:83, util.scala:118:{51,59}]
      r_val_0 <= io_req_valid;	// @[functional-unit.scala:436:23]
      r_val_1 <= r_val_0;	// @[functional-unit.scala:436:23]
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
    if (_alu_out_T_5)	// @[functional-unit.scala:441:30]
      r_data_0 <= io_req_bits_rs2_data;	// @[functional-unit.scala:437:19]
    else	// @[functional-unit.scala:441:30]
      r_data_0 <= _alu_io_out;	// @[functional-unit.scala:317:19, :437:19]
    r_data_1 <= r_data_0;	// @[functional-unit.scala:437:19]
    r_data_2 <= r_data_1;	// @[functional-unit.scala:437:19]
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
    logic [31:0] _RANDOM_38;
    logic [31:0] _RANDOM_39;
    logic [31:0] _RANDOM_40;
    logic [31:0] _RANDOM_41;
    logic [31:0] _RANDOM_42;
    logic [31:0] _RANDOM_43;
    logic [31:0] _RANDOM_44;
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
        _RANDOM_38 = `RANDOM;
        _RANDOM_39 = `RANDOM;
        _RANDOM_40 = `RANDOM;
        _RANDOM_41 = `RANDOM;
        _RANDOM_42 = `RANDOM;
        _RANDOM_43 = `RANDOM;
        _RANDOM_44 = `RANDOM;
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
        r_val_0 = _RANDOM_38[11];	// @[functional-unit.scala:436:23]
        r_val_1 = _RANDOM_38[12];	// @[functional-unit.scala:436:23]
        r_data_0 = {_RANDOM_38[31:14], _RANDOM_39, _RANDOM_40[13:0]};	// @[functional-unit.scala:436:23, :437:19]
        r_data_1 = {_RANDOM_40[31:14], _RANDOM_41, _RANDOM_42[13:0]};	// @[functional-unit.scala:437:19]
        r_data_2 = {_RANDOM_42[31:14], _RANDOM_43, _RANDOM_44[13:0]};	// @[functional-unit.scala:437:19]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // not def SYNTHESIS
  ALU alu (	// @[functional-unit.scala:317:19]
    .io_dw  (io_req_bits_uop_ctrl_fcn_dw),
    .io_fn  (io_req_bits_uop_ctrl_op_fcn),
    .io_in2 (io_req_bits_uop_ctrl_op2_sel == 3'h1 ? {{33{io_req_bits_uop_imm_packed[19]}}, imm_xprlen_i30_20, imm_xprlen_i19_12, imm_xprlen_i11, imm_xprlen_i10_5, imm_xprlen_i4_1, imm_xprlen_i0} : io_req_bits_uop_ctrl_op2_sel == 3'h4 ? {59'h0, io_req_bits_uop_prs1[4:0]} : io_req_bits_uop_ctrl_op2_sel == 3'h0 ? io_req_bits_rs2_data : {61'h0, io_req_bits_uop_ctrl_op2_sel == 3'h3 ? (io_req_bits_uop_is_rvc ? 3'h2 : 3'h4) : 3'h0}),	// @[Cat.scala:33:92, functional-unit.scala:311:{21,39}, :312:{21,39,73}, :313:{21,39}, :314:{21,39,56}, util.scala:273:18, :274:{21,27}, :275:{21,44}, :276:21, :277:44, :278:21, :279:21, :280:{21,27}]
    .io_in1 (io_req_bits_uop_ctrl_op1_sel == 2'h0 ? io_req_bits_rs1_data : io_req_bits_uop_ctrl_op1_sel == 2'h2 ? {{24{uop_pc[39]}}, uop_pc} : 64'h0),	// @[Bitwise.scala:77:12, Cat.scala:33:92, functional-unit.scala:300:{42,47}, :302:{19,44}, :303:{19,44}, util.scala:261:46]
    .io_out (_alu_io_out)
  );
  assign io_resp_valid = r_valids_2 & (io_brupdate_b1_mispredict_mask & r_uops_2_br_mask) == 16'h0;	// @[functional-unit.scala:226:27, :227:23, :247:47, util.scala:118:{51,59}]
  assign io_resp_bits_uop_rob_idx = r_uops_2_rob_idx;	// @[functional-unit.scala:227:23]
  assign io_resp_bits_uop_pdst = r_uops_2_pdst;	// @[functional-unit.scala:227:23]
  assign io_resp_bits_uop_bypassable = r_uops_2_bypassable;	// @[functional-unit.scala:227:23]
  assign io_resp_bits_uop_is_amo = r_uops_2_is_amo;	// @[functional-unit.scala:227:23]
  assign io_resp_bits_uop_uses_stq = r_uops_2_uses_stq;	// @[functional-unit.scala:227:23]
  assign io_resp_bits_uop_dst_rtype = r_uops_2_dst_rtype;	// @[functional-unit.scala:227:23]
  assign io_resp_bits_data = r_data_2;	// @[functional-unit.scala:437:19]
  assign io_bypass_0_valid = io_req_valid;
  assign io_bypass_0_bits_uop_pdst = io_req_bits_uop_pdst;
  assign io_bypass_0_bits_uop_dst_rtype = io_req_bits_uop_dst_rtype;
  assign io_bypass_0_bits_data = _alu_out_T_5 ? io_req_bits_rs2_data : _alu_io_out;	// @[functional-unit.scala:317:19, :441:{8,30}]
  assign io_bypass_1_valid = r_val_0;	// @[functional-unit.scala:436:23]
  assign io_bypass_1_bits_uop_pdst = r_uops_0_pdst;	// @[functional-unit.scala:227:23]
  assign io_bypass_1_bits_uop_dst_rtype = r_uops_0_dst_rtype;	// @[functional-unit.scala:227:23]
  assign io_bypass_1_bits_data = r_data_0;	// @[functional-unit.scala:437:19]
  assign io_bypass_2_valid = r_val_1;	// @[functional-unit.scala:436:23]
  assign io_bypass_2_bits_uop_pdst = r_uops_1_pdst;	// @[functional-unit.scala:227:23]
  assign io_bypass_2_bits_uop_dst_rtype = r_uops_1_dst_rtype;	// @[functional-unit.scala:227:23]
  assign io_bypass_2_bits_data = r_data_1;	// @[functional-unit.scala:437:19]
  assign io_brinfo_uop_is_rvc = io_req_bits_uop_is_rvc;
  assign io_brinfo_uop_br_mask = io_req_bits_uop_br_mask;
  assign io_brinfo_uop_br_tag = io_req_bits_uop_br_tag;
  assign io_brinfo_uop_ftq_idx = io_req_bits_uop_ftq_idx;
  assign io_brinfo_uop_edge_inst = io_req_bits_uop_edge_inst;
  assign io_brinfo_uop_pc_lob = io_req_bits_uop_pc_lob;
  assign io_brinfo_uop_rob_idx = io_req_bits_uop_rob_idx;
  assign io_brinfo_uop_ldq_idx = io_req_bits_uop_ldq_idx;
  assign io_brinfo_uop_stq_idx = io_req_bits_uop_stq_idx;
  assign io_brinfo_valid = brinfo_valid;	// @[functional-unit.scala:363:15]
  assign io_brinfo_mispredict = brinfo_pc_sel == 2'h2 ? ~io_get_ftq_pc_next_val | io_get_ftq_pc_next_pc != brinfo_jalr_target | ~io_get_ftq_pc_entry_cfi_idx_valid | io_get_ftq_pc_entry_cfi_idx_bits != (io_req_bits_uop_pc_lob[3:1] ^ {io_get_ftq_pc_entry_start_bank, 2'h0}) : brinfo_valid & (brinfo_pc_sel == 2'h1 ? ~io_req_bits_uop_taken : brinfo_pc_sel == 2'h0 & io_req_bits_uop_taken);	// @[Mux.scala:81:58, functional-unit.scala:300:47, :341:38, :357:28, :363:{15,27}, :367:{18,32}, :368:18, :370:{18,32}, :371:{18,21}, :409:88, :412:32, :414:{18,31}, :415:{18,21}, :416:44, :417:{21,56}, :418:55]
  assign io_brinfo_taken = io_req_valid & ~killed & (io_req_bits_uop_is_br | io_req_bits_uop_is_jalr | io_req_bits_uop_is_jal) & (|brinfo_pc_sel);	// @[Mux.scala:81:58, functional-unit.scala:328:26, :352:20, :353:{46,61}, :354:28]
  assign io_brinfo_cfi_type = is_jalr ? 3'h3 : {2'h0, is_br};	// @[functional-unit.scala:359:61, :361:48, :381:31, :382:31, util.scala:274:27]
  assign io_brinfo_pc_sel = brinfo_pc_sel;	// @[Mux.scala:81:58]
  assign io_brinfo_jalr_target = brinfo_jalr_target;	// @[functional-unit.scala:409:88]
  assign io_brinfo_target_offset = {imm_xprlen_i30_20[0], imm_xprlen_i19_12, imm_xprlen_i11, imm_xprlen_i10_5, imm_xprlen_i4_1, imm_xprlen_i0};	// @[functional-unit.scala:392:33, util.scala:274:21, :275:21, :276:21, :278:21, :279:21, :280:21]
endmodule

