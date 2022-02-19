circuit PC :
  module PC :
    input clock : Clock
    input reset : UInt<1>
    output io : { instRomEn : UInt<1>, instRomAddr : UInt<8>}

    reg instRomEn : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[PC.scala 14:28]
    reg instRomAddr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[PC.scala 15:30]
    instRomEn <= UInt<1>("h1") @[PC.scala 17:15]
    node _instRomAddr_T = add(instRomAddr, UInt<3>("h4")) @[PC.scala 19:47]
    node _instRomAddr_T_1 = tail(_instRomAddr_T, 1) @[PC.scala 19:47]
    node _instRomAddr_T_2 = mux(instRomEn, _instRomAddr_T_1, UInt<1>("h0")) @[PC.scala 19:23]
    instRomAddr <= _instRomAddr_T_2 @[PC.scala 19:17]
    io.instRomEn <= instRomEn @[PC.scala 26:18]
    io.instRomAddr <= instRomAddr @[PC.scala 27:20]

