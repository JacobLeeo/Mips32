circuit RegFile :
  module RegFile :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip rWEn : UInt<1>, flip r1REn : UInt<1>, flip r2REn : UInt<1>, flip rWAddr : UInt<5>, flip rWData : UInt<32>, flip r1RAddr : UInt<5>, r1RData : UInt<32>, flip r2RAddr : UInt<5>, r2RData : UInt<32>}

    cmem regs : UInt<32> [32] @[RegFile.scala 23:19]
    node _T = neq(io.rWAddr, UInt<1>("h0")) @[RegFile.scala 26:32]
    node _T_1 = and(io.rWEn, _T) @[RegFile.scala 26:18]
    when _T_1 : @[RegFile.scala 26:43]
      write mport MPORT = regs[io.rWAddr], clock
      MPORT <= io.rWData
    node _T_2 = eq(io.r1RAddr, UInt<1>("h0")) @[RegFile.scala 31:21]
    when _T_2 : @[RegFile.scala 31:30]
      io.r1RData <= UInt<1>("h0") @[RegFile.scala 32:20]
    else :
      node _T_3 = eq(io.r1RAddr, io.rWAddr) @[RegFile.scala 33:28]
      node _T_4 = eq(io.r1REn, UInt<1>("h1")) @[RegFile.scala 34:26]
      node _T_5 = and(_T_3, _T_4) @[RegFile.scala 34:13]
      node _T_6 = eq(io.rWEn, UInt<1>("h1")) @[RegFile.scala 35:25]
      node _T_7 = and(_T_5, _T_6) @[RegFile.scala 35:13]
      when _T_7 : @[RegFile.scala 35:38]
        io.r1RData <= io.rWData @[RegFile.scala 36:20]
      else :
        node _T_8 = eq(io.r1REn, UInt<1>("h1")) @[RegFile.scala 37:26]
        when _T_8 : @[RegFile.scala 37:39]
          read mport io_r1RData_MPORT = regs[io.r1RAddr], clock @[RegFile.scala 38:32]
          io.r1RData <= io_r1RData_MPORT @[RegFile.scala 38:20]
        else :
          io.r1RData <= UInt<1>("h0") @[RegFile.scala 40:20]
    node _T_9 = eq(io.r2RAddr, UInt<1>("h0")) @[RegFile.scala 44:21]
    when _T_9 : @[RegFile.scala 44:30]
      io.r2RData <= UInt<1>("h0") @[RegFile.scala 45:20]
    else :
      node _T_10 = eq(io.r2RAddr, io.rWAddr) @[RegFile.scala 46:28]
      node _T_11 = eq(io.r2REn, UInt<1>("h1")) @[RegFile.scala 47:26]
      node _T_12 = and(_T_10, _T_11) @[RegFile.scala 47:13]
      node _T_13 = eq(io.rWEn, UInt<1>("h1")) @[RegFile.scala 48:25]
      node _T_14 = and(_T_12, _T_13) @[RegFile.scala 48:13]
      when _T_14 : @[RegFile.scala 48:38]
        io.r2RData <= io.rWData @[RegFile.scala 49:20]
      else :
        node _T_15 = eq(io.r2REn, UInt<1>("h1")) @[RegFile.scala 50:25]
        when _T_15 : @[RegFile.scala 50:37]
          read mport io_r2RData_MPORT = regs[io.r2RAddr], clock @[RegFile.scala 51:32]
          io.r2RData <= io_r2RData_MPORT @[RegFile.scala 51:20]
        else :
          io.r2RData <= UInt<1>("h0") @[RegFile.scala 53:20]

