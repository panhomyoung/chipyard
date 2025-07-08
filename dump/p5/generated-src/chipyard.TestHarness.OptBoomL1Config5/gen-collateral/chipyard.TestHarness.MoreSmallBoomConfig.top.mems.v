module cc_dir_ext(
  input  [8:0]  RW0_addr,
  input         RW0_clk,
  input  [35:0] RW0_wdata,
  output [35:0] RW0_rdata,
  input         RW0_en,
  input         RW0_wmode,
  input  [1:0]  RW0_wmask
);
  wire [8:0] mem_0_0_0_A;
  wire  mem_0_0_0_CLK;
  wire [35:0] mem_0_0_0_D;
  wire [35:0] mem_0_0_0_Q;
  wire  mem_0_0_0_CEB;
  wire  mem_0_0_0_WEB;
  wire [35:0] mem_0_0_0_BWEB;
  wire [35:0] RW0_rdata_0_0_0 = mem_0_0_0_Q;
  wire [35:0] RW0_rdata_0_0 = RW0_rdata_0_0_0;
  wire  _GEN_0 = RW0_wmask[0];
  wire  _GEN_1 = RW0_wmask[0];
  wire  _GEN_2 = RW0_wmask[0];
  wire [1:0] _GEN_3 = {RW0_wmask[0],RW0_wmask[0]};
  wire  _GEN_4 = RW0_wmask[0];
  wire [2:0] _GEN_5 = {RW0_wmask[0],RW0_wmask[0],RW0_wmask[0]};
  wire  _GEN_6 = RW0_wmask[0];
  wire [3:0] _GEN_7 = {RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0]};
  wire  _GEN_8 = RW0_wmask[0];
  wire [4:0] _GEN_9 = {RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0]};
  wire  _GEN_10 = RW0_wmask[0];
  wire [5:0] _GEN_11 = {RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0]};
  wire  _GEN_12 = RW0_wmask[0];
  wire [6:0] _GEN_13 = {RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0]};
  wire  _GEN_14 = RW0_wmask[0];
  wire [7:0] _GEN_15 = {RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],
    RW0_wmask[0]};
  wire  _GEN_16 = RW0_wmask[0];
  wire [8:0] _GEN_17 = {RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],
    RW0_wmask[0],RW0_wmask[0]};
  wire  _GEN_18 = RW0_wmask[0];
  wire [9:0] _GEN_19 = {RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],
    RW0_wmask[0],RW0_wmask[0],RW0_wmask[0]};
  wire  _GEN_20 = RW0_wmask[0];
  wire [10:0] _GEN_21 = {RW0_wmask[0],_GEN_19};
  wire  _GEN_22 = RW0_wmask[0];
  wire [11:0] _GEN_23 = {RW0_wmask[0],RW0_wmask[0],_GEN_19};
  wire  _GEN_24 = RW0_wmask[0];
  wire [12:0] _GEN_25 = {RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],_GEN_19};
  wire  _GEN_26 = RW0_wmask[0];
  wire [13:0] _GEN_27 = {RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],_GEN_19};
  wire  _GEN_28 = RW0_wmask[0];
  wire [14:0] _GEN_29 = {RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],_GEN_19};
  wire  _GEN_30 = RW0_wmask[0];
  wire [15:0] _GEN_31 = {RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],_GEN_19};
  wire  _GEN_32 = RW0_wmask[0];
  wire [16:0] _GEN_33 = {RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],
    _GEN_19};
  wire  _GEN_34 = RW0_wmask[1];
  wire [17:0] _GEN_35 = {RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],
    RW0_wmask[0],_GEN_19};
  wire  _GEN_36 = RW0_wmask[1];
  wire [18:0] _GEN_37 = {RW0_wmask[1],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],
    RW0_wmask[0],RW0_wmask[0],_GEN_19};
  wire  _GEN_38 = RW0_wmask[1];
  wire [19:0] _GEN_39 = {RW0_wmask[1],_GEN_37};
  wire  _GEN_40 = RW0_wmask[1];
  wire [20:0] _GEN_41 = {RW0_wmask[1],RW0_wmask[1],_GEN_37};
  wire  _GEN_42 = RW0_wmask[1];
  wire [21:0] _GEN_43 = {RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],_GEN_37};
  wire  _GEN_44 = RW0_wmask[1];
  wire [22:0] _GEN_45 = {RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],_GEN_37};
  wire  _GEN_46 = RW0_wmask[1];
  wire [23:0] _GEN_47 = {RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],_GEN_37};
  wire  _GEN_48 = RW0_wmask[1];
  wire [24:0] _GEN_49 = {RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],_GEN_37};
  wire  _GEN_50 = RW0_wmask[1];
  wire [25:0] _GEN_51 = {RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],
    _GEN_37};
  wire  _GEN_52 = RW0_wmask[1];
  wire [26:0] _GEN_53 = {RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],
    RW0_wmask[1],_GEN_37};
  wire  _GEN_54 = RW0_wmask[1];
  wire [27:0] _GEN_55 = {RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],
    RW0_wmask[1],RW0_wmask[1],_GEN_37};
  wire  _GEN_56 = RW0_wmask[1];
  wire [28:0] _GEN_57 = {RW0_wmask[1],_GEN_55};
  wire  _GEN_58 = RW0_wmask[1];
  wire [29:0] _GEN_59 = {RW0_wmask[1],RW0_wmask[1],_GEN_55};
  wire  _GEN_60 = RW0_wmask[1];
  wire [30:0] _GEN_61 = {RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],_GEN_55};
  wire  _GEN_62 = RW0_wmask[1];
  wire [31:0] _GEN_63 = {RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],_GEN_55};
  wire  _GEN_64 = RW0_wmask[1];
  wire [32:0] _GEN_65 = {RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],_GEN_55};
  wire  _GEN_66 = RW0_wmask[1];
  wire [33:0] _GEN_67 = {RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],_GEN_55};
  wire  _GEN_68 = RW0_wmask[1];
  wire [34:0] _GEN_69 = {RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],
    _GEN_55};
  wire [35:0] _GEN_70 = {RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],
    RW0_wmask[1],_GEN_55};
  TS1N28HPCPUHDHVTB512X36M4SWBSO mem_0_0_0 (
    .A(mem_0_0_0_A),
    .CLK(mem_0_0_0_CLK),
    .D(mem_0_0_0_D),
    .Q(mem_0_0_0_Q),
    .CEB(mem_0_0_0_CEB),
    .WEB(mem_0_0_0_WEB),
    .BWEB(mem_0_0_0_BWEB)
  );
  assign RW0_rdata = mem_0_0_0_Q;
  assign mem_0_0_0_A = RW0_addr;
  assign mem_0_0_0_CLK = RW0_clk;
  assign mem_0_0_0_D = RW0_wdata;
  assign mem_0_0_0_CEB = ~RW0_en;
  assign mem_0_0_0_WEB = ~RW0_wmode;
  assign mem_0_0_0_BWEB = ~_GEN_70;
