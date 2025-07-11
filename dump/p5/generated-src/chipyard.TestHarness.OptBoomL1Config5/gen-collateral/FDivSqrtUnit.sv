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

module FDivSqrtUnit(
  input         clock,
                reset,
                io_req_valid,
  input  [6:0]  io_req_bits_uop_uopc,
  input  [15:0] io_req_bits_uop_br_mask,
  input  [7:0]  io_req_bits_uop_rob_idx,
  input  [5:0]  io_req_bits_uop_pdst,
  input         io_req_bits_uop_is_amo,
                io_req_bits_uop_uses_ldq,
                io_req_bits_uop_uses_stq,
  input  [1:0]  io_req_bits_uop_dst_rtype,
  input         io_req_bits_uop_fp_val,
  input  [64:0] io_req_bits_rs1_data,
                io_req_bits_rs2_data,
  input         io_req_bits_kill,
                io_resp_ready,
  input  [15:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  input  [2:0]  io_fcsr_rm,
  output        io_req_ready,
                io_resp_valid,
  output [7:0]  io_resp_bits_uop_rob_idx,
  output [5:0]  io_resp_bits_uop_pdst,
  output        io_resp_bits_uop_is_amo,
                io_resp_bits_uop_uses_ldq,
                io_resp_bits_uop_uses_stq,
  output [1:0]  io_resp_bits_uop_dst_rtype,
  output        io_resp_bits_uop_fp_val,
  output [64:0] io_resp_bits_data,
  output        io_resp_bits_fflags_valid,
  output [7:0]  io_resp_bits_fflags_bits_uop_rob_idx,
  output [4:0]  io_resp_bits_fflags_bits_flags
);

  wire        output_buffer_available;	// @[fdiv.scala:187:30]
  wire [32:0] _downvert_d2s_io_out;	// @[fdiv.scala:209:28]
  wire [4:0]  _downvert_d2s_io_exceptionFlags;	// @[fdiv.scala:209:28]
  wire        _divsqrt_io_inReady_div;	// @[fdiv.scala:141:23]
  wire        _divsqrt_io_inReady_sqrt;	// @[fdiv.scala:141:23]
  wire        _divsqrt_io_outValid_div;	// @[fdiv.scala:141:23]
  wire        _divsqrt_io_outValid_sqrt;	// @[fdiv.scala:141:23]
  wire [64:0] _divsqrt_io_out;	// @[fdiv.scala:141:23]
  wire [4:0]  _divsqrt_io_exceptionFlags;	// @[fdiv.scala:141:23]
  wire [64:0] _in2_upconvert_s2d_io_out;	// @[fdiv.scala:110:21]
  wire [64:0] _in1_upconvert_s2d_io_out;	// @[fdiv.scala:110:21]
  wire [1:0]  _fdiv_decoder_io_sigs_typeTagIn;	// @[fdiv.scala:99:28]
  wire        _fdiv_decoder_io_sigs_div;	// @[fdiv.scala:99:28]
  wire        _fdiv_decoder_io_sigs_sqrt;	// @[fdiv.scala:99:28]
  reg         r_buffer_val;	// @[fdiv.scala:95:29]
  reg  [15:0] r_buffer_req_uop_br_mask;	// @[fdiv.scala:96:25]
  reg  [7:0]  r_buffer_req_uop_rob_idx;	// @[fdiv.scala:96:25]
  reg  [5:0]  r_buffer_req_uop_pdst;	// @[fdiv.scala:96:25]
  reg         r_buffer_req_uop_is_amo;	// @[fdiv.scala:96:25]
  reg         r_buffer_req_uop_uses_ldq;	// @[fdiv.scala:96:25]
  reg         r_buffer_req_uop_uses_stq;	// @[fdiv.scala:96:25]
  reg  [1:0]  r_buffer_req_uop_dst_rtype;	// @[fdiv.scala:96:25]
  reg         r_buffer_req_uop_fp_val;	// @[fdiv.scala:96:25]
  reg  [1:0]  r_buffer_fin_typeTagIn;	// @[fdiv.scala:97:25]
  reg         r_buffer_fin_div;	// @[fdiv.scala:97:25]
  reg         r_buffer_fin_sqrt;	// @[fdiv.scala:97:25]
  reg  [2:0]  r_buffer_fin_rm;	// @[fdiv.scala:97:25]
  reg  [64:0] r_buffer_fin_in1;	// @[fdiv.scala:97:25]
  reg  [64:0] r_buffer_fin_in2;	// @[fdiv.scala:97:25]
  reg         r_divsqrt_val;	// @[fdiv.scala:143:30]
  reg         r_divsqrt_killed;	// @[fdiv.scala:144:29]
  reg  [1:0]  r_divsqrt_fin_typeTagIn;	// @[fdiv.scala:145:26]
  reg  [2:0]  r_divsqrt_fin_rm;	// @[fdiv.scala:145:26]
  reg  [15:0] r_divsqrt_uop_br_mask;	// @[fdiv.scala:146:26]
  reg  [7:0]  r_divsqrt_uop_rob_idx;	// @[fdiv.scala:146:26]
  reg  [5:0]  r_divsqrt_uop_pdst;	// @[fdiv.scala:146:26]
  reg         r_divsqrt_uop_is_amo;	// @[fdiv.scala:146:26]
  reg         r_divsqrt_uop_uses_ldq;	// @[fdiv.scala:146:26]
  reg         r_divsqrt_uop_uses_stq;	// @[fdiv.scala:146:26]
  reg  [1:0]  r_divsqrt_uop_dst_rtype;	// @[fdiv.scala:146:26]
  reg         r_divsqrt_uop_fp_val;	// @[fdiv.scala:146:26]
  wire        may_fire_input = r_buffer_val & (r_buffer_fin_div | r_buffer_fin_sqrt) & ~r_divsqrt_val & output_buffer_available;	// @[fdiv.scala:95:29, :97:25, :143:30, :153:23, :154:{5,20}, :187:30]
  reg         r_out_val;	// @[fdiv.scala:182:26]
  reg  [15:0] r_out_uop_br_mask;	// @[fdiv.scala:183:22]
  reg  [7:0]  r_out_uop_rob_idx;	// @[fdiv.scala:183:22]
  reg  [5:0]  r_out_uop_pdst;	// @[fdiv.scala:183:22]
  reg         r_out_uop_is_amo;	// @[fdiv.scala:183:22]
  reg         r_out_uop_uses_ldq;	// @[fdiv.scala:183:22]
  reg         r_out_uop_uses_stq;	// @[fdiv.scala:183:22]
  reg  [1:0]  r_out_uop_dst_rtype;	// @[fdiv.scala:183:22]
  reg         r_out_uop_fp_val;	// @[fdiv.scala:183:22]
  reg  [4:0]  r_out_flags_double;	// @[fdiv.scala:184:31]
  reg  [64:0] r_out_wdata_double;	// @[fdiv.scala:185:31]
  assign output_buffer_available = ~r_out_val;	// @[fdiv.scala:182:26, :187:30]
  wire [15:0] _io_resp_valid_T = io_brupdate_b1_mispredict_mask & r_out_uop_br_mask;	// @[fdiv.scala:183:22, util.scala:118:51]
  wire        _T_21 = _divsqrt_io_outValid_div | _divsqrt_io_outValid_sqrt;	// @[fdiv.scala:141:23, :194:33]
  wire        _io_resp_bits_data_T = r_divsqrt_fin_typeTagIn == 2'h0;	// @[fdiv.scala:97:25, :145:26, :214:68]
  wire        _io_resp_valid_output = r_out_val & _io_resp_valid_T == 16'h0;	// @[fdiv.scala:182:26, :216:30, util.scala:118:{51,59}]
  wire [15:0] _r_divsqrt_killed_T_4 = io_brupdate_b1_mispredict_mask & r_buffer_req_uop_br_mask;	// @[fdiv.scala:96:25, util.scala:118:51]
  wire        _T_5 = io_req_valid & (io_brupdate_b1_mispredict_mask & io_req_bits_uop_br_mask) == 16'h0 & ~io_req_bits_kill;	// @[fdiv.scala:103:71, :119:73, util.scala:118:{51,59}]
  wire [15:0] _r_out_val_T_1 = io_brupdate_b1_mispredict_mask & r_divsqrt_uop_br_mask;	// @[fdiv.scala:146:26, util.scala:118:51]
  wire        _T_12 = may_fire_input & (r_buffer_fin_sqrt ? _divsqrt_io_inReady_sqrt : _divsqrt_io_inReady_div);	// @[fdiv.scala:97:25, :141:23, :154:20, :157:26, :168:24]
  always @(posedge clock) begin
    if (reset) begin
      r_buffer_val <= 1'h0;	// @[fdiv.scala:95:29]
      r_divsqrt_val <= 1'h0;	// @[fdiv.scala:143:30]
      r_out_val <= 1'h0;	// @[fdiv.scala:182:26]
    end
    else begin
      r_buffer_val <= ~_T_12 & (_T_5 | _r_divsqrt_killed_T_4 == 16'h0 & ~io_req_bits_kill & r_buffer_val);	// @[fdiv.scala:95:29, :103:{16,71,89}, :119:{73,95}, :120:18, :168:{24,42}, :171:18, util.scala:118:{51,59}]
      r_divsqrt_val <= ~_T_21 & (_T_12 | r_divsqrt_val);	// @[fdiv.scala:143:30, :168:{24,42}, :172:19, :194:{33,62}, :195:19]
      if (_T_21)	// @[fdiv.scala:194:33]
        r_out_val <= ~r_divsqrt_killed & _r_out_val_T_1 == 16'h0 & ~io_req_bits_kill;	// @[fdiv.scala:103:71, :144:29, :182:26, :197:{18,85}, util.scala:118:{51,59}]
      else	// @[fdiv.scala:194:33]
        r_out_val <= ~(io_resp_ready | (|_io_resp_valid_T) | io_req_bits_kill) & r_out_val;	// @[fdiv.scala:182:26, :191:{67,88}, :192:15, util.scala:118:{51,59}]
    end
    if (_T_5) begin	// @[fdiv.scala:119:73]
      r_buffer_req_uop_br_mask <= io_req_bits_uop_br_mask & ~io_brupdate_b1_resolve_mask;	// @[fdiv.scala:96:25, util.scala:85:{25,27}]
      r_buffer_req_uop_rob_idx <= io_req_bits_uop_rob_idx;	// @[fdiv.scala:96:25]
      r_buffer_req_uop_pdst <= io_req_bits_uop_pdst;	// @[fdiv.scala:96:25]
      r_buffer_req_uop_is_amo <= io_req_bits_uop_is_amo;	// @[fdiv.scala:96:25]
      r_buffer_req_uop_uses_ldq <= io_req_bits_uop_uses_ldq;	// @[fdiv.scala:96:25]
      r_buffer_req_uop_uses_stq <= io_req_bits_uop_uses_stq;	// @[fdiv.scala:96:25]
      r_buffer_req_uop_dst_rtype <= io_req_bits_uop_dst_rtype;	// @[fdiv.scala:96:25]
      r_buffer_req_uop_fp_val <= io_req_bits_uop_fp_val;	// @[fdiv.scala:96:25]
      r_buffer_fin_typeTagIn <= _fdiv_decoder_io_sigs_typeTagIn;	// @[fdiv.scala:97:25, :99:28]
      r_buffer_fin_div <= _fdiv_decoder_io_sigs_div;	// @[fdiv.scala:97:25, :99:28]
      r_buffer_fin_sqrt <= _fdiv_decoder_io_sigs_sqrt;	// @[fdiv.scala:97:25, :99:28]
      r_buffer_fin_rm <= io_fcsr_rm;	// @[fdiv.scala:97:25]
      if (_fdiv_decoder_io_sigs_typeTagIn == 2'h0) begin	// @[fdiv.scala:97:25, :99:28, :130:15]
        r_buffer_fin_in1 <= _in1_upconvert_s2d_io_out;	// @[fdiv.scala:97:25, :110:21]
        r_buffer_fin_in2 <= _in2_upconvert_s2d_io_out;	// @[fdiv.scala:97:25, :110:21]
      end
      else begin	// @[fdiv.scala:130:15]
        r_buffer_fin_in1 <= io_req_bits_rs1_data;	// @[fdiv.scala:97:25]
        r_buffer_fin_in2 <= io_req_bits_rs2_data;	// @[fdiv.scala:97:25]
      end
    end
    else	// @[fdiv.scala:119:73]
      r_buffer_req_uop_br_mask <= r_buffer_req_uop_br_mask & ~io_brupdate_b1_resolve_mask;	// @[fdiv.scala:96:25, util.scala:85:{25,27}]
    if (_T_12) begin	// @[fdiv.scala:168:24]
      r_divsqrt_killed <= (|_r_divsqrt_killed_T_4) | io_req_bits_kill;	// @[fdiv.scala:144:29, :175:73, util.scala:118:{51,59}]
      r_divsqrt_fin_typeTagIn <= r_buffer_fin_typeTagIn;	// @[fdiv.scala:97:25, :145:26]
      r_divsqrt_fin_rm <= r_buffer_fin_rm;	// @[fdiv.scala:97:25, :145:26]
      r_divsqrt_uop_br_mask <= r_buffer_req_uop_br_mask & ~io_brupdate_b1_resolve_mask;	// @[fdiv.scala:96:25, :146:26, util.scala:85:{25,27}]
      r_divsqrt_uop_rob_idx <= r_buffer_req_uop_rob_idx;	// @[fdiv.scala:96:25, :146:26]
      r_divsqrt_uop_pdst <= r_buffer_req_uop_pdst;	// @[fdiv.scala:96:25, :146:26]
      r_divsqrt_uop_is_amo <= r_buffer_req_uop_is_amo;	// @[fdiv.scala:96:25, :146:26]
      r_divsqrt_uop_uses_ldq <= r_buffer_req_uop_uses_ldq;	// @[fdiv.scala:96:25, :146:26]
      r_divsqrt_uop_uses_stq <= r_buffer_req_uop_uses_stq;	// @[fdiv.scala:96:25, :146:26]
      r_divsqrt_uop_dst_rtype <= r_buffer_req_uop_dst_rtype;	// @[fdiv.scala:96:25, :146:26]
      r_divsqrt_uop_fp_val <= r_buffer_req_uop_fp_val;	// @[fdiv.scala:96:25, :146:26]
    end
    else begin	// @[fdiv.scala:168:24]
      r_divsqrt_killed <= r_divsqrt_killed | (|_r_out_val_T_1) | io_req_bits_kill;	// @[fdiv.scala:144:29, :165:88, util.scala:118:{51,59}]
      r_divsqrt_uop_br_mask <= r_divsqrt_uop_br_mask & ~io_brupdate_b1_resolve_mask;	// @[fdiv.scala:146:26, util.scala:85:{25,27}]
    end
    if (_T_21) begin	// @[fdiv.scala:194:33]
      r_out_uop_br_mask <= r_divsqrt_uop_br_mask & ~io_brupdate_b1_resolve_mask;	// @[fdiv.scala:146:26, :183:22, util.scala:85:{25,27}]
      r_out_uop_rob_idx <= r_divsqrt_uop_rob_idx;	// @[fdiv.scala:146:26, :183:22]
      r_out_uop_pdst <= r_divsqrt_uop_pdst;	// @[fdiv.scala:146:26, :183:22]
      r_out_uop_is_amo <= r_divsqrt_uop_is_amo;	// @[fdiv.scala:146:26, :183:22]
      r_out_uop_uses_ldq <= r_divsqrt_uop_uses_ldq;	// @[fdiv.scala:146:26, :183:22]
      r_out_uop_uses_stq <= r_divsqrt_uop_uses_stq;	// @[fdiv.scala:146:26, :183:22]
      r_out_uop_dst_rtype <= r_divsqrt_uop_dst_rtype;	// @[fdiv.scala:146:26, :183:22]
      r_out_uop_fp_val <= r_divsqrt_uop_fp_val;	// @[fdiv.scala:146:26, :183:22]
      r_out_flags_double <= _divsqrt_io_exceptionFlags;	// @[fdiv.scala:141:23, :184:31]
      r_out_wdata_double <= ({65{_divsqrt_io_out[63:61] != 3'h7}} | 65'h1EFEFFFFFFFFFFFFF) & _divsqrt_io_out;	// @[FPU.scala:243:{25,56}, :407:27, :408:10, fdiv.scala:141:23, :185:31]
    end
    else	// @[fdiv.scala:194:33]
      r_out_uop_br_mask <= r_out_uop_br_mask & ~io_brupdate_b1_resolve_mask;	// @[fdiv.scala:183:22, util.scala:85:{25,27}]
  end // always @(posedge)
  `ifndef SYNTHESIS
    always @(posedge clock) begin	// @[fdiv.scala:136:10]
      if (~reset & r_buffer_val & io_req_valid) begin	// @[fdiv.scala:95:29, :136:10]
        if (`ASSERT_VERBOSE_COND_)	// @[fdiv.scala:136:10]
          $error("Assertion failed: [fdiv] a request is incoming while the buffer is already full.\n    at fdiv.scala:136 assert (!(r_buffer_val && io.req.valid), \"[fdiv] a request is incoming while the buffer is already full.\")\n");	// @[fdiv.scala:136:10]
        if (`STOP_COND_)	// @[fdiv.scala:136:10]
          $fatal;	// @[fdiv.scala:136:10]
      end
      if (_T_21 & ~reset & ~r_divsqrt_val) begin	// @[fdiv.scala:143:30, :194:33, :203:12]
        if (`ASSERT_VERBOSE_COND_)	// @[fdiv.scala:203:12]
          $error("Assertion failed: [fdiv] a response is being generated for no request.\n    at fdiv.scala:203 assert (r_divsqrt_val, \"[fdiv] a response is being generated for no request.\")\n");	// @[fdiv.scala:203:12]
        if (`STOP_COND_)	// @[fdiv.scala:203:12]
          $fatal;	// @[fdiv.scala:203:12]
      end
      if (~reset & r_out_val & _T_21) begin	// @[fdiv.scala:182:26, :194:33, :206:10]
        if (`ASSERT_VERBOSE_COND_)	// @[fdiv.scala:206:10]
          $error("Assertion failed: [fdiv] Buffered output being overwritten by another output from the fdiv/fsqrt unit.\n    at fdiv.scala:206 assert (!(r_out_val && (divsqrt.io.outValid_div || divsqrt.io.outValid_sqrt)),\n");	// @[fdiv.scala:206:10]
        if (`STOP_COND_)	// @[fdiv.scala:206:10]
          $fatal;	// @[fdiv.scala:206:10]
      end
    end // always @(posedge)
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
    logic [31:0] _RANDOM_45;
    logic [31:0] _RANDOM_46;
    logic [31:0] _RANDOM_47;
    logic [31:0] _RANDOM_48;
    logic [31:0] _RANDOM_49;
    logic [31:0] _RANDOM_50;
    logic [31:0] _RANDOM_51;
    logic [31:0] _RANDOM_52;
    logic [31:0] _RANDOM_53;
    logic [31:0] _RANDOM_54;
    logic [31:0] _RANDOM_55;
    logic [31:0] _RANDOM_56;
    logic [31:0] _RANDOM_57;
    logic [31:0] _RANDOM_58;
    logic [31:0] _RANDOM_59;
    logic [31:0] _RANDOM_60;
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
        _RANDOM_45 = `RANDOM;
        _RANDOM_46 = `RANDOM;
        _RANDOM_47 = `RANDOM;
        _RANDOM_48 = `RANDOM;
        _RANDOM_49 = `RANDOM;
        _RANDOM_50 = `RANDOM;
        _RANDOM_51 = `RANDOM;
        _RANDOM_52 = `RANDOM;
        _RANDOM_53 = `RANDOM;
        _RANDOM_54 = `RANDOM;
        _RANDOM_55 = `RANDOM;
        _RANDOM_56 = `RANDOM;
        _RANDOM_57 = `RANDOM;
        _RANDOM_58 = `RANDOM;
        _RANDOM_59 = `RANDOM;
        _RANDOM_60 = `RANDOM;
        r_buffer_val = _RANDOM_0[0];	// @[fdiv.scala:95:29]
        r_buffer_req_uop_br_mask = {_RANDOM_4[31:29], _RANDOM_5[12:0]};	// @[fdiv.scala:96:25]
        r_buffer_req_uop_rob_idx = {_RANDOM_6[31], _RANDOM_7[6:0]};	// @[fdiv.scala:96:25]
        r_buffer_req_uop_pdst = _RANDOM_7[24:19];	// @[fdiv.scala:96:25]
        r_buffer_req_uop_is_amo = _RANDOM_11[7];	// @[fdiv.scala:96:25]
        r_buffer_req_uop_uses_ldq = _RANDOM_11[8];	// @[fdiv.scala:96:25]
        r_buffer_req_uop_uses_stq = _RANDOM_11[9];	// @[fdiv.scala:96:25]
        r_buffer_req_uop_dst_rtype = _RANDOM_12[8:7];	// @[fdiv.scala:96:25]
        r_buffer_req_uop_fp_val = _RANDOM_12[14];	// @[fdiv.scala:96:25]
        r_buffer_fin_typeTagIn = _RANDOM_19[6:5];	// @[fdiv.scala:97:25]
        r_buffer_fin_div = _RANDOM_19[13];	// @[fdiv.scala:97:25]
        r_buffer_fin_sqrt = _RANDOM_19[14];	// @[fdiv.scala:97:25]
        r_buffer_fin_rm = _RANDOM_19[18:16];	// @[fdiv.scala:97:25]
        r_buffer_fin_in1 = {_RANDOM_19[31:25], _RANDOM_20, _RANDOM_21[25:0]};	// @[fdiv.scala:97:25]
        r_buffer_fin_in2 = {_RANDOM_21[31:26], _RANDOM_22, _RANDOM_23[26:0]};	// @[fdiv.scala:97:25]
        r_divsqrt_val = _RANDOM_25[28];	// @[fdiv.scala:143:30]
        r_divsqrt_killed = _RANDOM_25[29];	// @[fdiv.scala:143:30, :144:29]
        r_divsqrt_fin_typeTagIn = _RANDOM_26[6:5];	// @[fdiv.scala:145:26]
        r_divsqrt_fin_rm = _RANDOM_26[18:16];	// @[fdiv.scala:145:26]
        r_divsqrt_uop_br_mask = {_RANDOM_37[31:24], _RANDOM_38[7:0]};	// @[fdiv.scala:146:26]
        r_divsqrt_uop_rob_idx = {_RANDOM_39[31:26], _RANDOM_40[1:0]};	// @[fdiv.scala:146:26]
        r_divsqrt_uop_pdst = _RANDOM_40[19:14];	// @[fdiv.scala:146:26]
        r_divsqrt_uop_is_amo = _RANDOM_44[2];	// @[fdiv.scala:146:26]
        r_divsqrt_uop_uses_ldq = _RANDOM_44[3];	// @[fdiv.scala:146:26]
        r_divsqrt_uop_uses_stq = _RANDOM_44[4];	// @[fdiv.scala:146:26]
        r_divsqrt_uop_dst_rtype = _RANDOM_45[3:2];	// @[fdiv.scala:146:26]
        r_divsqrt_uop_fp_val = _RANDOM_45[9];	// @[fdiv.scala:146:26]
        r_out_val = _RANDOM_45[20];	// @[fdiv.scala:146:26, :182:26]
        r_out_uop_br_mask = {_RANDOM_50[31:17], _RANDOM_51[0]};	// @[fdiv.scala:183:22]
        r_out_uop_rob_idx = _RANDOM_52[26:19];	// @[fdiv.scala:183:22]
        r_out_uop_pdst = _RANDOM_53[12:7];	// @[fdiv.scala:183:22]
        r_out_uop_is_amo = _RANDOM_56[27];	// @[fdiv.scala:183:22]
        r_out_uop_uses_ldq = _RANDOM_56[28];	// @[fdiv.scala:183:22]
        r_out_uop_uses_stq = _RANDOM_56[29];	// @[fdiv.scala:183:22]
        r_out_uop_dst_rtype = _RANDOM_57[28:27];	// @[fdiv.scala:183:22]
        r_out_uop_fp_val = _RANDOM_58[2];	// @[fdiv.scala:183:22]
        r_out_flags_double = _RANDOM_58[17:13];	// @[fdiv.scala:183:22, :184:31]
        r_out_wdata_double = {_RANDOM_58[31:18], _RANDOM_59, _RANDOM_60[18:0]};	// @[fdiv.scala:183:22, :185:31]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // not def SYNTHESIS
  UOPCodeFDivDecoder fdiv_decoder (	// @[fdiv.scala:99:28]
    .io_uopc           (io_req_bits_uop_uopc),
    .io_sigs_typeTagIn (_fdiv_decoder_io_sigs_typeTagIn),
    .io_sigs_div       (_fdiv_decoder_io_sigs_div),
    .io_sigs_sqrt      (_fdiv_decoder_io_sigs_sqrt)
  );
  RecFNToRecFN_1 in1_upconvert_s2d (	// @[fdiv.scala:110:21]
    .io_in  ({io_req_bits_rs1_data[31], io_req_bits_rs1_data[52], io_req_bits_rs1_data[30:0]} | ((&(io_req_bits_rs1_data[64:60])) ? 33'h0 : 33'hE0400000)),	// @[Cat.scala:33:92, FPU.scala:326:{49,84}, :351:14, :352:14, :353:14, :366:{26,31}]
    .io_out (_in1_upconvert_s2d_io_out)
  );
  RecFNToRecFN_1 in2_upconvert_s2d (	// @[fdiv.scala:110:21]
    .io_in  ({io_req_bits_rs2_data[31], io_req_bits_rs2_data[52], io_req_bits_rs2_data[30:0]} | ((&(io_req_bits_rs2_data[64:60])) ? 33'h0 : 33'hE0400000)),	// @[Cat.scala:33:92, FPU.scala:326:{49,84}, :351:14, :352:14, :353:14, :366:{26,31}]
    .io_out (_in2_upconvert_s2d_io_out)
  );
  DivSqrtRecF64 divsqrt (	// @[fdiv.scala:141:23]
    .clock             (clock),
    .reset             (reset),
    .io_inValid        (may_fire_input),	// @[fdiv.scala:154:20]
    .io_sqrtOp         (r_buffer_fin_sqrt),	// @[fdiv.scala:97:25]
    .io_a              (r_buffer_fin_in1),	// @[fdiv.scala:97:25]
    .io_b              (r_buffer_fin_sqrt ? r_buffer_fin_in1 : r_buffer_fin_in2),	// @[fdiv.scala:97:25, :161:22]
    .io_roundingMode   (r_buffer_fin_rm),	// @[fdiv.scala:97:25]
    .io_inReady_div    (_divsqrt_io_inReady_div),
    .io_inReady_sqrt   (_divsqrt_io_inReady_sqrt),
    .io_outValid_div   (_divsqrt_io_outValid_div),
    .io_outValid_sqrt  (_divsqrt_io_outValid_sqrt),
    .io_out            (_divsqrt_io_out),
    .io_exceptionFlags (_divsqrt_io_exceptionFlags)
  );
  RecFNToRecFN downvert_d2s (	// @[fdiv.scala:209:28]
    .io_in             (r_out_wdata_double),	// @[fdiv.scala:185:31]
    .io_roundingMode   (r_divsqrt_fin_rm),	// @[fdiv.scala:145:26]
    .io_detectTininess (1'h0),
    .io_out            (_downvert_d2s_io_out),
    .io_exceptionFlags (_downvert_d2s_io_exceptionFlags)
  );
  assign io_req_ready = ~r_buffer_val;	// @[fdiv.scala:95:29, :107:19]
  assign io_resp_valid = _io_resp_valid_output;	// @[fdiv.scala:216:30]
  assign io_resp_bits_uop_rob_idx = r_out_uop_rob_idx;	// @[fdiv.scala:183:22]
  assign io_resp_bits_uop_pdst = r_out_uop_pdst;	// @[fdiv.scala:183:22]
  assign io_resp_bits_uop_is_amo = r_out_uop_is_amo;	// @[fdiv.scala:183:22]
  assign io_resp_bits_uop_uses_ldq = r_out_uop_uses_ldq;	// @[fdiv.scala:183:22]
  assign io_resp_bits_uop_uses_stq = r_out_uop_uses_stq;	// @[fdiv.scala:183:22]
  assign io_resp_bits_uop_dst_rtype = r_out_uop_dst_rtype;	// @[fdiv.scala:183:22]
  assign io_resp_bits_uop_fp_val = r_out_uop_fp_val;	// @[fdiv.scala:183:22]
  assign io_resp_bits_data = _io_resp_bits_data_T ? {12'hFFF, _downvert_d2s_io_out[31], 20'hFFFFF, _downvert_d2s_io_out[32], _downvert_d2s_io_out[30:0]} : r_out_wdata_double;	// @[Cat.scala:33:92, FPU.scala:332:42, :334:8, :336:8, :337:8, fdiv.scala:185:31, :209:28, :214:68, :219:8]
  assign io_resp_bits_fflags_valid = _io_resp_valid_output;	// @[fdiv.scala:216:30]
  assign io_resp_bits_fflags_bits_uop_rob_idx = r_out_uop_rob_idx;	// @[fdiv.scala:183:22]
  assign io_resp_bits_fflags_bits_flags = r_out_flags_double | (_io_resp_bits_data_T ? _downvert_d2s_io_exceptionFlags : 5'h0);	// @[fdiv.scala:184:31, :209:28, :214:{38,43,68}]
endmodule

