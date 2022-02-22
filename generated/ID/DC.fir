circuit DC :
  module DC :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip inFromD : { iRRdDt : UInt<32>}, flip inFromRF : { r1RData : UInt<32>, r2RData : UInt<32>}, outToD : { iSK : UInt<8>, iK : UInt<3>, source1 : UInt<32>, source2 : UInt<32>, rWAddr : UInt<5>, rWEn : UInt<1>}, outToRF : { r1REn : UInt<1>, r2REn : UInt<1>, r1RAddr : UInt<5>, r2RAddr : UInt<5>}}

    wire op : UInt<6>
    op <= UInt<6>("h0")
    wire imm : UInt<32>
    imm <= UInt<32>("h0")
    io.outToRF.r1REn <= UInt<1>("h0") @[DC.scala 26:22]
    io.outToRF.r2REn <= UInt<1>("h0") @[DC.scala 27:22]
    io.outToD.rWEn <= UInt<1>("h0") @[DC.scala 28:20]
    io.outToD.iSK <= UInt<1>("h0") @[DC.scala 29:19]
    io.outToD.iK <= UInt<1>("h0") @[DC.scala 30:18]
    io.outToD.source1 <= UInt<1>("h0") @[DC.scala 31:23]
    io.outToD.source2 <= UInt<1>("h0") @[DC.scala 32:23]
    node _op_T = bits(io.inFromD.iRRdDt, 31, 26) @[DC.scala 34:28]
    op <= _op_T @[DC.scala 34:8]
    node _io_outToD_rWAddr_T = bits(io.inFromD.iRRdDt, 20, 16) @[DC.scala 35:42]
    io.outToD.rWAddr <= _io_outToD_rWAddr_T @[DC.scala 35:22]
    node _io_outToRF_r1RAddr_T = bits(io.inFromD.iRRdDt, 25, 21) @[DC.scala 36:44]
    io.outToRF.r1RAddr <= _io_outToRF_r1RAddr_T @[DC.scala 36:24]
    node _io_outToRF_r2RAddr_T = bits(io.inFromD.iRRdDt, 20, 16) @[DC.scala 37:44]
    io.outToRF.r2RAddr <= _io_outToRF_r2RAddr_T @[DC.scala 37:24]
    node _T = eq(UInt<4>("hd"), op) @[DC.scala 40:16]
    when _T : @[DC.scala 40:16]
      io.outToD.rWEn <= UInt<1>("h1") @[DC.scala 42:28]
      io.outToRF.r1REn <= UInt<1>("h1") @[DC.scala 43:30]
      io.outToRF.r2REn <= UInt<1>("h0") @[DC.scala 44:30]
      io.outToD.iSK <= UInt<6>("h25") @[DC.scala 45:27]
      io.outToD.iK <= UInt<1>("h1") @[DC.scala 46:26]
      node _imm_T = bits(io.inFromD.iRRdDt, 15, 0) @[DC.scala 47:37]
      imm <= _imm_T @[DC.scala 47:17]
    node _T_1 = eq(io.outToRF.r1REn, UInt<1>("h1")) @[DC.scala 51:27]
    when _T_1 : @[DC.scala 51:39]
      io.outToD.source1 <= io.inFromRF.r1RData @[DC.scala 52:27]
    else :
      node _T_2 = eq(io.outToRF.r1REn, UInt<1>("h0")) @[DC.scala 53:33]
      when _T_2 : @[DC.scala 53:46]
        io.outToD.source1 <= imm @[DC.scala 54:27]
    node _T_3 = eq(io.outToRF.r2REn, UInt<1>("h1")) @[DC.scala 57:27]
    when _T_3 : @[DC.scala 57:39]
      io.outToD.source2 <= io.inFromRF.r2RData @[DC.scala 58:27]
    else :
      node _T_4 = eq(io.outToRF.r2REn, UInt<1>("h0")) @[DC.scala 59:33]
      when _T_4 : @[DC.scala 59:46]
        io.outToD.source2 <= imm @[DC.scala 60:27]

