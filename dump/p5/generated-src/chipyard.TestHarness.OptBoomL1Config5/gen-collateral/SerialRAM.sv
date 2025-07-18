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

module SerialRAM(
  input         clock,
                reset,
                io_ser_in_ready,
                io_ser_out_valid,
  input  [31:0] io_ser_out_bits,
  input         io_tsi_ser_in_valid,
  input  [31:0] io_tsi_ser_in_bits,
  input         io_tsi_ser_out_ready,
  output        io_ser_in_valid,
  output [31:0] io_ser_in_bits,
  output        io_ser_out_ready,
                io_tsi_ser_in_ready,
                io_tsi_ser_out_valid,
  output [31:0] io_tsi_ser_out_bits
);

  wire        _buffer_1_auto_in_a_ready;	// @[Buffer.scala:69:28]
  wire        _buffer_1_auto_in_d_valid;	// @[Buffer.scala:69:28]
  wire [63:0] _buffer_1_auto_in_d_bits_data;	// @[Buffer.scala:69:28]
  wire        _buffer_1_auto_out_a_valid;	// @[Buffer.scala:69:28]
  wire [2:0]  _buffer_1_auto_out_a_bits_opcode;	// @[Buffer.scala:69:28]
  wire [2:0]  _buffer_1_auto_out_a_bits_param;	// @[Buffer.scala:69:28]
  wire [3:0]  _buffer_1_auto_out_a_bits_size;	// @[Buffer.scala:69:28]
  wire        _buffer_1_auto_out_a_bits_source;	// @[Buffer.scala:69:28]
  wire [31:0] _buffer_1_auto_out_a_bits_address;	// @[Buffer.scala:69:28]
  wire [7:0]  _buffer_1_auto_out_a_bits_mask;	// @[Buffer.scala:69:28]
  wire [63:0] _buffer_1_auto_out_a_bits_data;	// @[Buffer.scala:69:28]
  wire        _buffer_1_auto_out_a_bits_corrupt;	// @[Buffer.scala:69:28]
  wire        _buffer_1_auto_out_d_ready;	// @[Buffer.scala:69:28]
  wire        _fragmenter_1_auto_in_a_ready;	// @[Fragmenter.scala:334:34]
  wire        _fragmenter_1_auto_in_d_valid;	// @[Fragmenter.scala:334:34]
  wire [2:0]  _fragmenter_1_auto_in_d_bits_size;	// @[Fragmenter.scala:334:34]
  wire [3:0]  _fragmenter_1_auto_in_d_bits_source;	// @[Fragmenter.scala:334:34]
  wire [63:0] _fragmenter_1_auto_in_d_bits_data;	// @[Fragmenter.scala:334:34]
  wire        _fragmenter_1_auto_out_a_valid;	// @[Fragmenter.scala:334:34]
  wire [2:0]  _fragmenter_1_auto_out_a_bits_opcode;	// @[Fragmenter.scala:334:34]
  wire [2:0]  _fragmenter_1_auto_out_a_bits_param;	// @[Fragmenter.scala:334:34]
  wire [1:0]  _fragmenter_1_auto_out_a_bits_size;	// @[Fragmenter.scala:334:34]
  wire [7:0]  _fragmenter_1_auto_out_a_bits_source;	// @[Fragmenter.scala:334:34]
  wire [17:0] _fragmenter_1_auto_out_a_bits_address;	// @[Fragmenter.scala:334:34]
  wire [7:0]  _fragmenter_1_auto_out_a_bits_mask;	// @[Fragmenter.scala:334:34]
  wire        _fragmenter_1_auto_out_a_bits_corrupt;	// @[Fragmenter.scala:334:34]
  wire        _fragmenter_1_auto_out_d_ready;	// @[Fragmenter.scala:334:34]
  wire        _fragmenter_auto_in_a_ready;	// @[Fragmenter.scala:334:34]
  wire        _fragmenter_auto_in_d_valid;	// @[Fragmenter.scala:334:34]
  wire [2:0]  _fragmenter_auto_in_d_bits_opcode;	// @[Fragmenter.scala:334:34]
  wire [1:0]  _fragmenter_auto_in_d_bits_param;	// @[Fragmenter.scala:334:34]
  wire [2:0]  _fragmenter_auto_in_d_bits_size;	// @[Fragmenter.scala:334:34]
  wire [3:0]  _fragmenter_auto_in_d_bits_source;	// @[Fragmenter.scala:334:34]
  wire        _fragmenter_auto_in_d_bits_sink;	// @[Fragmenter.scala:334:34]
  wire        _fragmenter_auto_in_d_bits_denied;	// @[Fragmenter.scala:334:34]
  wire [63:0] _fragmenter_auto_in_d_bits_data;	// @[Fragmenter.scala:334:34]
  wire        _fragmenter_auto_in_d_bits_corrupt;	// @[Fragmenter.scala:334:34]
  wire        _fragmenter_auto_out_a_valid;	// @[Fragmenter.scala:334:34]
  wire [2:0]  _fragmenter_auto_out_a_bits_opcode;	// @[Fragmenter.scala:334:34]
  wire [2:0]  _fragmenter_auto_out_a_bits_param;	// @[Fragmenter.scala:334:34]
  wire [1:0]  _fragmenter_auto_out_a_bits_size;	// @[Fragmenter.scala:334:34]
  wire [7:0]  _fragmenter_auto_out_a_bits_source;	// @[Fragmenter.scala:334:34]
  wire [28:0] _fragmenter_auto_out_a_bits_address;	// @[Fragmenter.scala:334:34]
  wire [7:0]  _fragmenter_auto_out_a_bits_mask;	// @[Fragmenter.scala:334:34]
  wire [63:0] _fragmenter_auto_out_a_bits_data;	// @[Fragmenter.scala:334:34]
  wire        _fragmenter_auto_out_a_bits_corrupt;	// @[Fragmenter.scala:334:34]
  wire        _fragmenter_auto_out_d_ready;	// @[Fragmenter.scala:334:34]
  wire        _buffer_auto_in_a_ready;	// @[Buffer.scala:69:28]
  wire        _buffer_auto_in_d_valid;	// @[Buffer.scala:69:28]
  wire [2:0]  _buffer_auto_in_d_bits_opcode;	// @[Buffer.scala:69:28]
  wire [1:0]  _buffer_auto_in_d_bits_param;	// @[Buffer.scala:69:28]
  wire [1:0]  _buffer_auto_in_d_bits_size;	// @[Buffer.scala:69:28]
  wire [7:0]  _buffer_auto_in_d_bits_source;	// @[Buffer.scala:69:28]
  wire        _buffer_auto_in_d_bits_sink;	// @[Buffer.scala:69:28]
  wire        _buffer_auto_in_d_bits_denied;	// @[Buffer.scala:69:28]
  wire [63:0] _buffer_auto_in_d_bits_data;	// @[Buffer.scala:69:28]
  wire        _buffer_auto_in_d_bits_corrupt;	// @[Buffer.scala:69:28]
  wire        _buffer_auto_out_a_valid;	// @[Buffer.scala:69:28]
  wire [2:0]  _buffer_auto_out_a_bits_opcode;	// @[Buffer.scala:69:28]
  wire [2:0]  _buffer_auto_out_a_bits_param;	// @[Buffer.scala:69:28]
  wire [1:0]  _buffer_auto_out_a_bits_size;	// @[Buffer.scala:69:28]
  wire [7:0]  _buffer_auto_out_a_bits_source;	// @[Buffer.scala:69:28]
  wire [28:0] _buffer_auto_out_a_bits_address;	// @[Buffer.scala:69:28]
  wire [7:0]  _buffer_auto_out_a_bits_mask;	// @[Buffer.scala:69:28]
  wire [63:0] _buffer_auto_out_a_bits_data;	// @[Buffer.scala:69:28]
  wire        _buffer_auto_out_a_bits_corrupt;	// @[Buffer.scala:69:28]
  wire        _buffer_auto_out_d_ready;	// @[Buffer.scala:69:28]
  wire        _xbar_auto_in_a_ready;	// @[Xbar.scala:144:26]
  wire        _xbar_auto_in_d_valid;	// @[Xbar.scala:144:26]
  wire [2:0]  _xbar_auto_in_d_bits_opcode;	// @[Xbar.scala:144:26]
  wire [1:0]  _xbar_auto_in_d_bits_param;	// @[Xbar.scala:144:26]
  wire [2:0]  _xbar_auto_in_d_bits_size;	// @[Xbar.scala:144:26]
  wire [3:0]  _xbar_auto_in_d_bits_source;	// @[Xbar.scala:144:26]
  wire        _xbar_auto_in_d_bits_sink;	// @[Xbar.scala:144:26]
  wire        _xbar_auto_in_d_bits_denied;	// @[Xbar.scala:144:26]
  wire [63:0] _xbar_auto_in_d_bits_data;	// @[Xbar.scala:144:26]
  wire        _xbar_auto_in_d_bits_corrupt;	// @[Xbar.scala:144:26]
  wire        _xbar_auto_out_1_a_valid;	// @[Xbar.scala:144:26]
  wire [2:0]  _xbar_auto_out_1_a_bits_opcode;	// @[Xbar.scala:144:26]
  wire [2:0]  _xbar_auto_out_1_a_bits_param;	// @[Xbar.scala:144:26]
  wire [2:0]  _xbar_auto_out_1_a_bits_size;	// @[Xbar.scala:144:26]
  wire [3:0]  _xbar_auto_out_1_a_bits_source;	// @[Xbar.scala:144:26]
  wire [17:0] _xbar_auto_out_1_a_bits_address;	// @[Xbar.scala:144:26]
  wire [7:0]  _xbar_auto_out_1_a_bits_mask;	// @[Xbar.scala:144:26]
  wire        _xbar_auto_out_1_a_bits_corrupt;	// @[Xbar.scala:144:26]
  wire        _xbar_auto_out_1_d_ready;	// @[Xbar.scala:144:26]
  wire        _xbar_auto_out_0_a_valid;	// @[Xbar.scala:144:26]
  wire [2:0]  _xbar_auto_out_0_a_bits_opcode;	// @[Xbar.scala:144:26]
  wire [2:0]  _xbar_auto_out_0_a_bits_param;	// @[Xbar.scala:144:26]
  wire [2:0]  _xbar_auto_out_0_a_bits_size;	// @[Xbar.scala:144:26]
  wire [3:0]  _xbar_auto_out_0_a_bits_source;	// @[Xbar.scala:144:26]
  wire [28:0] _xbar_auto_out_0_a_bits_address;	// @[Xbar.scala:144:26]
  wire [7:0]  _xbar_auto_out_0_a_bits_mask;	// @[Xbar.scala:144:26]
  wire [63:0] _xbar_auto_out_0_a_bits_data;	// @[Xbar.scala:144:26]
  wire        _xbar_auto_out_0_a_bits_corrupt;	// @[Xbar.scala:144:26]
  wire        _xbar_auto_out_0_d_ready;	// @[Xbar.scala:144:26]
  wire        _rom_auto_in_a_ready;	// @[SerialAdapter.scala:438:25]
  wire        _rom_auto_in_d_valid;	// @[SerialAdapter.scala:438:25]
  wire [1:0]  _rom_auto_in_d_bits_size;	// @[SerialAdapter.scala:438:25]
  wire [7:0]  _rom_auto_in_d_bits_source;	// @[SerialAdapter.scala:438:25]
  wire [63:0] _rom_auto_in_d_bits_data;	// @[SerialAdapter.scala:438:25]
  wire        _srams_auto_in_a_ready;	// @[SerialAdapter.scala:459:15]
  wire        _srams_auto_in_d_valid;	// @[SerialAdapter.scala:459:15]
  wire [2:0]  _srams_auto_in_d_bits_opcode;	// @[SerialAdapter.scala:459:15]
  wire [1:0]  _srams_auto_in_d_bits_size;	// @[SerialAdapter.scala:459:15]
  wire [7:0]  _srams_auto_in_d_bits_source;	// @[SerialAdapter.scala:459:15]
  wire [63:0] _srams_auto_in_d_bits_data;	// @[SerialAdapter.scala:459:15]
  wire        _serdesser_auto_manager_in_a_ready;	// @[SerialAdapter.scala:452:29]
  wire        _serdesser_auto_manager_in_d_valid;	// @[SerialAdapter.scala:452:29]
  wire [2:0]  _serdesser_auto_manager_in_d_bits_opcode;	// @[SerialAdapter.scala:452:29]
  wire [1:0]  _serdesser_auto_manager_in_d_bits_param;	// @[SerialAdapter.scala:452:29]
  wire [3:0]  _serdesser_auto_manager_in_d_bits_size;	// @[SerialAdapter.scala:452:29]
  wire        _serdesser_auto_manager_in_d_bits_source;	// @[SerialAdapter.scala:452:29]
  wire [1:0]  _serdesser_auto_manager_in_d_bits_sink;	// @[SerialAdapter.scala:452:29]
  wire        _serdesser_auto_manager_in_d_bits_denied;	// @[SerialAdapter.scala:452:29]
  wire [63:0] _serdesser_auto_manager_in_d_bits_data;	// @[SerialAdapter.scala:452:29]
  wire        _serdesser_auto_manager_in_d_bits_corrupt;	// @[SerialAdapter.scala:452:29]
  wire        _serdesser_auto_client_out_a_valid;	// @[SerialAdapter.scala:452:29]
  wire [2:0]  _serdesser_auto_client_out_a_bits_opcode;	// @[SerialAdapter.scala:452:29]
  wire [2:0]  _serdesser_auto_client_out_a_bits_param;	// @[SerialAdapter.scala:452:29]
  wire [2:0]  _serdesser_auto_client_out_a_bits_size;	// @[SerialAdapter.scala:452:29]
  wire [3:0]  _serdesser_auto_client_out_a_bits_source;	// @[SerialAdapter.scala:452:29]
  wire [28:0] _serdesser_auto_client_out_a_bits_address;	// @[SerialAdapter.scala:452:29]
  wire [7:0]  _serdesser_auto_client_out_a_bits_mask;	// @[SerialAdapter.scala:452:29]
  wire [63:0] _serdesser_auto_client_out_a_bits_data;	// @[SerialAdapter.scala:452:29]
  wire        _serdesser_auto_client_out_a_bits_corrupt;	// @[SerialAdapter.scala:452:29]
  wire        _serdesser_auto_client_out_d_ready;	// @[SerialAdapter.scala:452:29]
  wire        _adapter_auto_out_a_valid;	// @[SerialAdapter.scala:451:27]
  wire [2:0]  _adapter_auto_out_a_bits_opcode;	// @[SerialAdapter.scala:451:27]
  wire [3:0]  _adapter_auto_out_a_bits_size;	// @[SerialAdapter.scala:451:27]
  wire [31:0] _adapter_auto_out_a_bits_address;	// @[SerialAdapter.scala:451:27]
  wire [7:0]  _adapter_auto_out_a_bits_mask;	// @[SerialAdapter.scala:451:27]
  wire [63:0] _adapter_auto_out_a_bits_data;	// @[SerialAdapter.scala:451:27]
  wire        _adapter_auto_out_d_ready;	// @[SerialAdapter.scala:451:27]
  SerialAdapter adapter (	// @[SerialAdapter.scala:451:27]
    .clock                   (clock),
    .reset                   (reset),
    .auto_out_a_ready        (_buffer_1_auto_in_a_ready),	// @[Buffer.scala:69:28]
    .auto_out_d_valid        (_buffer_1_auto_in_d_valid),	// @[Buffer.scala:69:28]
    .auto_out_d_bits_data    (_buffer_1_auto_in_d_bits_data),	// @[Buffer.scala:69:28]
    .io_serial_in_valid      (io_tsi_ser_in_valid),
    .io_serial_in_bits       (io_tsi_ser_in_bits),
    .io_serial_out_ready     (io_tsi_ser_out_ready),
    .auto_out_a_valid        (_adapter_auto_out_a_valid),
    .auto_out_a_bits_opcode  (_adapter_auto_out_a_bits_opcode),
    .auto_out_a_bits_size    (_adapter_auto_out_a_bits_size),
    .auto_out_a_bits_address (_adapter_auto_out_a_bits_address),
    .auto_out_a_bits_mask    (_adapter_auto_out_a_bits_mask),
    .auto_out_a_bits_data    (_adapter_auto_out_a_bits_data),
    .auto_out_d_ready        (_adapter_auto_out_d_ready),
    .io_serial_in_ready      (io_tsi_ser_in_ready),
    .io_serial_out_valid     (io_tsi_ser_out_valid),
    .io_serial_out_bits      (io_tsi_ser_out_bits)
  );
  TLSerdesser_1 serdesser (	// @[SerialAdapter.scala:452:29]
    .clock                          (clock),
    .reset                          (reset),
    .auto_manager_in_a_valid        (_buffer_1_auto_out_a_valid),	// @[Buffer.scala:69:28]
    .auto_manager_in_a_bits_opcode  (_buffer_1_auto_out_a_bits_opcode),	// @[Buffer.scala:69:28]
    .auto_manager_in_a_bits_param   (_buffer_1_auto_out_a_bits_param),	// @[Buffer.scala:69:28]
    .auto_manager_in_a_bits_size    (_buffer_1_auto_out_a_bits_size),	// @[Buffer.scala:69:28]
    .auto_manager_in_a_bits_source  (_buffer_1_auto_out_a_bits_source),	// @[Buffer.scala:69:28]
    .auto_manager_in_a_bits_address (_buffer_1_auto_out_a_bits_address),	// @[Buffer.scala:69:28]
    .auto_manager_in_a_bits_mask    (_buffer_1_auto_out_a_bits_mask),	// @[Buffer.scala:69:28]
    .auto_manager_in_a_bits_data    (_buffer_1_auto_out_a_bits_data),	// @[Buffer.scala:69:28]
    .auto_manager_in_a_bits_corrupt (_buffer_1_auto_out_a_bits_corrupt),	// @[Buffer.scala:69:28]
    .auto_manager_in_d_ready        (_buffer_1_auto_out_d_ready),	// @[Buffer.scala:69:28]
    .auto_client_out_a_ready        (_xbar_auto_in_a_ready),	// @[Xbar.scala:144:26]
    .auto_client_out_d_valid        (_xbar_auto_in_d_valid),	// @[Xbar.scala:144:26]
    .auto_client_out_d_bits_opcode  (_xbar_auto_in_d_bits_opcode),	// @[Xbar.scala:144:26]
    .auto_client_out_d_bits_param   (_xbar_auto_in_d_bits_param),	// @[Xbar.scala:144:26]
    .auto_client_out_d_bits_size    (_xbar_auto_in_d_bits_size),	// @[Xbar.scala:144:26]
    .auto_client_out_d_bits_source  (_xbar_auto_in_d_bits_source),	// @[Xbar.scala:144:26]
    .auto_client_out_d_bits_sink    (_xbar_auto_in_d_bits_sink),	// @[Xbar.scala:144:26]
    .auto_client_out_d_bits_denied  (_xbar_auto_in_d_bits_denied),	// @[Xbar.scala:144:26]
    .auto_client_out_d_bits_data    (_xbar_auto_in_d_bits_data),	// @[Xbar.scala:144:26]
    .auto_client_out_d_bits_corrupt (_xbar_auto_in_d_bits_corrupt),	// @[Xbar.scala:144:26]
    .io_ser_in_valid                (io_ser_out_valid),
    .io_ser_in_bits                 (io_ser_out_bits),
    .io_ser_out_ready               (io_ser_in_ready),
    .auto_manager_in_a_ready        (_serdesser_auto_manager_in_a_ready),
    .auto_manager_in_d_valid        (_serdesser_auto_manager_in_d_valid),
    .auto_manager_in_d_bits_opcode  (_serdesser_auto_manager_in_d_bits_opcode),
    .auto_manager_in_d_bits_param   (_serdesser_auto_manager_in_d_bits_param),
    .auto_manager_in_d_bits_size    (_serdesser_auto_manager_in_d_bits_size),
    .auto_manager_in_d_bits_source  (_serdesser_auto_manager_in_d_bits_source),
    .auto_manager_in_d_bits_sink    (_serdesser_auto_manager_in_d_bits_sink),
    .auto_manager_in_d_bits_denied  (_serdesser_auto_manager_in_d_bits_denied),
    .auto_manager_in_d_bits_data    (_serdesser_auto_manager_in_d_bits_data),
    .auto_manager_in_d_bits_corrupt (_serdesser_auto_manager_in_d_bits_corrupt),
    .auto_client_out_a_valid        (_serdesser_auto_client_out_a_valid),
    .auto_client_out_a_bits_opcode  (_serdesser_auto_client_out_a_bits_opcode),
    .auto_client_out_a_bits_param   (_serdesser_auto_client_out_a_bits_param),
    .auto_client_out_a_bits_size    (_serdesser_auto_client_out_a_bits_size),
    .auto_client_out_a_bits_source  (_serdesser_auto_client_out_a_bits_source),
    .auto_client_out_a_bits_address (_serdesser_auto_client_out_a_bits_address),
    .auto_client_out_a_bits_mask    (_serdesser_auto_client_out_a_bits_mask),
    .auto_client_out_a_bits_data    (_serdesser_auto_client_out_a_bits_data),
    .auto_client_out_a_bits_corrupt (_serdesser_auto_client_out_a_bits_corrupt),
    .auto_client_out_d_ready        (_serdesser_auto_client_out_d_ready),
    .io_ser_in_ready                (io_ser_out_ready),
    .io_ser_out_valid               (io_ser_in_valid),
    .io_ser_out_bits                (io_ser_in_bits)
  );
  TLRAM srams (	// @[SerialAdapter.scala:459:15]
    .clock                  (clock),
    .reset                  (reset),
    .auto_in_a_valid        (_buffer_auto_out_a_valid),	// @[Buffer.scala:69:28]
    .auto_in_a_bits_opcode  (_buffer_auto_out_a_bits_opcode),	// @[Buffer.scala:69:28]
    .auto_in_a_bits_param   (_buffer_auto_out_a_bits_param),	// @[Buffer.scala:69:28]
    .auto_in_a_bits_size    (_buffer_auto_out_a_bits_size),	// @[Buffer.scala:69:28]
    .auto_in_a_bits_source  (_buffer_auto_out_a_bits_source),	// @[Buffer.scala:69:28]
    .auto_in_a_bits_address (_buffer_auto_out_a_bits_address),	// @[Buffer.scala:69:28]
    .auto_in_a_bits_mask    (_buffer_auto_out_a_bits_mask),	// @[Buffer.scala:69:28]
    .auto_in_a_bits_data    (_buffer_auto_out_a_bits_data),	// @[Buffer.scala:69:28]
    .auto_in_a_bits_corrupt (_buffer_auto_out_a_bits_corrupt),	// @[Buffer.scala:69:28]
    .auto_in_d_ready        (_buffer_auto_out_d_ready),	// @[Buffer.scala:69:28]
    .auto_in_a_ready        (_srams_auto_in_a_ready),
    .auto_in_d_valid        (_srams_auto_in_d_valid),
    .auto_in_d_bits_opcode  (_srams_auto_in_d_bits_opcode),
    .auto_in_d_bits_size    (_srams_auto_in_d_bits_size),
    .auto_in_d_bits_source  (_srams_auto_in_d_bits_source),
    .auto_in_d_bits_data    (_srams_auto_in_d_bits_data)
  );
  TLROM_1 rom (	// @[SerialAdapter.scala:438:25]
    .clock                  (clock),
    .reset                  (reset),
    .auto_in_a_valid        (_fragmenter_1_auto_out_a_valid),	// @[Fragmenter.scala:334:34]
    .auto_in_a_bits_opcode  (_fragmenter_1_auto_out_a_bits_opcode),	// @[Fragmenter.scala:334:34]
    .auto_in_a_bits_param   (_fragmenter_1_auto_out_a_bits_param),	// @[Fragmenter.scala:334:34]
    .auto_in_a_bits_size    (_fragmenter_1_auto_out_a_bits_size),	// @[Fragmenter.scala:334:34]
    .auto_in_a_bits_source  (_fragmenter_1_auto_out_a_bits_source),	// @[Fragmenter.scala:334:34]
    .auto_in_a_bits_address (_fragmenter_1_auto_out_a_bits_address),	// @[Fragmenter.scala:334:34]
    .auto_in_a_bits_mask    (_fragmenter_1_auto_out_a_bits_mask),	// @[Fragmenter.scala:334:34]
    .auto_in_a_bits_corrupt (_fragmenter_1_auto_out_a_bits_corrupt),	// @[Fragmenter.scala:334:34]
    .auto_in_d_ready        (_fragmenter_1_auto_out_d_ready),	// @[Fragmenter.scala:334:34]
    .auto_in_a_ready        (_rom_auto_in_a_ready),
    .auto_in_d_valid        (_rom_auto_in_d_valid),
    .auto_in_d_bits_size    (_rom_auto_in_d_bits_size),
    .auto_in_d_bits_source  (_rom_auto_in_d_bits_source),
    .auto_in_d_bits_data    (_rom_auto_in_d_bits_data)
  );
  TLXbar_11 xbar (	// @[Xbar.scala:144:26]
    .clock                     (clock),
    .reset                     (reset),
    .auto_in_a_valid           (_serdesser_auto_client_out_a_valid),	// @[SerialAdapter.scala:452:29]
    .auto_in_a_bits_opcode     (_serdesser_auto_client_out_a_bits_opcode),	// @[SerialAdapter.scala:452:29]
    .auto_in_a_bits_param      (_serdesser_auto_client_out_a_bits_param),	// @[SerialAdapter.scala:452:29]
    .auto_in_a_bits_size       (_serdesser_auto_client_out_a_bits_size),	// @[SerialAdapter.scala:452:29]
    .auto_in_a_bits_source     (_serdesser_auto_client_out_a_bits_source),	// @[SerialAdapter.scala:452:29]
    .auto_in_a_bits_address    (_serdesser_auto_client_out_a_bits_address),	// @[SerialAdapter.scala:452:29]
    .auto_in_a_bits_mask       (_serdesser_auto_client_out_a_bits_mask),	// @[SerialAdapter.scala:452:29]
    .auto_in_a_bits_data       (_serdesser_auto_client_out_a_bits_data),	// @[SerialAdapter.scala:452:29]
    .auto_in_a_bits_corrupt    (_serdesser_auto_client_out_a_bits_corrupt),	// @[SerialAdapter.scala:452:29]
    .auto_in_d_ready           (_serdesser_auto_client_out_d_ready),	// @[SerialAdapter.scala:452:29]
    .auto_out_1_a_ready        (_fragmenter_1_auto_in_a_ready),	// @[Fragmenter.scala:334:34]
    .auto_out_1_d_valid        (_fragmenter_1_auto_in_d_valid),	// @[Fragmenter.scala:334:34]
    .auto_out_1_d_bits_size    (_fragmenter_1_auto_in_d_bits_size),	// @[Fragmenter.scala:334:34]
    .auto_out_1_d_bits_source  (_fragmenter_1_auto_in_d_bits_source),	// @[Fragmenter.scala:334:34]
    .auto_out_1_d_bits_data    (_fragmenter_1_auto_in_d_bits_data),	// @[Fragmenter.scala:334:34]
    .auto_out_0_a_ready        (_fragmenter_auto_in_a_ready),	// @[Fragmenter.scala:334:34]
    .auto_out_0_d_valid        (_fragmenter_auto_in_d_valid),	// @[Fragmenter.scala:334:34]
    .auto_out_0_d_bits_opcode  (_fragmenter_auto_in_d_bits_opcode),	// @[Fragmenter.scala:334:34]
    .auto_out_0_d_bits_param   (_fragmenter_auto_in_d_bits_param),	// @[Fragmenter.scala:334:34]
    .auto_out_0_d_bits_size    (_fragmenter_auto_in_d_bits_size),	// @[Fragmenter.scala:334:34]
    .auto_out_0_d_bits_source  (_fragmenter_auto_in_d_bits_source),	// @[Fragmenter.scala:334:34]
    .auto_out_0_d_bits_sink    (_fragmenter_auto_in_d_bits_sink),	// @[Fragmenter.scala:334:34]
    .auto_out_0_d_bits_denied  (_fragmenter_auto_in_d_bits_denied),	// @[Fragmenter.scala:334:34]
    .auto_out_0_d_bits_data    (_fragmenter_auto_in_d_bits_data),	// @[Fragmenter.scala:334:34]
    .auto_out_0_d_bits_corrupt (_fragmenter_auto_in_d_bits_corrupt),	// @[Fragmenter.scala:334:34]
    .auto_in_a_ready           (_xbar_auto_in_a_ready),
    .auto_in_d_valid           (_xbar_auto_in_d_valid),
    .auto_in_d_bits_opcode     (_xbar_auto_in_d_bits_opcode),
    .auto_in_d_bits_param      (_xbar_auto_in_d_bits_param),
    .auto_in_d_bits_size       (_xbar_auto_in_d_bits_size),
    .auto_in_d_bits_source     (_xbar_auto_in_d_bits_source),
    .auto_in_d_bits_sink       (_xbar_auto_in_d_bits_sink),
    .auto_in_d_bits_denied     (_xbar_auto_in_d_bits_denied),
    .auto_in_d_bits_data       (_xbar_auto_in_d_bits_data),
    .auto_in_d_bits_corrupt    (_xbar_auto_in_d_bits_corrupt),
    .auto_out_1_a_valid        (_xbar_auto_out_1_a_valid),
    .auto_out_1_a_bits_opcode  (_xbar_auto_out_1_a_bits_opcode),
    .auto_out_1_a_bits_param   (_xbar_auto_out_1_a_bits_param),
    .auto_out_1_a_bits_size    (_xbar_auto_out_1_a_bits_size),
    .auto_out_1_a_bits_source  (_xbar_auto_out_1_a_bits_source),
    .auto_out_1_a_bits_address (_xbar_auto_out_1_a_bits_address),
    .auto_out_1_a_bits_mask    (_xbar_auto_out_1_a_bits_mask),
    .auto_out_1_a_bits_corrupt (_xbar_auto_out_1_a_bits_corrupt),
    .auto_out_1_d_ready        (_xbar_auto_out_1_d_ready),
    .auto_out_0_a_valid        (_xbar_auto_out_0_a_valid),
    .auto_out_0_a_bits_opcode  (_xbar_auto_out_0_a_bits_opcode),
    .auto_out_0_a_bits_param   (_xbar_auto_out_0_a_bits_param),
    .auto_out_0_a_bits_size    (_xbar_auto_out_0_a_bits_size),
    .auto_out_0_a_bits_source  (_xbar_auto_out_0_a_bits_source),
    .auto_out_0_a_bits_address (_xbar_auto_out_0_a_bits_address),
    .auto_out_0_a_bits_mask    (_xbar_auto_out_0_a_bits_mask),
    .auto_out_0_a_bits_data    (_xbar_auto_out_0_a_bits_data),
    .auto_out_0_a_bits_corrupt (_xbar_auto_out_0_a_bits_corrupt),
    .auto_out_0_d_ready        (_xbar_auto_out_0_d_ready)
  );
  TLBuffer_20 buffer (	// @[Buffer.scala:69:28]
    .clock                   (clock),
    .reset                   (reset),
    .auto_in_a_valid         (_fragmenter_auto_out_a_valid),	// @[Fragmenter.scala:334:34]
    .auto_in_a_bits_opcode   (_fragmenter_auto_out_a_bits_opcode),	// @[Fragmenter.scala:334:34]
    .auto_in_a_bits_param    (_fragmenter_auto_out_a_bits_param),	// @[Fragmenter.scala:334:34]
    .auto_in_a_bits_size     (_fragmenter_auto_out_a_bits_size),	// @[Fragmenter.scala:334:34]
    .auto_in_a_bits_source   (_fragmenter_auto_out_a_bits_source),	// @[Fragmenter.scala:334:34]
    .auto_in_a_bits_address  (_fragmenter_auto_out_a_bits_address),	// @[Fragmenter.scala:334:34]
    .auto_in_a_bits_mask     (_fragmenter_auto_out_a_bits_mask),	// @[Fragmenter.scala:334:34]
    .auto_in_a_bits_data     (_fragmenter_auto_out_a_bits_data),	// @[Fragmenter.scala:334:34]
    .auto_in_a_bits_corrupt  (_fragmenter_auto_out_a_bits_corrupt),	// @[Fragmenter.scala:334:34]
    .auto_in_d_ready         (_fragmenter_auto_out_d_ready),	// @[Fragmenter.scala:334:34]
    .auto_out_a_ready        (_srams_auto_in_a_ready),	// @[SerialAdapter.scala:459:15]
    .auto_out_d_valid        (_srams_auto_in_d_valid),	// @[SerialAdapter.scala:459:15]
    .auto_out_d_bits_opcode  (_srams_auto_in_d_bits_opcode),	// @[SerialAdapter.scala:459:15]
    .auto_out_d_bits_size    (_srams_auto_in_d_bits_size),	// @[SerialAdapter.scala:459:15]
    .auto_out_d_bits_source  (_srams_auto_in_d_bits_source),	// @[SerialAdapter.scala:459:15]
    .auto_out_d_bits_data    (_srams_auto_in_d_bits_data),	// @[SerialAdapter.scala:459:15]
    .auto_in_a_ready         (_buffer_auto_in_a_ready),
    .auto_in_d_valid         (_buffer_auto_in_d_valid),
    .auto_in_d_bits_opcode   (_buffer_auto_in_d_bits_opcode),
    .auto_in_d_bits_param    (_buffer_auto_in_d_bits_param),
    .auto_in_d_bits_size     (_buffer_auto_in_d_bits_size),
    .auto_in_d_bits_source   (_buffer_auto_in_d_bits_source),
    .auto_in_d_bits_sink     (_buffer_auto_in_d_bits_sink),
    .auto_in_d_bits_denied   (_buffer_auto_in_d_bits_denied),
    .auto_in_d_bits_data     (_buffer_auto_in_d_bits_data),
    .auto_in_d_bits_corrupt  (_buffer_auto_in_d_bits_corrupt),
    .auto_out_a_valid        (_buffer_auto_out_a_valid),
    .auto_out_a_bits_opcode  (_buffer_auto_out_a_bits_opcode),
    .auto_out_a_bits_param   (_buffer_auto_out_a_bits_param),
    .auto_out_a_bits_size    (_buffer_auto_out_a_bits_size),
    .auto_out_a_bits_source  (_buffer_auto_out_a_bits_source),
    .auto_out_a_bits_address (_buffer_auto_out_a_bits_address),
    .auto_out_a_bits_mask    (_buffer_auto_out_a_bits_mask),
    .auto_out_a_bits_data    (_buffer_auto_out_a_bits_data),
    .auto_out_a_bits_corrupt (_buffer_auto_out_a_bits_corrupt),
    .auto_out_d_ready        (_buffer_auto_out_d_ready)
  );
  TLFragmenter_8 fragmenter (	// @[Fragmenter.scala:334:34]
    .clock                   (clock),
    .reset                   (reset),
    .auto_in_a_valid         (_xbar_auto_out_0_a_valid),	// @[Xbar.scala:144:26]
    .auto_in_a_bits_opcode   (_xbar_auto_out_0_a_bits_opcode),	// @[Xbar.scala:144:26]
    .auto_in_a_bits_param    (_xbar_auto_out_0_a_bits_param),	// @[Xbar.scala:144:26]
    .auto_in_a_bits_size     (_xbar_auto_out_0_a_bits_size),	// @[Xbar.scala:144:26]
    .auto_in_a_bits_source   (_xbar_auto_out_0_a_bits_source),	// @[Xbar.scala:144:26]
    .auto_in_a_bits_address  (_xbar_auto_out_0_a_bits_address),	// @[Xbar.scala:144:26]
    .auto_in_a_bits_mask     (_xbar_auto_out_0_a_bits_mask),	// @[Xbar.scala:144:26]
    .auto_in_a_bits_data     (_xbar_auto_out_0_a_bits_data),	// @[Xbar.scala:144:26]
    .auto_in_a_bits_corrupt  (_xbar_auto_out_0_a_bits_corrupt),	// @[Xbar.scala:144:26]
    .auto_in_d_ready         (_xbar_auto_out_0_d_ready),	// @[Xbar.scala:144:26]
    .auto_out_a_ready        (_buffer_auto_in_a_ready),	// @[Buffer.scala:69:28]
    .auto_out_d_valid        (_buffer_auto_in_d_valid),	// @[Buffer.scala:69:28]
    .auto_out_d_bits_opcode  (_buffer_auto_in_d_bits_opcode),	// @[Buffer.scala:69:28]
    .auto_out_d_bits_param   (_buffer_auto_in_d_bits_param),	// @[Buffer.scala:69:28]
    .auto_out_d_bits_size    (_buffer_auto_in_d_bits_size),	// @[Buffer.scala:69:28]
    .auto_out_d_bits_source  (_buffer_auto_in_d_bits_source),	// @[Buffer.scala:69:28]
    .auto_out_d_bits_sink    (_buffer_auto_in_d_bits_sink),	// @[Buffer.scala:69:28]
    .auto_out_d_bits_denied  (_buffer_auto_in_d_bits_denied),	// @[Buffer.scala:69:28]
    .auto_out_d_bits_data    (_buffer_auto_in_d_bits_data),	// @[Buffer.scala:69:28]
    .auto_out_d_bits_corrupt (_buffer_auto_in_d_bits_corrupt),	// @[Buffer.scala:69:28]
    .auto_in_a_ready         (_fragmenter_auto_in_a_ready),
    .auto_in_d_valid         (_fragmenter_auto_in_d_valid),
    .auto_in_d_bits_opcode   (_fragmenter_auto_in_d_bits_opcode),
    .auto_in_d_bits_param    (_fragmenter_auto_in_d_bits_param),
    .auto_in_d_bits_size     (_fragmenter_auto_in_d_bits_size),
    .auto_in_d_bits_source   (_fragmenter_auto_in_d_bits_source),
    .auto_in_d_bits_sink     (_fragmenter_auto_in_d_bits_sink),
    .auto_in_d_bits_denied   (_fragmenter_auto_in_d_bits_denied),
    .auto_in_d_bits_data     (_fragmenter_auto_in_d_bits_data),
    .auto_in_d_bits_corrupt  (_fragmenter_auto_in_d_bits_corrupt),
    .auto_out_a_valid        (_fragmenter_auto_out_a_valid),
    .auto_out_a_bits_opcode  (_fragmenter_auto_out_a_bits_opcode),
    .auto_out_a_bits_param   (_fragmenter_auto_out_a_bits_param),
    .auto_out_a_bits_size    (_fragmenter_auto_out_a_bits_size),
    .auto_out_a_bits_source  (_fragmenter_auto_out_a_bits_source),
    .auto_out_a_bits_address (_fragmenter_auto_out_a_bits_address),
    .auto_out_a_bits_mask    (_fragmenter_auto_out_a_bits_mask),
    .auto_out_a_bits_data    (_fragmenter_auto_out_a_bits_data),
    .auto_out_a_bits_corrupt (_fragmenter_auto_out_a_bits_corrupt),
    .auto_out_d_ready        (_fragmenter_auto_out_d_ready)
  );
  TLFragmenter_9 fragmenter_1 (	// @[Fragmenter.scala:334:34]
    .clock                   (clock),
    .reset                   (reset),
    .auto_in_a_valid         (_xbar_auto_out_1_a_valid),	// @[Xbar.scala:144:26]
    .auto_in_a_bits_opcode   (_xbar_auto_out_1_a_bits_opcode),	// @[Xbar.scala:144:26]
    .auto_in_a_bits_param    (_xbar_auto_out_1_a_bits_param),	// @[Xbar.scala:144:26]
    .auto_in_a_bits_size     (_xbar_auto_out_1_a_bits_size),	// @[Xbar.scala:144:26]
    .auto_in_a_bits_source   (_xbar_auto_out_1_a_bits_source),	// @[Xbar.scala:144:26]
    .auto_in_a_bits_address  (_xbar_auto_out_1_a_bits_address),	// @[Xbar.scala:144:26]
    .auto_in_a_bits_mask     (_xbar_auto_out_1_a_bits_mask),	// @[Xbar.scala:144:26]
    .auto_in_a_bits_corrupt  (_xbar_auto_out_1_a_bits_corrupt),	// @[Xbar.scala:144:26]
    .auto_in_d_ready         (_xbar_auto_out_1_d_ready),	// @[Xbar.scala:144:26]
    .auto_out_a_ready        (_rom_auto_in_a_ready),	// @[SerialAdapter.scala:438:25]
    .auto_out_d_valid        (_rom_auto_in_d_valid),	// @[SerialAdapter.scala:438:25]
    .auto_out_d_bits_size    (_rom_auto_in_d_bits_size),	// @[SerialAdapter.scala:438:25]
    .auto_out_d_bits_source  (_rom_auto_in_d_bits_source),	// @[SerialAdapter.scala:438:25]
    .auto_out_d_bits_data    (_rom_auto_in_d_bits_data),	// @[SerialAdapter.scala:438:25]
    .auto_in_a_ready         (_fragmenter_1_auto_in_a_ready),
    .auto_in_d_valid         (_fragmenter_1_auto_in_d_valid),
    .auto_in_d_bits_size     (_fragmenter_1_auto_in_d_bits_size),
    .auto_in_d_bits_source   (_fragmenter_1_auto_in_d_bits_source),
    .auto_in_d_bits_data     (_fragmenter_1_auto_in_d_bits_data),
    .auto_out_a_valid        (_fragmenter_1_auto_out_a_valid),
    .auto_out_a_bits_opcode  (_fragmenter_1_auto_out_a_bits_opcode),
    .auto_out_a_bits_param   (_fragmenter_1_auto_out_a_bits_param),
    .auto_out_a_bits_size    (_fragmenter_1_auto_out_a_bits_size),
    .auto_out_a_bits_source  (_fragmenter_1_auto_out_a_bits_source),
    .auto_out_a_bits_address (_fragmenter_1_auto_out_a_bits_address),
    .auto_out_a_bits_mask    (_fragmenter_1_auto_out_a_bits_mask),
    .auto_out_a_bits_corrupt (_fragmenter_1_auto_out_a_bits_corrupt),
    .auto_out_d_ready        (_fragmenter_1_auto_out_d_ready)
  );
  TLBuffer_21 buffer_1 (	// @[Buffer.scala:69:28]
    .clock                   (clock),
    .reset                   (reset),
    .auto_in_a_valid         (_adapter_auto_out_a_valid),	// @[SerialAdapter.scala:451:27]
    .auto_in_a_bits_opcode   (_adapter_auto_out_a_bits_opcode),	// @[SerialAdapter.scala:451:27]
    .auto_in_a_bits_size     (_adapter_auto_out_a_bits_size),	// @[SerialAdapter.scala:451:27]
    .auto_in_a_bits_address  (_adapter_auto_out_a_bits_address),	// @[SerialAdapter.scala:451:27]
    .auto_in_a_bits_mask     (_adapter_auto_out_a_bits_mask),	// @[SerialAdapter.scala:451:27]
    .auto_in_a_bits_data     (_adapter_auto_out_a_bits_data),	// @[SerialAdapter.scala:451:27]
    .auto_in_d_ready         (_adapter_auto_out_d_ready),	// @[SerialAdapter.scala:451:27]
    .auto_out_a_ready        (_serdesser_auto_manager_in_a_ready),	// @[SerialAdapter.scala:452:29]
    .auto_out_d_valid        (_serdesser_auto_manager_in_d_valid),	// @[SerialAdapter.scala:452:29]
    .auto_out_d_bits_opcode  (_serdesser_auto_manager_in_d_bits_opcode),	// @[SerialAdapter.scala:452:29]
    .auto_out_d_bits_param   (_serdesser_auto_manager_in_d_bits_param),	// @[SerialAdapter.scala:452:29]
    .auto_out_d_bits_size    (_serdesser_auto_manager_in_d_bits_size),	// @[SerialAdapter.scala:452:29]
    .auto_out_d_bits_source  (_serdesser_auto_manager_in_d_bits_source),	// @[SerialAdapter.scala:452:29]
    .auto_out_d_bits_sink    (_serdesser_auto_manager_in_d_bits_sink),	// @[SerialAdapter.scala:452:29]
    .auto_out_d_bits_denied  (_serdesser_auto_manager_in_d_bits_denied),	// @[SerialAdapter.scala:452:29]
    .auto_out_d_bits_data    (_serdesser_auto_manager_in_d_bits_data),	// @[SerialAdapter.scala:452:29]
    .auto_out_d_bits_corrupt (_serdesser_auto_manager_in_d_bits_corrupt),	// @[SerialAdapter.scala:452:29]
    .auto_in_a_ready         (_buffer_1_auto_in_a_ready),
    .auto_in_d_valid         (_buffer_1_auto_in_d_valid),
    .auto_in_d_bits_data     (_buffer_1_auto_in_d_bits_data),
    .auto_out_a_valid        (_buffer_1_auto_out_a_valid),
    .auto_out_a_bits_opcode  (_buffer_1_auto_out_a_bits_opcode),
    .auto_out_a_bits_param   (_buffer_1_auto_out_a_bits_param),
    .auto_out_a_bits_size    (_buffer_1_auto_out_a_bits_size),
    .auto_out_a_bits_source  (_buffer_1_auto_out_a_bits_source),
    .auto_out_a_bits_address (_buffer_1_auto_out_a_bits_address),
    .auto_out_a_bits_mask    (_buffer_1_auto_out_a_bits_mask),
    .auto_out_a_bits_data    (_buffer_1_auto_out_a_bits_data),
    .auto_out_a_bits_corrupt (_buffer_1_auto_out_a_bits_corrupt),
    .auto_out_d_ready        (_buffer_1_auto_out_d_ready)
  );
endmodule

