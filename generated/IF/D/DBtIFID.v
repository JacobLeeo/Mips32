module DBtIFID(
  input         clock,
  input         reset,
  input  [31:0] io_inFromIF_iRRdDt,
  output [31:0] io_outToID_iRRdDt
);
  assign io_outToID_iRRdDt = io_inFromIF_iRRdDt; // @[DBtIFID.scala 18:23]
endmodule
