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

module Queue_23(
  input          clock,
                 reset,
                 io_enq_valid,
  input  [39:0]  io_enq_bits_pc,
  input  [127:0] io_enq_bits_data,
  input  [7:0]   io_enq_bits_mask,
  input          io_enq_bits_xcpt_pf_inst,
                 io_enq_bits_xcpt_ae_inst,
  input  [63:0]  io_enq_bits_ghist_old_history,
  input          io_enq_bits_ghist_current_saw_branch_not_taken,
                 io_enq_bits_ghist_new_saw_branch_not_taken,
                 io_enq_bits_ghist_new_saw_branch_taken,
  input  [4:0]   io_enq_bits_ghist_ras_idx,
  input  [1:0]   io_enq_bits_fsrc,
                 io_enq_bits_tsrc,
  input          io_deq_ready,
  output         io_enq_ready,
                 io_deq_valid,
  output [39:0]  io_deq_bits_pc,
  output [127:0] io_deq_bits_data,
  output [7:0]   io_deq_bits_mask,
  output         io_deq_bits_xcpt_pf_inst,
                 io_deq_bits_xcpt_ae_inst,
  output [63:0]  io_deq_bits_ghist_old_history,
  output         io_deq_bits_ghist_current_saw_branch_not_taken,
                 io_deq_bits_ghist_new_saw_branch_not_taken,
                 io_deq_bits_ghist_new_saw_branch_taken,
  output [4:0]   io_deq_bits_ghist_ras_idx,
  output [1:0]   io_deq_bits_fsrc,
                 io_deq_bits_tsrc
);

  wire         _io_enq_ready_output;	// @[Decoupled.scala:303:16, :323:{24,39}]
  wire [254:0] _ram_ext_R0_data;	// @[Decoupled.scala:273:95]
  reg          maybe_full;	// @[Decoupled.scala:276:27]
  wire         do_enq = _io_enq_ready_output & io_enq_valid;	// @[Decoupled.scala:51:35, :303:16, :323:{24,39}]
  assign _io_enq_ready_output = io_deq_ready | ~maybe_full;	// @[Decoupled.scala:276:27, :303:{16,19}, :323:{24,39}]
  always @(posedge clock) begin
    if (reset)
      maybe_full <= 1'h0;	// @[Decoupled.scala:276:27]
    else if (do_enq != (io_deq_ready & maybe_full))	// @[Decoupled.scala:51:35, :276:27, :293:15]
      maybe_full <= do_enq;	// @[Decoupled.scala:51:35, :276:27]
  end // always @(posedge)
  `ifndef SYNTHESIS
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
        maybe_full = _RANDOM_0[0];	// @[Decoupled.scala:276:27]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // not def SYNTHESIS
  ram_combMem_23 ram_ext (	// @[Decoupled.scala:273:95]
    .R0_addr (1'h0),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (1'h0),
    .W0_en   (do_enq),	// @[Decoupled.scala:51:35]
    .W0_clk  (clock),
    .W0_data ({io_enq_bits_tsrc, io_enq_bits_fsrc, io_enq_bits_ghist_ras_idx, io_enq_bits_ghist_new_saw_branch_taken, io_enq_bits_ghist_new_saw_branch_not_taken, io_enq_bits_ghist_current_saw_branch_not_taken, io_enq_bits_ghist_old_history, io_enq_bits_xcpt_ae_inst, 1'h0, io_enq_bits_xcpt_pf_inst, io_enq_bits_mask, io_enq_bits_data, io_enq_bits_pc}),	// @[Decoupled.scala:273:95]
    .R0_data (_ram_ext_R0_data)
  );
  assign io_enq_ready = _io_enq_ready_output;	// @[Decoupled.scala:303:16, :323:{24,39}]
  assign io_deq_valid = maybe_full;	// @[Decoupled.scala:276:27]
  assign io_deq_bits_pc = _ram_ext_R0_data[39:0];	// @[Decoupled.scala:273:95]
  assign io_deq_bits_data = _ram_ext_R0_data[167:40];	// @[Decoupled.scala:273:95]
  assign io_deq_bits_mask = _ram_ext_R0_data[175:168];	// @[Decoupled.scala:273:95]
  assign io_deq_bits_xcpt_pf_inst = _ram_ext_R0_data[176];	// @[Decoupled.scala:273:95]
  assign io_deq_bits_xcpt_ae_inst = _ram_ext_R0_data[178];	// @[Decoupled.scala:273:95]
  assign io_deq_bits_ghist_old_history = _ram_ext_R0_data[242:179];	// @[Decoupled.scala:273:95]
  assign io_deq_bits_ghist_current_saw_branch_not_taken = _ram_ext_R0_data[243];	// @[Decoupled.scala:273:95]
  assign io_deq_bits_ghist_new_saw_branch_not_taken = _ram_ext_R0_data[244];	// @[Decoupled.scala:273:95]
  assign io_deq_bits_ghist_new_saw_branch_taken = _ram_ext_R0_data[245];	// @[Decoupled.scala:273:95]
  assign io_deq_bits_ghist_ras_idx = _ram_ext_R0_data[250:246];	// @[Decoupled.scala:273:95]
  assign io_deq_bits_fsrc = _ram_ext_R0_data[252:251];	// @[Decoupled.scala:273:95]
  assign io_deq_bits_tsrc = _ram_ext_R0_data[254:253];	// @[Decoupled.scala:273:95]
endmodule

