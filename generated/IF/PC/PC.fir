circuit PC :
  module PC :
    input clock : Clock
    input reset : UInt<1>
    output io : { instRomEn : UInt<1>, instRomAddr : UInt<8>}

    reg instRomAddr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[PC.scala 14:30]
    reg instRomEn : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[PC.scala 15:29]
    instRomEn <= UInt<1>("h1") @[PC.scala 17:15]
    node _instRomAddr_T = add(instRomAddr, UInt<3>("h4")) @[PC.scala 18:50]
    node _instRomAddr_T_1 = tail(_instRomAddr_T, 1) @[PC.scala 18:50]
    node _instRomAddr_T_2 = mux(io.instRomEn, _instRomAddr_T_1, UInt<1>("h0")) @[PC.scala 18:23]
    instRomAddr <= _instRomAddr_T_2 @[PC.scala 18:17]
    io.instRomAddr <= instRomAddr @[PC.scala 25:20]
    io.instRomEn <= instRomEn @[PC.scala 26:18]

