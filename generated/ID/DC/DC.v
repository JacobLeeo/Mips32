module DC(
  input         clock,
  input         reset,
  input  [31:0] io_inFromD_iRRdDt,
  input  [31:0] io_inFromRF_r1RData,
  input  [31:0] io_inFromRF_r2RData,
  output [7:0]  io_outToD_iSK,
  output [2:0]  io_outToD_iK,
  output [31:0] io_outToD_source1,
  output [31:0] io_outToD_source2,
  output [4:0]  io_outToD_rWAddr,
  output        io_outToD_rWEn,
  output        io_outToRF_r1REn,
  output        io_outToRF_r2REn,
  output [4:0]  io_outToRF_r1RAddr,
  output [4:0]  io_outToRF_r2RAddr
);
  wire [5:0] op = io_inFromD_iRRdDt[31:26]; // @[DC.scala 34:28]
  wire  _T = 6'hd == op; // @[DC.scala 40:16]
  wire [5:0] _GEN_2 = 6'hd == op ? 6'h25 : 6'h0; // @[DC.scala 40:16 29:19 45:27]
  wire [31:0] imm = 6'hd == op ? {{16'd0}, io_inFromD_iRRdDt[15:0]} : 32'h0; // @[DC.scala 40:16 47:17]
  wire [31:0] _GEN_4 = ~io_outToRF_r1REn ? imm : 32'h0; // @[DC.scala 31:23 53:46 54:27]
  wire [31:0] _GEN_6 = ~io_outToRF_r2REn ? imm : 32'h0; // @[DC.scala 32:23 59:46 60:27]
  assign io_outToD_iSK = {{2'd0}, _GEN_2};
  assign io_outToD_iK = {{2'd0}, _T};
  assign io_outToD_source1 = io_outToRF_r1REn ? io_inFromRF_r1RData : _GEN_4; // @[DC.scala 51:39 52:27]
  assign io_outToD_source2 = io_outToRF_r2REn ? io_inFromRF_r2RData : _GEN_6; // @[DC.scala 57:39 58:27]
  assign io_outToD_rWAddr = io_inFromD_iRRdDt[20:16]; // @[DC.scala 35:42]
  assign io_outToD_rWEn = 6'hd == op; // @[DC.scala 40:16]
  assign io_outToRF_r1REn = 6'hd == op; // @[DC.scala 40:16]
  assign io_outToRF_r2REn = 1'h0; // @[DC.scala 40:16 27:22 44:30]
  assign io_outToRF_r1RAddr = io_inFromD_iRRdDt[25:21]; // @[DC.scala 36:44]
  assign io_outToRF_r2RAddr = io_inFromD_iRRdDt[20:16]; // @[DC.scala 37:44]
endmodule
