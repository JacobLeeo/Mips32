circuit IDTop :
  module DbtIDEX :
    input clock : Clock
    input reset : Reset
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

  module RegFile :
    input clock : Clock
    input reset : Reset
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

  module DC :
    input clock : Clock
    input reset : Reset
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

  module IDTop :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip inFromIF : { iRRdDt : UInt<32>}, outToEX : { iSK : UInt<8>, iK : UInt<3>, source1 : UInt<32>, source2 : UInt<32>, rWAddr : UInt<5>, rWEn : UInt<1>}}

    inst d of DbtIDEX @[IDTop.scala 17:19]
    d.clock <= clock
    d.reset <= reset
    inst rf of RegFile @[IDTop.scala 18:20]
    rf.clock <= clock
    rf.reset <= reset
    inst dc of DC @[IDTop.scala 19:20]
    dc.clock <= clock
    dc.reset <= reset
    dc.io.inFromD.iRRdDt <= io.inFromIF.iRRdDt @[IDTop.scala 22:19]
    dc.io.inFromRF.r2RData <= rf.io.outToID.r2RData @[IDTop.scala 23:20]
    dc.io.inFromRF.r1RData <= rf.io.outToID.r1RData @[IDTop.scala 23:20]
    rf.io.inFromID.r2RAddr <= dc.io.outToRF.r2RAddr @[IDTop.scala 24:20]
    rf.io.inFromID.r1RAddr <= dc.io.outToRF.r1RAddr @[IDTop.scala 24:20]
    rf.io.inFromID.r2REn <= dc.io.outToRF.r2REn @[IDTop.scala 24:20]
    rf.io.inFromID.r1REn <= dc.io.outToRF.r1REn @[IDTop.scala 24:20]
    d.io.inFromID.rWEn <= dc.io.outToD.rWEn @[IDTop.scala 25:19]
    d.io.inFromID.rWAddr <= dc.io.outToD.rWAddr @[IDTop.scala 25:19]
    d.io.inFromID.source2 <= dc.io.outToD.source2 @[IDTop.scala 25:19]
    d.io.inFromID.source1 <= dc.io.outToD.source1 @[IDTop.scala 25:19]
    d.io.inFromID.iK <= dc.io.outToD.iK @[IDTop.scala 25:19]
    d.io.inFromID.iSK <= dc.io.outToD.iSK @[IDTop.scala 25:19]
    io.outToEX.rWEn <= d.io.outToEX.rWEn @[IDTop.scala 26:16]
    io.outToEX.rWAddr <= d.io.outToEX.rWAddr @[IDTop.scala 26:16]
    io.outToEX.source2 <= d.io.outToEX.source2 @[IDTop.scala 26:16]
    io.outToEX.source1 <= d.io.outToEX.source1 @[IDTop.scala 26:16]
    io.outToEX.iK <= d.io.outToEX.iK @[IDTop.scala 26:16]
    io.outToEX.iSK <= d.io.outToEX.iSK @[IDTop.scala 26:16]
    rf.io.inFromWB.rWData is invalid @[IDTop.scala 27:20]
    rf.io.inFromWB.rWAddr is invalid @[IDTop.scala 27:20]
    rf.io.inFromWB.rWEn is invalid @[IDTop.scala 27:20]

