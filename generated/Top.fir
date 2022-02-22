circuit Top :
  module PC :
    input clock : Clock
    input reset : Reset
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

  module InstROM :
    input clock : Clock
    input reset : Reset
    output io : { flip inFromPC : { iREn : UInt<1>, iRRdAd : UInt<8>, iRWrEn : UInt<1>, iRWrDt : UInt<32>}, outToD : { iRRdDt : UInt<32>}}

    reg enable : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[InstROM.scala 16:25]
    smem memBank : UInt<32> [256] @[InstROM.scala 17:30]
    io.outToD.iRRdDt <= UInt<1>("h0") @[InstROM.scala 21:22]
    enable <= io.inFromPC.iREn @[InstROM.scala 22:12]
    when enable : @[InstROM.scala 24:18]
      infer mport rdwrPort = memBank[io.inFromPC.iRRdAd], clock @[InstROM.scala 25:31]
      when io.inFromPC.iRWrEn : @[InstROM.scala 26:34]
        rdwrPort <= io.inFromPC.iRWrDt @[InstROM.scala 27:22]
      else :
        io.outToD.iRRdDt <= rdwrPort @[InstROM.scala 29:30]

  module DBtIFID :
    input clock : Clock
    input reset : Reset
    output io : { flip inFromIF : { iRRdDt : UInt<32>}, outToID : { iRRdDt : UInt<32>}}

    wire instRomData : UInt<32>
    instRomData <= UInt<32>("h0")
    instRomData <= io.inFromIF.iRRdDt @[DBtIFID.scala 16:17]
    io.outToID.iRRdDt <= instRomData @[DBtIFID.scala 17:23]

  module IFTop :
    input clock : Clock
    input reset : Reset
    output io : { outToID : { iRRdDt : UInt<32>}}

    inst pc of PC @[IFTop.scala 21:20]
    pc.clock <= clock
    pc.reset <= reset
    inst ir of InstROM @[IFTop.scala 22:20]
    ir.clock <= clock
    ir.reset <= reset
    inst d of DBtIFID @[IFTop.scala 23:19]
    d.clock <= clock
    d.reset <= reset
    ir.io.inFromPC.iRWrDt <= pc.io.outToIR.iRWrDt @[IFTop.scala 25:20]
    ir.io.inFromPC.iRWrEn <= pc.io.outToIR.iRWrEn @[IFTop.scala 25:20]
    ir.io.inFromPC.iRRdAd <= pc.io.outToIR.iRRdAd @[IFTop.scala 25:20]
    ir.io.inFromPC.iREn <= pc.io.outToIR.iREn @[IFTop.scala 25:20]
    d.io.inFromIF.iRRdDt <= ir.io.outToD.iRRdDt @[IFTop.scala 26:19]
    io.outToID.iRRdDt <= d.io.outToID.iRRdDt @[IFTop.scala 27:16]

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

    cmem regBank : UInt<32> [32] @[RegFile.scala 16:22]
    node _T = neq(io.inFromWB.rWAddr, UInt<1>("h0")) @[RegFile.scala 19:50]
    node _T_1 = and(io.inFromWB.rWEn, _T) @[RegFile.scala 19:27]
    when _T_1 : @[RegFile.scala 19:61]
      node _T_2 = bits(io.inFromWB.rWAddr, 4, 0)
      write mport MPORT = regBank[_T_2], clock
      MPORT <= io.inFromWB.rWData
    node _T_3 = eq(io.inFromID.r1RAddr, UInt<1>("h0")) @[RegFile.scala 24:30]
    when _T_3 : @[RegFile.scala 24:39]
      io.outToID.r1RData <= UInt<1>("h0") @[RegFile.scala 25:28]
    else :
      node _T_4 = eq(io.inFromID.r1RAddr, io.inFromWB.rWAddr) @[RegFile.scala 26:37]
      node _T_5 = eq(io.inFromID.r1REn, UInt<1>("h1")) @[RegFile.scala 27:35]
      node _T_6 = and(_T_4, _T_5) @[RegFile.scala 27:13]
      node _T_7 = eq(io.inFromWB.rWEn, UInt<1>("h1")) @[RegFile.scala 28:34]
      node _T_8 = and(_T_6, _T_7) @[RegFile.scala 28:13]
      when _T_8 : @[RegFile.scala 28:47]
        io.outToID.r1RData <= io.inFromWB.rWData @[RegFile.scala 29:28]
      else :
        node _T_9 = eq(io.inFromID.r1REn, UInt<1>("h1")) @[RegFile.scala 30:35]
        when _T_9 : @[RegFile.scala 30:48]
          read mport io_outToID_r1RData_MPORT = regBank[io.inFromID.r1RAddr], clock @[RegFile.scala 31:43]
          io.outToID.r1RData <= io_outToID_r1RData_MPORT @[RegFile.scala 31:28]
        else :
          io.outToID.r1RData <= UInt<32>("h0") @[RegFile.scala 33:28]
    node _T_10 = eq(io.inFromID.r2RAddr, UInt<1>("h0")) @[RegFile.scala 37:30]
    when _T_10 : @[RegFile.scala 37:39]
      io.outToID.r2RData <= UInt<1>("h0") @[RegFile.scala 38:28]
    else :
      node _T_11 = eq(io.inFromID.r2RAddr, io.inFromWB.rWAddr) @[RegFile.scala 39:37]
      node _T_12 = eq(io.inFromID.r2REn, UInt<1>("h1")) @[RegFile.scala 40:35]
      node _T_13 = and(_T_11, _T_12) @[RegFile.scala 40:13]
      node _T_14 = eq(io.inFromWB.rWEn, UInt<1>("h1")) @[RegFile.scala 41:34]
      node _T_15 = and(_T_13, _T_14) @[RegFile.scala 41:13]
      when _T_15 : @[RegFile.scala 41:47]
        io.outToID.r2RData <= io.inFromWB.rWData @[RegFile.scala 42:28]
      else :
        node _T_16 = eq(io.inFromID.r2REn, UInt<1>("h1")) @[RegFile.scala 43:34]
        when _T_16 : @[RegFile.scala 43:46]
          read mport io_outToID_r2RData_MPORT = regBank[io.inFromID.r2RAddr], clock @[RegFile.scala 44:43]
          io.outToID.r2RData <= io_outToID_r2RData_MPORT @[RegFile.scala 44:28]
        else :
          io.outToID.r2RData <= UInt<1>("h0") @[RegFile.scala 46:28]

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
    input reset : Reset
    output io : { flip inFromIF : { iRRdDt : UInt<32>}, outToEX : { iSK : UInt<8>, iK : UInt<3>, source1 : UInt<32>, source2 : UInt<32>, rWAddr : UInt<5>, rWEn : UInt<1>}}

    inst d of DbtIDEX @[IDTop.scala 15:19]
    d.clock <= clock
    d.reset <= reset
    inst rf of RegFile @[IDTop.scala 16:20]
    rf.clock <= clock
    rf.reset <= reset
    inst dc of DC @[IDTop.scala 17:20]
    dc.clock <= clock
    dc.reset <= reset
    dc.io.inFromD.iRRdDt <= io.inFromIF.iRRdDt @[IDTop.scala 19:19]
    dc.io.inFromRF.r2RData <= rf.io.outToID.r2RData @[IDTop.scala 20:20]
    dc.io.inFromRF.r1RData <= rf.io.outToID.r1RData @[IDTop.scala 20:20]
    rf.io.inFromID.r2RAddr <= dc.io.outToRF.r2RAddr @[IDTop.scala 21:20]
    rf.io.inFromID.r1RAddr <= dc.io.outToRF.r1RAddr @[IDTop.scala 21:20]
    rf.io.inFromID.r2REn <= dc.io.outToRF.r2REn @[IDTop.scala 21:20]
    rf.io.inFromID.r1REn <= dc.io.outToRF.r1REn @[IDTop.scala 21:20]
    d.io.inFromID.rWEn <= dc.io.outToD.rWEn @[IDTop.scala 22:19]
    d.io.inFromID.rWAddr <= dc.io.outToD.rWAddr @[IDTop.scala 22:19]
    d.io.inFromID.source2 <= dc.io.outToD.source2 @[IDTop.scala 22:19]
    d.io.inFromID.source1 <= dc.io.outToD.source1 @[IDTop.scala 22:19]
    d.io.inFromID.iK <= dc.io.outToD.iK @[IDTop.scala 22:19]
    d.io.inFromID.iSK <= dc.io.outToD.iSK @[IDTop.scala 22:19]
    io.outToEX.rWEn <= d.io.outToEX.rWEn @[IDTop.scala 23:16]
    io.outToEX.rWAddr <= d.io.outToEX.rWAddr @[IDTop.scala 23:16]
    io.outToEX.source2 <= d.io.outToEX.source2 @[IDTop.scala 23:16]
    io.outToEX.source1 <= d.io.outToEX.source1 @[IDTop.scala 23:16]
    io.outToEX.iK <= d.io.outToEX.iK @[IDTop.scala 23:16]
    io.outToEX.iSK <= d.io.outToEX.iSK @[IDTop.scala 23:16]
    rf.io.inFromWB.rWData is invalid @[IDTop.scala 25:20]
    rf.io.inFromWB.rWAddr is invalid @[IDTop.scala 25:20]
    rf.io.inFromWB.rWEn is invalid @[IDTop.scala 25:20]

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
    input reset : Reset
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

  module Top :
    input clock : Clock
    input reset : UInt<1>
    output io : { out : { rWAddrO : UInt<5>, rWEnO : UInt<1>, rWDataO : UInt<32>}}

    inst ifTop of IFTop @[Top.scala 20:23]
    ifTop.clock <= clock
    ifTop.reset <= reset
    inst idTop of IDTop @[Top.scala 21:23]
    idTop.clock <= clock
    idTop.reset <= reset
    inst exTop of EXTop @[Top.scala 22:23]
    exTop.clock <= clock
    exTop.reset <= reset
    idTop.io.inFromIF.iRRdDt <= ifTop.io.outToID.iRRdDt @[Top.scala 24:23]
    exTop.io.inFromID.rWEn <= idTop.io.outToEX.rWEn @[Top.scala 25:22]
    exTop.io.inFromID.rWAddr <= idTop.io.outToEX.rWAddr @[Top.scala 25:22]
    exTop.io.inFromID.source2 <= idTop.io.outToEX.source2 @[Top.scala 25:22]
    exTop.io.inFromID.source1 <= idTop.io.outToEX.source1 @[Top.scala 25:22]
    exTop.io.inFromID.iK <= idTop.io.outToEX.iK @[Top.scala 25:22]
    exTop.io.inFromID.iSK <= idTop.io.outToEX.iSK @[Top.scala 25:22]
    io.out.rWDataO <= exTop.io.outToMEM.rWDataO @[Top.scala 26:12]
    io.out.rWEnO <= exTop.io.outToMEM.rWEnO @[Top.scala 26:12]
    io.out.rWAddrO <= exTop.io.outToMEM.rWAddrO @[Top.scala 26:12]

