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

// VCS coverage exclude_file
module regfile_combMem_0(	// @[regfile.scala:117:20]
  input  [5:0]  R0_addr,
  input         R0_en,
                R0_clk,
  input  [5:0]  R1_addr,
  input         R1_en,
                R1_clk,
  input  [5:0]  R2_addr,
  input         R2_en,
                R2_clk,
  input  [5:0]  R3_addr,
  input         R3_en,
                R3_clk,
  input  [5:0]  R4_addr,
  input         R4_en,
                R4_clk,
  input  [5:0]  R5_addr,
  input         R5_en,
                R5_clk,
  input  [5:0]  W0_addr,
  input         W0_en,
                W0_clk,
  input  [63:0] W0_data,
  input  [5:0]  W1_addr,
  input         W1_en,
                W1_clk,
  input  [63:0] W1_data,
  input  [5:0]  W2_addr,
  input         W2_en,
                W2_clk,
  input  [63:0] W2_data,
  output [63:0] R0_data,
                R1_data,
                R2_data,
                R3_data,
                R4_data,
                R5_data
);

  reg [63:0] Memory[0:63];	// @[regfile.scala:117:20]
  always @(posedge W0_clk) begin	// @[regfile.scala:117:20]
    if (W0_en)	// @[regfile.scala:117:20]
      Memory[W0_addr] <= W0_data;	// @[regfile.scala:117:20]
    if (W1_en)	// @[regfile.scala:117:20]
      Memory[W1_addr] <= W1_data;	// @[regfile.scala:117:20]
    if (W2_en)	// @[regfile.scala:117:20]
      Memory[W2_addr] <= W2_data;	// @[regfile.scala:117:20]
  end // always @(posedge)
  `ifndef SYNTHESIS	// @[regfile.scala:117:20]
    `ifdef RANDOMIZE_MEM_INIT	// @[regfile.scala:117:20]
      integer initvar;	// @[regfile.scala:117:20]
      reg [63:0] _RANDOM_MEM;	// @[regfile.scala:117:20]
    `endif // RANDOMIZE_MEM_INIT
    initial begin	// @[regfile.scala:117:20]
      `INIT_RANDOM_PROLOG_	// @[regfile.scala:117:20]
      `ifdef RANDOMIZE_MEM_INIT	// @[regfile.scala:117:20]
        for (initvar = 0; initvar < 64; initvar = initvar + 1) begin
          _RANDOM_MEM = {{`RANDOM}, {`RANDOM}};
          Memory[initvar] = _RANDOM_MEM[63:0];
        end	// @[regfile.scala:117:20]
      `endif // RANDOMIZE_MEM_INIT
    end // initial
  `endif // not def SYNTHESIS
  assign R0_data = R0_en ? Memory[R0_addr] : 64'bx;	// @[regfile.scala:117:20]
  assign R1_data = R1_en ? Memory[R1_addr] : 64'bx;	// @[regfile.scala:117:20]
  assign R2_data = R2_en ? Memory[R2_addr] : 64'bx;	// @[regfile.scala:117:20]
  assign R3_data = R3_en ? Memory[R3_addr] : 64'bx;	// @[regfile.scala:117:20]
  assign R4_data = R4_en ? Memory[R4_addr] : 64'bx;	// @[regfile.scala:117:20]
  assign R5_data = R5_en ? Memory[R5_addr] : 64'bx;	// @[regfile.scala:117:20]
endmodule

