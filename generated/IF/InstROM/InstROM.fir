circuit InstROM :
  module InstROM :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip inFromPC : { iREn : UInt<1>, iRRdAd : UInt<8>, iRWrEn : UInt<1>, iRWrDt : UInt<32>}, outToD : { iRRdDt : UInt<32>}}

    reg enable : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[IR.scala 16:25]
    smem memBank : UInt<32> [256] @[IR.scala 17:30]
    io.outToD.iRRdDt <= UInt<1>("h0") @[IR.scala 21:22]
    enable <= io.inFromPC.iREn @[IR.scala 22:12]
    when enable : @[IR.scala 24:18]
      infer mport rdwrPort = memBank[io.inFromPC.iRRdAd], clock @[IR.scala 25:31]
      when io.inFromPC.iRWrEn : @[IR.scala 26:34]
        rdwrPort <= io.inFromPC.iRWrDt @[IR.scala 27:22]
      else :
        io.outToD.iRRdDt <= rdwrPort @[IR.scala 29:30]

