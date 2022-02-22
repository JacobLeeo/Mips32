circuit PC :
  module PC :
    input clock : Clock
    input reset : UInt<1>
    output io : { outToIR : { iREn : UInt<1>, iRRdAd : UInt<8>, iRWrEn : UInt<1>, iRWrDt : UInt<32>}}

    reg instRomAddr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[PC.scala 14:30]
    reg instRomEn : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[PC.scala 15:29]
    instRomEn <= UInt<1>("h1") @[PC.scala 17:15]
    node _instRomAddr_T = add(instRomAddr, UInt<3>("h4")) @[PC.scala 18:53]
    node _instRomAddr_T_1 = tail(_instRomAddr_T, 1) @[PC.scala 18:53]
    node _instRomAddr_T_2 = mux(io.outToIR.iREn, _instRomAddr_T_1, UInt<1>("h0")) @[PC.scala 18:23]
    instRomAddr <= _instRomAddr_T_2 @[PC.scala 18:17]
    io.outToIR.iRWrDt is invalid @[PC.scala 20:23]
    io.outToIR.iRWrEn is invalid @[PC.scala 21:23]
    io.outToIR.iRRdAd <= instRomAddr @[PC.scala 22:23]
    io.outToIR.iREn <= instRomEn @[PC.scala 23:21]

