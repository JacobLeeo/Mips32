circuit PC :
  module PC :
    input clock : Clock
    input reset : UInt<1>
    output io : { instRonEn : UInt<1>, instRomAddr : UInt<8>}

    reg instRonEn : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[PC.scala 14:26]
    reg instRomAddr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[PC.scala 15:28]
    instRonEn <= UInt<1>("h1") @[PC.scala 17:13]
    node _instRomAddr_T = add(instRomAddr, UInt<3>("h4")) @[PC.scala 19:45]
    node _instRomAddr_T_1 = tail(_instRomAddr_T, 1) @[PC.scala 19:45]
    node _instRomAddr_T_2 = mux(instRonEn, _instRomAddr_T_1, UInt<1>("h0")) @[PC.scala 19:21]
    instRomAddr <= _instRomAddr_T_2 @[PC.scala 19:15]
    io.instRonEn <= instRonEn @[PC.scala 21:16]
    io.instRomAddr <= instRomAddr @[PC.scala 22:18]