endmodule
module cc_banks_0_ext(
  input  [8:0]  RW0_addr,
  input         RW0_clk,
  input  [63:0] RW0_wdata,
  output [63:0] RW0_rdata,
  input         RW0_en,
  input         RW0_wmode
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire [7:0] mem_0_0_0_A;
  wire  mem_0_0_0_CLK;
  wire [63:0] mem_0_0_0_D;
  wire [63:0] mem_0_0_0_Q;
  wire  mem_0_0_0_CEB;
  wire  mem_0_0_0_WEB;
  wire [63:0] mem_0_0_0_BWEB;
  wire [7:0] mem_1_0_0_A;
  wire  mem_1_0_0_CLK;
  wire [63:0] mem_1_0_0_D;
  wire [63:0] mem_1_0_0_Q;
  wire  mem_1_0_0_CEB;
  wire  mem_1_0_0_WEB;
  wire [63:0] mem_1_0_0_BWEB;
  wire  RW0_addr_sel = RW0_addr[8];
  reg  RW0_addr_sel_reg;
  wire [63:0] RW0_rdata_0_0_0 = mem_0_0_0_Q;
  wire [63:0] RW0_rdata_0_0 = RW0_rdata_0_0_0;
  wire [63:0] RW0_rdata_1_0_0 = mem_1_0_0_Q;
  wire [63:0] RW0_rdata_1_0 = RW0_rdata_1_0_0;
  wire  _GEN_0 = ~RW0_addr_sel;
  wire  _GEN_1 = RW0_en & ~RW0_addr_sel;
  wire  _GEN_2 = ~RW0_addr_sel;
  wire  _GEN_3 = RW0_wmode & ~RW0_addr_sel;
  wire  _GEN_4 = RW0_en & RW0_addr_sel;
  wire  _GEN_5 = RW0_wmode & RW0_addr_sel;
  TS1N28HPCPUHDHVTB256X64M4SWBSO mem_0_0_0 (
    .A(mem_0_0_0_A),
    .CLK(mem_0_0_0_CLK),
    .D(mem_0_0_0_D),
    .Q(mem_0_0_0_Q),
    .CEB(mem_0_0_0_CEB),
    .WEB(mem_0_0_0_WEB),
    .BWEB(mem_0_0_0_BWEB)
  );
  TS1N28HPCPUHDHVTB256X64M4SWBSO mem_1_0_0 (
    .A(mem_1_0_0_A),
    .CLK(mem_1_0_0_CLK),
    .D(mem_1_0_0_D),
    .Q(mem_1_0_0_Q),
    .CEB(mem_1_0_0_CEB),
    .WEB(mem_1_0_0_WEB),
    .BWEB(mem_1_0_0_BWEB)
  );
  assign RW0_rdata = ~RW0_addr_sel_reg ? RW0_rdata_0_0_0 : RW0_addr_sel_reg ? RW0_rdata_1_0_0 : 64'h0;
  assign mem_0_0_0_A = RW0_addr[7:0];
  assign mem_0_0_0_CLK = RW0_clk;
  assign mem_0_0_0_D = RW0_wdata;
  assign mem_0_0_0_CEB = ~(RW0_en & ~RW0_addr_sel);
  assign mem_0_0_0_WEB = ~(RW0_wmode & ~RW0_addr_sel);
  assign mem_0_0_0_BWEB = 64'h0;
  assign mem_1_0_0_A = RW0_addr[7:0];
  assign mem_1_0_0_CLK = RW0_clk;
  assign mem_1_0_0_D = RW0_wdata;
  assign mem_1_0_0_CEB = ~(RW0_en & RW0_addr_sel);
  assign mem_1_0_0_WEB = ~(RW0_wmode & RW0_addr_sel);
  assign mem_1_0_0_BWEB = 64'h0;
  always @(posedge RW0_clk) begin
    if (RW0_en) begin
      RW0_addr_sel_reg <= RW0_addr_sel;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  RW0_addr_sel_reg = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module tag_array_ext(
  input  [4:0]  W0_addr,
  input         W0_clk,
  input  [45:0] W0_data,
  input         W0_en,
  input  [1:0]  W0_mask,
  input  [4:0]  R0_addr,
  input         R0_clk,
  output [45:0] R0_data,
  input         R0_en
);
  wire [4:0] mem_0_0_0_A;
  wire  mem_0_0_0_CLK;
  wire [49:0] mem_0_0_0_D;
  wire [49:0] mem_0_0_0_Q;
  wire  mem_0_0_0_CEB;
  wire  mem_0_0_0_WEB;
  wire [49:0] mem_0_0_0_BWEB;
  wire [4:0] mem_0_0_1_A;
  wire  mem_0_0_1_CLK;
  wire [49:0] mem_0_0_1_D;
  wire [49:0] mem_0_0_1_Q;
  wire  mem_0_0_1_CEB;
  wire  mem_0_0_1_WEB;
  wire [49:0] mem_0_0_1_BWEB;
  wire [45:0] R0_data_0_0_1 = mem_0_0_1_Q[45:0];
  wire [45:0] R0_data_0_1 = R0_data_0_0_1;
  wire  _GEN_0 = W0_mask[0];
  wire  _GEN_1 = W0_mask[0];
  wire  _GEN_2 = W0_mask[0];
  wire [1:0] _GEN_3 = {W0_mask[0],W0_mask[0]};
  wire  _GEN_4 = W0_mask[0];
  wire [2:0] _GEN_5 = {W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_6 = W0_mask[0];
  wire [3:0] _GEN_7 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_8 = W0_mask[0];
  wire [4:0] _GEN_9 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_10 = W0_mask[0];
  wire [5:0] _GEN_11 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_12 = W0_mask[0];
  wire [6:0] _GEN_13 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_14 = W0_mask[0];
  wire [7:0] _GEN_15 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_16 = W0_mask[0];
  wire [8:0] _GEN_17 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[
    0]};
  wire  _GEN_18 = W0_mask[0];
  wire [9:0] _GEN_19 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[
    0],W0_mask[0]};
  wire  _GEN_20 = W0_mask[0];
  wire [10:0] _GEN_21 = {W0_mask[0],_GEN_19};
  wire  _GEN_22 = W0_mask[0];
  wire [11:0] _GEN_23 = {W0_mask[0],W0_mask[0],_GEN_19};
  wire  _GEN_24 = W0_mask[0];
  wire [12:0] _GEN_25 = {W0_mask[0],W0_mask[0],W0_mask[0],_GEN_19};
  wire  _GEN_26 = W0_mask[0];
  wire [13:0] _GEN_27 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],_GEN_19};
  wire  _GEN_28 = W0_mask[0];
  wire [14:0] _GEN_29 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],_GEN_19};
  wire  _GEN_30 = W0_mask[0];
  wire [15:0] _GEN_31 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],_GEN_19};
  wire  _GEN_32 = W0_mask[0];
  wire [16:0] _GEN_33 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],_GEN_19};
  wire  _GEN_34 = W0_mask[0];
  wire [17:0] _GEN_35 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],_GEN_19
    };
  wire  _GEN_36 = W0_mask[0];
  wire [18:0] _GEN_37 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask
    [0],_GEN_19};
  wire  _GEN_38 = W0_mask[0];
  wire [19:0] _GEN_39 = {W0_mask[0],_GEN_37};
  wire  _GEN_40 = W0_mask[0];
  wire [20:0] _GEN_41 = {W0_mask[0],W0_mask[0],_GEN_37};
  wire  _GEN_42 = W0_mask[0];
  wire [21:0] _GEN_43 = {W0_mask[0],W0_mask[0],W0_mask[0],_GEN_37};
  wire  _GEN_44 = W0_mask[1];
  wire [22:0] _GEN_45 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],_GEN_37};
  wire  _GEN_46 = W0_mask[1];
  wire [23:0] _GEN_47 = {W0_mask[1],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],_GEN_37};
  wire  _GEN_48 = W0_mask[1];
  wire [24:0] _GEN_49 = {W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],_GEN_37};
  wire  _GEN_50 = W0_mask[1];
  wire [25:0] _GEN_51 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],_GEN_37};
  wire  _GEN_52 = W0_mask[1];
  wire [26:0] _GEN_53 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],_GEN_37
    };
  wire  _GEN_54 = W0_mask[1];
  wire [27:0] _GEN_55 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask
    [0],_GEN_37};
  wire  _GEN_56 = W0_mask[1];
  wire [28:0] _GEN_57 = {W0_mask[1],_GEN_55};
  wire  _GEN_58 = W0_mask[1];
  wire [29:0] _GEN_59 = {W0_mask[1],W0_mask[1],_GEN_55};
  wire  _GEN_60 = W0_mask[1];
  wire [30:0] _GEN_61 = {W0_mask[1],W0_mask[1],W0_mask[1],_GEN_55};
  wire  _GEN_62 = W0_mask[1];
  wire [31:0] _GEN_63 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_55};
  wire  _GEN_64 = W0_mask[1];
  wire [32:0] _GEN_65 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_55};
  wire  _GEN_66 = W0_mask[1];
  wire [33:0] _GEN_67 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_55};
  wire  _GEN_68 = W0_mask[1];
  wire [34:0] _GEN_69 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_55};
  wire  _GEN_70 = W0_mask[1];
  wire [35:0] _GEN_71 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_55
    };
  wire  _GEN_72 = W0_mask[1];
  wire [36:0] _GEN_73 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask
    [1],_GEN_55};
  wire  _GEN_74 = W0_mask[1];
  wire [37:0] _GEN_75 = {W0_mask[1],_GEN_73};
  wire  _GEN_76 = W0_mask[1];
  wire [38:0] _GEN_77 = {W0_mask[1],W0_mask[1],_GEN_73};
  wire  _GEN_78 = W0_mask[1];
  wire [39:0] _GEN_79 = {W0_mask[1],W0_mask[1],W0_mask[1],_GEN_73};
  wire  _GEN_80 = W0_mask[1];
  wire [40:0] _GEN_81 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_73};
  wire  _GEN_82 = W0_mask[1];
  wire [41:0] _GEN_83 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_73};
  wire  _GEN_84 = W0_mask[1];
  wire [42:0] _GEN_85 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_73};
  wire  _GEN_86 = W0_mask[1];
  wire [43:0] _GEN_87 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_73};
  wire  _GEN_88 = W0_mask[1];
  wire [44:0] _GEN_89 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_73
    };
  wire [45:0] _GEN_90 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask
    [1],_GEN_73};
  wire [46:0] _GEN_91 = {1'h0,_GEN_90};
  wire [47:0] _GEN_92 = {1'h0,1'h0,_GEN_90};
  wire [48:0] _GEN_93 = {1'h0,1'h0,1'h0,_GEN_90};
  wire [49:0] _GEN_94 = {1'h0,1'h0,1'h0,1'h0,_GEN_90};
  TS1N28HPCPUHDHVTB32X50M4SWBSO mem_0_0_0 (
    .A(mem_0_0_0_A),
    .CLK(mem_0_0_0_CLK),
    .D(mem_0_0_0_D),
    .Q(mem_0_0_0_Q),
    .CEB(mem_0_0_0_CEB),
    .WEB(mem_0_0_0_WEB),
    .BWEB(mem_0_0_0_BWEB)
  );
  TS1N28HPCPUHDHVTB32X50M4SWBSO mem_0_0_1 (
    .A(mem_0_0_1_A),
    .CLK(mem_0_0_1_CLK),
    .D(mem_0_0_1_D),
    .Q(mem_0_0_1_Q),
    .CEB(mem_0_0_1_CEB),
    .WEB(mem_0_0_1_WEB),
    .BWEB(mem_0_0_1_BWEB)
  );
  assign R0_data = mem_0_0_1_Q[45:0];
  assign mem_0_0_0_A = W0_addr;
  assign mem_0_0_0_CLK = W0_clk;
  assign mem_0_0_0_D = {{4'd0}, W0_data};
  assign mem_0_0_0_CEB = 1'h0;
  assign mem_0_0_0_WEB = ~W0_en;
  assign mem_0_0_0_BWEB = ~_GEN_94;
  assign mem_0_0_1_A = R0_addr;
  assign mem_0_0_1_CLK = R0_clk;
  assign mem_0_0_1_D = 50'h0;
  assign mem_0_0_1_CEB = 1'h0;
  assign mem_0_0_1_WEB = 1'h1;
  assign mem_0_0_1_BWEB = 50'h0;
endmodule
module array_0_0_0_ext(
  input  [7:0]  W0_addr,
  input         W0_clk,
  input  [63:0] W0_data,
  input         W0_en,
  input  [7:0]  R0_addr,
  input         R0_clk,
  output [63:0] R0_data,
  input         R0_en
);
  wire [7:0] mem_0_0_0_A;
  wire  mem_0_0_0_CLK;
  wire [63:0] mem_0_0_0_D;
  wire [63:0] mem_0_0_0_Q;
  wire  mem_0_0_0_CEB;
  wire  mem_0_0_0_WEB;
  wire [63:0] mem_0_0_0_BWEB;
  wire [7:0] mem_0_0_1_A;
  wire  mem_0_0_1_CLK;
  wire [63:0] mem_0_0_1_D;
  wire [63:0] mem_0_0_1_Q;
  wire  mem_0_0_1_CEB;
  wire  mem_0_0_1_WEB;
  wire [63:0] mem_0_0_1_BWEB;
  wire [63:0] R0_data_0_0_1 = mem_0_0_1_Q;
  wire [63:0] R0_data_0_1 = R0_data_0_0_1;
  TS1N28HPCPUHDHVTB256X64M4SWBSO mem_0_0_0 (
    .A(mem_0_0_0_A),
    .CLK(mem_0_0_0_CLK),
    .D(mem_0_0_0_D),
    .Q(mem_0_0_0_Q),
    .CEB(mem_0_0_0_CEB),
    .WEB(mem_0_0_0_WEB),
    .BWEB(mem_0_0_0_BWEB)
  );
  TS1N28HPCPUHDHVTB256X64M4SWBSO mem_0_0_1 (
    .A(mem_0_0_1_A),
    .CLK(mem_0_0_1_CLK),
    .D(mem_0_0_1_D),
    .Q(mem_0_0_1_Q),
    .CEB(mem_0_0_1_CEB),
    .WEB(mem_0_0_1_WEB),
    .BWEB(mem_0_0_1_BWEB)
  );
  assign R0_data = mem_0_0_1_Q;
  assign mem_0_0_0_A = W0_addr;
  assign mem_0_0_0_CLK = W0_clk;
  assign mem_0_0_0_D = W0_data;
  assign mem_0_0_0_CEB = 1'h0;
  assign mem_0_0_0_WEB = ~W0_en;
  assign mem_0_0_0_BWEB = 64'h0;
  assign mem_0_0_1_A = R0_addr;
  assign mem_0_0_1_CLK = R0_clk;
  assign mem_0_0_1_D = 64'h0;
  assign mem_0_0_1_CEB = 1'h0;
  assign mem_0_0_1_WEB = 1'h1;
  assign mem_0_0_1_BWEB = 64'h0;
endmodule
module tag_array_0_ext(
  input  [4:0]  RW0_addr,
  input         RW0_clk,
  input  [41:0] RW0_wdata,
  output [41:0] RW0_rdata,
  input         RW0_en,
  input         RW0_wmode,
  input  [1:0]  RW0_wmask
);
  wire [4:0] mem_0_0_0_A;
  wire  mem_0_0_0_CLK;
  wire [49:0] mem_0_0_0_D;
  wire [49:0] mem_0_0_0_Q;
  wire  mem_0_0_0_CEB;
  wire  mem_0_0_0_WEB;
  wire [49:0] mem_0_0_0_BWEB;
  wire [41:0] RW0_rdata_0_0_0 = mem_0_0_0_Q[41:0];
  wire [41:0] RW0_rdata_0_0 = RW0_rdata_0_0_0;
  wire  _GEN_0 = RW0_wmask[0];
  wire  _GEN_1 = RW0_wmask[0];
  wire  _GEN_2 = RW0_wmask[0];
  wire [1:0] _GEN_3 = {RW0_wmask[0],RW0_wmask[0]};
  wire  _GEN_4 = RW0_wmask[0];
  wire [2:0] _GEN_5 = {RW0_wmask[0],RW0_wmask[0],RW0_wmask[0]};
  wire  _GEN_6 = RW0_wmask[0];
  wire [3:0] _GEN_7 = {RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0]};
  wire  _GEN_8 = RW0_wmask[0];
  wire [4:0] _GEN_9 = {RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0]};
  wire  _GEN_10 = RW0_wmask[0];
  wire [5:0] _GEN_11 = {RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0]};
  wire  _GEN_12 = RW0_wmask[0];
  wire [6:0] _GEN_13 = {RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0]};
  wire  _GEN_14 = RW0_wmask[0];
  wire [7:0] _GEN_15 = {RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],
    RW0_wmask[0]};
  wire  _GEN_16 = RW0_wmask[0];
  wire [8:0] _GEN_17 = {RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],
    RW0_wmask[0],RW0_wmask[0]};
  wire  _GEN_18 = RW0_wmask[0];
  wire [9:0] _GEN_19 = {RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],
    RW0_wmask[0],RW0_wmask[0],RW0_wmask[0]};
  wire  _GEN_20 = RW0_wmask[0];
  wire [10:0] _GEN_21 = {RW0_wmask[0],_GEN_19};
  wire  _GEN_22 = RW0_wmask[0];
  wire [11:0] _GEN_23 = {RW0_wmask[0],RW0_wmask[0],_GEN_19};
  wire  _GEN_24 = RW0_wmask[0];
  wire [12:0] _GEN_25 = {RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],_GEN_19};
  wire  _GEN_26 = RW0_wmask[0];
  wire [13:0] _GEN_27 = {RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],_GEN_19};
  wire  _GEN_28 = RW0_wmask[0];
  wire [14:0] _GEN_29 = {RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],_GEN_19};
  wire  _GEN_30 = RW0_wmask[0];
  wire [15:0] _GEN_31 = {RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],_GEN_19};
  wire  _GEN_32 = RW0_wmask[0];
  wire [16:0] _GEN_33 = {RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],
    _GEN_19};
  wire  _GEN_34 = RW0_wmask[0];
  wire [17:0] _GEN_35 = {RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],
    RW0_wmask[0],_GEN_19};
  wire  _GEN_36 = RW0_wmask[0];
  wire [18:0] _GEN_37 = {RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],RW0_wmask[0],
    RW0_wmask[0],RW0_wmask[0],_GEN_19};
  wire  _GEN_38 = RW0_wmask[0];
  wire [19:0] _GEN_39 = {RW0_wmask[0],_GEN_37};
  wire  _GEN_40 = RW0_wmask[1];
  wire [20:0] _GEN_41 = {RW0_wmask[0],RW0_wmask[0],_GEN_37};
  wire  _GEN_42 = RW0_wmask[1];
  wire [21:0] _GEN_43 = {RW0_wmask[1],RW0_wmask[0],RW0_wmask[0],_GEN_37};
  wire  _GEN_44 = RW0_wmask[1];
  wire [22:0] _GEN_45 = {RW0_wmask[1],RW0_wmask[1],RW0_wmask[0],RW0_wmask[0],_GEN_37};
  wire  _GEN_46 = RW0_wmask[1];
  wire [23:0] _GEN_47 = {RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[0],RW0_wmask[0],_GEN_37};
  wire  _GEN_48 = RW0_wmask[1];
  wire [24:0] _GEN_49 = {RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[0],RW0_wmask[0],_GEN_37};
  wire  _GEN_50 = RW0_wmask[1];
  wire [25:0] _GEN_51 = {RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[0],RW0_wmask[0],
    _GEN_37};
  wire  _GEN_52 = RW0_wmask[1];
  wire [26:0] _GEN_53 = {RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[0],
    RW0_wmask[0],_GEN_37};
  wire  _GEN_54 = RW0_wmask[1];
  wire [27:0] _GEN_55 = {RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],
    RW0_wmask[0],RW0_wmask[0],_GEN_37};
  wire  _GEN_56 = RW0_wmask[1];
  wire [28:0] _GEN_57 = {RW0_wmask[1],_GEN_55};
  wire  _GEN_58 = RW0_wmask[1];
  wire [29:0] _GEN_59 = {RW0_wmask[1],RW0_wmask[1],_GEN_55};
  wire  _GEN_60 = RW0_wmask[1];
  wire [30:0] _GEN_61 = {RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],_GEN_55};
  wire  _GEN_62 = RW0_wmask[1];
  wire [31:0] _GEN_63 = {RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],_GEN_55};
  wire  _GEN_64 = RW0_wmask[1];
  wire [32:0] _GEN_65 = {RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],_GEN_55};
  wire  _GEN_66 = RW0_wmask[1];
  wire [33:0] _GEN_67 = {RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],_GEN_55};
  wire  _GEN_68 = RW0_wmask[1];
  wire [34:0] _GEN_69 = {RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],
    _GEN_55};
  wire  _GEN_70 = RW0_wmask[1];
  wire [35:0] _GEN_71 = {RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],
    RW0_wmask[1],_GEN_55};
  wire  _GEN_72 = RW0_wmask[1];
  wire [36:0] _GEN_73 = {RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],
    RW0_wmask[1],RW0_wmask[1],_GEN_55};
  wire  _GEN_74 = RW0_wmask[1];
  wire [37:0] _GEN_75 = {RW0_wmask[1],_GEN_73};
  wire  _GEN_76 = RW0_wmask[1];
  wire [38:0] _GEN_77 = {RW0_wmask[1],RW0_wmask[1],_GEN_73};
  wire  _GEN_78 = RW0_wmask[1];
  wire [39:0] _GEN_79 = {RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],_GEN_73};
  wire  _GEN_80 = RW0_wmask[1];
  wire [40:0] _GEN_81 = {RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],_GEN_73};
  wire [41:0] _GEN_82 = {RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],_GEN_73};
  wire [42:0] _GEN_83 = {1'h0,RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],_GEN_73};
  wire [43:0] _GEN_84 = {1'h0,1'h0,RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],_GEN_73};
  wire [44:0] _GEN_85 = {1'h0,1'h0,1'h0,RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],_GEN_73};
  wire [45:0] _GEN_86 = {1'h0,1'h0,1'h0,1'h0,RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],RW0_wmask[1],_GEN_73};
  wire [46:0] _GEN_87 = {1'h0,_GEN_86};
  wire [47:0] _GEN_88 = {1'h0,1'h0,_GEN_86};
  wire [48:0] _GEN_89 = {1'h0,1'h0,1'h0,_GEN_86};
  wire [49:0] _GEN_90 = {1'h0,1'h0,1'h0,1'h0,_GEN_86};
  TS1N28HPCPUHDHVTB32X50M4SWBSO mem_0_0_0 (
    .A(mem_0_0_0_A),
    .CLK(mem_0_0_0_CLK),
    .D(mem_0_0_0_D),
    .Q(mem_0_0_0_Q),
    .CEB(mem_0_0_0_CEB),
    .WEB(mem_0_0_0_WEB),
    .BWEB(mem_0_0_0_BWEB)
  );
  assign RW0_rdata = mem_0_0_0_Q[41:0];
  assign mem_0_0_0_A = RW0_addr;
  assign mem_0_0_0_CLK = RW0_clk;
  assign mem_0_0_0_D = {{8'd0}, RW0_wdata};
  assign mem_0_0_0_CEB = ~RW0_en;
  assign mem_0_0_0_WEB = ~RW0_wmode;
  assign mem_0_0_0_BWEB = ~_GEN_90;
endmodule
module dataArrayWay_0_ext(
  input  [7:0]  RW0_addr,
  input         RW0_clk,
  input  [63:0] RW0_wdata,
  output [63:0] RW0_rdata,
  input         RW0_en,
  input         RW0_wmode
);
  wire [7:0] mem_0_0_0_A;
  wire  mem_0_0_0_CLK;
  wire [63:0] mem_0_0_0_D;
  wire [63:0] mem_0_0_0_Q;
  wire  mem_0_0_0_CEB;
  wire  mem_0_0_0_WEB;
  wire [63:0] mem_0_0_0_BWEB;
  wire [63:0] RW0_rdata_0_0_0 = mem_0_0_0_Q;
  wire [63:0] RW0_rdata_0_0 = RW0_rdata_0_0_0;
  TS1N28HPCPUHDHVTB256X64M4SWBSO mem_0_0_0 (
    .A(mem_0_0_0_A),
    .CLK(mem_0_0_0_CLK),
    .D(mem_0_0_0_D),
    .Q(mem_0_0_0_Q),
    .CEB(mem_0_0_0_CEB),
    .WEB(mem_0_0_0_WEB),
    .BWEB(mem_0_0_0_BWEB)
  );
  assign RW0_rdata = mem_0_0_0_Q;
  assign mem_0_0_0_A = RW0_addr;
  assign mem_0_0_0_CLK = RW0_clk;
  assign mem_0_0_0_D = RW0_wdata;
  assign mem_0_0_0_CEB = ~RW0_en;
  assign mem_0_0_0_WEB = ~RW0_wmode;
  assign mem_0_0_0_BWEB = 64'h0;
endmodule
module hi_us_ext(
  input  [6:0] W0_addr,
  input        W0_clk,
  input  [3:0] W0_data,
  input        W0_en,
  input  [3:0] W0_mask,
  input  [6:0] R0_addr,
  input        R0_clk,
  output [3:0] R0_data,
  input        R0_en
);
  wire [6:0] mem_0_0_0_A;
  wire  mem_0_0_0_CLK;
  wire [11:0] mem_0_0_0_D;
  wire [11:0] mem_0_0_0_Q;
  wire  mem_0_0_0_CEB;
  wire  mem_0_0_0_WEB;
  wire [11:0] mem_0_0_0_BWEB;
  wire [6:0] mem_0_0_1_A;
  wire  mem_0_0_1_CLK;
  wire [11:0] mem_0_0_1_D;
  wire [11:0] mem_0_0_1_Q;
  wire  mem_0_0_1_CEB;
  wire  mem_0_0_1_WEB;
  wire [11:0] mem_0_0_1_BWEB;
  wire [3:0] R0_data_0_0_1 = mem_0_0_1_Q[3:0];
  wire [3:0] R0_data_0_1 = R0_data_0_0_1;
  wire  _GEN_0 = W0_mask[1];
  wire  _GEN_1 = W0_mask[0];
  wire  _GEN_2 = W0_mask[2];
  wire [1:0] _GEN_3 = {W0_mask[1],W0_mask[0]};
  wire  _GEN_4 = W0_mask[3];
  wire [2:0] _GEN_5 = {W0_mask[2],W0_mask[1],W0_mask[0]};
  wire [3:0] _GEN_6 = {W0_mask[3],W0_mask[2],W0_mask[1],W0_mask[0]};
  wire [4:0] _GEN_7 = {1'h0,W0_mask[3],W0_mask[2],W0_mask[1],W0_mask[0]};
  wire [5:0] _GEN_8 = {1'h0,1'h0,W0_mask[3],W0_mask[2],W0_mask[1],W0_mask[0]};
  wire [6:0] _GEN_9 = {1'h0,1'h0,1'h0,W0_mask[3],W0_mask[2],W0_mask[1],W0_mask[0]};
  wire [7:0] _GEN_10 = {1'h0,1'h0,1'h0,1'h0,W0_mask[3],W0_mask[2],W0_mask[1],W0_mask[0]};
  wire [8:0] _GEN_11 = {1'h0,1'h0,1'h0,1'h0,1'h0,W0_mask[3],W0_mask[2],W0_mask[1],W0_mask[0]};
  wire [9:0] _GEN_12 = {1'h0,1'h0,1'h0,1'h0,1'h0,1'h0,W0_mask[3],W0_mask[2],W0_mask[1],W0_mask[0]};
  wire [10:0] _GEN_13 = {1'h0,_GEN_12};
  wire [11:0] _GEN_14 = {1'h0,1'h0,_GEN_12};
  TS1N28HPCPUHDHVTB128X12M4SWBSO mem_0_0_0 (
    .A(mem_0_0_0_A),
    .CLK(mem_0_0_0_CLK),
    .D(mem_0_0_0_D),
    .Q(mem_0_0_0_Q),
    .CEB(mem_0_0_0_CEB),
    .WEB(mem_0_0_0_WEB),
    .BWEB(mem_0_0_0_BWEB)
  );
  TS1N28HPCPUHDHVTB128X12M4SWBSO mem_0_0_1 (
    .A(mem_0_0_1_A),
    .CLK(mem_0_0_1_CLK),
    .D(mem_0_0_1_D),
    .Q(mem_0_0_1_Q),
    .CEB(mem_0_0_1_CEB),
    .WEB(mem_0_0_1_WEB),
    .BWEB(mem_0_0_1_BWEB)
  );
  assign R0_data = mem_0_0_1_Q[3:0];
  assign mem_0_0_0_A = W0_addr;
  assign mem_0_0_0_CLK = W0_clk;
  assign mem_0_0_0_D = {{8'd0}, W0_data};
  assign mem_0_0_0_CEB = 1'h0;
  assign mem_0_0_0_WEB = ~W0_en;
  assign mem_0_0_0_BWEB = ~_GEN_14;
  assign mem_0_0_1_A = R0_addr;
  assign mem_0_0_1_CLK = R0_clk;
  assign mem_0_0_1_D = 12'h0;
  assign mem_0_0_1_CEB = 1'h0;
  assign mem_0_0_1_WEB = 1'h1;
  assign mem_0_0_1_BWEB = 12'h0;
endmodule
module table_ext(
  input  [6:0]  W0_addr,
  input         W0_clk,
  input  [43:0] W0_data,
  input         W0_en,
  input  [3:0]  W0_mask,
  input  [6:0]  R0_addr,
  input         R0_clk,
  output [43:0] R0_data,
  input         R0_en
);
  wire [6:0] mem_0_0_0_A;
  wire  mem_0_0_0_CLK;
  wire [21:0] mem_0_0_0_D;
  wire [21:0] mem_0_0_0_Q;
  wire  mem_0_0_0_CEB;
  wire  mem_0_0_0_WEB;
  wire [21:0] mem_0_0_0_BWEB;
  wire [6:0] mem_0_0_1_A;
  wire  mem_0_0_1_CLK;
  wire [21:0] mem_0_0_1_D;
  wire [21:0] mem_0_0_1_Q;
  wire  mem_0_0_1_CEB;
  wire  mem_0_0_1_WEB;
  wire [21:0] mem_0_0_1_BWEB;
  wire [6:0] mem_0_1_0_A;
  wire  mem_0_1_0_CLK;
  wire [21:0] mem_0_1_0_D;
  wire [21:0] mem_0_1_0_Q;
  wire  mem_0_1_0_CEB;
  wire  mem_0_1_0_WEB;
  wire [21:0] mem_0_1_0_BWEB;
  wire [6:0] mem_0_1_1_A;
  wire  mem_0_1_1_CLK;
  wire [21:0] mem_0_1_1_D;
  wire [21:0] mem_0_1_1_Q;
  wire  mem_0_1_1_CEB;
  wire  mem_0_1_1_WEB;
  wire [21:0] mem_0_1_1_BWEB;
  wire [21:0] R0_data_0_0_1 = mem_0_0_1_Q;
  wire [21:0] R0_data_0_1_1 = mem_0_1_1_Q;
  wire [43:0] R0_data_0_1 = {R0_data_0_1_1,R0_data_0_0_1};
  wire  _GEN_0 = W0_mask[0];
  wire  _GEN_1 = W0_mask[0];
  wire  _GEN_2 = W0_mask[0];
  wire [1:0] _GEN_3 = {W0_mask[0],W0_mask[0]};
  wire  _GEN_4 = W0_mask[0];
  wire [2:0] _GEN_5 = {W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_6 = W0_mask[0];
  wire [3:0] _GEN_7 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_8 = W0_mask[0];
  wire [4:0] _GEN_9 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_10 = W0_mask[0];
  wire [5:0] _GEN_11 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_12 = W0_mask[0];
  wire [6:0] _GEN_13 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_14 = W0_mask[0];
  wire [7:0] _GEN_15 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_16 = W0_mask[0];
  wire [8:0] _GEN_17 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[
    0]};
  wire  _GEN_18 = W0_mask[0];
  wire [9:0] _GEN_19 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[
    0],W0_mask[0]};
  wire  _GEN_20 = W0_mask[1];
  wire [10:0] _GEN_21 = {W0_mask[0],_GEN_19};
  wire  _GEN_22 = W0_mask[1];
  wire [11:0] _GEN_23 = {W0_mask[1],W0_mask[0],_GEN_19};
  wire  _GEN_24 = W0_mask[1];
  wire [12:0] _GEN_25 = {W0_mask[1],W0_mask[1],W0_mask[0],_GEN_19};
  wire  _GEN_26 = W0_mask[1];
  wire [13:0] _GEN_27 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[0],_GEN_19};
  wire  _GEN_28 = W0_mask[1];
  wire [14:0] _GEN_29 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[0],_GEN_19};
  wire  _GEN_30 = W0_mask[1];
  wire [15:0] _GEN_31 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[0],_GEN_19};
  wire  _GEN_32 = W0_mask[1];
  wire [16:0] _GEN_33 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[0],_GEN_19};
  wire  _GEN_34 = W0_mask[1];
  wire [17:0] _GEN_35 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[0],_GEN_19
    };
  wire  _GEN_36 = W0_mask[1];
  wire [18:0] _GEN_37 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask
    [0],_GEN_19};
  wire  _GEN_38 = W0_mask[1];
  wire [19:0] _GEN_39 = {W0_mask[1],_GEN_37};
  wire  _GEN_40 = W0_mask[1];
  wire [20:0] _GEN_41 = {W0_mask[1],W0_mask[1],_GEN_37};
  wire [21:0] _GEN_42 = {W0_mask[1],W0_mask[1],W0_mask[1],_GEN_37};
  wire  _GEN_43 = W0_mask[2];
  wire  _GEN_44 = W0_mask[2];
  wire  _GEN_45 = W0_mask[2];
  wire [1:0] _GEN_46 = {W0_mask[2],W0_mask[2]};
  wire  _GEN_47 = W0_mask[2];
  wire [2:0] _GEN_48 = {W0_mask[2],W0_mask[2],W0_mask[2]};
  wire  _GEN_49 = W0_mask[2];
  wire [3:0] _GEN_50 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2]};
  wire  _GEN_51 = W0_mask[2];
  wire [4:0] _GEN_52 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2]};
  wire  _GEN_53 = W0_mask[2];
  wire [5:0] _GEN_54 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2]};
  wire  _GEN_55 = W0_mask[2];
  wire [6:0] _GEN_56 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2]};
  wire  _GEN_57 = W0_mask[2];
  wire [7:0] _GEN_58 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2]};
  wire  _GEN_59 = W0_mask[2];
  wire [8:0] _GEN_60 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[
    2]};
  wire  _GEN_61 = W0_mask[2];
  wire [9:0] _GEN_62 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[
    2],W0_mask[2]};
  wire  _GEN_63 = W0_mask[3];
  wire [10:0] _GEN_64 = {W0_mask[2],_GEN_62};
  wire  _GEN_65 = W0_mask[3];
  wire [11:0] _GEN_66 = {W0_mask[3],W0_mask[2],_GEN_62};
  wire  _GEN_67 = W0_mask[3];
  wire [12:0] _GEN_68 = {W0_mask[3],W0_mask[3],W0_mask[2],_GEN_62};
  wire  _GEN_69 = W0_mask[3];
  wire [13:0] _GEN_70 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[2],_GEN_62};
  wire  _GEN_71 = W0_mask[3];
  wire [14:0] _GEN_72 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[2],_GEN_62};
  wire  _GEN_73 = W0_mask[3];
  wire [15:0] _GEN_74 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[2],_GEN_62};
  wire  _GEN_75 = W0_mask[3];
  wire [16:0] _GEN_76 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[2],_GEN_62};
  wire  _GEN_77 = W0_mask[3];
  wire [17:0] _GEN_78 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[2],_GEN_62
    };
  wire  _GEN_79 = W0_mask[3];
  wire [18:0] _GEN_80 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask
    [2],_GEN_62};
  wire  _GEN_81 = W0_mask[3];
  wire [19:0] _GEN_82 = {W0_mask[3],_GEN_80};
  wire  _GEN_83 = W0_mask[3];
  wire [20:0] _GEN_84 = {W0_mask[3],W0_mask[3],_GEN_80};
  wire [21:0] _GEN_85 = {W0_mask[3],W0_mask[3],W0_mask[3],_GEN_80};
  TS1N28HPCPUHDHVTB128X22M4SWBSO mem_0_0_0 (
    .A(mem_0_0_0_A),
    .CLK(mem_0_0_0_CLK),
    .D(mem_0_0_0_D),
    .Q(mem_0_0_0_Q),
    .CEB(mem_0_0_0_CEB),
    .WEB(mem_0_0_0_WEB),
    .BWEB(mem_0_0_0_BWEB)
  );
  TS1N28HPCPUHDHVTB128X22M4SWBSO mem_0_0_1 (
    .A(mem_0_0_1_A),
    .CLK(mem_0_0_1_CLK),
    .D(mem_0_0_1_D),
    .Q(mem_0_0_1_Q),
    .CEB(mem_0_0_1_CEB),
    .WEB(mem_0_0_1_WEB),
    .BWEB(mem_0_0_1_BWEB)
  );
  TS1N28HPCPUHDHVTB128X22M4SWBSO mem_0_1_0 (
    .A(mem_0_1_0_A),
    .CLK(mem_0_1_0_CLK),
    .D(mem_0_1_0_D),
    .Q(mem_0_1_0_Q),
    .CEB(mem_0_1_0_CEB),
    .WEB(mem_0_1_0_WEB),
    .BWEB(mem_0_1_0_BWEB)
  );
  TS1N28HPCPUHDHVTB128X22M4SWBSO mem_0_1_1 (
    .A(mem_0_1_1_A),
    .CLK(mem_0_1_1_CLK),
    .D(mem_0_1_1_D),
    .Q(mem_0_1_1_Q),
    .CEB(mem_0_1_1_CEB),
    .WEB(mem_0_1_1_WEB),
    .BWEB(mem_0_1_1_BWEB)
  );
  assign R0_data = {R0_data_0_1_1,R0_data_0_0_1};
  assign mem_0_0_0_A = W0_addr;
  assign mem_0_0_0_CLK = W0_clk;
  assign mem_0_0_0_D = W0_data[21:0];
  assign mem_0_0_0_CEB = 1'h0;
  assign mem_0_0_0_WEB = ~W0_en;
  assign mem_0_0_0_BWEB = ~_GEN_42;
  assign mem_0_0_1_A = R0_addr;
  assign mem_0_0_1_CLK = R0_clk;
  assign mem_0_0_1_D = 22'h0;
  assign mem_0_0_1_CEB = 1'h0;
  assign mem_0_0_1_WEB = 1'h1;
  assign mem_0_0_1_BWEB = 22'h0;
  assign mem_0_1_0_A = W0_addr;
  assign mem_0_1_0_CLK = W0_clk;
  assign mem_0_1_0_D = W0_data[43:22];
  assign mem_0_1_0_CEB = 1'h0;
  assign mem_0_1_0_WEB = ~W0_en;
  assign mem_0_1_0_BWEB = ~_GEN_85;
  assign mem_0_1_1_A = R0_addr;
  assign mem_0_1_1_CLK = R0_clk;
  assign mem_0_1_1_D = 22'h0;
  assign mem_0_1_1_CEB = 1'h0;
  assign mem_0_1_1_WEB = 1'h1;
  assign mem_0_1_1_BWEB = 22'h0;
