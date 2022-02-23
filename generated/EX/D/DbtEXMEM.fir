circuit DbtEXMEM :
  module DbtEXMEM :
    input clock : Clock
    input reset : UInt<1>
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

