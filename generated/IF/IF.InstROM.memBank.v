module BindsTo_0_InstROM(
  input         clock,
  input  [7:0]  io_rAddr,
  output [31:0] io_rData,
  input         io_wEn,
  input  [7:0]  io_wAddr,
  input  [31:0] io_wData
);

initial begin
  $readmemh("mem.txt", InstROM.memBank);
end
                      endmodule

bind InstROM BindsTo_0_InstROM BindsTo_0_InstROM_Inst(.*);