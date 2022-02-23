circuit EXTop :
  module EX :
    input clock : Clock
    input reset : Reset
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

  module DbtEXMEM :
    input clock : Clock
    input reset : Reset
    output io : { flip inFromEX : { rWAddrO : UInt<5>, rWEnO : UInt<1>, rWDataO : UInt<32>}, outToMEM : { rWAddrO : UInt<5>, rWEnO : UInt<1>, rWDataO : UInt<32>}}

    reg rWAddr : UInt, clock with :
      reset => (UInt<1>("h0"), rWAddr) @[DbtEXMEM.scala 19:25]
    rWAddr <= io.inFromEX.rWAddrO @[DbtEXMEM.scala 19:25]
    reg rWEn : UInt<1>, clock with :
      reset => (UInt<1>("h0"), rWEn) @[DbtEXMEM.scala 20:23]
    rWEn <= io.inFromEX.rWEnO @[DbtEXMEM.scala 20:23]
    reg rWData : UInt, clock with :
      reset => (UInt<1>("h0"), rWData) @[DbtEXMEM.scala 21:25]
    rWData <= io.inFromEX.rWDataO @[DbtEXMEM.scala 21:25]
    io.outToMEM.rWAddrO <= rWAddr @[DbtEXMEM.scala 23:25]
    io.outToMEM.rWEnO <= rWEn @[DbtEXMEM.scala 24:23]
    io.outToMEM.rWDataO <= rWData @[DbtEXMEM.scala 25:25]

  module EXTop :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip inFromID : { iSK : UInt<8>, iK : UInt<3>, source1 : UInt<32>, source2 : UInt<32>, rWAddr : UInt<5>, rWEn : UInt<1>}, outToMEM : { rWAddrO : UInt<5>, rWEnO : UInt<1>, rWDataO : UInt<32>}}

    inst ex of EX @[EXTop.scala 13:20]
    ex.clock <= clock
    ex.reset <= reset
    inst d of DbtEXMEM @[EXTop.scala 14:19]
    d.clock <= clock
    d.reset <= reset
    ex.io.inFromD.rWEn <= io.inFromID.rWEn @[EXTop.scala 16:19]
    ex.io.inFromD.rWAddr <= io.inFromID.rWAddr @[EXTop.scala 16:19]
    ex.io.inFromD.source2 <= io.inFromID.source2 @[EXTop.scala 16:19]
    ex.io.inFromD.source1 <= io.inFromID.source1 @[EXTop.scala 16:19]
    ex.io.inFromD.iK <= io.inFromID.iK @[EXTop.scala 16:19]
    ex.io.inFromD.iSK <= io.inFromID.iSK @[EXTop.scala 16:19]
    d.io.inFromEX.rWDataO <= ex.io.outToD.rWDataO @[EXTop.scala 17:18]
    d.io.inFromEX.rWEnO <= ex.io.outToD.rWEnO @[EXTop.scala 17:18]
    d.io.inFromEX.rWAddrO <= ex.io.outToD.rWAddrO @[EXTop.scala 17:18]
    io.outToMEM.rWDataO <= d.io.outToMEM.rWDataO @[EXTop.scala 18:19]
    io.outToMEM.rWEnO <= d.io.outToMEM.rWEnO @[EXTop.scala 18:19]
    io.outToMEM.rWAddrO <= d.io.outToMEM.rWAddrO @[EXTop.scala 18:19]

