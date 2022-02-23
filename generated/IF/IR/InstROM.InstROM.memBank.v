module BindsTo_0_InstROM(
  input         clock,
  input         reset,
  input         io_inFromPC_iREn,
  input  [7:0]  io_inFromPC_iRRdAd,
  input         io_inFromPC_iRWrEn,
  input  [31:0] io_inFromPC_iRWrDt,
  output [31:0] io_outToD_iRRdDt
);

initial begin
  $readmemh("mem.txt", InstROM.memBank);
end
                      endmodule

bind InstROM BindsTo_0_InstROM BindsTo_0_InstROM_Inst(.*);