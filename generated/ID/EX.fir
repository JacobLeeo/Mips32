circuit EX :
  module EX :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip inFromD : { iSK : UInt<8>, iK : UInt<3>, source1 : UInt<32>, source2 : UInt<32>, rWAddr : UInt<5>, rWEn : UInt<1>}, outToD : { rWAddrO : UInt<5>, rWEnO : UInt<1>, rWDataO : UInt<32>}}

    wire logicResult : UInt<32>
    logicResult <= UInt<32>("h0")
    io.outToD.rWAddrO <= io.inFromD.rWAddr @[EX.scala 21:23]
    io.outToD.rWEnO <= io.inFromD.rWEn @[EX.scala 22:21]
    io.outToD.rWDataO <= UInt<1>("h0") @[EX.scala 24:23]
    node _T = eq(UInt<6>("h25"), io.inFromD.iSK) @[EX.scala 28:28]
    when _T : @[EX.scala 28:28]
      node _logicResult_T = or(io.inFromD.source1, io.inFromD.source2) @[EX.scala 30:47]
      logicResult <= _logicResult_T @[EX.scala 30:25]
    node _T_1 = eq(UInt<1>("h1"), io.inFromD.iK) @[EX.scala 35:27]
    when _T_1 : @[EX.scala 35:27]
      io.outToD.rWDataO <= logicResult @[EX.scala 37:31]

