module RegFile(
  input         clock,
  input         reset,
  input         io_rWEn,
  input         io_r1REn,
  input         io_r2REn,
  input  [4:0]  io_rWAddr,
  input  [31:0] io_rWData,
  input  [4:0]  io_r1RAddr,
  output [31:0] io_r1RData,
  input  [4:0]  io_r2RAddr,
  output [31:0] io_r2RData
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [31:0] regs [0:31]; // @[RegFile.scala 23:19]
  wire  regs_io_r1RData_MPORT_en; // @[RegFile.scala 23:19]
  wire [4:0] regs_io_r1RData_MPORT_addr; // @[RegFile.scala 23:19]
  wire [31:0] regs_io_r1RData_MPORT_data; // @[RegFile.scala 23:19]
  wire  regs_io_r2RData_MPORT_en; // @[RegFile.scala 23:19]
  wire [4:0] regs_io_r2RData_MPORT_addr; // @[RegFile.scala 23:19]
  wire [31:0] regs_io_r2RData_MPORT_data; // @[RegFile.scala 23:19]
  wire [31:0] regs_MPORT_data; // @[RegFile.scala 23:19]
  wire [4:0] regs_MPORT_addr; // @[RegFile.scala 23:19]
  wire  regs_MPORT_mask; // @[RegFile.scala 23:19]
  wire  regs_MPORT_en; // @[RegFile.scala 23:19]
  wire  _T = io_rWAddr != 5'h0; // @[RegFile.scala 26:32]
  wire  _T_2 = io_r1RAddr == 5'h0; // @[RegFile.scala 31:21]
  wire  _T_3 = io_r1RAddr == io_rWAddr; // @[RegFile.scala 33:28]
  wire  _T_5 = _T_3 & io_r1REn; // @[RegFile.scala 34:13]
  wire [31:0] _GEN_8 = io_r1REn ? regs_io_r1RData_MPORT_data : 32'h0; // @[RegFile.scala 37:39 38:20 40:20]
  wire [31:0] _GEN_9 = _T_5 & io_rWEn ? io_rWData : _GEN_8; // @[RegFile.scala 35:38 36:20]
  wire  _GEN_12 = _T_5 & io_rWEn ? 1'h0 : io_r1REn; // @[RegFile.scala 23:19 35:38]
  wire  _T_9 = io_r2RAddr == 5'h0; // @[RegFile.scala 44:21]
  wire  _T_10 = io_r2RAddr == io_rWAddr; // @[RegFile.scala 46:28]
  wire  _T_12 = _T_10 & io_r2REn; // @[RegFile.scala 47:13]
  wire [31:0] _GEN_20 = io_r2REn ? regs_io_r2RData_MPORT_data : 32'h0; // @[RegFile.scala 50:37 51:20 53:20]
  wire [31:0] _GEN_21 = _T_12 & io_rWEn ? io_rWData : _GEN_20; // @[RegFile.scala 48:38 49:20]
  wire  _GEN_24 = _T_12 & io_rWEn ? 1'h0 : io_r2REn; // @[RegFile.scala 23:19 48:38]
  assign regs_io_r1RData_MPORT_en = _T_2 ? 1'h0 : _GEN_12;
  assign regs_io_r1RData_MPORT_addr = io_r1RAddr;
  assign regs_io_r1RData_MPORT_data = regs[regs_io_r1RData_MPORT_addr]; // @[RegFile.scala 23:19]
  assign regs_io_r2RData_MPORT_en = _T_9 ? 1'h0 : _GEN_24;
  assign regs_io_r2RData_MPORT_addr = io_r2RAddr;
  assign regs_io_r2RData_MPORT_data = regs[regs_io_r2RData_MPORT_addr]; // @[RegFile.scala 23:19]
  assign regs_MPORT_data = io_rWData;
  assign regs_MPORT_addr = io_rWAddr;
  assign regs_MPORT_mask = 1'h1;
  assign regs_MPORT_en = io_rWEn & _T;
  assign io_r1RData = io_r1RAddr == 5'h0 ? 32'h0 : _GEN_9; // @[RegFile.scala 31:30 32:20]
  assign io_r2RData = io_r2RAddr == 5'h0 ? 32'h0 : _GEN_21; // @[RegFile.scala 44:30 45:20]
  always @(posedge clock) begin
    if (regs_MPORT_en & regs_MPORT_mask) begin
      regs[regs_MPORT_addr] <= regs_MPORT_data; // @[RegFile.scala 23:19]
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 32; initvar = initvar+1)
    regs[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
