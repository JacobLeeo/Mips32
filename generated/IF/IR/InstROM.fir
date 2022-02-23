circuit InstROM :
  module InstROM :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip inFromPC : { iREn : UInt<1>, iRRdAd : UInt<8>, iRWrEn : UInt<1>, iRWrDt : UInt<32>}, outToD : { iRRdDt : UInt<32>}}

    reg enable : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[InstROM.scala 16:25]
    smem memBank : UInt<32> [256] @[InstROM.scala 17:30]
    io.outToD.iRRdDt <= UInt<1>("h0") @[InstROM.scala 21:22]
    enable <= io.inFromPC.iREn @[InstROM.scala 22:12]
    when enable : @[InstROM.scala 24:18]
      infer mport rdwrPort = memBank[io.inFromPC.iRRdAd], clock @[InstROM.scala 25:31]
      when io.inFromPC.iRWrEn : @[InstROM.scala 26:34]
        rdwrPort <= io.inFromPC.iRWrDt @[InstROM.scala 27:22]
      else :
        io.outToD.iRRdDt <= rdwrPort @[InstROM.scala 29:30]

