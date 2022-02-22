circuit DbtIDEX :
  module DbtIDEX :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip inFromID : { iSK : UInt<8>, iK : UInt<3>, source1 : UInt<32>, source2 : UInt<32>, rWAddr : UInt<5>, rWEn : UInt<1>}, outToEX : { iSK : UInt<8>, iK : UInt<3>, source1 : UInt<32>, source2 : UInt<32>, rWAddr : UInt<5>, rWEn : UInt<1>}}

    reg iSK : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[DbtIDEX.scala 14:22]
    iSK <= io.inFromID.iSK @[DbtIDEX.scala 14:22]
    reg iK : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[DbtIDEX.scala 15:21]
    iK <= io.inFromID.iK @[DbtIDEX.scala 15:21]
    reg s1 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[DbtIDEX.scala 16:21]
    s1 <= io.inFromID.source1 @[DbtIDEX.scala 16:21]
    reg s2 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[DbtIDEX.scala 17:21]
    s2 <= io.inFromID.source2 @[DbtIDEX.scala 17:21]
    reg rWAddr : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[DbtIDEX.scala 18:25]
    rWAddr <= io.inFromID.rWAddr @[DbtIDEX.scala 18:25]
    reg rWEn : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[DbtIDEX.scala 19:23]
    rWEn <= io.inFromID.rWEn @[DbtIDEX.scala 19:23]
    io.outToEX.iSK <= iSK @[DbtIDEX.scala 21:20]
    io.outToEX.iK <= iK @[DbtIDEX.scala 22:19]
    io.outToEX.source1 <= s1 @[DbtIDEX.scala 23:24]
    io.outToEX.source2 <= s2 @[DbtIDEX.scala 24:24]
    io.outToEX.rWAddr <= rWAddr @[DbtIDEX.scala 25:23]
    io.outToEX.rWEn <= rWEn @[DbtIDEX.scala 26:21]

