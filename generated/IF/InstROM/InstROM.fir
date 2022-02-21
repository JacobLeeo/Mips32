circuit InstROM :
  module InstROM :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip ena : UInt<1>, flip rAddr : UInt<8>, rData : UInt<32>, flip wEn : UInt<1>, flip wData : UInt<32>}

    reg enable : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[InstROM.scala 22:25]
    smem memBank : UInt<32> [256] @[InstROM.scala 23:30]
    io.rData <= UInt<1>("h0") @[InstROM.scala 26:14]
    enable <= io.ena @[InstROM.scala 27:12]
    when enable : @[InstROM.scala 29:18]
      infer mport rdwrPort = memBank[io.rAddr], clock @[InstROM.scala 30:31]
      when io.wEn : @[InstROM.scala 31:22]
        rdwrPort <= io.wData @[InstROM.scala 32:22]
      else :
        io.rData <= rdwrPort @[InstROM.scala 34:22]

