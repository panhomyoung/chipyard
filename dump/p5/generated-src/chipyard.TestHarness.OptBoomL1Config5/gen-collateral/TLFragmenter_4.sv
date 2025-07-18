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

module TLFragmenter_4(
  input         clock,
                reset,
                auto_in_a_valid,
  input  [2:0]  auto_in_a_bits_opcode,
                auto_in_a_bits_param,
                auto_in_a_bits_size,
  input  [6:0]  auto_in_a_bits_source,
  input  [11:0] auto_in_a_bits_address,
  input  [7:0]  auto_in_a_bits_mask,
  input  [63:0] auto_in_a_bits_data,
  input         auto_in_a_bits_corrupt,
                auto_in_d_ready,
                auto_out_a_ready,
                auto_out_d_valid,
  input  [2:0]  auto_out_d_bits_opcode,
  input  [1:0]  auto_out_d_bits_size,
  input  [10:0] auto_out_d_bits_source,
  input  [63:0] auto_out_d_bits_data,
  output        auto_in_a_ready,
                auto_in_d_valid,
  output [2:0]  auto_in_d_bits_opcode,
                auto_in_d_bits_size,
  output [6:0]  auto_in_d_bits_source,
  output [63:0] auto_in_d_bits_data,
  output        auto_out_a_valid,
  output [2:0]  auto_out_a_bits_opcode,
                auto_out_a_bits_param,
  output [1:0]  auto_out_a_bits_size,
  output [10:0] auto_out_a_bits_source,
  output [11:0] auto_out_a_bits_address,
  output [7:0]  auto_out_a_bits_mask,
  output [63:0] auto_out_a_bits_data,
  output        auto_out_a_bits_corrupt,
                auto_out_d_ready
);

  wire        _repeater_io_full;	// @[Fragmenter.scala:263:30]
  wire        _repeater_io_enq_ready;	// @[Fragmenter.scala:263:30]
  wire        _repeater_io_deq_valid;	// @[Fragmenter.scala:263:30]
  wire [2:0]  _repeater_io_deq_bits_opcode;	// @[Fragmenter.scala:263:30]
  wire [2:0]  _repeater_io_deq_bits_size;	// @[Fragmenter.scala:263:30]
  wire [6:0]  _repeater_io_deq_bits_source;	// @[Fragmenter.scala:263:30]
  wire [11:0] _repeater_io_deq_bits_address;	// @[Fragmenter.scala:263:30]
  wire [7:0]  _repeater_io_deq_bits_mask;	// @[Fragmenter.scala:263:30]
  reg  [2:0]  acknum;	// @[Fragmenter.scala:190:29]
  reg  [2:0]  dOrig;	// @[Fragmenter.scala:191:24]
  reg         dToggle;	// @[Fragmenter.scala:192:30]
  wire        dFirst = acknum == 3'h0;	// @[Fragmenter.scala:190:29, :194:29]
  wire [5:0]  _dsizeOH1_T_1 = 6'h7 << auto_out_d_bits_size;	// @[Fragmenter.scala:305:111, package.scala:235:71]
  wire [5:0]  _GEN = {auto_out_d_bits_source[2:0], ~(_dsizeOH1_T_1[2:0])} & {1'h1, ~(auto_out_d_bits_source[2:0]), _dsizeOH1_T_1[2:1]};	// @[Cat.scala:33:92, Fragmenter.scala:193:41, OneHot.scala:64:12, package.scala:233:{35,47,49}, :235:{46,71,76}]
  wire [2:0]  _GEN_0 = {1'h0, _GEN[5:4]} | _GEN[2:0];	// @[OneHot.scala:31:18, :32:28, package.scala:233:47]
  wire [2:0]  dFirst_size = {|(_GEN[5:3]), |(_GEN_0[2:1]), _GEN_0[2] | _GEN_0[0]};	// @[Cat.scala:33:92, OneHot.scala:30:18, :31:18, :32:{14,28}, package.scala:233:47]
  wire        drop = ~(auto_out_d_bits_opcode[0]) & (|(auto_out_d_bits_source[2:0]));	// @[Edges.scala:105:36, Fragmenter.scala:193:41, :195:30, :223:{20,30}]
  wire        x1_d_ready = auto_in_d_ready | drop;	// @[Fragmenter.scala:223:30, :224:35]
  wire        bundleIn_0_d_valid = auto_out_d_valid & ~drop;	// @[Fragmenter.scala:223:30, :225:{36,39}]
  wire [2:0]  bundleIn_0_d_bits_size = dFirst ? dFirst_size : dOrig;	// @[Cat.scala:33:92, Fragmenter.scala:191:24, :194:29, :228:32]
  wire [2:0]  aFrag = _repeater_io_deq_bits_size[2] ? 3'h3 : _repeater_io_deq_bits_size;	// @[Fragmenter.scala:263:30, :286:{24,31}]
  wire [12:0] _aOrigOH1_T_1 = 13'h3F << _repeater_io_deq_bits_size;	// @[Fragmenter.scala:263:30, package.scala:235:71]
  wire [9:0]  _aFragOH1_T_1 = 10'h7 << aFrag;	// @[Fragmenter.scala:286:24, package.scala:235:71]
  reg  [2:0]  gennum;	// @[Fragmenter.scala:292:29]
  wire        aFirst = gennum == 3'h0;	// @[Fragmenter.scala:190:29, :292:29, :293:29]
  wire [2:0]  _old_gennum1_T_2 = gennum - 3'h1;	// @[Fragmenter.scala:292:29, :294:79]
  wire [2:0]  old_gennum1 = aFirst ? ~(_aOrigOH1_T_1[5:3]) : _old_gennum1_T_2;	// @[Fragmenter.scala:293:29, :294:{30,79}, package.scala:235:{46,71,76}]
  reg         aToggle_r;	// @[Reg.scala:19:16]
  wire        _T_7 = x1_d_ready & auto_out_d_valid;	// @[Decoupled.scala:51:35, Fragmenter.scala:224:35]
  wire        _GEN_1 = _T_7 & dFirst;	// @[Decoupled.scala:51:35, Fragmenter.scala:191:24, :194:29, :209:29, :211:25, :212:19]
  always @(posedge clock) begin
    if (reset) begin
      acknum <= 3'h0;	// @[Fragmenter.scala:190:29]
      dToggle <= 1'h0;	// @[Fragmenter.scala:192:30]
      gennum <= 3'h0;	// @[Fragmenter.scala:190:29, :292:29]
    end
    else begin
      if (_T_7) begin	// @[Decoupled.scala:51:35]
        if (dFirst)	// @[Fragmenter.scala:194:29]
          acknum <= auto_out_d_bits_source[2:0];	// @[Fragmenter.scala:190:29, :193:41]
        else	// @[Fragmenter.scala:194:29]
          acknum <= acknum - {2'h0, auto_out_d_bits_opcode[0] | (&auto_out_d_bits_size)};	// @[Edges.scala:105:36, Fragmenter.scala:190:29, :205:{32,60}, :210:55, OneHot.scala:64:12]
      end
      if (_GEN_1)	// @[Fragmenter.scala:191:24, :209:29, :211:25, :212:19]
        dToggle <= auto_out_d_bits_source[3];	// @[Fragmenter.scala:192:30, :213:41]
      if (auto_out_a_ready & _repeater_io_deq_valid) begin	// @[Decoupled.scala:51:35, Fragmenter.scala:263:30]
        if (aFirst)	// @[Fragmenter.scala:293:29]
          gennum <= ~(_aOrigOH1_T_1[5:3]);	// @[Fragmenter.scala:292:29, package.scala:235:{46,71,76}]
        else	// @[Fragmenter.scala:293:29]
          gennum <= _old_gennum1_T_2;	// @[Fragmenter.scala:292:29, :294:79]
      end
    end
    if (_GEN_1)	// @[Fragmenter.scala:191:24, :209:29, :211:25, :212:19]
      dOrig <= dFirst_size;	// @[Cat.scala:33:92, Fragmenter.scala:191:24]
    if (aFirst)	// @[Fragmenter.scala:293:29]
      aToggle_r <= dToggle;	// @[Fragmenter.scala:192:30, Reg.scala:19:16]
  end // always @(posedge)
  `ifndef SYNTHESIS
    always @(posedge clock) begin	// @[Fragmenter.scala:310:16]
      if (~reset & ~(~_repeater_io_full | _repeater_io_deq_bits_opcode[2])) begin	// @[Edges.scala:91:37, Fragmenter.scala:263:30, :310:{16,17,35}]
        if (`ASSERT_VERBOSE_COND_)	// @[Fragmenter.scala:310:16]
          $error("Assertion failed\n    at Fragmenter.scala:310 assert (!repeater.io.full || !aHasData)\n");	// @[Fragmenter.scala:310:16]
        if (`STOP_COND_)	// @[Fragmenter.scala:310:16]
          $fatal;	// @[Fragmenter.scala:310:16]
      end
      if (~reset & ~(~_repeater_io_full | (&_repeater_io_deq_bits_mask))) begin	// @[Fragmenter.scala:263:30, :310:17, :313:{16,35,53}]
        if (`ASSERT_VERBOSE_COND_)	// @[Fragmenter.scala:313:16]
          $error("Assertion failed\n    at Fragmenter.scala:313 assert (!repeater.io.full || in_a.bits.mask === fullMask)\n");	// @[Fragmenter.scala:313:16]
        if (`STOP_COND_)	// @[Fragmenter.scala:313:16]
          $fatal;	// @[Fragmenter.scala:313:16]
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
        acknum = _RANDOM_0[2:0];	// @[Fragmenter.scala:190:29]
        dOrig = _RANDOM_0[5:3];	// @[Fragmenter.scala:190:29, :191:24]
        dToggle = _RANDOM_0[6];	// @[Fragmenter.scala:190:29, :192:30]
        gennum = _RANDOM_0[9:7];	// @[Fragmenter.scala:190:29, :292:29]
        aToggle_r = _RANDOM_0[10];	// @[Fragmenter.scala:190:29, Reg.scala:19:16]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // not def SYNTHESIS
  TLMonitor_27 monitor (	// @[Nodes.scala:24:25]
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (_repeater_io_enq_ready),	// @[Fragmenter.scala:263:30]
    .io_in_a_valid        (auto_in_a_valid),
    .io_in_a_bits_opcode  (auto_in_a_bits_opcode),
    .io_in_a_bits_param   (auto_in_a_bits_param),
    .io_in_a_bits_size    (auto_in_a_bits_size),
    .io_in_a_bits_source  (auto_in_a_bits_source),
    .io_in_a_bits_address (auto_in_a_bits_address),
    .io_in_a_bits_mask    (auto_in_a_bits_mask),
    .io_in_a_bits_corrupt (auto_in_a_bits_corrupt),
    .io_in_d_ready        (auto_in_d_ready),
    .io_in_d_valid        (bundleIn_0_d_valid),	// @[Fragmenter.scala:225:36]
    .io_in_d_bits_opcode  (auto_out_d_bits_opcode),
    .io_in_d_bits_size    (bundleIn_0_d_bits_size),	// @[Fragmenter.scala:228:32]
    .io_in_d_bits_source  (auto_out_d_bits_source[10:4])	// @[Fragmenter.scala:227:47]
  );
  Repeater_8 repeater (	// @[Fragmenter.scala:263:30]
    .clock               (clock),
    .reset               (reset),
    .io_repeat           (_repeater_io_deq_bits_opcode[2] & (|old_gennum1)),	// @[Edges.scala:91:37, Fragmenter.scala:263:30, :294:30, :303:{41,53}]
    .io_enq_valid        (auto_in_a_valid),
    .io_enq_bits_opcode  (auto_in_a_bits_opcode),
    .io_enq_bits_param   (auto_in_a_bits_param),
    .io_enq_bits_size    (auto_in_a_bits_size),
    .io_enq_bits_source  (auto_in_a_bits_source),
    .io_enq_bits_address (auto_in_a_bits_address),
    .io_enq_bits_mask    (auto_in_a_bits_mask),
    .io_enq_bits_corrupt (auto_in_a_bits_corrupt),
    .io_deq_ready        (auto_out_a_ready),
    .io_full             (_repeater_io_full),
    .io_enq_ready        (_repeater_io_enq_ready),
    .io_deq_valid        (_repeater_io_deq_valid),
    .io_deq_bits_opcode  (_repeater_io_deq_bits_opcode),
    .io_deq_bits_param   (auto_out_a_bits_param),
    .io_deq_bits_size    (_repeater_io_deq_bits_size),
    .io_deq_bits_source  (_repeater_io_deq_bits_source),
    .io_deq_bits_address (_repeater_io_deq_bits_address),
    .io_deq_bits_mask    (_repeater_io_deq_bits_mask),
    .io_deq_bits_corrupt (auto_out_a_bits_corrupt)
  );
  assign auto_in_a_ready = _repeater_io_enq_ready;	// @[Fragmenter.scala:263:30]
  assign auto_in_d_valid = bundleIn_0_d_valid;	// @[Fragmenter.scala:225:36]
  assign auto_in_d_bits_opcode = auto_out_d_bits_opcode;
  assign auto_in_d_bits_size = bundleIn_0_d_bits_size;	// @[Fragmenter.scala:228:32]
  assign auto_in_d_bits_source = auto_out_d_bits_source[10:4];	// @[Fragmenter.scala:227:47]
  assign auto_in_d_bits_data = auto_out_d_bits_data;
  assign auto_out_a_valid = _repeater_io_deq_valid;	// @[Fragmenter.scala:263:30]
  assign auto_out_a_bits_opcode = _repeater_io_deq_bits_opcode;	// @[Fragmenter.scala:263:30]
  assign auto_out_a_bits_size = aFrag[1:0];	// @[Fragmenter.scala:286:24, :307:25]
  assign auto_out_a_bits_source = {_repeater_io_deq_bits_source, ~(aFirst ? dToggle : aToggle_r), old_gennum1};	// @[Cat.scala:33:92, Fragmenter.scala:192:30, :263:30, :293:29, :294:30, :298:{23,27}, Reg.scala:19:16]
  assign auto_out_a_bits_address = _repeater_io_deq_bits_address | {6'h0, ~(_aOrigOH1_T_1[5:0] | {old_gennum1, ~(_aFragOH1_T_1[2:0])} | 6'h7)};	// @[Fragmenter.scala:263:30, :294:30, :305:{49,51,100,111}, package.scala:235:{46,71,76}]
  assign auto_out_a_bits_mask = _repeater_io_full ? 8'hFF : auto_in_a_bits_mask;	// @[Fragmenter.scala:263:30, :313:53, :314:31]
  assign auto_out_a_bits_data = auto_in_a_bits_data;
  assign auto_out_d_ready = x1_d_ready;	// @[Fragmenter.scala:224:35]
endmodule

