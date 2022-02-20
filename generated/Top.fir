circuit Top :
  module PC :
    input clock : Clock
    input reset : Reset
    output io : { instRomEn : UInt<1>, instRomAddr : UInt<8>}

    reg instRomAddr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[PC.scala 14:30]
    reg instRomEn : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[PC.scala 15:29]
    instRomEn <= UInt<1>("h1") @[PC.scala 17:15]
    node _instRomAddr_T = add(instRomAddr, UInt<3>("h4")) @[PC.scala 18:50]
    node _instRomAddr_T_1 = tail(_instRomAddr_T, 1) @[PC.scala 18:50]
    node _instRomAddr_T_2 = mux(io.instRomEn, _instRomAddr_T_1, UInt<1>("h0")) @[PC.scala 18:23]
    instRomAddr <= _instRomAddr_T_2 @[PC.scala 18:17]
    io.instRomAddr <= instRomAddr @[PC.scala 25:20]
    io.instRomEn <= instRomEn @[PC.scala 26:18]

  module InstROM :
    input clock : Clock
    input reset : Reset
    output io : { flip ena : UInt<1>, flip rAddr : UInt<8>, rData : UInt<32>, flip wEn : UInt<1>, flip wAddr : UInt<8>, flip wData : UInt<32>}

    smem memBank : UInt<32> [256] @[InstROM.scala 21:30]
    wire _io_rData_WIRE : UInt @[InstROM.scala 24:30]
    _io_rData_WIRE is invalid @[InstROM.scala 24:30]
    when io.ena : @[InstROM.scala 24:30]
      _io_rData_WIRE <= io.rAddr @[InstROM.scala 24:30]
      node _io_rData_T = or(_io_rData_WIRE, UInt<8>("h0")) @[InstROM.scala 24:30]
      node _io_rData_T_1 = bits(_io_rData_T, 7, 0) @[InstROM.scala 24:30]
      read mport io_rData_MPORT = memBank[_io_rData_T_1], clock @[InstROM.scala 24:30]
    io.rData <= io_rData_MPORT @[InstROM.scala 24:15]
    node _T = and(io.ena, io.wEn) @[InstROM.scala 26:17]
    when _T : @[InstROM.scala 26:28]
      write mport MPORT = memBank[io.wAddr], clock
      MPORT <= io.wData

  module IFTop :
    input clock : Clock
    input reset : Reset
    output io : { instRomAddr : UInt<8>, instRomData : UInt<32>}

    reg instAddr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[IFTop.scala 16:27]
    inst pc of PC @[IFTop.scala 18:20]
    pc.clock <= clock
    pc.reset <= reset
    inst instROM of InstROM @[IFTop.scala 19:25]
    instROM.clock <= clock
    instROM.reset <= reset
    instROM.io.wEn is invalid @[IFTop.scala 21:20]
    instROM.io.wAddr is invalid @[IFTop.scala 22:22]
    instROM.io.wData is invalid @[IFTop.scala 23:22]
    node _instROM_io_rAddr_T = shr(pc.io.instRomAddr, 2) @[IFTop.scala 25:44]
    instROM.io.rAddr <= _instROM_io_rAddr_T @[IFTop.scala 25:22]
    instROM.io.ena <= pc.io.instRomEn @[IFTop.scala 26:20]
    io.instRomData <= instROM.io.rData @[IFTop.scala 28:20]
    node _instAddr_T = shr(pc.io.instRomAddr, 2) @[IFTop.scala 30:36]
    instAddr <= _instAddr_T @[IFTop.scala 30:14]
    io.instRomAddr <= instAddr @[IFTop.scala 31:20]

  module ID :
    input clock : Clock
    input reset : Reset
    output io : { flip instData : UInt<32>, flip r1RData : UInt<32>, flip r2RData : UInt<32>, r1REn : UInt<1>, r2REn : UInt<1>, r1RAddr : UInt<5>, r2RAddr : UInt<5>, iKind : UInt<8>, iSKind : UInt<3>, source1 : UInt<32>, source2 : UInt<32>, rWAddr : UInt<5>, rWEn : UInt<1>}

    wire op : UInt<6>
    op <= UInt<6>("h0")
    wire imm : UInt<32>
    imm <= UInt<32>("h0")
    node _op_T = bits(io.instData, 31, 26) @[ID.scala 36:22]
    op <= _op_T @[ID.scala 36:8]
    io.r1REn <= UInt<1>("h0") @[ID.scala 38:14]
    io.r2REn <= UInt<1>("h0") @[ID.scala 39:14]
    io.rWEn <= UInt<1>("h0") @[ID.scala 40:13]
    node _io_rWAddr_T = bits(io.instData, 20, 16) @[ID.scala 41:29]
    io.rWAddr <= _io_rWAddr_T @[ID.scala 41:15]
    node _io_r1RAddr_T = bits(io.instData, 25, 21) @[ID.scala 42:30]
    io.r1RAddr <= _io_r1RAddr_T @[ID.scala 42:16]
    node _io_r2RAddr_T = bits(io.instData, 20, 16) @[ID.scala 43:30]
    io.r2RAddr <= _io_r2RAddr_T @[ID.scala 43:16]
    io.iKind <= UInt<1>("h0") @[ID.scala 45:14]
    io.iSKind <= UInt<1>("h0") @[ID.scala 46:15]
    node _T = eq(UInt<4>("hd"), op) @[ID.scala 48:16]
    when _T : @[ID.scala 48:16]
      io.rWEn <= UInt<1>("h1") @[ID.scala 50:21]
      io.iKind <= UInt<6>("h25") @[ID.scala 51:22]
      io.iSKind <= UInt<1>("h1") @[ID.scala 52:23]
      io.r1REn <= UInt<1>("h1") @[ID.scala 53:22]
      io.r2REn <= UInt<1>("h0") @[ID.scala 54:22]
      node _imm_T = bits(io.instData, 15, 0) @[ID.scala 55:31]
      imm <= _imm_T @[ID.scala 55:17]
    node _T_1 = eq(io.r1REn, UInt<1>("h1")) @[ID.scala 59:19]
    when _T_1 : @[ID.scala 59:31]
      io.source1 <= io.r1RData @[ID.scala 60:20]
    else :
      node _T_2 = eq(io.r1REn, UInt<1>("h0")) @[ID.scala 61:25]
      when _T_2 : @[ID.scala 61:38]
        io.source1 <= imm @[ID.scala 62:20]
      else :
        io.source1 <= UInt<1>("h0") @[ID.scala 64:20]
    node _T_3 = eq(io.r2REn, UInt<1>("h1")) @[ID.scala 67:19]
    when _T_3 : @[ID.scala 67:31]
      io.source2 <= io.r2RData @[ID.scala 68:20]
    else :
      node _T_4 = eq(io.r2REn, UInt<1>("h0")) @[ID.scala 69:25]
      when _T_4 : @[ID.scala 69:38]
        io.source2 <= imm @[ID.scala 70:20]
      else :
        io.source2 <= UInt<1>("h0") @[ID.scala 72:20]

  module RegFile :
    input clock : Clock
    input reset : Reset
    output io : { flip rWEn : UInt<1>, flip r1REn : UInt<1>, flip r2REn : UInt<1>, flip rWAddr : UInt<5>, flip rWData : UInt<32>, flip r1RAddr : UInt<5>, r1RData : UInt<32>, flip r2RAddr : UInt<5>, r2RData : UInt<32>}

    cmem regBank : UInt<32> [32] @[RegFile.scala 28:22]
    node _T = neq(io.rWAddr, UInt<1>("h0")) @[RegFile.scala 31:32]
    node _T_1 = and(io.rWEn, _T) @[RegFile.scala 31:18]
    when _T_1 : @[RegFile.scala 31:43]
      write mport MPORT = regBank[io.rWAddr], clock
      MPORT <= io.rWData
    node _T_2 = eq(io.r1RAddr, UInt<1>("h0")) @[RegFile.scala 36:21]
    when _T_2 : @[RegFile.scala 36:30]
      io.r1RData <= UInt<1>("h0") @[RegFile.scala 37:20]
    else :
      node _T_3 = eq(io.r1RAddr, io.rWAddr) @[RegFile.scala 38:28]
      node _T_4 = eq(io.r1REn, UInt<1>("h1")) @[RegFile.scala 39:26]
      node _T_5 = and(_T_3, _T_4) @[RegFile.scala 39:13]
      node _T_6 = eq(io.rWEn, UInt<1>("h1")) @[RegFile.scala 40:25]
      node _T_7 = and(_T_5, _T_6) @[RegFile.scala 40:13]
      when _T_7 : @[RegFile.scala 40:38]
        io.r1RData <= io.rWData @[RegFile.scala 41:20]
      else :
        node _T_8 = eq(io.r1REn, UInt<1>("h1")) @[RegFile.scala 42:26]
        when _T_8 : @[RegFile.scala 42:39]
          read mport io_r1RData_MPORT = regBank[io.r1RAddr], clock @[RegFile.scala 43:35]
          io.r1RData <= io_r1RData_MPORT @[RegFile.scala 43:20]
        else :
          io.r1RData <= UInt<1>("h0") @[RegFile.scala 45:20]
    node _T_9 = eq(io.r2RAddr, UInt<1>("h0")) @[RegFile.scala 49:21]
    when _T_9 : @[RegFile.scala 49:30]
      io.r2RData <= UInt<1>("h0") @[RegFile.scala 50:20]
    else :
      node _T_10 = eq(io.r2RAddr, io.rWAddr) @[RegFile.scala 51:28]
      node _T_11 = eq(io.r2REn, UInt<1>("h1")) @[RegFile.scala 52:26]
      node _T_12 = and(_T_10, _T_11) @[RegFile.scala 52:13]
      node _T_13 = eq(io.rWEn, UInt<1>("h1")) @[RegFile.scala 53:25]
      node _T_14 = and(_T_12, _T_13) @[RegFile.scala 53:13]
      when _T_14 : @[RegFile.scala 53:38]
        io.r2RData <= io.rWData @[RegFile.scala 54:20]
      else :
        node _T_15 = eq(io.r2REn, UInt<1>("h1")) @[RegFile.scala 55:25]
        when _T_15 : @[RegFile.scala 55:37]
          read mport io_r2RData_MPORT = regBank[io.r2RAddr], clock @[RegFile.scala 56:35]
          io.r2RData <= io_r2RData_MPORT @[RegFile.scala 56:20]
        else :
          io.r2RData <= UInt<2>("h2") @[RegFile.scala 58:20]

  module IDTop :
    input clock : Clock
    input reset : Reset
    output io : { flip instAddr : UInt<8>, flip instData : UInt<32>, iKind : UInt<8>, iSKind : UInt<3>, source1 : UInt<32>, source2 : UInt<32>, rWAddr : UInt<5>, rWEn : UInt<1>}

    inst id of ID @[IDTop.scala 26:20]
    id.clock <= clock
    id.reset <= reset
    inst rf of RegFile @[IDTop.scala 27:20]
    rf.clock <= clock
    rf.reset <= reset
    id.io.instData <= io.instData @[IDTop.scala 29:20]
    rf.io.r1REn <= id.io.r1REn @[IDTop.scala 31:17]
    rf.io.r2REn <= id.io.r2REn @[IDTop.scala 32:17]
    rf.io.r1RAddr <= id.io.r1RAddr @[IDTop.scala 33:19]
    rf.io.r2RAddr <= id.io.r2RAddr @[IDTop.scala 34:19]
    id.io.r1RData <= rf.io.r1RData @[IDTop.scala 36:19]
    id.io.r2RData <= rf.io.r2RData @[IDTop.scala 37:19]
    io.source1 <= id.io.source1 @[IDTop.scala 39:16]
    io.source2 <= id.io.source2 @[IDTop.scala 40:16]
    io.rWEn <= id.io.rWEn @[IDTop.scala 42:13]
    io.rWAddr <= id.io.rWAddr @[IDTop.scala 43:15]
    io.iKind <= id.io.iKind @[IDTop.scala 45:14]
    io.iSKind <= id.io.iSKind @[IDTop.scala 46:15]
    rf.io.rWEn is invalid @[IDTop.scala 48:16]
    rf.io.rWAddr is invalid @[IDTop.scala 49:18]
    rf.io.rWData is invalid @[IDTop.scala 50:18]

  module Top :
    input clock : Clock
    input reset : UInt<1>
    output io : { iKind : UInt<8>, iSKind : UInt<3>, source1 : UInt<32>, source2 : UInt<32>, rWAddr : UInt<5>, rWEn : UInt<1>}

    inst iftop of IFTop @[Top.scala 24:23]
    iftop.clock <= clock
    iftop.reset <= reset
    inst idTop of IDTop @[Top.scala 25:23]
    idTop.clock <= clock
    idTop.reset <= reset
    idTop.io.instData <= iftop.io.instRomData @[Top.scala 27:23]
    idTop.io.instAddr <= iftop.io.instRomAddr @[Top.scala 28:23]
    io.iKind <= idTop.io.iKind @[Top.scala 30:14]
    io.iSKind <= idTop.io.iSKind @[Top.scala 31:15]
    io.source1 <= idTop.io.source1 @[Top.scala 32:16]
    io.source2 <= idTop.io.source2 @[Top.scala 33:16]
    io.rWAddr <= idTop.io.rWAddr @[Top.scala 34:15]
    io.rWEn <= idTop.io.rWEn @[Top.scala 35:13]