endmodule
module hi_us_0_ext(
  input  [7:0] W0_addr,
  input        W0_clk,
  input  [3:0] W0_data,
  input        W0_en,
  input  [3:0] W0_mask,
  input  [7:0] R0_addr,
  input        R0_clk,
  output [3:0] R0_data,
  input        R0_en
);
  wire [7:0] mem_0_0_0_A;
  wire  mem_0_0_0_CLK;
  wire [11:0] mem_0_0_0_D;
  wire [11:0] mem_0_0_0_Q;
  wire  mem_0_0_0_CEB;
  wire  mem_0_0_0_WEB;
  wire [11:0] mem_0_0_0_BWEB;
  wire [7:0] mem_0_0_1_A;
  wire  mem_0_0_1_CLK;
  wire [11:0] mem_0_0_1_D;
  wire [11:0] mem_0_0_1_Q;
  wire  mem_0_0_1_CEB;
  wire  mem_0_0_1_WEB;
  wire [11:0] mem_0_0_1_BWEB;
  wire [3:0] R0_data_0_0_1 = mem_0_0_1_Q[3:0];
  wire [3:0] R0_data_0_1 = R0_data_0_0_1;
  wire  _GEN_0 = W0_mask[1];
  wire  _GEN_1 = W0_mask[0];
  wire  _GEN_2 = W0_mask[2];
  wire [1:0] _GEN_3 = {W0_mask[1],W0_mask[0]};
  wire  _GEN_4 = W0_mask[3];
  wire [2:0] _GEN_5 = {W0_mask[2],W0_mask[1],W0_mask[0]};
  wire [3:0] _GEN_6 = {W0_mask[3],W0_mask[2],W0_mask[1],W0_mask[0]};
  wire [4:0] _GEN_7 = {1'h0,W0_mask[3],W0_mask[2],W0_mask[1],W0_mask[0]};
  wire [5:0] _GEN_8 = {1'h0,1'h0,W0_mask[3],W0_mask[2],W0_mask[1],W0_mask[0]};
  wire [6:0] _GEN_9 = {1'h0,1'h0,1'h0,W0_mask[3],W0_mask[2],W0_mask[1],W0_mask[0]};
  wire [7:0] _GEN_10 = {1'h0,1'h0,1'h0,1'h0,W0_mask[3],W0_mask[2],W0_mask[1],W0_mask[0]};
  wire [8:0] _GEN_11 = {1'h0,1'h0,1'h0,1'h0,1'h0,W0_mask[3],W0_mask[2],W0_mask[1],W0_mask[0]};
  wire [9:0] _GEN_12 = {1'h0,1'h0,1'h0,1'h0,1'h0,1'h0,W0_mask[3],W0_mask[2],W0_mask[1],W0_mask[0]};
  wire [10:0] _GEN_13 = {1'h0,_GEN_12};
  wire [11:0] _GEN_14 = {1'h0,1'h0,_GEN_12};
  TS1N28HPCPUHDHVTB256X12M4SWBSO mem_0_0_0 (
    .A(mem_0_0_0_A),
    .CLK(mem_0_0_0_CLK),
    .D(mem_0_0_0_D),
    .Q(mem_0_0_0_Q),
    .CEB(mem_0_0_0_CEB),
    .WEB(mem_0_0_0_WEB),
    .BWEB(mem_0_0_0_BWEB)
  );
  TS1N28HPCPUHDHVTB256X12M4SWBSO mem_0_0_1 (
    .A(mem_0_0_1_A),
    .CLK(mem_0_0_1_CLK),
    .D(mem_0_0_1_D),
    .Q(mem_0_0_1_Q),
    .CEB(mem_0_0_1_CEB),
    .WEB(mem_0_0_1_WEB),
    .BWEB(mem_0_0_1_BWEB)
  );
  assign R0_data = mem_0_0_1_Q[3:0];
  assign mem_0_0_0_A = W0_addr;
  assign mem_0_0_0_CLK = W0_clk;
  assign mem_0_0_0_D = {{8'd0}, W0_data};
  assign mem_0_0_0_CEB = 1'h0;
  assign mem_0_0_0_WEB = ~W0_en;
  assign mem_0_0_0_BWEB = ~_GEN_14;
  assign mem_0_0_1_A = R0_addr;
  assign mem_0_0_1_CLK = R0_clk;
  assign mem_0_0_1_D = 12'h0;
  assign mem_0_0_1_CEB = 1'h0;
  assign mem_0_0_1_WEB = 1'h1;
  assign mem_0_0_1_BWEB = 12'h0;
endmodule
module table_0_ext(
  input  [7:0]  W0_addr,
  input         W0_clk,
  input  [47:0] W0_data,
  input         W0_en,
  input  [3:0]  W0_mask,
  input  [7:0]  R0_addr,
  input         R0_clk,
  output [47:0] R0_data,
  input         R0_en
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire [6:0] mem_0_0_0_A;
  wire  mem_0_0_0_CLK;
  wire [49:0] mem_0_0_0_D;
  wire [49:0] mem_0_0_0_Q;
  wire  mem_0_0_0_CEB;
  wire  mem_0_0_0_WEB;
  wire [49:0] mem_0_0_0_BWEB;
  wire [6:0] mem_0_0_1_A;
  wire  mem_0_0_1_CLK;
  wire [49:0] mem_0_0_1_D;
  wire [49:0] mem_0_0_1_Q;
  wire  mem_0_0_1_CEB;
  wire  mem_0_0_1_WEB;
  wire [49:0] mem_0_0_1_BWEB;
  wire [6:0] mem_1_0_0_A;
  wire  mem_1_0_0_CLK;
  wire [49:0] mem_1_0_0_D;
  wire [49:0] mem_1_0_0_Q;
  wire  mem_1_0_0_CEB;
  wire  mem_1_0_0_WEB;
  wire [49:0] mem_1_0_0_BWEB;
  wire [6:0] mem_1_0_1_A;
  wire  mem_1_0_1_CLK;
  wire [49:0] mem_1_0_1_D;
  wire [49:0] mem_1_0_1_Q;
  wire  mem_1_0_1_CEB;
  wire  mem_1_0_1_WEB;
  wire [49:0] mem_1_0_1_BWEB;
  wire  W0_addr_sel = W0_addr[7];
  wire  R0_addr_sel = R0_addr[7];
  reg  R0_addr_sel_reg;
  wire [47:0] R0_data_0_0_1 = mem_0_0_1_Q[47:0];
  wire [47:0] R0_data_0_1 = R0_data_0_0_1;
  wire [47:0] R0_data_1_0_1 = mem_1_0_1_Q[47:0];
  wire [47:0] R0_data_1_1 = R0_data_1_0_1;
  wire  _GEN_0 = ~W0_addr_sel;
  wire  _GEN_1 = ~W0_addr_sel;
  wire  _GEN_2 = W0_en & ~W0_addr_sel;
  wire  _GEN_3 = W0_mask[0];
  wire  _GEN_4 = W0_mask[0];
  wire  _GEN_5 = W0_mask[0];
  wire [1:0] _GEN_6 = {W0_mask[0],W0_mask[0]};
  wire  _GEN_7 = W0_mask[0];
  wire [2:0] _GEN_8 = {W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_9 = W0_mask[0];
  wire [3:0] _GEN_10 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_11 = W0_mask[0];
  wire [4:0] _GEN_12 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_13 = W0_mask[0];
  wire [5:0] _GEN_14 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_15 = W0_mask[0];
  wire [6:0] _GEN_16 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_17 = W0_mask[0];
  wire [7:0] _GEN_18 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_19 = W0_mask[0];
  wire [8:0] _GEN_20 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[
    0]};
  wire  _GEN_21 = W0_mask[0];
  wire [9:0] _GEN_22 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[
    0],W0_mask[0]};
  wire  _GEN_23 = W0_mask[0];
  wire [10:0] _GEN_24 = {W0_mask[0],_GEN_22};
  wire  _GEN_25 = W0_mask[1];
  wire [11:0] _GEN_26 = {W0_mask[0],W0_mask[0],_GEN_22};
  wire  _GEN_27 = W0_mask[1];
  wire [12:0] _GEN_28 = {W0_mask[1],W0_mask[0],W0_mask[0],_GEN_22};
  wire  _GEN_29 = W0_mask[1];
  wire [13:0] _GEN_30 = {W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0],_GEN_22};
  wire  _GEN_31 = W0_mask[1];
  wire [14:0] _GEN_32 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0],_GEN_22};
  wire  _GEN_33 = W0_mask[1];
  wire [15:0] _GEN_34 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0],_GEN_22};
  wire  _GEN_35 = W0_mask[1];
  wire [16:0] _GEN_36 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0],_GEN_22};
  wire  _GEN_37 = W0_mask[1];
  wire [17:0] _GEN_38 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0],_GEN_22
    };
  wire  _GEN_39 = W0_mask[1];
  wire [18:0] _GEN_40 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask
    [0],_GEN_22};
  wire  _GEN_41 = W0_mask[1];
  wire [19:0] _GEN_42 = {W0_mask[1],_GEN_40};
  wire  _GEN_43 = W0_mask[1];
  wire [20:0] _GEN_44 = {W0_mask[1],W0_mask[1],_GEN_40};
  wire  _GEN_45 = W0_mask[1];
  wire [21:0] _GEN_46 = {W0_mask[1],W0_mask[1],W0_mask[1],_GEN_40};
  wire  _GEN_47 = W0_mask[1];
  wire [22:0] _GEN_48 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_40};
  wire  _GEN_49 = W0_mask[2];
  wire [23:0] _GEN_50 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_40};
  wire  _GEN_51 = W0_mask[2];
  wire [24:0] _GEN_52 = {W0_mask[2],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_40};
  wire  _GEN_53 = W0_mask[2];
  wire [25:0] _GEN_54 = {W0_mask[2],W0_mask[2],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_40};
  wire  _GEN_55 = W0_mask[2];
  wire [26:0] _GEN_56 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_40
    };
  wire  _GEN_57 = W0_mask[2];
  wire [27:0] _GEN_58 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask
    [1],_GEN_40};
  wire  _GEN_59 = W0_mask[2];
  wire [28:0] _GEN_60 = {W0_mask[2],_GEN_58};
  wire  _GEN_61 = W0_mask[2];
  wire [29:0] _GEN_62 = {W0_mask[2],W0_mask[2],_GEN_58};
  wire  _GEN_63 = W0_mask[2];
  wire [30:0] _GEN_64 = {W0_mask[2],W0_mask[2],W0_mask[2],_GEN_58};
  wire  _GEN_65 = W0_mask[2];
  wire [31:0] _GEN_66 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],_GEN_58};
  wire  _GEN_67 = W0_mask[2];
  wire [32:0] _GEN_68 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],_GEN_58};
  wire  _GEN_69 = W0_mask[2];
  wire [33:0] _GEN_70 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],_GEN_58};
  wire  _GEN_71 = W0_mask[2];
  wire [34:0] _GEN_72 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],_GEN_58};
  wire  _GEN_73 = W0_mask[3];
  wire [35:0] _GEN_74 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],_GEN_58
    };
  wire  _GEN_75 = W0_mask[3];
  wire [36:0] _GEN_76 = {W0_mask[3],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask
    [2],_GEN_58};
  wire  _GEN_77 = W0_mask[3];
  wire [37:0] _GEN_78 = {W0_mask[3],_GEN_76};
  wire  _GEN_79 = W0_mask[3];
  wire [38:0] _GEN_80 = {W0_mask[3],W0_mask[3],_GEN_76};
  wire  _GEN_81 = W0_mask[3];
  wire [39:0] _GEN_82 = {W0_mask[3],W0_mask[3],W0_mask[3],_GEN_76};
  wire  _GEN_83 = W0_mask[3];
  wire [40:0] _GEN_84 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],_GEN_76};
  wire  _GEN_85 = W0_mask[3];
  wire [41:0] _GEN_86 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],_GEN_76};
  wire  _GEN_87 = W0_mask[3];
  wire [42:0] _GEN_88 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],_GEN_76};
  wire  _GEN_89 = W0_mask[3];
  wire [43:0] _GEN_90 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],_GEN_76};
  wire  _GEN_91 = W0_mask[3];
  wire [44:0] _GEN_92 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],_GEN_76
    };
  wire  _GEN_93 = W0_mask[3];
  wire [45:0] _GEN_94 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask
    [3],_GEN_76};
  wire  _GEN_95 = W0_mask[3];
  wire [46:0] _GEN_96 = {W0_mask[3],_GEN_94};
  wire [47:0] _GEN_97 = {W0_mask[3],W0_mask[3],_GEN_94};
  wire [48:0] _GEN_98 = {1'h0,W0_mask[3],W0_mask[3],_GEN_94};
  wire [49:0] _GEN_99 = {1'h0,1'h0,W0_mask[3],W0_mask[3],_GEN_94};
  wire  _GEN_100 = ~R0_addr_sel;
  wire  _GEN_101 = W0_en & W0_addr_sel;
  wire  _GEN_102 = W0_mask[0];
  wire  _GEN_103 = W0_mask[0];
  wire  _GEN_104 = W0_mask[0];
  wire [1:0] _GEN_105 = {W0_mask[0],W0_mask[0]};
  wire  _GEN_106 = W0_mask[0];
  wire [2:0] _GEN_107 = {W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_108 = W0_mask[0];
  wire [3:0] _GEN_109 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_110 = W0_mask[0];
  wire [4:0] _GEN_111 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_112 = W0_mask[0];
  wire [5:0] _GEN_113 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_114 = W0_mask[0];
  wire [6:0] _GEN_115 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_116 = W0_mask[0];
  wire [7:0] _GEN_117 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_118 = W0_mask[0];
  wire [8:0] _GEN_119 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask
    [0]};
  wire  _GEN_120 = W0_mask[0];
  wire [9:0] _GEN_121 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask
    [0],W0_mask[0]};
  wire  _GEN_122 = W0_mask[0];
  wire [10:0] _GEN_123 = {W0_mask[0],_GEN_22};
  wire  _GEN_124 = W0_mask[1];
  wire [11:0] _GEN_125 = {W0_mask[0],W0_mask[0],_GEN_22};
  wire  _GEN_126 = W0_mask[1];
  wire [12:0] _GEN_127 = {W0_mask[1],W0_mask[0],W0_mask[0],_GEN_22};
  wire  _GEN_128 = W0_mask[1];
  wire [13:0] _GEN_129 = {W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0],_GEN_22};
  wire  _GEN_130 = W0_mask[1];
  wire [14:0] _GEN_131 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0],_GEN_22};
  wire  _GEN_132 = W0_mask[1];
  wire [15:0] _GEN_133 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0],_GEN_22};
  wire  _GEN_134 = W0_mask[1];
  wire [16:0] _GEN_135 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0],_GEN_22};
  wire  _GEN_136 = W0_mask[1];
  wire [17:0] _GEN_137 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0],
    _GEN_22};
  wire  _GEN_138 = W0_mask[1];
  wire [18:0] _GEN_139 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[0],
    W0_mask[0],_GEN_22};
  wire  _GEN_140 = W0_mask[1];
  wire [19:0] _GEN_141 = {W0_mask[1],_GEN_40};
  wire  _GEN_142 = W0_mask[1];
  wire [20:0] _GEN_143 = {W0_mask[1],W0_mask[1],_GEN_40};
  wire  _GEN_144 = W0_mask[1];
  wire [21:0] _GEN_145 = {W0_mask[1],W0_mask[1],W0_mask[1],_GEN_40};
  wire  _GEN_146 = W0_mask[1];
  wire [22:0] _GEN_147 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_40};
  wire  _GEN_148 = W0_mask[2];
  wire [23:0] _GEN_149 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_40};
  wire  _GEN_150 = W0_mask[2];
  wire [24:0] _GEN_151 = {W0_mask[2],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_40};
  wire  _GEN_152 = W0_mask[2];
  wire [25:0] _GEN_153 = {W0_mask[2],W0_mask[2],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_40};
  wire  _GEN_154 = W0_mask[2];
  wire [26:0] _GEN_155 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],
    _GEN_40};
  wire  _GEN_156 = W0_mask[2];
  wire [27:0] _GEN_157 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],
    W0_mask[1],_GEN_40};
  wire  _GEN_158 = W0_mask[2];
  wire [28:0] _GEN_159 = {W0_mask[2],_GEN_58};
  wire  _GEN_160 = W0_mask[2];
  wire [29:0] _GEN_161 = {W0_mask[2],W0_mask[2],_GEN_58};
  wire  _GEN_162 = W0_mask[2];
  wire [30:0] _GEN_163 = {W0_mask[2],W0_mask[2],W0_mask[2],_GEN_58};
  wire  _GEN_164 = W0_mask[2];
  wire [31:0] _GEN_165 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],_GEN_58};
  wire  _GEN_166 = W0_mask[2];
  wire [32:0] _GEN_167 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],_GEN_58};
  wire  _GEN_168 = W0_mask[2];
  wire [33:0] _GEN_169 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],_GEN_58};
  wire  _GEN_170 = W0_mask[2];
  wire [34:0] _GEN_171 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],_GEN_58};
  wire  _GEN_172 = W0_mask[3];
  wire [35:0] _GEN_173 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],
    _GEN_58};
  wire  _GEN_174 = W0_mask[3];
  wire [36:0] _GEN_175 = {W0_mask[3],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],
    W0_mask[2],_GEN_58};
  wire  _GEN_176 = W0_mask[3];
  wire [37:0] _GEN_177 = {W0_mask[3],_GEN_76};
  wire  _GEN_178 = W0_mask[3];
  wire [38:0] _GEN_179 = {W0_mask[3],W0_mask[3],_GEN_76};
  wire  _GEN_180 = W0_mask[3];
  wire [39:0] _GEN_181 = {W0_mask[3],W0_mask[3],W0_mask[3],_GEN_76};
  wire  _GEN_182 = W0_mask[3];
  wire [40:0] _GEN_183 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],_GEN_76};
  wire  _GEN_184 = W0_mask[3];
  wire [41:0] _GEN_185 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],_GEN_76};
  wire  _GEN_186 = W0_mask[3];
  wire [42:0] _GEN_187 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],_GEN_76};
  wire  _GEN_188 = W0_mask[3];
  wire [43:0] _GEN_189 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],_GEN_76};
  wire  _GEN_190 = W0_mask[3];
  wire [44:0] _GEN_191 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],
    _GEN_76};
  wire  _GEN_192 = W0_mask[3];
  wire [45:0] _GEN_193 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],
    W0_mask[3],_GEN_76};
  wire  _GEN_194 = W0_mask[3];
  wire [46:0] _GEN_195 = {W0_mask[3],_GEN_94};
  wire [47:0] _GEN_196 = {W0_mask[3],W0_mask[3],_GEN_94};
  wire [48:0] _GEN_197 = {1'h0,W0_mask[3],W0_mask[3],_GEN_94};
  wire [49:0] _GEN_198 = {1'h0,1'h0,W0_mask[3],W0_mask[3],_GEN_94};
  TS1N28HPCPUHDHVTB128X50M4SWBSO mem_0_0_0 (
    .A(mem_0_0_0_A),
    .CLK(mem_0_0_0_CLK),
    .D(mem_0_0_0_D),
    .Q(mem_0_0_0_Q),
    .CEB(mem_0_0_0_CEB),
    .WEB(mem_0_0_0_WEB),
    .BWEB(mem_0_0_0_BWEB)
  );
  TS1N28HPCPUHDHVTB128X50M4SWBSO mem_0_0_1 (
    .A(mem_0_0_1_A),
    .CLK(mem_0_0_1_CLK),
    .D(mem_0_0_1_D),
    .Q(mem_0_0_1_Q),
    .CEB(mem_0_0_1_CEB),
    .WEB(mem_0_0_1_WEB),
    .BWEB(mem_0_0_1_BWEB)
  );
  TS1N28HPCPUHDHVTB128X50M4SWBSO mem_1_0_0 (
    .A(mem_1_0_0_A),
    .CLK(mem_1_0_0_CLK),
    .D(mem_1_0_0_D),
    .Q(mem_1_0_0_Q),
    .CEB(mem_1_0_0_CEB),
    .WEB(mem_1_0_0_WEB),
    .BWEB(mem_1_0_0_BWEB)
  );
  TS1N28HPCPUHDHVTB128X50M4SWBSO mem_1_0_1 (
    .A(mem_1_0_1_A),
    .CLK(mem_1_0_1_CLK),
    .D(mem_1_0_1_D),
    .Q(mem_1_0_1_Q),
    .CEB(mem_1_0_1_CEB),
    .WEB(mem_1_0_1_WEB),
    .BWEB(mem_1_0_1_BWEB)
  );
  assign R0_data = ~R0_addr_sel_reg ? R0_data_0_0_1 : R0_addr_sel_reg ? R0_data_1_0_1 : 48'h0;
  assign mem_0_0_0_A = W0_addr[6:0];
  assign mem_0_0_0_CLK = W0_clk;
  assign mem_0_0_0_D = {{2'd0}, W0_data};
  assign mem_0_0_0_CEB = ~(~W0_addr_sel);
  assign mem_0_0_0_WEB = ~(W0_en & ~W0_addr_sel);
  assign mem_0_0_0_BWEB = ~_GEN_99;
  assign mem_0_0_1_A = R0_addr[6:0];
  assign mem_0_0_1_CLK = R0_clk;
  assign mem_0_0_1_D = 50'h0;
  assign mem_0_0_1_CEB = ~(~R0_addr_sel);
  assign mem_0_0_1_WEB = 1'h1;
  assign mem_0_0_1_BWEB = 50'h0;
  assign mem_1_0_0_A = W0_addr[6:0];
  assign mem_1_0_0_CLK = W0_clk;
  assign mem_1_0_0_D = {{2'd0}, W0_data};
  assign mem_1_0_0_CEB = ~W0_addr_sel;
  assign mem_1_0_0_WEB = ~(W0_en & W0_addr_sel);
  assign mem_1_0_0_BWEB = ~_GEN_99;
  assign mem_1_0_1_A = R0_addr[6:0];
  assign mem_1_0_1_CLK = R0_clk;
  assign mem_1_0_1_D = 50'h0;
  assign mem_1_0_1_CEB = ~R0_addr_sel;
  assign mem_1_0_1_WEB = 1'h1;
  assign mem_1_0_1_BWEB = 50'h0;
  always @(posedge R0_clk) begin
    if (R0_en) begin
      R0_addr_sel_reg <= R0_addr_sel;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  R0_addr_sel_reg = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module table_1_ext(
  input  [6:0]  W0_addr,
  input         W0_clk,
  input  [51:0] W0_data,
  input         W0_en,
  input  [3:0]  W0_mask,
  input  [6:0]  R0_addr,
  input         R0_clk,
  output [51:0] R0_data,
  input         R0_en
);
  wire [6:0] mem_0_0_0_A;
  wire  mem_0_0_0_CLK;
  wire [25:0] mem_0_0_0_D;
  wire [25:0] mem_0_0_0_Q;
  wire  mem_0_0_0_CEB;
  wire  mem_0_0_0_WEB;
  wire [25:0] mem_0_0_0_BWEB;
  wire [6:0] mem_0_0_1_A;
  wire  mem_0_0_1_CLK;
  wire [25:0] mem_0_0_1_D;
  wire [25:0] mem_0_0_1_Q;
  wire  mem_0_0_1_CEB;
  wire  mem_0_0_1_WEB;
  wire [25:0] mem_0_0_1_BWEB;
  wire [6:0] mem_0_1_0_A;
  wire  mem_0_1_0_CLK;
  wire [25:0] mem_0_1_0_D;
  wire [25:0] mem_0_1_0_Q;
  wire  mem_0_1_0_CEB;
  wire  mem_0_1_0_WEB;
  wire [25:0] mem_0_1_0_BWEB;
  wire [6:0] mem_0_1_1_A;
  wire  mem_0_1_1_CLK;
  wire [25:0] mem_0_1_1_D;
  wire [25:0] mem_0_1_1_Q;
  wire  mem_0_1_1_CEB;
  wire  mem_0_1_1_WEB;
  wire [25:0] mem_0_1_1_BWEB;
  wire [25:0] R0_data_0_0_1 = mem_0_0_1_Q;
  wire [25:0] R0_data_0_1_1 = mem_0_1_1_Q;
  wire [51:0] R0_data_0_1 = {R0_data_0_1_1,R0_data_0_0_1};
  wire  _GEN_0 = W0_mask[0];
  wire  _GEN_1 = W0_mask[0];
  wire  _GEN_2 = W0_mask[0];
  wire [1:0] _GEN_3 = {W0_mask[0],W0_mask[0]};
  wire  _GEN_4 = W0_mask[0];
  wire [2:0] _GEN_5 = {W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_6 = W0_mask[0];
  wire [3:0] _GEN_7 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_8 = W0_mask[0];
  wire [4:0] _GEN_9 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_10 = W0_mask[0];
  wire [5:0] _GEN_11 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_12 = W0_mask[0];
  wire [6:0] _GEN_13 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_14 = W0_mask[0];
  wire [7:0] _GEN_15 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_16 = W0_mask[0];
  wire [8:0] _GEN_17 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[
    0]};
  wire  _GEN_18 = W0_mask[0];
  wire [9:0] _GEN_19 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[
    0],W0_mask[0]};
  wire  _GEN_20 = W0_mask[0];
  wire [10:0] _GEN_21 = {W0_mask[0],_GEN_19};
  wire  _GEN_22 = W0_mask[0];
  wire [11:0] _GEN_23 = {W0_mask[0],W0_mask[0],_GEN_19};
  wire  _GEN_24 = W0_mask[1];
  wire [12:0] _GEN_25 = {W0_mask[0],W0_mask[0],W0_mask[0],_GEN_19};
  wire  _GEN_26 = W0_mask[1];
  wire [13:0] _GEN_27 = {W0_mask[1],W0_mask[0],W0_mask[0],W0_mask[0],_GEN_19};
  wire  _GEN_28 = W0_mask[1];
  wire [14:0] _GEN_29 = {W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0],W0_mask[0],_GEN_19};
  wire  _GEN_30 = W0_mask[1];
  wire [15:0] _GEN_31 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0],W0_mask[0],_GEN_19};
  wire  _GEN_32 = W0_mask[1];
  wire [16:0] _GEN_33 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0],W0_mask[0],_GEN_19};
  wire  _GEN_34 = W0_mask[1];
  wire [17:0] _GEN_35 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0],W0_mask[0],_GEN_19
    };
  wire  _GEN_36 = W0_mask[1];
  wire [18:0] _GEN_37 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0],W0_mask
    [0],_GEN_19};
  wire  _GEN_38 = W0_mask[1];
  wire [19:0] _GEN_39 = {W0_mask[1],_GEN_37};
  wire  _GEN_40 = W0_mask[1];
  wire [20:0] _GEN_41 = {W0_mask[1],W0_mask[1],_GEN_37};
  wire  _GEN_42 = W0_mask[1];
  wire [21:0] _GEN_43 = {W0_mask[1],W0_mask[1],W0_mask[1],_GEN_37};
  wire  _GEN_44 = W0_mask[1];
  wire [22:0] _GEN_45 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_37};
  wire  _GEN_46 = W0_mask[1];
  wire [23:0] _GEN_47 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_37};
  wire  _GEN_48 = W0_mask[1];
  wire [24:0] _GEN_49 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_37};
  wire [25:0] _GEN_50 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_37};
  wire  _GEN_51 = W0_mask[2];
  wire  _GEN_52 = W0_mask[2];
  wire  _GEN_53 = W0_mask[2];
  wire [1:0] _GEN_54 = {W0_mask[2],W0_mask[2]};
  wire  _GEN_55 = W0_mask[2];
  wire [2:0] _GEN_56 = {W0_mask[2],W0_mask[2],W0_mask[2]};
  wire  _GEN_57 = W0_mask[2];
  wire [3:0] _GEN_58 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2]};
  wire  _GEN_59 = W0_mask[2];
  wire [4:0] _GEN_60 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2]};
  wire  _GEN_61 = W0_mask[2];
  wire [5:0] _GEN_62 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2]};
  wire  _GEN_63 = W0_mask[2];
  wire [6:0] _GEN_64 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2]};
  wire  _GEN_65 = W0_mask[2];
  wire [7:0] _GEN_66 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2]};
  wire  _GEN_67 = W0_mask[2];
  wire [8:0] _GEN_68 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[
    2]};
  wire  _GEN_69 = W0_mask[2];
  wire [9:0] _GEN_70 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[
    2],W0_mask[2]};
  wire  _GEN_71 = W0_mask[2];
  wire [10:0] _GEN_72 = {W0_mask[2],_GEN_70};
  wire  _GEN_73 = W0_mask[2];
  wire [11:0] _GEN_74 = {W0_mask[2],W0_mask[2],_GEN_70};
  wire  _GEN_75 = W0_mask[3];
  wire [12:0] _GEN_76 = {W0_mask[2],W0_mask[2],W0_mask[2],_GEN_70};
  wire  _GEN_77 = W0_mask[3];
  wire [13:0] _GEN_78 = {W0_mask[3],W0_mask[2],W0_mask[2],W0_mask[2],_GEN_70};
  wire  _GEN_79 = W0_mask[3];
  wire [14:0] _GEN_80 = {W0_mask[3],W0_mask[3],W0_mask[2],W0_mask[2],W0_mask[2],_GEN_70};
  wire  _GEN_81 = W0_mask[3];
  wire [15:0] _GEN_82 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[2],W0_mask[2],W0_mask[2],_GEN_70};
  wire  _GEN_83 = W0_mask[3];
  wire [16:0] _GEN_84 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[2],W0_mask[2],W0_mask[2],_GEN_70};
  wire  _GEN_85 = W0_mask[3];
  wire [17:0] _GEN_86 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[2],W0_mask[2],W0_mask[2],_GEN_70
    };
  wire  _GEN_87 = W0_mask[3];
  wire [18:0] _GEN_88 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[2],W0_mask[2],W0_mask
    [2],_GEN_70};
  wire  _GEN_89 = W0_mask[3];
  wire [19:0] _GEN_90 = {W0_mask[3],_GEN_88};
  wire  _GEN_91 = W0_mask[3];
  wire [20:0] _GEN_92 = {W0_mask[3],W0_mask[3],_GEN_88};
  wire  _GEN_93 = W0_mask[3];
  wire [21:0] _GEN_94 = {W0_mask[3],W0_mask[3],W0_mask[3],_GEN_88};
  wire  _GEN_95 = W0_mask[3];
  wire [22:0] _GEN_96 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],_GEN_88};
  wire  _GEN_97 = W0_mask[3];
  wire [23:0] _GEN_98 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],_GEN_88};
  wire  _GEN_99 = W0_mask[3];
  wire [24:0] _GEN_100 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],_GEN_88};
  wire [25:0] _GEN_101 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],_GEN_88};
  TS1N28HPCPUHDHVTB128X26M4SWBSO mem_0_0_0 (
    .A(mem_0_0_0_A),
    .CLK(mem_0_0_0_CLK),
    .D(mem_0_0_0_D),
    .Q(mem_0_0_0_Q),
    .CEB(mem_0_0_0_CEB),
    .WEB(mem_0_0_0_WEB),
    .BWEB(mem_0_0_0_BWEB)
  );
  TS1N28HPCPUHDHVTB128X26M4SWBSO mem_0_0_1 (
    .A(mem_0_0_1_A),
    .CLK(mem_0_0_1_CLK),
    .D(mem_0_0_1_D),
    .Q(mem_0_0_1_Q),
    .CEB(mem_0_0_1_CEB),
    .WEB(mem_0_0_1_WEB),
    .BWEB(mem_0_0_1_BWEB)
  );
  TS1N28HPCPUHDHVTB128X26M4SWBSO mem_0_1_0 (
    .A(mem_0_1_0_A),
    .CLK(mem_0_1_0_CLK),
    .D(mem_0_1_0_D),
    .Q(mem_0_1_0_Q),
    .CEB(mem_0_1_0_CEB),
    .WEB(mem_0_1_0_WEB),
    .BWEB(mem_0_1_0_BWEB)
  );
  TS1N28HPCPUHDHVTB128X26M4SWBSO mem_0_1_1 (
    .A(mem_0_1_1_A),
    .CLK(mem_0_1_1_CLK),
    .D(mem_0_1_1_D),
    .Q(mem_0_1_1_Q),
    .CEB(mem_0_1_1_CEB),
    .WEB(mem_0_1_1_WEB),
    .BWEB(mem_0_1_1_BWEB)
  );
  assign R0_data = {R0_data_0_1_1,R0_data_0_0_1};
  assign mem_0_0_0_A = W0_addr;
  assign mem_0_0_0_CLK = W0_clk;
  assign mem_0_0_0_D = W0_data[25:0];
  assign mem_0_0_0_CEB = 1'h0;
  assign mem_0_0_0_WEB = ~W0_en;
  assign mem_0_0_0_BWEB = ~_GEN_50;
  assign mem_0_0_1_A = R0_addr;
  assign mem_0_0_1_CLK = R0_clk;
  assign mem_0_0_1_D = 26'h0;
  assign mem_0_0_1_CEB = 1'h0;
  assign mem_0_0_1_WEB = 1'h1;
  assign mem_0_0_1_BWEB = 26'h0;
  assign mem_0_1_0_A = W0_addr;
  assign mem_0_1_0_CLK = W0_clk;
  assign mem_0_1_0_D = W0_data[51:26];
  assign mem_0_1_0_CEB = 1'h0;
  assign mem_0_1_0_WEB = ~W0_en;
  assign mem_0_1_0_BWEB = ~_GEN_101;
  assign mem_0_1_1_A = R0_addr;
  assign mem_0_1_1_CLK = R0_clk;
  assign mem_0_1_1_D = 26'h0;
  assign mem_0_1_1_CEB = 1'h0;
  assign mem_0_1_1_WEB = 1'h1;
  assign mem_0_1_1_BWEB = 26'h0;
