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

module TLXbar_10(
  input         clock,
                reset,
                auto_in_a_valid,
  input  [2:0]  auto_in_a_bits_opcode,
  input  [8:0]  auto_in_a_bits_address,
  input  [31:0] auto_in_a_bits_data,
  input         auto_in_d_ready,
                auto_out_1_a_ready,
                auto_out_1_d_valid,
  input  [2:0]  auto_out_1_d_bits_opcode,
  input  [31:0] auto_out_1_d_bits_data,
  input         auto_out_0_a_ready,
                auto_out_0_d_valid,
  input  [2:0]  auto_out_0_d_bits_opcode,
  input  [1:0]  auto_out_0_d_bits_param,
                auto_out_0_d_bits_size,
  input         auto_out_0_d_bits_denied,
  input  [31:0] auto_out_0_d_bits_data,
  input         auto_out_0_d_bits_corrupt,
  output        auto_in_a_ready,
                auto_in_d_valid,
                auto_in_d_bits_denied,
  output [31:0] auto_in_d_bits_data,
  output        auto_in_d_bits_corrupt,
                auto_out_1_a_valid,
  output [2:0]  auto_out_1_a_bits_opcode,
  output [6:0]  auto_out_1_a_bits_address,
  output [31:0] auto_out_1_a_bits_data,
  output        auto_out_1_d_ready,
                auto_out_0_a_valid,
  output [2:0]  auto_out_0_a_bits_opcode,
  output [8:0]  auto_out_0_a_bits_address,
  output [31:0] auto_out_0_a_bits_data,
  output        auto_out_0_d_ready
);

  wire [6:0] _GEN = auto_in_a_bits_address[8:2] ^ 7'h11;	// @[Parameters.scala:137:31]
  wire       requestAIO_0_0 = auto_in_a_bits_address[8:6] == 3'h0 | {_GEN[6:2], _GEN[0]} == 6'h0 | auto_in_a_bits_address[8:3] == 6'hB | auto_in_a_bits_address[8:5] == 4'h3 | auto_in_a_bits_address[8:7] == 2'h1 | auto_in_a_bits_address[8];	// @[Parameters.scala:137:{31,45,65}, Xbar.scala:365:92]
  wire       requestAIO_0_1 = {auto_in_a_bits_address[8:4] ^ 5'h4, auto_in_a_bits_address[2]} == 6'h0 | auto_in_a_bits_address[8:3] == 6'hA;	// @[Parameters.scala:137:{31,45,65}, Xbar.scala:365:92]
  wire       _portsAOI_in_0_a_ready_WIRE = requestAIO_0_0 & auto_out_0_a_ready | requestAIO_0_1 & auto_out_1_a_ready;	// @[Mux.scala:27:73, Xbar.scala:365:92]
  reg        beatsLeft;	// @[Arbiter.scala:87:30]
  wire [1:0] readys_valid = {auto_out_1_d_valid, auto_out_0_d_valid};	// @[Cat.scala:33:92]
  reg  [1:0] readys_mask;	// @[Arbiter.scala:23:23]
  wire [1:0] _readys_filter_T_1 = readys_valid & ~readys_mask;	// @[Arbiter.scala:23:23, :24:{28,30}, Cat.scala:33:92]
  wire [1:0] readys_readys = ~({readys_mask[1], _readys_filter_T_1[1] | readys_mask[0]} & {|_readys_filter_T_1, auto_out_1_d_valid | _readys_filter_T_1[0]});	// @[Arbiter.scala:23:23, :24:28, :25:58, :26:{18,29,39,48}, package.scala:254:43]
  wire       earlyWinner_0 = readys_readys[0] & auto_out_0_d_valid;	// @[Arbiter.scala:26:18, :95:86, :97:79]
  wire       earlyWinner_1 = readys_readys[1] & auto_out_1_d_valid;	// @[Arbiter.scala:26:18, :95:86, :97:79]
  wire       _sink_ACancel_earlyValid_T = auto_out_0_d_valid | auto_out_1_d_valid;	// @[Arbiter.scala:107:36]
  reg        state_0;	// @[Arbiter.scala:116:26]
  reg        state_1;	// @[Arbiter.scala:116:26]
  wire       muxStateEarly_0 = beatsLeft ? state_0 : earlyWinner_0;	// @[Arbiter.scala:87:30, :97:79, :116:26, :117:30]
  wire       muxStateEarly_1 = beatsLeft ? state_1 : earlyWinner_1;	// @[Arbiter.scala:87:30, :97:79, :116:26, :117:30]
  wire       out_9_valid = beatsLeft ? state_0 & auto_out_0_d_valid | state_1 & auto_out_1_d_valid : _sink_ACancel_earlyValid_T;	// @[Arbiter.scala:87:30, :107:36, :116:26, :125:29, Mux.scala:27:73]
  wire       out_9_bits_corrupt = muxStateEarly_0 & auto_out_0_d_bits_corrupt;	// @[Arbiter.scala:117:30, Mux.scala:27:73]
  wire       out_9_bits_denied = muxStateEarly_0 & auto_out_0_d_bits_denied;	// @[Arbiter.scala:117:30, Mux.scala:27:73]
  wire [1:0] _readys_mask_T = readys_readys & readys_valid;	// @[Arbiter.scala:26:18, :28:29, Cat.scala:33:92]
  wire       latch = ~beatsLeft & auto_in_d_ready;	// @[Arbiter.scala:87:30, :88:28, :89:24]
  always @(posedge clock) begin
    if (reset) begin
      beatsLeft <= 1'h0;	// @[Arbiter.scala:87:30]
      readys_mask <= 2'h3;	// @[Arbiter.scala:23:23, package.scala:235:64]
      state_0 <= 1'h0;	// @[Arbiter.scala:116:26]
      state_1 <= 1'h0;	// @[Arbiter.scala:116:26]
    end
    else begin
      beatsLeft <= ~latch & beatsLeft - (auto_in_d_ready & out_9_valid);	// @[Arbiter.scala:87:30, :89:24, :113:{23,52}, :125:29, ReadyValidCancel.scala:49:33]
      if (latch & (|readys_valid))	// @[Arbiter.scala:27:{18,27}, :89:24, Cat.scala:33:92]
        readys_mask <= _readys_mask_T | {_readys_mask_T[0], 1'h0};	// @[Arbiter.scala:23:23, :28:29, package.scala:245:{43,53}]
      if (beatsLeft) begin	// @[Arbiter.scala:87:30]
      end
      else begin	// @[Arbiter.scala:87:30]
        state_0 <= readys_readys[0] & auto_out_0_d_valid;	// @[Arbiter.scala:26:18, :95:86, :98:79, :116:26]
        state_1 <= readys_readys[1] & auto_out_1_d_valid;	// @[Arbiter.scala:26:18, :95:86, :98:79, :116:26]
      end
    end
  end // always @(posedge)
  `ifndef SYNTHESIS
    always @(posedge clock) begin	// @[Arbiter.scala:105:13]
      if (~reset & ~(~earlyWinner_0 | ~earlyWinner_1)) begin	// @[Arbiter.scala:97:79, :105:{13,61,64,67}]
        if (`ASSERT_VERBOSE_COND_)	// @[Arbiter.scala:105:13]
          $error("Assertion failed\n    at Arbiter.scala:105 assert((prefixOR zip earlyWinner) map { case (p,w) => !p || !w } reduce {_ && _})\n");	// @[Arbiter.scala:105:13]
        if (`STOP_COND_)	// @[Arbiter.scala:105:13]
          $fatal;	// @[Arbiter.scala:105:13]
      end
      if (~reset & ~(~_sink_ACancel_earlyValid_T | earlyWinner_0 | earlyWinner_1)) begin	// @[Arbiter.scala:97:79, :107:{14,15,36,41}]
        if (`ASSERT_VERBOSE_COND_)	// @[Arbiter.scala:107:14]
          $error("Assertion failed\n    at Arbiter.scala:107 assert (!earlyValids.reduce(_||_) || earlyWinner.reduce(_||_))\n");	// @[Arbiter.scala:107:14]
        if (`STOP_COND_)	// @[Arbiter.scala:107:14]
          $fatal;	// @[Arbiter.scala:107:14]
      end
    end // always @(posedge)
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM_0;
    initial begin
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        _RANDOM_0 = `RANDOM;
        beatsLeft = _RANDOM_0[0];	// @[Arbiter.scala:87:30]
        readys_mask = _RANDOM_0[2:1];	// @[Arbiter.scala:23:23, :87:30]
        state_0 = _RANDOM_0[3];	// @[Arbiter.scala:87:30, :116:26]
        state_1 = _RANDOM_0[4];	// @[Arbiter.scala:87:30, :116:26]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // not def SYNTHESIS
  TLMonitor_46 monitor (	// @[Nodes.scala:24:25]
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (_portsAOI_in_0_a_ready_WIRE),	// @[Mux.scala:27:73]
    .io_in_a_valid        (auto_in_a_valid),
    .io_in_a_bits_opcode  (auto_in_a_bits_opcode),
    .io_in_a_bits_address (auto_in_a_bits_address),
    .io_in_d_ready        (auto_in_d_ready),
    .io_in_d_valid        (out_9_valid),	// @[Arbiter.scala:125:29]
    .io_in_d_bits_opcode  ((muxStateEarly_0 ? auto_out_0_d_bits_opcode : 3'h0) | (muxStateEarly_1 ? auto_out_1_d_bits_opcode : 3'h0)),	// @[Arbiter.scala:117:30, Mux.scala:27:73]
    .io_in_d_bits_param   (muxStateEarly_0 ? auto_out_0_d_bits_param : 2'h0),	// @[Arbiter.scala:117:30, Mux.scala:27:73]
    .io_in_d_bits_size    ((muxStateEarly_0 ? auto_out_0_d_bits_size : 2'h0) | {muxStateEarly_1, 1'h0}),	// @[Arbiter.scala:117:30, Mux.scala:27:73]
    .io_in_d_bits_denied  (out_9_bits_denied),	// @[Mux.scala:27:73]
    .io_in_d_bits_corrupt (out_9_bits_corrupt)	// @[Mux.scala:27:73]
  );
  assign auto_in_a_ready = _portsAOI_in_0_a_ready_WIRE;	// @[Mux.scala:27:73]
  assign auto_in_d_valid = out_9_valid;	// @[Arbiter.scala:125:29]
  assign auto_in_d_bits_denied = out_9_bits_denied;	// @[Mux.scala:27:73]
  assign auto_in_d_bits_data = (muxStateEarly_0 ? auto_out_0_d_bits_data : 32'h0) | (muxStateEarly_1 ? auto_out_1_d_bits_data : 32'h0);	// @[Arbiter.scala:117:30, Bundles.scala:259:74, Mux.scala:27:73]
  assign auto_in_d_bits_corrupt = out_9_bits_corrupt;	// @[Mux.scala:27:73]
  assign auto_out_1_a_valid = auto_in_a_valid & requestAIO_0_1;	// @[Xbar.scala:365:92, :430:50]
  assign auto_out_1_a_bits_opcode = auto_in_a_bits_opcode;
  assign auto_out_1_a_bits_address = auto_in_a_bits_address[6:0];	// @[BundleMap.scala:247:19]
  assign auto_out_1_a_bits_data = auto_in_a_bits_data;
  assign auto_out_1_d_ready = auto_in_d_ready & (beatsLeft ? state_1 : readys_readys[1]);	// @[Arbiter.scala:26:18, :87:30, :95:86, :116:26, :121:24, :123:31]
  assign auto_out_0_a_valid = auto_in_a_valid & requestAIO_0_0;	// @[Xbar.scala:365:92, :430:50]
  assign auto_out_0_a_bits_opcode = auto_in_a_bits_opcode;
  assign auto_out_0_a_bits_address = auto_in_a_bits_address;
  assign auto_out_0_a_bits_data = auto_in_a_bits_data;
  assign auto_out_0_d_ready = auto_in_d_ready & (beatsLeft ? state_0 : readys_readys[0]);	// @[Arbiter.scala:26:18, :87:30, :95:86, :116:26, :121:24, :123:31]
endmodule

