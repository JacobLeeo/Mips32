circuit RegFile :
  module RegFile :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip inFromID : { r1REn : UInt<1>, r2REn : UInt<1>, r1RAddr : UInt<5>, r2RAddr : UInt<5>}, flip inFromWB : { rWEn : UInt<1>, rWAddr : UInt<32>, rWData : UInt<32>}, outToID : { r1RData : UInt<32>, r2RData : UInt<32>}}

    cmem regBank : UInt<32> [32] @[RF.scala 16:22]
    node _T = neq(io.inFromWB.rWAddr, UInt<1>("h0")) @[RF.scala 19:50]
    node _T_1 = and(io.inFromWB.rWEn, _T) @[RF.scala 19:27]
    when _T_1 : @[RF.scala 19:61]
      node _T_2 = bits(io.inFromWB.rWAddr, 4, 0)
      write mport MPORT = regBank[_T_2], clock
      MPORT <= io.inFromWB.rWData
    node _T_3 = eq(io.inFromID.r1RAddr, UInt<1>("h0")) @[RF.scala 24:30]
    when _T_3 : @[RF.scala 24:39]
      io.outToID.r1RData <= UInt<1>("h0") @[RF.scala 25:28]
    else :
      node _T_4 = eq(io.inFromID.r1RAddr, io.inFromWB.rWAddr) @[RF.scala 26:37]
      node _T_5 = eq(io.inFromID.r1REn, UInt<1>("h1")) @[RF.scala 27:35]
      node _T_6 = and(_T_4, _T_5) @[RF.scala 27:13]
      node _T_7 = eq(io.inFromWB.rWEn, UInt<1>("h1")) @[RF.scala 28:34]
      node _T_8 = and(_T_6, _T_7) @[RF.scala 28:13]
      when _T_8 : @[RF.scala 28:47]
        io.outToID.r1RData <= io.inFromWB.rWData @[RF.scala 29:28]
      else :
        node _T_9 = eq(io.inFromID.r1REn, UInt<1>("h1")) @[RF.scala 30:35]
        when _T_9 : @[RF.scala 30:48]
          read mport io_outToID_r1RData_MPORT = regBank[io.inFromID.r1RAddr], clock @[RF.scala 31:43]
          io.outToID.r1RData <= io_outToID_r1RData_MPORT @[RF.scala 31:28]
        else :
          io.outToID.r1RData <= UInt<32>("h0") @[RF.scala 33:28]
    node _T_10 = eq(io.inFromID.r2RAddr, UInt<1>("h0")) @[RF.scala 37:30]
    when _T_10 : @[RF.scala 37:39]
      io.outToID.r2RData <= UInt<1>("h0") @[RF.scala 38:28]
    else :
      node _T_11 = eq(io.inFromID.r2RAddr, io.inFromWB.rWAddr) @[RF.scala 39:37]
      node _T_12 = eq(io.inFromID.r2REn, UInt<1>("h1")) @[RF.scala 40:35]
      node _T_13 = and(_T_11, _T_12) @[RF.scala 40:13]
      node _T_14 = eq(io.inFromWB.rWEn, UInt<1>("h1")) @[RF.scala 41:34]
      node _T_15 = and(_T_13, _T_14) @[RF.scala 41:13]
      when _T_15 : @[RF.scala 41:47]
        io.outToID.r2RData <= io.inFromWB.rWData @[RF.scala 42:28]
      else :
        node _T_16 = eq(io.inFromID.r2REn, UInt<1>("h1")) @[RF.scala 43:34]
        when _T_16 : @[RF.scala 43:46]
          read mport io_outToID_r2RData_MPORT = regBank[io.inFromID.r2RAddr], clock @[RF.scala 44:43]
          io.outToID.r2RData <= io_outToID_r2RData_MPORT @[RF.scala 44:28]
        else :
          io.outToID.r2RData <= UInt<1>("h0") @[RF.scala 46:28]

