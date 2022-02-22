module EX(
  input         clock,
  input         reset,
  input  [7:0]  io_inFromD_iSK,
  input  [2:0]  io_inFromD_iK,
  input  [31:0] io_inFromD_source1,
  input  [31:0] io_inFromD_source2,
  input  [4:0]  io_inFromD_rWAddr,
  input         io_inFromD_rWEn,
  output [4:0]  io_outToD_rWAddrO,
  output        io_outToD_rWEnO,
  output [31:0] io_outToD_rWDataO
);
  wire [31:0] _logicResult_T = io_inFromD_source1 | io_inFromD_source2; // @[EX.scala 30:47]
  wire [31:0] logicResult = 8'h25 == io_inFromD_iSK ? _logicResult_T : 32'h0; // @[EX.scala 28:28 30:25]
  assign io_outToD_rWAddrO = io_inFromD_rWAddr; // @[EX.scala 21:23]
  assign io_outToD_rWEnO = io_inFromD_rWEn; // @[EX.scala 22:21]
  assign io_outToD_rWDataO = 3'h1 == io_inFromD_iK ? logicResult : 32'h0; // @[EX.scala 24:23 35:27 37:31]
endmodule
