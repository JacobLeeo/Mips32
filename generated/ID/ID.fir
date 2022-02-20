circuit ID :
  module ID :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip instData : UInt<32>, flip r1RData : UInt<32>, flip r2RData : UInt<32>, r1REn : UInt<1>, r2REn : UInt<1>, r1RAddr : UInt<5>, r2RAddr : UInt<5>, iKind : UInt<8>, iSKind : UInt<3>, source1 : UInt<32>, source2 : UInt<32>, rWAddr : UInt<5>, rWEn : UInt<1>}

    wire op : UInt<6>
    op <= UInt<6>("h0")
    wire imm : UInt<32>
    imm <= UInt<32>("h0")
    node _op_T = bits(io.instData, 31, 26) @[ID.scala 34:22]
    op <= _op_T @[ID.scala 34:8]
    node _io_rWAddr_T = bits(io.instData, 20, 16) @[ID.scala 35:29]
    io.rWAddr <= _io_rWAddr_T @[ID.scala 35:15]
    node _io_r1RAddr_T = bits(io.instData, 25, 21) @[ID.scala 36:30]
    io.r1RAddr <= _io_r1RAddr_T @[ID.scala 36:16]
    node _io_r2RAddr_T = bits(io.instData, 20, 16) @[ID.scala 37:30]
    io.r2RAddr <= _io_r2RAddr_T @[ID.scala 37:16]
    io.rWEn <= UInt<1>("h0") @[ID.scala 39:13]
    io.iKind <= UInt<1>("h0") @[ID.scala 40:14]
    io.iSKind <= UInt<1>("h0") @[ID.scala 41:15]
    io.r1REn <= UInt<1>("h0") @[ID.scala 42:14]
    io.r2REn <= UInt<1>("h0") @[ID.scala 43:14]
    node _T = eq(UInt<4>("hd"), op) @[ID.scala 45:16]
    when _T : @[ID.scala 45:16]
      io.rWEn <= UInt<1>("h1") @[ID.scala 47:21]
      io.iKind <= UInt<6>("h25") @[ID.scala 48:22]
      io.iSKind <= UInt<1>("h1") @[ID.scala 49:23]
      io.r1REn <= UInt<1>("h1") @[ID.scala 50:22]
      io.r2REn <= UInt<1>("h0") @[ID.scala 51:22]
      node _imm_T = bits(io.instData, 15, 0) @[ID.scala 52:31]
      imm <= _imm_T @[ID.scala 52:17]
    node _T_1 = eq(io.r1REn, UInt<1>("h1")) @[ID.scala 56:19]
    when _T_1 : @[ID.scala 56:31]
      io.source1 <= io.r1RData @[ID.scala 57:20]
    else :
      node _T_2 = eq(io.r1REn, UInt<1>("h0")) @[ID.scala 58:25]
      when _T_2 : @[ID.scala 58:38]
        io.source1 <= imm @[ID.scala 59:20]
      else :
        io.source1 <= UInt<1>("h0") @[ID.scala 61:20]
    node _T_3 = eq(io.r2REn, UInt<1>("h1")) @[ID.scala 64:19]
    when _T_3 : @[ID.scala 64:31]
      io.source2 <= io.r2RData @[ID.scala 65:20]
    else :
      node _T_4 = eq(io.r2REn, UInt<1>("h0")) @[ID.scala 66:25]
      when _T_4 : @[ID.scala 66:38]
        io.source2 <= imm @[ID.scala 67:20]
      else :
        io.source2 <= UInt<1>("h0") @[ID.scala 69:20]

