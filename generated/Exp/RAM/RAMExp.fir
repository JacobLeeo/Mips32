circuit RAMExp :
  module RAMExp :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enable : UInt<1>, flip write : UInt<1>, flip addr : UInt<10>, flip dataIn : UInt<32>, dataOut : UInt<32>}

    reg enable : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[RAM.scala 24:25]
    smem mem : UInt<32> [1024] @[RAM.scala 25:26]
    io.dataOut <= UInt<1>("h0") @[RAM.scala 31:16]
    enable <= io.enable @[RAM.scala 32:12]
    when enable : @[RAM.scala 34:18]
      infer mport rdwrPort = mem[io.addr], clock @[RAM.scala 35:27]
      when io.write : @[RAM.scala 36:24]
        rdwrPort <= io.dataIn @[RAM.scala 37:22]
      else :
        io.dataOut <= rdwrPort @[RAM.scala 40:28]

