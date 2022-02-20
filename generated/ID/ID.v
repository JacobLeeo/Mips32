module ID(
  input         clock,
  input         reset,
  input  [31:0] io_instData,
  input  [31:0] io_r1RData,
  input  [31:0] io_r2RData,
  output        io_r1REn,
  output        io_r2REn,
  output [4:0]  io_r1RAddr,
  output [4:0]  io_r2RAddr,
  output [7:0]  io_iKind,
  output [2:0]  io_iSKind,
  output [31:0] io_source1,
  output [31:0] io_source2,
  output [4:0]  io_rWAddr,
  output        io_rWEn
);
  wire [5:0] op = io_instData[31:26]; // @[ID.scala 34:22]
  wire  _T = 6'hd == op; // @[ID.scala 45:16]
  wire [5:0] _GEN_1 = 6'hd == op ? 6'h25 : 6'h0; // @[ID.scala 40:14 45:16 48:22]
  wire [31:0] imm = 6'hd == op ? {{16'd0}, io_instData[15:0]} : 32'h0; // @[ID.scala 45:16 52:17]
  wire [31:0] _GEN_4 = ~io_r1REn ? imm : 32'h0; // @[ID.scala 58:38 59:20 61:20]
  wire [31:0] _GEN_6 = ~io_r2REn ? imm : 32'h0; // @[ID.scala 66:38 67:20 69:20]
  assign io_r1REn = 6'hd == op; // @[ID.scala 45:16]
  assign io_r2REn = 1'h0; // @[ID.scala 43:14 45:16 51:22]
  assign io_r1RAddr = io_instData[25:21]; // @[ID.scala 36:30]
  assign io_r2RAddr = io_instData[20:16]; // @[ID.scala 37:30]
  assign io_iKind = {{2'd0}, _GEN_1};
  assign io_iSKind = {{2'd0}, _T};
  assign io_source1 = io_r1REn ? io_r1RData : _GEN_4; // @[ID.scala 56:31 57:20]
  assign io_source2 = io_r2REn ? io_r2RData : _GEN_6; // @[ID.scala 64:31 65:20]
  assign io_rWAddr = io_instData[20:16]; // @[ID.scala 35:29]
  assign io_rWEn = 6'hd == op; // @[ID.scala 45:16]
endmodule