endmodule
module meta_0_ext(
  input  [6:0]   W0_addr,
  input          W0_clk,
  input  [123:0] W0_data,
  input          W0_en,
  input  [3:0]   W0_mask,
  input  [6:0]   R0_addr,
  input          R0_clk,
  output [123:0] R0_data,
  input          R0_en
);
  wire [6:0] mem_0_0_0_A;
  wire  mem_0_0_0_CLK;
  wire [63:0] mem_0_0_0_D;
  wire [63:0] mem_0_0_0_Q;
  wire  mem_0_0_0_CEB;
  wire  mem_0_0_0_WEB;
  wire [63:0] mem_0_0_0_BWEB;
  wire [6:0] mem_0_0_1_A;
  wire  mem_0_0_1_CLK;
  wire [63:0] mem_0_0_1_D;
  wire [63:0] mem_0_0_1_Q;
  wire  mem_0_0_1_CEB;
  wire  mem_0_0_1_WEB;
  wire [63:0] mem_0_0_1_BWEB;
  wire [6:0] mem_0_1_0_A;
  wire  mem_0_1_0_CLK;
  wire [63:0] mem_0_1_0_D;
  wire [63:0] mem_0_1_0_Q;
  wire  mem_0_1_0_CEB;
  wire  mem_0_1_0_WEB;
  wire [63:0] mem_0_1_0_BWEB;
  wire [6:0] mem_0_1_1_A;
  wire  mem_0_1_1_CLK;
  wire [63:0] mem_0_1_1_D;
  wire [63:0] mem_0_1_1_Q;
  wire  mem_0_1_1_CEB;
  wire  mem_0_1_1_WEB;
  wire [63:0] mem_0_1_1_BWEB;
  wire [63:0] R0_data_0_0_1 = mem_0_0_1_Q;
  wire [59:0] R0_data_0_1_1 = mem_0_1_1_Q[59:0];
  wire [123:0] R0_data_0_1 = {R0_data_0_1_1,R0_data_0_0_1};
  wire  _GEN_0 = W0_mask[0];
  wire  _GEN_1 = W0_mask[0];
  wire  _GEN_2 = W0_mask[0];
  wire [1:0] _GEN_3 = {W0_mask[0],W0_mask[0]};
  wire  _GEN_4 = W0_mask[0];
  wire [2:0] _GEN_5 = {W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_6 = W0_mask[0];
  wire [3:0] _GEN_7 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_8 = W0_mask[0];
  wire [4:0] _GEN_9 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_10 = W0_mask[0];
  wire [5:0] _GEN_11 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_12 = W0_mask[0];
  wire [6:0] _GEN_13 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_14 = W0_mask[0];
  wire [7:0] _GEN_15 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_16 = W0_mask[0];
  wire [8:0] _GEN_17 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[
    0]};
  wire  _GEN_18 = W0_mask[0];
  wire [9:0] _GEN_19 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[
    0],W0_mask[0]};
  wire  _GEN_20 = W0_mask[0];
  wire [10:0] _GEN_21 = {W0_mask[0],_GEN_19};
  wire  _GEN_22 = W0_mask[0];
  wire [11:0] _GEN_23 = {W0_mask[0],W0_mask[0],_GEN_19};
  wire  _GEN_24 = W0_mask[0];
  wire [12:0] _GEN_25 = {W0_mask[0],W0_mask[0],W0_mask[0],_GEN_19};
  wire  _GEN_26 = W0_mask[0];
  wire [13:0] _GEN_27 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],_GEN_19};
  wire  _GEN_28 = W0_mask[0];
  wire [14:0] _GEN_29 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],_GEN_19};
  wire  _GEN_30 = W0_mask[0];
  wire [15:0] _GEN_31 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],_GEN_19};
  wire  _GEN_32 = W0_mask[0];
  wire [16:0] _GEN_33 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],_GEN_19};
  wire  _GEN_34 = W0_mask[0];
  wire [17:0] _GEN_35 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],_GEN_19
    };
  wire  _GEN_36 = W0_mask[0];
  wire [18:0] _GEN_37 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask
    [0],_GEN_19};
  wire  _GEN_38 = W0_mask[0];
  wire [19:0] _GEN_39 = {W0_mask[0],_GEN_37};
  wire  _GEN_40 = W0_mask[0];
  wire [20:0] _GEN_41 = {W0_mask[0],W0_mask[0],_GEN_37};
  wire  _GEN_42 = W0_mask[0];
  wire [21:0] _GEN_43 = {W0_mask[0],W0_mask[0],W0_mask[0],_GEN_37};
  wire  _GEN_44 = W0_mask[0];
  wire [22:0] _GEN_45 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],_GEN_37};
  wire  _GEN_46 = W0_mask[0];
  wire [23:0] _GEN_47 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],_GEN_37};
  wire  _GEN_48 = W0_mask[0];
  wire [24:0] _GEN_49 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],_GEN_37};
  wire  _GEN_50 = W0_mask[0];
  wire [25:0] _GEN_51 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],_GEN_37};
  wire  _GEN_52 = W0_mask[0];
  wire [26:0] _GEN_53 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],_GEN_37
    };
  wire  _GEN_54 = W0_mask[0];
  wire [27:0] _GEN_55 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask
    [0],_GEN_37};
  wire  _GEN_56 = W0_mask[0];
  wire [28:0] _GEN_57 = {W0_mask[0],_GEN_55};
  wire  _GEN_58 = W0_mask[0];
  wire [29:0] _GEN_59 = {W0_mask[0],W0_mask[0],_GEN_55};
  wire  _GEN_60 = W0_mask[1];
  wire [30:0] _GEN_61 = {W0_mask[0],W0_mask[0],W0_mask[0],_GEN_55};
  wire  _GEN_62 = W0_mask[1];
  wire [31:0] _GEN_63 = {W0_mask[1],W0_mask[0],W0_mask[0],W0_mask[0],_GEN_55};
  wire  _GEN_64 = W0_mask[1];
  wire [32:0] _GEN_65 = {W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0],W0_mask[0],_GEN_55};
  wire  _GEN_66 = W0_mask[1];
  wire [33:0] _GEN_67 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0],W0_mask[0],_GEN_55};
  wire  _GEN_68 = W0_mask[1];
  wire [34:0] _GEN_69 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0],W0_mask[0],_GEN_55};
  wire  _GEN_70 = W0_mask[1];
  wire [35:0] _GEN_71 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0],W0_mask[0],_GEN_55
    };
  wire  _GEN_72 = W0_mask[1];
  wire [36:0] _GEN_73 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0],W0_mask
    [0],_GEN_55};
  wire  _GEN_74 = W0_mask[1];
  wire [37:0] _GEN_75 = {W0_mask[1],_GEN_73};
  wire  _GEN_76 = W0_mask[1];
  wire [38:0] _GEN_77 = {W0_mask[1],W0_mask[1],_GEN_73};
  wire  _GEN_78 = W0_mask[1];
  wire [39:0] _GEN_79 = {W0_mask[1],W0_mask[1],W0_mask[1],_GEN_73};
  wire  _GEN_80 = W0_mask[1];
  wire [40:0] _GEN_81 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_73};
  wire  _GEN_82 = W0_mask[1];
  wire [41:0] _GEN_83 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_73};
  wire  _GEN_84 = W0_mask[1];
  wire [42:0] _GEN_85 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_73};
  wire  _GEN_86 = W0_mask[1];
  wire [43:0] _GEN_87 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_73};
  wire  _GEN_88 = W0_mask[1];
  wire [44:0] _GEN_89 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_73
    };
  wire  _GEN_90 = W0_mask[1];
  wire [45:0] _GEN_91 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask
    [1],_GEN_73};
  wire  _GEN_92 = W0_mask[1];
  wire [46:0] _GEN_93 = {W0_mask[1],_GEN_91};
  wire  _GEN_94 = W0_mask[1];
  wire [47:0] _GEN_95 = {W0_mask[1],W0_mask[1],_GEN_91};
  wire  _GEN_96 = W0_mask[1];
  wire [48:0] _GEN_97 = {W0_mask[1],W0_mask[1],W0_mask[1],_GEN_91};
  wire  _GEN_98 = W0_mask[1];
  wire [49:0] _GEN_99 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_91};
  wire  _GEN_100 = W0_mask[1];
  wire [50:0] _GEN_101 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_91};
  wire  _GEN_102 = W0_mask[1];
  wire [51:0] _GEN_103 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_91};
  wire  _GEN_104 = W0_mask[1];
  wire [52:0] _GEN_105 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_91};
  wire  _GEN_106 = W0_mask[1];
  wire [53:0] _GEN_107 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],
    _GEN_91};
  wire  _GEN_108 = W0_mask[1];
  wire [54:0] _GEN_109 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],
    W0_mask[1],_GEN_91};
  wire  _GEN_110 = W0_mask[1];
  wire [55:0] _GEN_111 = {W0_mask[1],_GEN_109};
  wire  _GEN_112 = W0_mask[1];
  wire [56:0] _GEN_113 = {W0_mask[1],W0_mask[1],_GEN_109};
  wire  _GEN_114 = W0_mask[1];
  wire [57:0] _GEN_115 = {W0_mask[1],W0_mask[1],W0_mask[1],_GEN_109};
  wire  _GEN_116 = W0_mask[1];
  wire [58:0] _GEN_117 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_109};
  wire  _GEN_118 = W0_mask[1];
  wire [59:0] _GEN_119 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_109};
  wire  _GEN_120 = W0_mask[1];
  wire [60:0] _GEN_121 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_109};
  wire  _GEN_122 = W0_mask[2];
  wire [61:0] _GEN_123 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_109};
  wire  _GEN_124 = W0_mask[2];
  wire [62:0] _GEN_125 = {W0_mask[2],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],
    _GEN_109};
  wire [63:0] _GEN_126 = {W0_mask[2],W0_mask[2],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],
    W0_mask[1],_GEN_109};
  wire [59:0] _GEN_127 = W0_data[123:64];
  wire  _GEN_128 = W0_mask[2];
  wire  _GEN_129 = W0_mask[2];
  wire  _GEN_130 = W0_mask[2];
  wire [1:0] _GEN_131 = {W0_mask[2],W0_mask[2]};
  wire  _GEN_132 = W0_mask[2];
  wire [2:0] _GEN_133 = {W0_mask[2],W0_mask[2],W0_mask[2]};
  wire  _GEN_134 = W0_mask[2];
  wire [3:0] _GEN_135 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2]};
  wire  _GEN_136 = W0_mask[2];
  wire [4:0] _GEN_137 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2]};
  wire  _GEN_138 = W0_mask[2];
  wire [5:0] _GEN_139 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2]};
  wire  _GEN_140 = W0_mask[2];
  wire [6:0] _GEN_141 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2]};
  wire  _GEN_142 = W0_mask[2];
  wire [7:0] _GEN_143 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2]};
  wire  _GEN_144 = W0_mask[2];
  wire [8:0] _GEN_145 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask
    [2]};
  wire  _GEN_146 = W0_mask[2];
  wire [9:0] _GEN_147 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask
    [2],W0_mask[2]};
  wire  _GEN_148 = W0_mask[2];
  wire [10:0] _GEN_149 = {W0_mask[2],_GEN_147};
  wire  _GEN_150 = W0_mask[2];
  wire [11:0] _GEN_151 = {W0_mask[2],W0_mask[2],_GEN_147};
  wire  _GEN_152 = W0_mask[2];
  wire [12:0] _GEN_153 = {W0_mask[2],W0_mask[2],W0_mask[2],_GEN_147};
  wire  _GEN_154 = W0_mask[2];
  wire [13:0] _GEN_155 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],_GEN_147};
  wire  _GEN_156 = W0_mask[2];
  wire [14:0] _GEN_157 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],_GEN_147};
  wire  _GEN_158 = W0_mask[2];
  wire [15:0] _GEN_159 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],_GEN_147};
  wire  _GEN_160 = W0_mask[2];
  wire [16:0] _GEN_161 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],_GEN_147};
  wire  _GEN_162 = W0_mask[2];
  wire [17:0] _GEN_163 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],
    _GEN_147};
  wire  _GEN_164 = W0_mask[2];
  wire [18:0] _GEN_165 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],
    W0_mask[2],_GEN_147};
  wire  _GEN_166 = W0_mask[2];
  wire [19:0] _GEN_167 = {W0_mask[2],_GEN_165};
  wire  _GEN_168 = W0_mask[2];
  wire [20:0] _GEN_169 = {W0_mask[2],W0_mask[2],_GEN_165};
  wire  _GEN_170 = W0_mask[2];
  wire [21:0] _GEN_171 = {W0_mask[2],W0_mask[2],W0_mask[2],_GEN_165};
  wire  _GEN_172 = W0_mask[2];
  wire [22:0] _GEN_173 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],_GEN_165};
  wire  _GEN_174 = W0_mask[2];
  wire [23:0] _GEN_175 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],_GEN_165};
  wire  _GEN_176 = W0_mask[2];
  wire [24:0] _GEN_177 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],_GEN_165};
  wire  _GEN_178 = W0_mask[2];
  wire [25:0] _GEN_179 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],_GEN_165};
  wire  _GEN_180 = W0_mask[2];
  wire [26:0] _GEN_181 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],
    _GEN_165};
  wire  _GEN_182 = W0_mask[2];
  wire [27:0] _GEN_183 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],
    W0_mask[2],_GEN_165};
  wire  _GEN_184 = W0_mask[3];
  wire [28:0] _GEN_185 = {W0_mask[2],_GEN_183};
  wire  _GEN_186 = W0_mask[3];
  wire [29:0] _GEN_187 = {W0_mask[3],W0_mask[2],_GEN_183};
  wire  _GEN_188 = W0_mask[3];
  wire [30:0] _GEN_189 = {W0_mask[3],W0_mask[3],W0_mask[2],_GEN_183};
  wire  _GEN_190 = W0_mask[3];
  wire [31:0] _GEN_191 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[2],_GEN_183};
  wire  _GEN_192 = W0_mask[3];
  wire [32:0] _GEN_193 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[2],_GEN_183};
  wire  _GEN_194 = W0_mask[3];
  wire [33:0] _GEN_195 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[2],_GEN_183};
  wire  _GEN_196 = W0_mask[3];
  wire [34:0] _GEN_197 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[2],_GEN_183};
  wire  _GEN_198 = W0_mask[3];
  wire [35:0] _GEN_199 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[2],
    _GEN_183};
  wire  _GEN_200 = W0_mask[3];
  wire [36:0] _GEN_201 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],
    W0_mask[2],_GEN_183};
  wire  _GEN_202 = W0_mask[3];
  wire [37:0] _GEN_203 = {W0_mask[3],_GEN_201};
  wire  _GEN_204 = W0_mask[3];
  wire [38:0] _GEN_205 = {W0_mask[3],W0_mask[3],_GEN_201};
  wire  _GEN_206 = W0_mask[3];
  wire [39:0] _GEN_207 = {W0_mask[3],W0_mask[3],W0_mask[3],_GEN_201};
  wire  _GEN_208 = W0_mask[3];
  wire [40:0] _GEN_209 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],_GEN_201};
  wire  _GEN_210 = W0_mask[3];
  wire [41:0] _GEN_211 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],_GEN_201};
  wire  _GEN_212 = W0_mask[3];
  wire [42:0] _GEN_213 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],_GEN_201};
  wire  _GEN_214 = W0_mask[3];
  wire [43:0] _GEN_215 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],_GEN_201};
  wire  _GEN_216 = W0_mask[3];
  wire [44:0] _GEN_217 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],
    _GEN_201};
  wire  _GEN_218 = W0_mask[3];
  wire [45:0] _GEN_219 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],
    W0_mask[3],_GEN_201};
  wire  _GEN_220 = W0_mask[3];
  wire [46:0] _GEN_221 = {W0_mask[3],_GEN_219};
  wire  _GEN_222 = W0_mask[3];
  wire [47:0] _GEN_223 = {W0_mask[3],W0_mask[3],_GEN_219};
  wire  _GEN_224 = W0_mask[3];
  wire [48:0] _GEN_225 = {W0_mask[3],W0_mask[3],W0_mask[3],_GEN_219};
  wire  _GEN_226 = W0_mask[3];
  wire [49:0] _GEN_227 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],_GEN_219};
  wire  _GEN_228 = W0_mask[3];
  wire [50:0] _GEN_229 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],_GEN_219};
  wire  _GEN_230 = W0_mask[3];
  wire [51:0] _GEN_231 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],_GEN_219};
  wire  _GEN_232 = W0_mask[3];
  wire [52:0] _GEN_233 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],_GEN_219};
  wire  _GEN_234 = W0_mask[3];
  wire [53:0] _GEN_235 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],
    _GEN_219};
  wire  _GEN_236 = W0_mask[3];
  wire [54:0] _GEN_237 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],
    W0_mask[3],_GEN_219};
  wire  _GEN_238 = W0_mask[3];
  wire [55:0] _GEN_239 = {W0_mask[3],_GEN_237};
  wire  _GEN_240 = W0_mask[3];
  wire [56:0] _GEN_241 = {W0_mask[3],W0_mask[3],_GEN_237};
  wire  _GEN_242 = W0_mask[3];
  wire [57:0] _GEN_243 = {W0_mask[3],W0_mask[3],W0_mask[3],_GEN_237};
  wire  _GEN_244 = W0_mask[3];
  wire [58:0] _GEN_245 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],_GEN_237};
  wire [59:0] _GEN_246 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],_GEN_237};
  wire [60:0] _GEN_247 = {1'h0,W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],_GEN_237};
  wire [61:0] _GEN_248 = {1'h0,1'h0,W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],_GEN_237};
  wire [62:0] _GEN_249 = {1'h0,1'h0,1'h0,W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],_GEN_237};
  wire [63:0] _GEN_250 = {1'h0,1'h0,1'h0,1'h0,W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],_GEN_237};
  TS1N28HPCPUHDHVTB128X64M4SWBSO mem_0_0_0 (
    .A(mem_0_0_0_A),
    .CLK(mem_0_0_0_CLK),
    .D(mem_0_0_0_D),
    .Q(mem_0_0_0_Q),
    .CEB(mem_0_0_0_CEB),
    .WEB(mem_0_0_0_WEB),
    .BWEB(mem_0_0_0_BWEB)
  );
  TS1N28HPCPUHDHVTB128X64M4SWBSO mem_0_0_1 (
    .A(mem_0_0_1_A),
    .CLK(mem_0_0_1_CLK),
    .D(mem_0_0_1_D),
    .Q(mem_0_0_1_Q),
    .CEB(mem_0_0_1_CEB),
    .WEB(mem_0_0_1_WEB),
    .BWEB(mem_0_0_1_BWEB)
  );
  TS1N28HPCPUHDHVTB128X64M4SWBSO mem_0_1_0 (
    .A(mem_0_1_0_A),
    .CLK(mem_0_1_0_CLK),
    .D(mem_0_1_0_D),
    .Q(mem_0_1_0_Q),
    .CEB(mem_0_1_0_CEB),
    .WEB(mem_0_1_0_WEB),
    .BWEB(mem_0_1_0_BWEB)
  );
  TS1N28HPCPUHDHVTB128X64M4SWBSO mem_0_1_1 (
    .A(mem_0_1_1_A),
    .CLK(mem_0_1_1_CLK),
    .D(mem_0_1_1_D),
    .Q(mem_0_1_1_Q),
    .CEB(mem_0_1_1_CEB),
    .WEB(mem_0_1_1_WEB),
    .BWEB(mem_0_1_1_BWEB)
  );
  assign R0_data = {R0_data_0_1_1,R0_data_0_0_1};
  assign mem_0_0_0_A = W0_addr;
  assign mem_0_0_0_CLK = W0_clk;
  assign mem_0_0_0_D = W0_data[63:0];
  assign mem_0_0_0_CEB = 1'h0;
  assign mem_0_0_0_WEB = ~W0_en;
  assign mem_0_0_0_BWEB = ~_GEN_126;
  assign mem_0_0_1_A = R0_addr;
  assign mem_0_0_1_CLK = R0_clk;
  assign mem_0_0_1_D = 64'h0;
  assign mem_0_0_1_CEB = 1'h0;
  assign mem_0_0_1_WEB = 1'h1;
  assign mem_0_0_1_BWEB = 64'h0;
  assign mem_0_1_0_A = W0_addr;
  assign mem_0_1_0_CLK = W0_clk;
  assign mem_0_1_0_D = {{4'd0}, W0_data[123:64]};
  assign mem_0_1_0_CEB = 1'h0;
  assign mem_0_1_0_WEB = ~W0_en;
  assign mem_0_1_0_BWEB = ~_GEN_250;
  assign mem_0_1_1_A = R0_addr;
  assign mem_0_1_1_CLK = R0_clk;
  assign mem_0_1_1_D = 64'h0;
  assign mem_0_1_1_CEB = 1'h0;
  assign mem_0_1_1_WEB = 1'h1;
  assign mem_0_1_1_BWEB = 64'h0;
endmodule
module btb_0_ext(
  input  [6:0]  W0_addr,
  input         W0_clk,
  input  [55:0] W0_data,
  input         W0_en,
  input  [3:0]  W0_mask,
  input  [6:0]  R0_addr,
  input         R0_clk,
  output [55:0] R0_data,
  input         R0_en
);
  wire [6:0] mem_0_0_0_A;
  wire  mem_0_0_0_CLK;
  wire [58:0] mem_0_0_0_D;
  wire [58:0] mem_0_0_0_Q;
  wire  mem_0_0_0_CEB;
  wire  mem_0_0_0_WEB;
  wire [58:0] mem_0_0_0_BWEB;
  wire [6:0] mem_0_0_1_A;
  wire  mem_0_0_1_CLK;
  wire [58:0] mem_0_0_1_D;
  wire [58:0] mem_0_0_1_Q;
  wire  mem_0_0_1_CEB;
  wire  mem_0_0_1_WEB;
  wire [58:0] mem_0_0_1_BWEB;
  wire [55:0] R0_data_0_0_1 = mem_0_0_1_Q[55:0];
  wire [55:0] R0_data_0_1 = R0_data_0_0_1;
  wire  _GEN_0 = W0_mask[0];
  wire  _GEN_1 = W0_mask[0];
  wire  _GEN_2 = W0_mask[0];
  wire [1:0] _GEN_3 = {W0_mask[0],W0_mask[0]};
  wire  _GEN_4 = W0_mask[0];
  wire [2:0] _GEN_5 = {W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_6 = W0_mask[0];
  wire [3:0] _GEN_7 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_8 = W0_mask[0];
  wire [4:0] _GEN_9 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_10 = W0_mask[0];
  wire [5:0] _GEN_11 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_12 = W0_mask[0];
  wire [6:0] _GEN_13 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_14 = W0_mask[0];
  wire [7:0] _GEN_15 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0]};
  wire  _GEN_16 = W0_mask[0];
  wire [8:0] _GEN_17 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[
    0]};
  wire  _GEN_18 = W0_mask[0];
  wire [9:0] _GEN_19 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[
    0],W0_mask[0]};
  wire  _GEN_20 = W0_mask[0];
  wire [10:0] _GEN_21 = {W0_mask[0],_GEN_19};
  wire  _GEN_22 = W0_mask[0];
  wire [11:0] _GEN_23 = {W0_mask[0],W0_mask[0],_GEN_19};
  wire  _GEN_24 = W0_mask[0];
  wire [12:0] _GEN_25 = {W0_mask[0],W0_mask[0],W0_mask[0],_GEN_19};
  wire  _GEN_26 = W0_mask[1];
  wire [13:0] _GEN_27 = {W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],_GEN_19};
  wire  _GEN_28 = W0_mask[1];
  wire [14:0] _GEN_29 = {W0_mask[1],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],_GEN_19};
  wire  _GEN_30 = W0_mask[1];
  wire [15:0] _GEN_31 = {W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],_GEN_19};
  wire  _GEN_32 = W0_mask[1];
  wire [16:0] _GEN_33 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],_GEN_19};
  wire  _GEN_34 = W0_mask[1];
  wire [17:0] _GEN_35 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask[0],_GEN_19
    };
  wire  _GEN_36 = W0_mask[1];
  wire [18:0] _GEN_37 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0],W0_mask[0],W0_mask
    [0],_GEN_19};
  wire  _GEN_38 = W0_mask[1];
  wire [19:0] _GEN_39 = {W0_mask[1],_GEN_37};
  wire  _GEN_40 = W0_mask[1];
  wire [20:0] _GEN_41 = {W0_mask[1],W0_mask[1],_GEN_37};
  wire  _GEN_42 = W0_mask[1];
  wire [21:0] _GEN_43 = {W0_mask[1],W0_mask[1],W0_mask[1],_GEN_37};
  wire  _GEN_44 = W0_mask[1];
  wire [22:0] _GEN_45 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_37};
  wire  _GEN_46 = W0_mask[1];
  wire [23:0] _GEN_47 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_37};
  wire  _GEN_48 = W0_mask[1];
  wire [24:0] _GEN_49 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_37};
  wire  _GEN_50 = W0_mask[1];
  wire [25:0] _GEN_51 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_37};
  wire  _GEN_52 = W0_mask[1];
  wire [26:0] _GEN_53 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],_GEN_37
    };
  wire  _GEN_54 = W0_mask[2];
  wire [27:0] _GEN_55 = {W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask[1],W0_mask
    [1],_GEN_37};
  wire  _GEN_56 = W0_mask[2];
  wire [28:0] _GEN_57 = {W0_mask[2],_GEN_55};
  wire  _GEN_58 = W0_mask[2];
  wire [29:0] _GEN_59 = {W0_mask[2],W0_mask[2],_GEN_55};
  wire  _GEN_60 = W0_mask[2];
  wire [30:0] _GEN_61 = {W0_mask[2],W0_mask[2],W0_mask[2],_GEN_55};
  wire  _GEN_62 = W0_mask[2];
  wire [31:0] _GEN_63 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],_GEN_55};
  wire  _GEN_64 = W0_mask[2];
  wire [32:0] _GEN_65 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],_GEN_55};
  wire  _GEN_66 = W0_mask[2];
  wire [33:0] _GEN_67 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],_GEN_55};
  wire  _GEN_68 = W0_mask[2];
  wire [34:0] _GEN_69 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],_GEN_55};
  wire  _GEN_70 = W0_mask[2];
  wire [35:0] _GEN_71 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],_GEN_55
    };
  wire  _GEN_72 = W0_mask[2];
  wire [36:0] _GEN_73 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask
    [2],_GEN_55};
  wire  _GEN_74 = W0_mask[2];
  wire [37:0] _GEN_75 = {W0_mask[2],_GEN_73};
  wire  _GEN_76 = W0_mask[2];
  wire [38:0] _GEN_77 = {W0_mask[2],W0_mask[2],_GEN_73};
  wire  _GEN_78 = W0_mask[2];
  wire [39:0] _GEN_79 = {W0_mask[2],W0_mask[2],W0_mask[2],_GEN_73};
  wire  _GEN_80 = W0_mask[2];
  wire [40:0] _GEN_81 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],_GEN_73};
  wire  _GEN_82 = W0_mask[3];
  wire [41:0] _GEN_83 = {W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],_GEN_73};
  wire  _GEN_84 = W0_mask[3];
  wire [42:0] _GEN_85 = {W0_mask[3],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],_GEN_73};
  wire  _GEN_86 = W0_mask[3];
  wire [43:0] _GEN_87 = {W0_mask[3],W0_mask[3],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],_GEN_73};
  wire  _GEN_88 = W0_mask[3];
  wire [44:0] _GEN_89 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],_GEN_73
    };
  wire  _GEN_90 = W0_mask[3];
  wire [45:0] _GEN_91 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask[2],W0_mask
    [2],_GEN_73};
  wire  _GEN_92 = W0_mask[3];
  wire [46:0] _GEN_93 = {W0_mask[3],_GEN_91};
  wire  _GEN_94 = W0_mask[3];
  wire [47:0] _GEN_95 = {W0_mask[3],W0_mask[3],_GEN_91};
  wire  _GEN_96 = W0_mask[3];
  wire [48:0] _GEN_97 = {W0_mask[3],W0_mask[3],W0_mask[3],_GEN_91};
  wire  _GEN_98 = W0_mask[3];
  wire [49:0] _GEN_99 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],_GEN_91};
  wire  _GEN_100 = W0_mask[3];
  wire [50:0] _GEN_101 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],_GEN_91};
  wire  _GEN_102 = W0_mask[3];
  wire [51:0] _GEN_103 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],_GEN_91};
  wire  _GEN_104 = W0_mask[3];
  wire [52:0] _GEN_105 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],_GEN_91};
  wire  _GEN_106 = W0_mask[3];
  wire [53:0] _GEN_107 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],
    _GEN_91};
  wire  _GEN_108 = W0_mask[3];
  wire [54:0] _GEN_109 = {W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],W0_mask[3],
    W0_mask[3],_GEN_91};
  wire [55:0] _GEN_110 = {W0_mask[3],_GEN_109};
  wire [56:0] _GEN_111 = {1'h0,W0_mask[3],_GEN_109};
  wire [57:0] _GEN_112 = {1'h0,1'h0,W0_mask[3],_GEN_109};
  wire [58:0] _GEN_113 = {1'h0,1'h0,1'h0,W0_mask[3],_GEN_109};
  TS1N28HPCPUHDHVTB128X59M4SWBSO mem_0_0_0 (
    .A(mem_0_0_0_A),
    .CLK(mem_0_0_0_CLK),
    .D(mem_0_0_0_D),
    .Q(mem_0_0_0_Q),
    .CEB(mem_0_0_0_CEB),
    .WEB(mem_0_0_0_WEB),
    .BWEB(mem_0_0_0_BWEB)
  );
  TS1N28HPCPUHDHVTB128X59M4SWBSO mem_0_0_1 (
    .A(mem_0_0_1_A),
    .CLK(mem_0_0_1_CLK),
    .D(mem_0_0_1_D),
    .Q(mem_0_0_1_Q),
    .CEB(mem_0_0_1_CEB),
    .WEB(mem_0_0_1_WEB),
    .BWEB(mem_0_0_1_BWEB)
  );
  assign R0_data = mem_0_0_1_Q[55:0];
  assign mem_0_0_0_A = W0_addr;
  assign mem_0_0_0_CLK = W0_clk;
  assign mem_0_0_0_D = {{3'd0}, W0_data};
  assign mem_0_0_0_CEB = 1'h0;
  assign mem_0_0_0_WEB = ~W0_en;
  assign mem_0_0_0_BWEB = ~_GEN_113;
  assign mem_0_0_1_A = R0_addr;
  assign mem_0_0_1_CLK = R0_clk;
  assign mem_0_0_1_D = 59'h0;
  assign mem_0_0_1_CEB = 1'h0;
  assign mem_0_0_1_WEB = 1'h1;
  assign mem_0_0_1_BWEB = 59'h0;
endmodule
module ebtb_ext(
  input  [6:0]  W0_addr,
  input         W0_clk,
  input  [39:0] W0_data,
  input         W0_en,
  input  [6:0]  R0_addr,
  input         R0_clk,
  output [39:0] R0_data,
  input         R0_en
);
  wire [6:0] mem_0_0_0_A;
  wire  mem_0_0_0_CLK;
  wire [19:0] mem_0_0_0_D;
  wire [19:0] mem_0_0_0_Q;
  wire  mem_0_0_0_CEB;
  wire  mem_0_0_0_WEB;
  wire [19:0] mem_0_0_0_BWEB;
  wire [6:0] mem_0_0_1_A;
  wire  mem_0_0_1_CLK;
  wire [19:0] mem_0_0_1_D;
  wire [19:0] mem_0_0_1_Q;
  wire  mem_0_0_1_CEB;
  wire  mem_0_0_1_WEB;
  wire [19:0] mem_0_0_1_BWEB;
  wire [6:0] mem_0_1_0_A;
  wire  mem_0_1_0_CLK;
  wire [19:0] mem_0_1_0_D;
  wire [19:0] mem_0_1_0_Q;
  wire  mem_0_1_0_CEB;
  wire  mem_0_1_0_WEB;
  wire [19:0] mem_0_1_0_BWEB;
  wire [6:0] mem_0_1_1_A;
  wire  mem_0_1_1_CLK;
  wire [19:0] mem_0_1_1_D;
  wire [19:0] mem_0_1_1_Q;
  wire  mem_0_1_1_CEB;
  wire  mem_0_1_1_WEB;
  wire [19:0] mem_0_1_1_BWEB;
  wire [19:0] R0_data_0_0_1 = mem_0_0_1_Q;
  wire [19:0] R0_data_0_1_1 = mem_0_1_1_Q;
  wire [39:0] R0_data_0_1 = {R0_data_0_1_1,R0_data_0_0_1};
  TS1N28HPCPUHDHVTB128X20M4SWBSO mem_0_0_0 (
    .A(mem_0_0_0_A),
    .CLK(mem_0_0_0_CLK),
    .D(mem_0_0_0_D),
    .Q(mem_0_0_0_Q),
    .CEB(mem_0_0_0_CEB),
    .WEB(mem_0_0_0_WEB),
    .BWEB(mem_0_0_0_BWEB)
  );
  TS1N28HPCPUHDHVTB128X20M4SWBSO mem_0_0_1 (
    .A(mem_0_0_1_A),
    .CLK(mem_0_0_1_CLK),
    .D(mem_0_0_1_D),
    .Q(mem_0_0_1_Q),
    .CEB(mem_0_0_1_CEB),
    .WEB(mem_0_0_1_WEB),
    .BWEB(mem_0_0_1_BWEB)
  );
  TS1N28HPCPUHDHVTB128X20M4SWBSO mem_0_1_0 (
    .A(mem_0_1_0_A),
    .CLK(mem_0_1_0_CLK),
    .D(mem_0_1_0_D),
    .Q(mem_0_1_0_Q),
    .CEB(mem_0_1_0_CEB),
    .WEB(mem_0_1_0_WEB),
    .BWEB(mem_0_1_0_BWEB)
  );
  TS1N28HPCPUHDHVTB128X20M4SWBSO mem_0_1_1 (
    .A(mem_0_1_1_A),
    .CLK(mem_0_1_1_CLK),
    .D(mem_0_1_1_D),
    .Q(mem_0_1_1_Q),
    .CEB(mem_0_1_1_CEB),
    .WEB(mem_0_1_1_WEB),
    .BWEB(mem_0_1_1_BWEB)
  );
  assign R0_data = {R0_data_0_1_1,R0_data_0_0_1};
  assign mem_0_0_0_A = W0_addr;
  assign mem_0_0_0_CLK = W0_clk;
  assign mem_0_0_0_D = W0_data[19:0];
  assign mem_0_0_0_CEB = 1'h0;
  assign mem_0_0_0_WEB = ~W0_en;
  assign mem_0_0_0_BWEB = 20'h0;
  assign mem_0_0_1_A = R0_addr;
  assign mem_0_0_1_CLK = R0_clk;
  assign mem_0_0_1_D = 20'h0;
  assign mem_0_0_1_CEB = 1'h0;
  assign mem_0_0_1_WEB = 1'h1;
  assign mem_0_0_1_BWEB = 20'h0;
  assign mem_0_1_0_A = W0_addr;
  assign mem_0_1_0_CLK = W0_clk;
  assign mem_0_1_0_D = W0_data[39:20];
  assign mem_0_1_0_CEB = 1'h0;
  assign mem_0_1_0_WEB = ~W0_en;
  assign mem_0_1_0_BWEB = 20'h0;
  assign mem_0_1_1_A = R0_addr;
  assign mem_0_1_1_CLK = R0_clk;
  assign mem_0_1_1_D = 20'h0;
  assign mem_0_1_1_CEB = 1'h0;
  assign mem_0_1_1_WEB = 1'h1;
  assign mem_0_1_1_BWEB = 20'h0;
endmodule
module data_ext(
  input  [10:0] W0_addr,
  input         W0_clk,
  input  [7:0]  W0_data,
  input         W0_en,
  input  [3:0]  W0_mask,
  input  [10:0] R0_addr,
  input         R0_clk,
  output [7:0]  R0_data,
  input         R0_en
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire [8:0] mem_0_0_0_A;
  wire  mem_0_0_0_CLK;
  wire [11:0] mem_0_0_0_D;
  wire [11:0] mem_0_0_0_Q;
  wire  mem_0_0_0_CEB;
  wire  mem_0_0_0_WEB;
  wire [11:0] mem_0_0_0_BWEB;
  wire [8:0] mem_0_0_1_A;
  wire  mem_0_0_1_CLK;
  wire [11:0] mem_0_0_1_D;
  wire [11:0] mem_0_0_1_Q;
  wire  mem_0_0_1_CEB;
  wire  mem_0_0_1_WEB;
  wire [11:0] mem_0_0_1_BWEB;
  wire [8:0] mem_1_0_0_A;
  wire  mem_1_0_0_CLK;
  wire [11:0] mem_1_0_0_D;
  wire [11:0] mem_1_0_0_Q;
  wire  mem_1_0_0_CEB;
  wire  mem_1_0_0_WEB;
  wire [11:0] mem_1_0_0_BWEB;
  wire [8:0] mem_1_0_1_A;
  wire  mem_1_0_1_CLK;
  wire [11:0] mem_1_0_1_D;
  wire [11:0] mem_1_0_1_Q;
  wire  mem_1_0_1_CEB;
  wire  mem_1_0_1_WEB;
  wire [11:0] mem_1_0_1_BWEB;
  wire [8:0] mem_2_0_0_A;
  wire  mem_2_0_0_CLK;
  wire [11:0] mem_2_0_0_D;
  wire [11:0] mem_2_0_0_Q;
  wire  mem_2_0_0_CEB;
  wire  mem_2_0_0_WEB;
  wire [11:0] mem_2_0_0_BWEB;
  wire [8:0] mem_2_0_1_A;
  wire  mem_2_0_1_CLK;
  wire [11:0] mem_2_0_1_D;
  wire [11:0] mem_2_0_1_Q;
  wire  mem_2_0_1_CEB;
  wire  mem_2_0_1_WEB;
  wire [11:0] mem_2_0_1_BWEB;
  wire [8:0] mem_3_0_0_A;
  wire  mem_3_0_0_CLK;
  wire [11:0] mem_3_0_0_D;
  wire [11:0] mem_3_0_0_Q;
  wire  mem_3_0_0_CEB;
  wire  mem_3_0_0_WEB;
  wire [11:0] mem_3_0_0_BWEB;
  wire [8:0] mem_3_0_1_A;
  wire  mem_3_0_1_CLK;
  wire [11:0] mem_3_0_1_D;
  wire [11:0] mem_3_0_1_Q;
  wire  mem_3_0_1_CEB;
  wire  mem_3_0_1_WEB;
  wire [11:0] mem_3_0_1_BWEB;
  wire [1:0] W0_addr_sel = W0_addr[10:9];
  wire [1:0] R0_addr_sel = R0_addr[10:9];
  reg [1:0] R0_addr_sel_reg;
  wire [7:0] R0_data_0_0_1 = mem_0_0_1_Q[7:0];
  wire [7:0] R0_data_0_1 = R0_data_0_0_1;
  wire [7:0] R0_data_1_0_1 = mem_1_0_1_Q[7:0];
  wire [7:0] R0_data_1_1 = R0_data_1_0_1;
  wire [7:0] R0_data_2_0_1 = mem_2_0_1_Q[7:0];
  wire [7:0] R0_data_2_1 = R0_data_2_0_1;
  wire [7:0] R0_data_3_0_1 = mem_3_0_1_Q[7:0];
  wire [7:0] R0_data_3_1 = R0_data_3_0_1;
  wire  _GEN_0 = W0_addr_sel == 2'h0;
  wire  _GEN_1 = W0_addr_sel == 2'h0;
  wire  _GEN_2 = W0_en & W0_addr_sel == 2'h0;
  wire  _GEN_3 = W0_mask[0];
  wire  _GEN_4 = W0_mask[0];
  wire  _GEN_5 = W0_mask[1];
  wire [1:0] _GEN_6 = {W0_mask[0],W0_mask[0]};
  wire  _GEN_7 = W0_mask[1];
  wire [2:0] _GEN_8 = {W0_mask[1],W0_mask[0],W0_mask[0]};
  wire  _GEN_9 = W0_mask[2];
  wire [3:0] _GEN_10 = {W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0]};
  wire  _GEN_11 = W0_mask[2];
  wire [4:0] _GEN_12 = {W0_mask[2],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0]};
  wire  _GEN_13 = W0_mask[3];
  wire [5:0] _GEN_14 = {W0_mask[2],W0_mask[2],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0]};
  wire  _GEN_15 = W0_mask[3];
  wire [6:0] _GEN_16 = {W0_mask[3],W0_mask[2],W0_mask[2],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0]};
  wire [7:0] _GEN_17 = {W0_mask[3],W0_mask[3],W0_mask[2],W0_mask[2],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0]};
  wire [8:0] _GEN_18 = {1'h0,W0_mask[3],W0_mask[3],W0_mask[2],W0_mask[2],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0]};
  wire [9:0] _GEN_19 = {1'h0,1'h0,W0_mask[3],W0_mask[3],W0_mask[2],W0_mask[2],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0
    ]};
  wire [10:0] _GEN_20 = {1'h0,_GEN_19};
  wire [11:0] _GEN_21 = {1'h0,1'h0,_GEN_19};
  wire  _GEN_22 = R0_addr_sel == 2'h0;
  wire  _GEN_23 = W0_addr_sel == 2'h1;
  wire  _GEN_24 = W0_addr_sel == 2'h1;
  wire  _GEN_25 = W0_en & W0_addr_sel == 2'h1;
  wire  _GEN_26 = W0_mask[0];
  wire  _GEN_27 = W0_mask[0];
  wire  _GEN_28 = W0_mask[1];
  wire [1:0] _GEN_29 = {W0_mask[0],W0_mask[0]};
  wire  _GEN_30 = W0_mask[1];
  wire [2:0] _GEN_31 = {W0_mask[1],W0_mask[0],W0_mask[0]};
  wire  _GEN_32 = W0_mask[2];
  wire [3:0] _GEN_33 = {W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0]};
  wire  _GEN_34 = W0_mask[2];
  wire [4:0] _GEN_35 = {W0_mask[2],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0]};
  wire  _GEN_36 = W0_mask[3];
  wire [5:0] _GEN_37 = {W0_mask[2],W0_mask[2],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0]};
  wire  _GEN_38 = W0_mask[3];
  wire [6:0] _GEN_39 = {W0_mask[3],W0_mask[2],W0_mask[2],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0]};
  wire [7:0] _GEN_40 = {W0_mask[3],W0_mask[3],W0_mask[2],W0_mask[2],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0]};
  wire [8:0] _GEN_41 = {1'h0,W0_mask[3],W0_mask[3],W0_mask[2],W0_mask[2],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0]};
  wire [9:0] _GEN_42 = {1'h0,1'h0,W0_mask[3],W0_mask[3],W0_mask[2],W0_mask[2],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0
    ]};
  wire [10:0] _GEN_43 = {1'h0,_GEN_19};
  wire [11:0] _GEN_44 = {1'h0,1'h0,_GEN_19};
  wire  _GEN_45 = R0_addr_sel == 2'h1;
  wire  _GEN_46 = W0_addr_sel == 2'h2;
  wire  _GEN_47 = W0_addr_sel == 2'h2;
  wire  _GEN_48 = W0_en & W0_addr_sel == 2'h2;
  wire  _GEN_49 = W0_mask[0];
  wire  _GEN_50 = W0_mask[0];
  wire  _GEN_51 = W0_mask[1];
  wire [1:0] _GEN_52 = {W0_mask[0],W0_mask[0]};
  wire  _GEN_53 = W0_mask[1];
  wire [2:0] _GEN_54 = {W0_mask[1],W0_mask[0],W0_mask[0]};
  wire  _GEN_55 = W0_mask[2];
  wire [3:0] _GEN_56 = {W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0]};
  wire  _GEN_57 = W0_mask[2];
  wire [4:0] _GEN_58 = {W0_mask[2],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0]};
  wire  _GEN_59 = W0_mask[3];
  wire [5:0] _GEN_60 = {W0_mask[2],W0_mask[2],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0]};
  wire  _GEN_61 = W0_mask[3];
  wire [6:0] _GEN_62 = {W0_mask[3],W0_mask[2],W0_mask[2],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0]};
  wire [7:0] _GEN_63 = {W0_mask[3],W0_mask[3],W0_mask[2],W0_mask[2],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0]};
  wire [8:0] _GEN_64 = {1'h0,W0_mask[3],W0_mask[3],W0_mask[2],W0_mask[2],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0]};
  wire [9:0] _GEN_65 = {1'h0,1'h0,W0_mask[3],W0_mask[3],W0_mask[2],W0_mask[2],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0
    ]};
  wire [10:0] _GEN_66 = {1'h0,_GEN_19};
  wire [11:0] _GEN_67 = {1'h0,1'h0,_GEN_19};
  wire  _GEN_68 = R0_addr_sel == 2'h2;
  wire  _GEN_69 = W0_addr_sel == 2'h3;
  wire  _GEN_70 = W0_addr_sel == 2'h3;
  wire  _GEN_71 = W0_en & W0_addr_sel == 2'h3;
  wire  _GEN_72 = W0_mask[0];
  wire  _GEN_73 = W0_mask[0];
  wire  _GEN_74 = W0_mask[1];
  wire [1:0] _GEN_75 = {W0_mask[0],W0_mask[0]};
  wire  _GEN_76 = W0_mask[1];
  wire [2:0] _GEN_77 = {W0_mask[1],W0_mask[0],W0_mask[0]};
  wire  _GEN_78 = W0_mask[2];
  wire [3:0] _GEN_79 = {W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0]};
  wire  _GEN_80 = W0_mask[2];
  wire [4:0] _GEN_81 = {W0_mask[2],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0]};
  wire  _GEN_82 = W0_mask[3];
  wire [5:0] _GEN_83 = {W0_mask[2],W0_mask[2],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0]};
  wire  _GEN_84 = W0_mask[3];
  wire [6:0] _GEN_85 = {W0_mask[3],W0_mask[2],W0_mask[2],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0]};
  wire [7:0] _GEN_86 = {W0_mask[3],W0_mask[3],W0_mask[2],W0_mask[2],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0]};
  wire [8:0] _GEN_87 = {1'h0,W0_mask[3],W0_mask[3],W0_mask[2],W0_mask[2],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0]};
  wire [9:0] _GEN_88 = {1'h0,1'h0,W0_mask[3],W0_mask[3],W0_mask[2],W0_mask[2],W0_mask[1],W0_mask[1],W0_mask[0],W0_mask[0
    ]};
  wire [10:0] _GEN_89 = {1'h0,_GEN_19};
  wire [11:0] _GEN_90 = {1'h0,1'h0,_GEN_19};
  wire  _GEN_91 = R0_addr_sel == 2'h3;
  TS1N28HPCPUHDHVTB512X12M4SWBSO mem_0_0_0 (
    .A(mem_0_0_0_A),
    .CLK(mem_0_0_0_CLK),
    .D(mem_0_0_0_D),
    .Q(mem_0_0_0_Q),
    .CEB(mem_0_0_0_CEB),
    .WEB(mem_0_0_0_WEB),
    .BWEB(mem_0_0_0_BWEB)
  );
  TS1N28HPCPUHDHVTB512X12M4SWBSO mem_0_0_1 (
    .A(mem_0_0_1_A),
    .CLK(mem_0_0_1_CLK),
    .D(mem_0_0_1_D),
    .Q(mem_0_0_1_Q),
    .CEB(mem_0_0_1_CEB),
    .WEB(mem_0_0_1_WEB),
    .BWEB(mem_0_0_1_BWEB)
  );
  TS1N28HPCPUHDHVTB512X12M4SWBSO mem_1_0_0 (
    .A(mem_1_0_0_A),
    .CLK(mem_1_0_0_CLK),
    .D(mem_1_0_0_D),
    .Q(mem_1_0_0_Q),
    .CEB(mem_1_0_0_CEB),
    .WEB(mem_1_0_0_WEB),
    .BWEB(mem_1_0_0_BWEB)
  );
  TS1N28HPCPUHDHVTB512X12M4SWBSO mem_1_0_1 (
    .A(mem_1_0_1_A),
    .CLK(mem_1_0_1_CLK),
    .D(mem_1_0_1_D),
    .Q(mem_1_0_1_Q),
    .CEB(mem_1_0_1_CEB),
    .WEB(mem_1_0_1_WEB),
    .BWEB(mem_1_0_1_BWEB)
  );
  TS1N28HPCPUHDHVTB512X12M4SWBSO mem_2_0_0 (
    .A(mem_2_0_0_A),
    .CLK(mem_2_0_0_CLK),
    .D(mem_2_0_0_D),
    .Q(mem_2_0_0_Q),
    .CEB(mem_2_0_0_CEB),
    .WEB(mem_2_0_0_WEB),
    .BWEB(mem_2_0_0_BWEB)
  );
  TS1N28HPCPUHDHVTB512X12M4SWBSO mem_2_0_1 (
    .A(mem_2_0_1_A),
    .CLK(mem_2_0_1_CLK),
    .D(mem_2_0_1_D),
    .Q(mem_2_0_1_Q),
    .CEB(mem_2_0_1_CEB),
    .WEB(mem_2_0_1_WEB),
    .BWEB(mem_2_0_1_BWEB)
  );
  TS1N28HPCPUHDHVTB512X12M4SWBSO mem_3_0_0 (
    .A(mem_3_0_0_A),
    .CLK(mem_3_0_0_CLK),
    .D(mem_3_0_0_D),
    .Q(mem_3_0_0_Q),
    .CEB(mem_3_0_0_CEB),
    .WEB(mem_3_0_0_WEB),
    .BWEB(mem_3_0_0_BWEB)
  );
  TS1N28HPCPUHDHVTB512X12M4SWBSO mem_3_0_1 (
    .A(mem_3_0_1_A),
    .CLK(mem_3_0_1_CLK),
    .D(mem_3_0_1_D),
    .Q(mem_3_0_1_Q),
    .CEB(mem_3_0_1_CEB),
    .WEB(mem_3_0_1_WEB),
    .BWEB(mem_3_0_1_BWEB)
  );
  assign R0_data = R0_addr_sel_reg == 2'h0 ? R0_data_0_0_1 : R0_addr_sel_reg == 2'h1 ? R0_data_1_0_1 : R0_addr_sel_reg
     == 2'h2 ? R0_data_2_0_1 : R0_addr_sel_reg == 2'h3 ? R0_data_3_0_1 : 8'h0;
  assign mem_0_0_0_A = W0_addr[8:0];
  assign mem_0_0_0_CLK = W0_clk;
  assign mem_0_0_0_D = {{4'd0}, W0_data};
  assign mem_0_0_0_CEB = ~(W0_addr_sel == 2'h0);
  assign mem_0_0_0_WEB = ~(W0_en & W0_addr_sel == 2'h0);
  assign mem_0_0_0_BWEB = ~_GEN_21;
  assign mem_0_0_1_A = R0_addr[8:0];
  assign mem_0_0_1_CLK = R0_clk;
  assign mem_0_0_1_D = 12'h0;
  assign mem_0_0_1_CEB = ~(R0_addr_sel == 2'h0);
  assign mem_0_0_1_WEB = 1'h1;
  assign mem_0_0_1_BWEB = 12'h0;
  assign mem_1_0_0_A = W0_addr[8:0];
  assign mem_1_0_0_CLK = W0_clk;
  assign mem_1_0_0_D = {{4'd0}, W0_data};
  assign mem_1_0_0_CEB = ~(W0_addr_sel == 2'h1);
  assign mem_1_0_0_WEB = ~(W0_en & W0_addr_sel == 2'h1);
  assign mem_1_0_0_BWEB = ~_GEN_21;
  assign mem_1_0_1_A = R0_addr[8:0];
  assign mem_1_0_1_CLK = R0_clk;
  assign mem_1_0_1_D = 12'h0;
  assign mem_1_0_1_CEB = ~(R0_addr_sel == 2'h1);
  assign mem_1_0_1_WEB = 1'h1;
  assign mem_1_0_1_BWEB = 12'h0;
  assign mem_2_0_0_A = W0_addr[8:0];
  assign mem_2_0_0_CLK = W0_clk;
  assign mem_2_0_0_D = {{4'd0}, W0_data};
  assign mem_2_0_0_CEB = ~(W0_addr_sel == 2'h2);
  assign mem_2_0_0_WEB = ~(W0_en & W0_addr_sel == 2'h2);
  assign mem_2_0_0_BWEB = ~_GEN_21;
  assign mem_2_0_1_A = R0_addr[8:0];
  assign mem_2_0_1_CLK = R0_clk;
  assign mem_2_0_1_D = 12'h0;
  assign mem_2_0_1_CEB = ~(R0_addr_sel == 2'h2);
  assign mem_2_0_1_WEB = 1'h1;
  assign mem_2_0_1_BWEB = 12'h0;
  assign mem_3_0_0_A = W0_addr[8:0];
  assign mem_3_0_0_CLK = W0_clk;
  assign mem_3_0_0_D = {{4'd0}, W0_data};
  assign mem_3_0_0_CEB = ~(W0_addr_sel == 2'h3);
  assign mem_3_0_0_WEB = ~(W0_en & W0_addr_sel == 2'h3);
  assign mem_3_0_0_BWEB = ~_GEN_21;
  assign mem_3_0_1_A = R0_addr[8:0];
  assign mem_3_0_1_CLK = R0_clk;
  assign mem_3_0_1_D = 12'h0;
  assign mem_3_0_1_CEB = ~(R0_addr_sel == 2'h3);
  assign mem_3_0_1_WEB = 1'h1;
  assign mem_3_0_1_BWEB = 12'h0;
  always @(posedge R0_clk) begin
    if (R0_en) begin
      R0_addr_sel_reg <= R0_addr_sel;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  R0_addr_sel_reg = _RAND_0[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module meta_0_0_ext(
  input  [3:0]   W0_addr,
  input          W0_clk,
  input  [119:0] W0_data,
  input          W0_en,
  input  [3:0]   R0_addr,
  input          R0_clk,
  output [119:0] R0_data,
  input          R0_en
);
  wire [4:0] mem_0_0_0_AA;
  wire  mem_0_0_0_CLK;
  wire [32:0] mem_0_0_0_DA;
  wire [32:0] mem_0_0_0_QA;
  wire  mem_0_0_0_CEBA;
  wire  mem_0_0_0_WEBA;
  wire [32:0] mem_0_0_0_BWEBA;
  wire [4:0] mem_0_0_0_AB;
  wire [32:0] mem_0_0_0_DB;
  wire [32:0] mem_0_0_0_QB;
  wire  mem_0_0_0_CEBB;
  wire  mem_0_0_0_WEBB;
  wire [32:0] mem_0_0_0_BWEBB;
  wire [4:0] mem_0_1_0_AA;
  wire  mem_0_1_0_CLK;
  wire [32:0] mem_0_1_0_DA;
  wire [32:0] mem_0_1_0_QA;
  wire  mem_0_1_0_CEBA;
  wire  mem_0_1_0_WEBA;
  wire [32:0] mem_0_1_0_BWEBA;
  wire [4:0] mem_0_1_0_AB;
  wire [32:0] mem_0_1_0_DB;
  wire [32:0] mem_0_1_0_QB;
  wire  mem_0_1_0_CEBB;
  wire  mem_0_1_0_WEBB;
  wire [32:0] mem_0_1_0_BWEBB;
  wire [4:0] mem_0_2_0_AA;
  wire  mem_0_2_0_CLK;
  wire [32:0] mem_0_2_0_DA;
  wire [32:0] mem_0_2_0_QA;
  wire  mem_0_2_0_CEBA;
  wire  mem_0_2_0_WEBA;
  wire [32:0] mem_0_2_0_BWEBA;
  wire [4:0] mem_0_2_0_AB;
  wire [32:0] mem_0_2_0_DB;
  wire [32:0] mem_0_2_0_QB;
  wire  mem_0_2_0_CEBB;
  wire  mem_0_2_0_WEBB;
  wire [32:0] mem_0_2_0_BWEBB;
  wire [4:0] mem_0_3_0_AA;
  wire  mem_0_3_0_CLK;
  wire [32:0] mem_0_3_0_DA;
  wire [32:0] mem_0_3_0_QA;
  wire  mem_0_3_0_CEBA;
  wire  mem_0_3_0_WEBA;
  wire [32:0] mem_0_3_0_BWEBA;
  wire [4:0] mem_0_3_0_AB;
  wire [32:0] mem_0_3_0_DB;
  wire [32:0] mem_0_3_0_QB;
  wire  mem_0_3_0_CEBB;
  wire  mem_0_3_0_WEBB;
  wire [32:0] mem_0_3_0_BWEBB;
  wire [32:0] R0_data_0_0_0 = mem_0_0_0_QB;
  wire [32:0] R0_data_0_1_0 = mem_0_1_0_QB;
  wire [32:0] R0_data_0_2_0 = mem_0_2_0_QB;
  wire [20:0] R0_data_0_3_0 = mem_0_3_0_QB[20:0];
  wire [65:0] _GEN_0 = {R0_data_0_1_0,R0_data_0_0_0};
  wire [98:0] _GEN_1 = {R0_data_0_2_0,R0_data_0_1_0,R0_data_0_0_0};
  wire [119:0] R0_data_0_0 = {R0_data_0_3_0,R0_data_0_2_0,R0_data_0_1_0,R0_data_0_0_0};
  wire [65:0] _GEN_2 = {R0_data_0_1_0,R0_data_0_0_0};
  wire [98:0] _GEN_3 = {R0_data_0_2_0,R0_data_0_1_0,R0_data_0_0_0};
  wire [20:0] _GEN_4 = W0_data[119:99];
  TSDN28HPCPUHDB32X33M4MWA mem_0_0_0 (
    .AA(mem_0_0_0_AA),
    .CLK(mem_0_0_0_CLK),
    .DA(mem_0_0_0_DA),
    .QA(mem_0_0_0_QA),
    .CEBA(mem_0_0_0_CEBA),
    .WEBA(mem_0_0_0_WEBA),
    .BWEBA(mem_0_0_0_BWEBA),
    .AB(mem_0_0_0_AB),
    .DB(mem_0_0_0_DB),
    .QB(mem_0_0_0_QB),
    .CEBB(mem_0_0_0_CEBB),
    .WEBB(mem_0_0_0_WEBB),
    .BWEBB(mem_0_0_0_BWEBB)
  );
  TSDN28HPCPUHDB32X33M4MWA mem_0_1_0 (
    .AA(mem_0_1_0_AA),
    .CLK(mem_0_1_0_CLK),
    .DA(mem_0_1_0_DA),
    .QA(mem_0_1_0_QA),
    .CEBA(mem_0_1_0_CEBA),
    .WEBA(mem_0_1_0_WEBA),
    .BWEBA(mem_0_1_0_BWEBA),
    .AB(mem_0_1_0_AB),
    .DB(mem_0_1_0_DB),
    .QB(mem_0_1_0_QB),
    .CEBB(mem_0_1_0_CEBB),
    .WEBB(mem_0_1_0_WEBB),
    .BWEBB(mem_0_1_0_BWEBB)
  );
  TSDN28HPCPUHDB32X33M4MWA mem_0_2_0 (
    .AA(mem_0_2_0_AA),
    .CLK(mem_0_2_0_CLK),
    .DA(mem_0_2_0_DA),
    .QA(mem_0_2_0_QA),
    .CEBA(mem_0_2_0_CEBA),
    .WEBA(mem_0_2_0_WEBA),
    .BWEBA(mem_0_2_0_BWEBA),
    .AB(mem_0_2_0_AB),
    .DB(mem_0_2_0_DB),
    .QB(mem_0_2_0_QB),
    .CEBB(mem_0_2_0_CEBB),
    .WEBB(mem_0_2_0_WEBB),
    .BWEBB(mem_0_2_0_BWEBB)
  );
  TSDN28HPCPUHDB32X33M4MWA mem_0_3_0 (
    .AA(mem_0_3_0_AA),
    .CLK(mem_0_3_0_CLK),
    .DA(mem_0_3_0_DA),
    .QA(mem_0_3_0_QA),
    .CEBA(mem_0_3_0_CEBA),
    .WEBA(mem_0_3_0_WEBA),
    .BWEBA(mem_0_3_0_BWEBA),
    .AB(mem_0_3_0_AB),
    .DB(mem_0_3_0_DB),
    .QB(mem_0_3_0_QB),
    .CEBB(mem_0_3_0_CEBB),
    .WEBB(mem_0_3_0_WEBB),
    .BWEBB(mem_0_3_0_BWEBB)
  );
  assign R0_data = {R0_data_0_3_0,_GEN_1};
  assign mem_0_0_0_AA = {{1'd0}, W0_addr};
  assign mem_0_0_0_CLK = R0_clk;
  assign mem_0_0_0_DA = W0_data[32:0];
  assign mem_0_0_0_CEBA = 1'h0;
  assign mem_0_0_0_WEBA = ~W0_en;
  assign mem_0_0_0_BWEBA = 33'h0;
  assign mem_0_0_0_AB = {{1'd0}, R0_addr};
  assign mem_0_0_0_DB = 33'h0;
  assign mem_0_0_0_CEBB = 1'h0;
  assign mem_0_0_0_WEBB = 1'h1;
  assign mem_0_0_0_BWEBB = 33'h0;
  assign mem_0_1_0_AA = {{1'd0}, W0_addr};
  assign mem_0_1_0_CLK = R0_clk;
  assign mem_0_1_0_DA = W0_data[65:33];
  assign mem_0_1_0_CEBA = 1'h0;
  assign mem_0_1_0_WEBA = ~W0_en;
  assign mem_0_1_0_BWEBA = 33'h0;
  assign mem_0_1_0_AB = {{1'd0}, R0_addr};
  assign mem_0_1_0_DB = 33'h0;
  assign mem_0_1_0_CEBB = 1'h0;
  assign mem_0_1_0_WEBB = 1'h1;
  assign mem_0_1_0_BWEBB = 33'h0;
  assign mem_0_2_0_AA = {{1'd0}, W0_addr};
  assign mem_0_2_0_CLK = R0_clk;
  assign mem_0_2_0_DA = W0_data[98:66];
  assign mem_0_2_0_CEBA = 1'h0;
  assign mem_0_2_0_WEBA = ~W0_en;
  assign mem_0_2_0_BWEBA = 33'h0;
  assign mem_0_2_0_AB = {{1'd0}, R0_addr};
  assign mem_0_2_0_DB = 33'h0;
  assign mem_0_2_0_CEBB = 1'h0;
  assign mem_0_2_0_WEBB = 1'h1;
  assign mem_0_2_0_BWEBB = 33'h0;
  assign mem_0_3_0_AA = {{1'd0}, W0_addr};
  assign mem_0_3_0_CLK = R0_clk;
  assign mem_0_3_0_DA = {{12'd0}, W0_data[119:99]};
  assign mem_0_3_0_CEBA = 1'h0;
  assign mem_0_3_0_WEBA = ~W0_en;
  assign mem_0_3_0_BWEBA = 33'h0;
  assign mem_0_3_0_AB = {{1'd0}, R0_addr};
  assign mem_0_3_0_DB = 33'h0;
  assign mem_0_3_0_CEBB = 1'h0;
  assign mem_0_3_0_WEBB = 1'h1;
  assign mem_0_3_0_BWEBB = 33'h0;
endmodule
module ghist_0_ext(
  input  [3:0]  W0_addr,
  input         W0_clk,
  input  [71:0] W0_data,
  input         W0_en,
  input  [3:0]  R0_addr,
  input         R0_clk,
  output [71:0] R0_data,
  input         R0_en
);
  wire [4:0] mem_0_0_0_AA;
  wire  mem_0_0_0_CLK;
  wire [38:0] mem_0_0_0_DA;
  wire [38:0] mem_0_0_0_QA;
  wire  mem_0_0_0_CEBA;
  wire  mem_0_0_0_WEBA;
  wire [38:0] mem_0_0_0_BWEBA;
  wire [4:0] mem_0_0_0_AB;
  wire [38:0] mem_0_0_0_DB;
  wire [38:0] mem_0_0_0_QB;
  wire  mem_0_0_0_CEBB;
  wire  mem_0_0_0_WEBB;
  wire [38:0] mem_0_0_0_BWEBB;
  wire [4:0] mem_0_1_0_AA;
  wire  mem_0_1_0_CLK;
  wire [38:0] mem_0_1_0_DA;
  wire [38:0] mem_0_1_0_QA;
  wire  mem_0_1_0_CEBA;
  wire  mem_0_1_0_WEBA;
  wire [38:0] mem_0_1_0_BWEBA;
  wire [4:0] mem_0_1_0_AB;
  wire [38:0] mem_0_1_0_DB;
  wire [38:0] mem_0_1_0_QB;
  wire  mem_0_1_0_CEBB;
  wire  mem_0_1_0_WEBB;
  wire [38:0] mem_0_1_0_BWEBB;
  wire [38:0] R0_data_0_0_0 = mem_0_0_0_QB;
  wire [32:0] R0_data_0_1_0 = mem_0_1_0_QB[32:0];
  wire [71:0] R0_data_0_0 = {R0_data_0_1_0,R0_data_0_0_0};
  wire [32:0] _GEN_0 = W0_data[71:39];
  TSDN28HPCPUHDB32X39M4MWA mem_0_0_0 (
    .AA(mem_0_0_0_AA),
    .CLK(mem_0_0_0_CLK),
    .DA(mem_0_0_0_DA),
    .QA(mem_0_0_0_QA),
    .CEBA(mem_0_0_0_CEBA),
    .WEBA(mem_0_0_0_WEBA),
    .BWEBA(mem_0_0_0_BWEBA),
    .AB(mem_0_0_0_AB),
    .DB(mem_0_0_0_DB),
    .QB(mem_0_0_0_QB),
    .CEBB(mem_0_0_0_CEBB),
    .WEBB(mem_0_0_0_WEBB),
    .BWEBB(mem_0_0_0_BWEBB)
  );
  TSDN28HPCPUHDB32X39M4MWA mem_0_1_0 (
    .AA(mem_0_1_0_AA),
    .CLK(mem_0_1_0_CLK),
    .DA(mem_0_1_0_DA),
    .QA(mem_0_1_0_QA),
    .CEBA(mem_0_1_0_CEBA),
    .WEBA(mem_0_1_0_WEBA),
    .BWEBA(mem_0_1_0_BWEBA),
    .AB(mem_0_1_0_AB),
    .DB(mem_0_1_0_DB),
    .QB(mem_0_1_0_QB),
    .CEBB(mem_0_1_0_CEBB),
    .WEBB(mem_0_1_0_WEBB),
    .BWEBB(mem_0_1_0_BWEBB)
  );
  assign R0_data = {R0_data_0_1_0,R0_data_0_0_0};
  assign mem_0_0_0_AA = {{1'd0}, W0_addr};
  assign mem_0_0_0_CLK = R0_clk;
  assign mem_0_0_0_DA = W0_data[38:0];
  assign mem_0_0_0_CEBA = 1'h0;
  assign mem_0_0_0_WEBA = ~W0_en;
  assign mem_0_0_0_BWEBA = 39'h0;
  assign mem_0_0_0_AB = {{1'd0}, R0_addr};
  assign mem_0_0_0_DB = 39'h0;
  assign mem_0_0_0_CEBB = 1'h0;
  assign mem_0_0_0_WEBB = 1'h1;
  assign mem_0_0_0_BWEBB = 39'h0;
  assign mem_0_1_0_AA = {{1'd0}, W0_addr};
  assign mem_0_1_0_CLK = R0_clk;
  assign mem_0_1_0_DA = {{6'd0}, W0_data[71:39]};
  assign mem_0_1_0_CEBA = 1'h0;
  assign mem_0_1_0_WEBA = ~W0_en;
  assign mem_0_1_0_BWEBA = 39'h0;
  assign mem_0_1_0_AB = {{1'd0}, R0_addr};
  assign mem_0_1_0_DB = 39'h0;
  assign mem_0_1_0_CEBB = 1'h0;
  assign mem_0_1_0_WEBB = 1'h1;
  assign mem_0_1_0_BWEBB = 39'h0;
endmodule
module rob_debug_inst_mem_0_ext(
  input  [4:0]  W0_addr,
  input         W0_clk,
  input  [31:0] W0_data,
  input         W0_en,
  input  [4:0]  R0_addr,
  input         R0_clk,
  output [31:0] R0_data,
  input         R0_en
);
  wire [4:0] mem_0_0_0_AA;
  wire  mem_0_0_0_CLK;
  wire [32:0] mem_0_0_0_DA;
  wire [32:0] mem_0_0_0_QA;
  wire  mem_0_0_0_CEBA;
  wire  mem_0_0_0_WEBA;
  wire [32:0] mem_0_0_0_BWEBA;
  wire [4:0] mem_0_0_0_AB;
  wire [32:0] mem_0_0_0_DB;
  wire [32:0] mem_0_0_0_QB;
  wire  mem_0_0_0_CEBB;
  wire  mem_0_0_0_WEBB;
  wire [32:0] mem_0_0_0_BWEBB;
  wire [31:0] R0_data_0_0_0 = mem_0_0_0_QB[31:0];
  wire [31:0] R0_data_0_0 = R0_data_0_0_0;
  TSDN28HPCPUHDB32X33M4MWA mem_0_0_0 (
    .AA(mem_0_0_0_AA),
    .CLK(mem_0_0_0_CLK),
    .DA(mem_0_0_0_DA),
    .QA(mem_0_0_0_QA),
    .CEBA(mem_0_0_0_CEBA),
    .WEBA(mem_0_0_0_WEBA),
    .BWEBA(mem_0_0_0_BWEBA),
    .AB(mem_0_0_0_AB),
    .DB(mem_0_0_0_DB),
    .QB(mem_0_0_0_QB),
    .CEBB(mem_0_0_0_CEBB),
    .WEBB(mem_0_0_0_WEBB),
    .BWEBB(mem_0_0_0_BWEBB)
  );
  assign R0_data = mem_0_0_0_QB[31:0];
  assign mem_0_0_0_AA = W0_addr;
  assign mem_0_0_0_CLK = R0_clk;
  assign mem_0_0_0_DA = {{1'd0}, W0_data};
  assign mem_0_0_0_CEBA = 1'h0;
  assign mem_0_0_0_WEBA = ~W0_en;
  assign mem_0_0_0_BWEBA = 33'h0;
  assign mem_0_0_0_AB = R0_addr;
  assign mem_0_0_0_DB = 33'h0;
  assign mem_0_0_0_CEBB = 1'h0;
  assign mem_0_0_0_WEBB = 1'h1;
  assign mem_0_0_0_BWEBB = 33'h0;
endmodule
module l2_tlb_ram_0_ext(
  input  [8:0]  RW0_addr,
  input         RW0_clk,
  input  [44:0] RW0_wdata,
  output [44:0] RW0_rdata,
  input         RW0_en,
  input         RW0_wmode
);
  wire [8:0] mem_0_0_0_A;
  wire  mem_0_0_0_CLK;
  wire [22:0] mem_0_0_0_D;
  wire [22:0] mem_0_0_0_Q;
  wire  mem_0_0_0_CEB;
  wire  mem_0_0_0_WEB;
  wire [22:0] mem_0_0_0_BWEB;
  wire [8:0] mem_0_1_0_A;
  wire  mem_0_1_0_CLK;
  wire [22:0] mem_0_1_0_D;
  wire [22:0] mem_0_1_0_Q;
  wire  mem_0_1_0_CEB;
  wire  mem_0_1_0_WEB;
  wire [22:0] mem_0_1_0_BWEB;
  wire [22:0] RW0_rdata_0_0_0 = mem_0_0_0_Q;
  wire [21:0] RW0_rdata_0_1_0 = mem_0_1_0_Q[21:0];
  wire [44:0] RW0_rdata_0_0 = {RW0_rdata_0_1_0,RW0_rdata_0_0_0};
  wire [21:0] _GEN_0 = RW0_wdata[44:23];
  TS1N28HPCPUHDHVTB512X23M4SWBSO mem_0_0_0 (
    .A(mem_0_0_0_A),
    .CLK(mem_0_0_0_CLK),
    .D(mem_0_0_0_D),
    .Q(mem_0_0_0_Q),
    .CEB(mem_0_0_0_CEB),
    .WEB(mem_0_0_0_WEB),
    .BWEB(mem_0_0_0_BWEB)
  );
  TS1N28HPCPUHDHVTB512X23M4SWBSO mem_0_1_0 (
    .A(mem_0_1_0_A),
    .CLK(mem_0_1_0_CLK),
    .D(mem_0_1_0_D),
    .Q(mem_0_1_0_Q),
    .CEB(mem_0_1_0_CEB),
    .WEB(mem_0_1_0_WEB),
    .BWEB(mem_0_1_0_BWEB)
  );
  assign RW0_rdata = {RW0_rdata_0_1_0,RW0_rdata_0_0_0};
  assign mem_0_0_0_A = RW0_addr;
  assign mem_0_0_0_CLK = RW0_clk;
  assign mem_0_0_0_D = RW0_wdata[22:0];
  assign mem_0_0_0_CEB = ~RW0_en;
  assign mem_0_0_0_WEB = ~RW0_wmode;
  assign mem_0_0_0_BWEB = 23'h0;
  assign mem_0_1_0_A = RW0_addr;
  assign mem_0_1_0_CLK = RW0_clk;
  assign mem_0_1_0_D = {{1'd0}, RW0_wdata[44:23]};
  assign mem_0_1_0_CEB = ~RW0_en;
  assign mem_0_1_0_WEB = ~RW0_wmode;
  assign mem_0_1_0_BWEB = 23'h0;
endmodule
