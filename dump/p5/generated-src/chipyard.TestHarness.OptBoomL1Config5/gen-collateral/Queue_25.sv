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

module Queue_25(
  input          clock,
                 reset,
                 io_enq_valid,
  input  [7:0]   io_enq_bits_btb_mispredicts,
  input  [39:0]  io_enq_bits_pc,
  input  [63:0]  io_enq_bits_ghist_old_history,
  input          io_enq_bits_ghist_current_saw_branch_not_taken,
                 io_enq_bits_ghist_new_saw_branch_not_taken,
                 io_enq_bits_ghist_new_saw_branch_taken,
  input  [4:0]   io_enq_bits_ghist_ras_idx,
  input          io_enq_bits_lhist_0,
                 io_enq_bits_lhist_1,
  input  [119:0] io_enq_bits_meta_0,
                 io_enq_bits_meta_1,
  input          io_deq_ready,
  output         io_deq_valid,
                 io_deq_bits_is_mispredict_update,
                 io_deq_bits_is_repair_update,
  output [7:0]   io_deq_bits_btb_mispredicts,
  output [39:0]  io_deq_bits_pc,
  output [7:0]   io_deq_bits_br_mask,
  output         io_deq_bits_cfi_idx_valid,
  output [2:0]   io_deq_bits_cfi_idx_bits,
  output         io_deq_bits_cfi_taken,
                 io_deq_bits_cfi_mispredicted,
                 io_deq_bits_cfi_is_br,
                 io_deq_bits_cfi_is_jal,
  output [63:0]  io_deq_bits_ghist_old_history,
  output         io_deq_bits_ghist_new_saw_branch_not_taken,
                 io_deq_bits_ghist_new_saw_branch_taken,
  output [39:0]  io_deq_bits_target,
  output [119:0] io_deq_bits_meta_0,
                 io_deq_bits_meta_1
);

  wire         _io_enq_ready_T;	// @[Decoupled.scala:303:19]
  wire [420:0] _ram_ext_R0_data;	// @[Decoupled.scala:273:95]
  reg          enq_ptr_value;	// @[Counter.scala:61:40]
  reg          deq_ptr_value;	// @[Counter.scala:61:40]
  reg          maybe_full;	// @[Decoupled.scala:276:27]
  wire         ptr_match = enq_ptr_value == deq_ptr_value;	// @[Counter.scala:61:40, Decoupled.scala:277:33]
  wire         empty = ptr_match & ~maybe_full;	// @[Decoupled.scala:276:27, :277:33, :278:{25,28}]
  wire         do_enq = _io_enq_ready_T & io_enq_valid;	// @[Decoupled.scala:51:35, :303:19]
  assign _io_enq_ready_T = ~(ptr_match & maybe_full);	// @[Decoupled.scala:276:27, :277:33, :279:24, :303:19]
  wire         do_deq = io_deq_ready & ~empty;	// @[Decoupled.scala:51:35, :278:25, :302:19]
  always @(posedge clock) begin
    if (reset) begin
      enq_ptr_value <= 1'h0;	// @[Counter.scala:61:40]
      deq_ptr_value <= 1'h0;	// @[Counter.scala:61:40]
      maybe_full <= 1'h0;	// @[Decoupled.scala:276:27]
    end
    else begin
      if (do_enq)	// @[Decoupled.scala:51:35]
        enq_ptr_value <= enq_ptr_value - 1'h1;	// @[Counter.scala:61:40, :77:24]
      if (do_deq)	// @[Decoupled.scala:51:35]
        deq_ptr_value <= deq_ptr_value - 1'h1;	// @[Counter.scala:61:40, :77:24]
      if (do_enq != do_deq)	// @[Decoupled.scala:51:35, :293:15]
        maybe_full <= do_enq;	// @[Decoupled.scala:51:35, :276:27]
    end
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
        enq_ptr_value = _RANDOM_0[0];	// @[Counter.scala:61:40]
        deq_ptr_value = _RANDOM_0[1];	// @[Counter.scala:61:40]
        maybe_full = _RANDOM_0[2];	// @[Counter.scala:61:40, Decoupled.scala:276:27]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // not def SYNTHESIS
  ram_combMem_24 ram_ext (	// @[Decoupled.scala:273:95]
    .R0_addr (deq_ptr_value),	// @[Counter.scala:61:40]
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr_value),	// @[Counter.scala:61:40]
    .W0_en   (do_enq),	// @[Decoupled.scala:51:35]
    .W0_clk  (clock),
    .W0_data ({io_enq_bits_meta_1, io_enq_bits_meta_0, 40'h0, io_enq_bits_lhist_1, io_enq_bits_lhist_0, io_enq_bits_ghist_ras_idx, io_enq_bits_ghist_new_saw_branch_taken, io_enq_bits_ghist_new_saw_branch_not_taken, io_enq_bits_ghist_current_saw_branch_not_taken, io_enq_bits_ghist_old_history, 17'h0, io_enq_bits_pc, io_enq_bits_btb_mispredicts, 2'h0}),	// @[Decoupled.scala:273:95]
    .R0_data (_ram_ext_R0_data)
  );
  assign io_deq_valid = ~empty;	// @[Decoupled.scala:278:25, :302:19]
  assign io_deq_bits_is_mispredict_update = _ram_ext_R0_data[0];	// @[Decoupled.scala:273:95]
  assign io_deq_bits_is_repair_update = _ram_ext_R0_data[1];	// @[Decoupled.scala:273:95]
  assign io_deq_bits_btb_mispredicts = _ram_ext_R0_data[9:2];	// @[Decoupled.scala:273:95]
  assign io_deq_bits_pc = _ram_ext_R0_data[49:10];	// @[Decoupled.scala:273:95]
  assign io_deq_bits_br_mask = _ram_ext_R0_data[57:50];	// @[Decoupled.scala:273:95]
  assign io_deq_bits_cfi_idx_valid = _ram_ext_R0_data[58];	// @[Decoupled.scala:273:95]
  assign io_deq_bits_cfi_idx_bits = _ram_ext_R0_data[61:59];	// @[Decoupled.scala:273:95]
  assign io_deq_bits_cfi_taken = _ram_ext_R0_data[62];	// @[Decoupled.scala:273:95]
  assign io_deq_bits_cfi_mispredicted = _ram_ext_R0_data[63];	// @[Decoupled.scala:273:95]
  assign io_deq_bits_cfi_is_br = _ram_ext_R0_data[64];	// @[Decoupled.scala:273:95]
  assign io_deq_bits_cfi_is_jal = _ram_ext_R0_data[65];	// @[Decoupled.scala:273:95]
  assign io_deq_bits_ghist_old_history = _ram_ext_R0_data[130:67];	// @[Decoupled.scala:273:95]
  assign io_deq_bits_ghist_new_saw_branch_not_taken = _ram_ext_R0_data[132];	// @[Decoupled.scala:273:95]
  assign io_deq_bits_ghist_new_saw_branch_taken = _ram_ext_R0_data[133];	// @[Decoupled.scala:273:95]
  assign io_deq_bits_target = _ram_ext_R0_data[180:141];	// @[Decoupled.scala:273:95]
  assign io_deq_bits_meta_0 = _ram_ext_R0_data[300:181];	// @[Decoupled.scala:273:95]
  assign io_deq_bits_meta_1 = _ram_ext_R0_data[420:301];	// @[Decoupled.scala:273:95]
endmodule

