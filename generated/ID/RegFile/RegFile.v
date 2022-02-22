module RegFile(
  input         clock,
  input         reset,
  input         io_inFromID_r1REn,
  input         io_inFromID_r2REn,
  input  [4:0]  io_inFromID_r1RAddr,
  input  [4:0]  io_inFromID_r2RAddr,
  input         io_inFromWB_rWEn,
  input  [31:0] io_inFromWB_rWAddr,
  input  [31:0] io_inFromWB_rWData,
  output [31:0] io_outToID_r1RData,
  output [31:0] io_outToID_r2RData
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [31:0] regBank [0:31]; // @[RF.scala 16:22]
  wire  regBank_io_outToID_r1RData_MPORT_en; // @[RF.scala 16:22]
  wire [4:0] regBank_io_outToID_r1RData_MPORT_addr; // @[RF.scala 16:22]
  wire [31:0] regBank_io_outToID_r1RData_MPORT_data; // @[RF.scala 16:22]
  wire  regBank_io_outToID_r2RData_MPORT_en; // @[RF.scala 16:22]
  wire [4:0] regBank_io_outToID_r2RData_MPORT_addr; // @[RF.scala 16:22]
  wire [31:0] regBank_io_outToID_r2RData_MPORT_data; // @[RF.scala 16:22]
  wire [31:0] regBank_MPORT_data; // @[RF.scala 16:22]
  wire [4:0] regBank_MPORT_addr; // @[RF.scala 16:22]
  wire  regBank_MPORT_mask; // @[RF.scala 16:22]
  wire  regBank_MPORT_en; // @[RF.scala 16:22]
  wire  _T = io_inFromWB_rWAddr != 32'h0; // @[RF.scala 19:50]
  wire  _T_3 = io_inFromID_r1RAddr == 5'h0; // @[RF.scala 24:30]
  wire [31:0] _GEN_29 = {{27'd0}, io_inFromID_r1RAddr}; // @[RF.scala 26:37]
  wire  _T_4 = _GEN_29 == io_inFromWB_rWAddr; // @[RF.scala 26:37]
  wire  _T_6 = _T_4 & io_inFromID_r1REn; // @[RF.scala 27:13]
  wire [31:0] _GEN_8 = io_inFromID_r1REn ? regBank_io_outToID_r1RData_MPORT_data : 32'h0; // @[RF.scala 30:48 31:28 33:28]
  wire [31:0] _GEN_9 = _T_6 & io_inFromWB_rWEn ? io_inFromWB_rWData : _GEN_8; // @[RF.scala 28:47 29:28]
  wire  _GEN_12 = _T_6 & io_inFromWB_rWEn ? 1'h0 : io_inFromID_r1REn; // @[RF.scala 16:22 28:47]
  wire  _T_10 = io_inFromID_r2RAddr == 5'h0; // @[RF.scala 37:30]
  wire [31:0] _GEN_30 = {{27'd0}, io_inFromID_r2RAddr}; // @[RF.scala 39:37]
  wire  _T_11 = _GEN_30 == io_inFromWB_rWAddr; // @[RF.scala 39:37]
  wire  _T_13 = _T_11 & io_inFromID_r2REn; // @[RF.scala 40:13]
  wire [31:0] _GEN_20 = io_inFromID_r2REn ? regBank_io_outToID_r2RData_MPORT_data : 32'h0; // @[RF.scala 43:46 44:28 46:28]
  wire [31:0] _GEN_21 = _T_13 & io_inFromWB_rWEn ? io_inFromWB_rWData : _GEN_20; // @[RF.scala 41:47 42:28]
  wire  _GEN_24 = _T_13 & io_inFromWB_rWEn ? 1'h0 : io_inFromID_r2REn; // @[RF.scala 16:22 41:47]
  assign regBank_io_outToID_r1RData_MPORT_en = _T_3 ? 1'h0 : _GEN_12;
  assign regBank_io_outToID_r1RData_MPORT_addr = io_inFromID_r1RAddr;
  assign regBank_io_outToID_r1RData_MPORT_data = regBank[regBank_io_outToID_r1RData_MPORT_addr]; // @[RF.scala 16:22]
  assign regBank_io_outToID_r2RData_MPORT_en = _T_10 ? 1'h0 : _GEN_24;
  assign regBank_io_outToID_r2RData_MPORT_addr = io_inFromID_r2RAddr;
  assign regBank_io_outToID_r2RData_MPORT_data = regBank[regBank_io_outToID_r2RData_MPORT_addr]; // @[RF.scala 16:22]
  assign regBank_MPORT_data = io_inFromWB_rWData;
  assign regBank_MPORT_addr = io_inFromWB_rWAddr[4:0];
  assign regBank_MPORT_mask = 1'h1;
  assign regBank_MPORT_en = io_inFromWB_rWEn & _T;
  assign io_outToID_r1RData = io_inFromID_r1RAddr == 5'h0 ? 32'h0 : _GEN_9; // @[RF.scala 24:39 25:28]
  assign io_outToID_r2RData = io_inFromID_r2RAddr == 5'h0 ? 32'h0 : _GEN_21; // @[RF.scala 37:39 38:28]
  always @(posedge clock) begin
    if (regBank_MPORT_en & regBank_MPORT_mask) begin
      regBank[regBank_MPORT_addr] <= regBank_MPORT_data; // @[RF.scala 16:22]
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
    regBank[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
