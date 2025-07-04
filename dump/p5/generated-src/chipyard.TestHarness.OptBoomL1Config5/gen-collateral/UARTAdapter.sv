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

module UARTAdapter(
  input  clock,
         reset,
         io_uart_txd,
  output io_uart_rxd
);

  wire            _sim_serial_in_valid;	// @[UARTAdapter.scala:108:19]
  wire [7:0]      _sim_serial_in_bits;	// @[UARTAdapter.scala:108:19]
  wire            _sim_serial_out_ready;	// @[UARTAdapter.scala:108:19]
  wire            _rxfifo_io_enq_ready;	// @[UARTAdapter.scala:33:22]
  wire            _rxfifo_io_deq_valid;	// @[UARTAdapter.scala:33:22]
  wire [7:0]      _rxfifo_io_deq_bits;	// @[UARTAdapter.scala:33:22]
  wire            _txfifo_io_enq_ready;	// @[UARTAdapter.scala:32:22]
  wire            _txfifo_io_deq_valid;	// @[UARTAdapter.scala:32:22]
  wire [7:0]      _txfifo_io_deq_bits;	// @[UARTAdapter.scala:32:22]
  reg  [1:0]      txState;	// @[UARTAdapter.scala:38:24]
  reg  [7:0]      txData;	// @[UARTAdapter.scala:39:19]
  wire            _T_10 = txState == 2'h2;	// @[UARTAdapter.scala:38:24, :41:49]
  wire            _T_1 = _T_10 & _txfifo_io_enq_ready;	// @[UARTAdapter.scala:32:22, :41:{49,61}]
  reg  [2:0]      txDataIdx;	// @[Counter.scala:61:40]
  wire            txDataWrap = _T_1 & (&txDataIdx);	// @[Counter.scala:61:40, :73:24, :117:24, :118:{16,23}, UARTAdapter.scala:41:61]
  reg  [9:0]      txBaudCount;	// @[Counter.scala:61:40]
  reg  [1:0]      txSlackCount;	// @[Counter.scala:61:40]
  reg  [1:0]      rxState;	// @[UARTAdapter.scala:79:24]
  reg  [9:0]      rxBaudCount;	// @[Counter.scala:61:40]
  wire            wrap_wrap_3 = rxBaudCount == 10'h363;	// @[Counter.scala:61:40, :73:24]
  wire            rxBaudWrap = _txfifo_io_enq_ready & wrap_wrap_3;	// @[Counter.scala:73:24, :117:24, :118:{16,23}, UARTAdapter.scala:32:22]
  wire            _rxfifo_io_deq_ready_T = rxState == 2'h2;	// @[UARTAdapter.scala:41:49, :79:24, :83:49]
  wire            _T_16 = _rxfifo_io_deq_ready_T & _txfifo_io_enq_ready & rxBaudWrap;	// @[Counter.scala:117:24, :118:{16,23}, UARTAdapter.scala:32:22, :83:{49,84}]
  reg  [2:0]      rxDataIdx;	// @[Counter.scala:61:40]
  wire            rxDataWrap = _T_16 & (&rxDataIdx);	// @[Counter.scala:61:40, :73:24, :117:24, :118:{16,23}, UARTAdapter.scala:83:84]
  wire            _T_17 = rxState == 2'h0;	// @[UARTAdapter.scala:38:24, :79:24, :86:19]
  wire            _T_19 = rxState == 2'h1;	// @[UARTAdapter.scala:43:51, :79:24, :86:19]
  wire [7:0]      _io_uart_rxd_T = _rxfifo_io_deq_bits >> rxDataIdx;	// @[Counter.scala:61:40, UARTAdapter.scala:33:22, :100:42]
  wire            wrap_wrap_1 = txBaudCount == 10'h363;	// @[Counter.scala:61:40, :73:24]
  wire            _T_9 = txState == 2'h1;	// @[UARTAdapter.scala:38:24, :43:51]
  wire            _T_8 = txState == 2'h0;	// @[UARTAdapter.scala:38:24, :44:53]
  wire            _T_7 = _T_8 & ~io_uart_txd & _txfifo_io_enq_ready;	// @[UARTAdapter.scala:32:22, :44:{53,80,88}]
  wire            txSlackWrap = _T_7 & (&txSlackCount);	// @[Counter.scala:61:40, :73:24, :117:24, :118:{16,23}, UARTAdapter.scala:44:88]
  wire            _T_3 = _T_9 & _txfifo_io_enq_ready;	// @[UARTAdapter.scala:32:22, :43:{51,63}]
  wire [3:0][1:0] _GEN = {{(&txState) & io_uart_txd & _txfifo_io_enq_ready ? 2'h0 : txState}, {txDataWrap ? (io_uart_txd ? 2'h0 : 2'h3) : _txfifo_io_enq_ready ? 2'h1 : txState}, {_T_3 & wrap_wrap_1 ? 2'h2 : txState}, {txSlackWrap ? 2'h1 : txState}};	// @[Counter.scala:73:24, :117:24, :118:{16,23}, UARTAdapter.scala:32:22, :38:24, :41:49, :43:{51,63}, :44:53, :46:19, :48:25, :50:17, :54:24, :55:17, :62:24, :63:{17,23}, :64:39, :65:17, :69:56, :70:17]
  always @(posedge clock) begin
    if (reset) begin
      txState <= 2'h0;	// @[UARTAdapter.scala:38:24]
      txDataIdx <= 3'h0;	// @[Counter.scala:61:40]
      txBaudCount <= 10'h0;	// @[Counter.scala:61:40]
      txSlackCount <= 2'h0;	// @[Counter.scala:61:40, UARTAdapter.scala:38:24]
      rxState <= 2'h0;	// @[UARTAdapter.scala:38:24, :79:24]
      rxBaudCount <= 10'h0;	// @[Counter.scala:61:40]
      rxDataIdx <= 3'h0;	// @[Counter.scala:61:40]
    end
    else begin
      txState <= _GEN[txState];	// @[UARTAdapter.scala:38:24, :41:49, :43:51, :44:53, :46:19, :48:25, :54:24, :62:24]
      if (_T_1)	// @[UARTAdapter.scala:41:61]
        txDataIdx <= txDataIdx + 3'h1;	// @[Counter.scala:61:40, :77:24]
      if (_T_3) begin	// @[UARTAdapter.scala:43:63]
        if (wrap_wrap_1)	// @[Counter.scala:73:24]
          txBaudCount <= 10'h0;	// @[Counter.scala:61:40]
        else	// @[Counter.scala:73:24]
          txBaudCount <= txBaudCount + 10'h1;	// @[Counter.scala:61:40, :77:24]
      end
      if (_T_7)	// @[UARTAdapter.scala:44:88]
        txSlackCount <= txSlackCount + 2'h1;	// @[Counter.scala:61:40, :77:24, UARTAdapter.scala:43:51]
      if (_T_17) begin	// @[UARTAdapter.scala:86:19]
        if (rxBaudWrap & _rxfifo_io_deq_valid)	// @[Counter.scala:117:24, :118:{16,23}, UARTAdapter.scala:33:22, :89:24]
          rxState <= 2'h1;	// @[UARTAdapter.scala:43:51, :79:24]
      end
      else if (_T_19) begin	// @[UARTAdapter.scala:86:19]
        if (rxBaudWrap)	// @[Counter.scala:117:24, :118:{16,23}]
          rxState <= 2'h2;	// @[UARTAdapter.scala:41:49, :79:24]
      end
      else if (_rxfifo_io_deq_ready_T & rxDataWrap & rxBaudWrap)	// @[Counter.scala:117:24, :118:{16,23}, UARTAdapter.scala:79:24, :83:49, :86:19, :101:38, :102:17]
        rxState <= 2'h0;	// @[UARTAdapter.scala:38:24, :79:24]
      if (_txfifo_io_enq_ready) begin	// @[UARTAdapter.scala:32:22]
        if (wrap_wrap_3)	// @[Counter.scala:73:24]
          rxBaudCount <= 10'h0;	// @[Counter.scala:61:40]
        else	// @[Counter.scala:73:24]
          rxBaudCount <= rxBaudCount + 10'h1;	// @[Counter.scala:61:40, :77:24]
      end
      if (_T_16)	// @[UARTAdapter.scala:83:84]
        rxDataIdx <= rxDataIdx + 3'h1;	// @[Counter.scala:61:40, :77:24]
    end
    if (_T_8) begin	// @[UARTAdapter.scala:44:53]
      if (txSlackWrap)	// @[Counter.scala:117:24, :118:{16,23}]
        txData <= 8'h0;	// @[UARTAdapter.scala:39:19, :49:17]
    end
    else	// @[UARTAdapter.scala:44:53]
      txData <= {8{~_T_9}} & {8{_T_10 & _txfifo_io_enq_ready}} & {7'h0, io_uart_txd} << txDataIdx | txData;	// @[Counter.scala:61:40, UARTAdapter.scala:32:22, :39:19, :41:49, :43:51, :46:19, :59:34, :60:{16,41}]
  end // always @(posedge)
  `ifndef SYNTHESIS
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM_0;
    logic [31:0] _RANDOM_1;
    initial begin
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        _RANDOM_0 = `RANDOM;
        _RANDOM_1 = `RANDOM;
        txState = _RANDOM_0[1:0];	// @[UARTAdapter.scala:38:24]
        txData = _RANDOM_0[9:2];	// @[UARTAdapter.scala:38:24, :39:19]
        txDataIdx = _RANDOM_0[12:10];	// @[Counter.scala:61:40, UARTAdapter.scala:38:24]
        txBaudCount = _RANDOM_0[22:13];	// @[Counter.scala:61:40, UARTAdapter.scala:38:24]
        txSlackCount = _RANDOM_0[24:23];	// @[Counter.scala:61:40, UARTAdapter.scala:38:24]
        rxState = _RANDOM_0[26:25];	// @[UARTAdapter.scala:38:24, :79:24]
        rxBaudCount = {_RANDOM_0[31:27], _RANDOM_1[4:0]};	// @[Counter.scala:61:40, UARTAdapter.scala:38:24]
        rxDataIdx = _RANDOM_1[7:5];	// @[Counter.scala:61:40]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // not def SYNTHESIS
  Queue_39 txfifo (	// @[UARTAdapter.scala:32:22]
    .clock        (clock),
    .reset        (reset),
    .io_enq_valid (txDataWrap),	// @[Counter.scala:117:24, :118:{16,23}]
    .io_enq_bits  (txData),	// @[UARTAdapter.scala:39:19]
    .io_deq_ready (_sim_serial_out_ready),	// @[UARTAdapter.scala:108:19]
    .io_enq_ready (_txfifo_io_enq_ready),
    .io_deq_valid (_txfifo_io_deq_valid),
    .io_deq_bits  (_txfifo_io_deq_bits)
  );
  Queue_39 rxfifo (	// @[UARTAdapter.scala:33:22]
    .clock        (clock),
    .reset        (reset),
    .io_enq_valid (_sim_serial_in_valid),	// @[UARTAdapter.scala:108:19]
    .io_enq_bits  (_sim_serial_in_bits),	// @[UARTAdapter.scala:108:19]
    .io_deq_ready (_rxfifo_io_deq_ready_T & rxDataWrap & rxBaudWrap & _txfifo_io_enq_ready),	// @[Counter.scala:117:24, :118:{16,23}, UARTAdapter.scala:32:22, :83:49, :106:76]
    .io_enq_ready (_rxfifo_io_enq_ready),
    .io_deq_valid (_rxfifo_io_deq_valid),
    .io_deq_bits  (_rxfifo_io_deq_bits)
  );
  SimUART #(
    .UARTNO(0)
  ) sim (	// @[UARTAdapter.scala:108:19]
    .clock            (clock),
    .reset            (reset),
    .serial_in_ready  (_rxfifo_io_enq_ready),	// @[UARTAdapter.scala:33:22]
    .serial_out_valid (_txfifo_io_deq_valid),	// @[UARTAdapter.scala:32:22]
    .serial_out_bits  (_txfifo_io_deq_bits),	// @[UARTAdapter.scala:32:22]
    .serial_in_valid  (_sim_serial_in_valid),
    .serial_in_bits   (_sim_serial_in_bits),
    .serial_out_ready (_sim_serial_out_ready)
  );
  assign io_uart_rxd = _T_17 | ~_T_19 & (~_rxfifo_io_deq_ready_T | _io_uart_rxd_T[0]);	// @[UARTAdapter.scala:83:49, :85:15, :86:19, :88:19, :94:19, :100:{19,42,55}]
endmodule

