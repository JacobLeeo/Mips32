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
      reset => (reset, UInt<1>("h0")) @[InstROM.scala 19:25]
    wire iAdRS2 : UInt
    iAdRS2 <= UInt<1>("h0")
    smem memBank : UInt<32> [256] @[InstROM.scala 31:30]
    io.outToD.iRRdDt <= UInt<1>("h0") @[InstROM.scala 37:22]
    enable <= io.inFromPC.iREn @[InstROM.scala 38:12]
    node _iAdRS2_T = shr(io.inFromPC.iRRdAd, 2) @[InstROM.scala 40:34]
    iAdRS2 <= _iAdRS2_T @[InstROM.scala 40:12]
    when enable : @[InstROM.scala 42:18]
      node _rdwrPort_T = or(iAdRS2, UInt<8>("h0")) @[InstROM.scala 43:31]
      node _rdwrPort_T_1 = bits(_rdwrPort_T, 7, 0) @[InstROM.scala 43:31]
      infer mport rdwrPort = memBank[_rdwrPort_T_1], clock @[InstROM.scala 43:31]
      when io.inFromPC.iRWrEn : @[InstROM.scala 44:34]
        rdwrPort <= io.inFromPC.iRWrDt @[InstROM.scala 45:22]
      else :
        io.outToD.iRRdDt <= rdwrPort @[InstROM.scala 47:30]

  module DBtIFID :
    input clock : Clock
    input reset : Reset
    output io : { flip inFromIF : { iRRdDt : UInt<32>}, outToID : { iRRdDt : UInt<32>}}

    wire instRomData : UInt<32>
    instRomData <= UInt<32>("h0")
    instRomData <= io.inFromIF.iRRdDt @[DBtIFID.scala 17:17]
    io.outToID.iRRdDt <= instRomData @[DBtIFID.scala 18:23]

  module IFTop :
    input clock : Clock
    input reset : Reset
    output io : { outToID : { iRRdDt : UInt<32>}}

    inst pc of PC @[IFTop.scala 17:20]
    pc.clock <= clock
    pc.reset <= reset
    inst ir of InstROM @[IFTop.scala 18:20]
    ir.clock <= clock
    ir.reset <= reset
    inst d of DBtIFID @[IFTop.scala 19:19]
    d.clock <= clock
    d.reset <= reset
    ir.io.inFromPC.iRWrDt <= pc.io.outToIR.iRWrDt @[IFTop.scala 21:20]
    ir.io.inFromPC.iRWrEn <= pc.io.outToIR.iRWrEn @[IFTop.scala 21:20]
    ir.io.inFromPC.iRRdAd <= pc.io.outToIR.iRRdAd @[IFTop.scala 21:20]
    ir.io.inFromPC.iREn <= pc.io.outToIR.iREn @[IFTop.scala 21:20]
    d.io.inFromIF.iRRdDt <= ir.io.outToD.iRRdDt @[IFTop.scala 22:19]
    io.outToID.iRRdDt <= d.io.outToID.iRRdDt @[IFTop.scala 23:16]

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
    output io : { flip inFromID : { r1REn : UInt<1>, r2REn : UInt<1>, r1RAddr : UInt<5>, r2RAddr : UInt<5>}, flip inFromWB : { rWAddrO : UInt<5>, rWEnO : UInt<1>, rWDataO : UInt<32>}, outToID : { r1RData : UInt<32>, r2RData : UInt<32>}, outToIDTop : { r1Out : UInt<32>, r2Out : UInt<32>, r3Out : UInt<32>, r4Out : UInt<32>, r5Out : UInt<32>, r6Out : UInt<32>, r7Out : UInt<32>, r8Out : UInt<32>, r9Out : UInt<32>, r10Out : UInt<32>, r11Out : UInt<32>, r12Out : UInt<32>, r13Out : UInt<32>, r14Out : UInt<32>, r15Out : UInt<32>, r16Out : UInt<32>, r17Out : UInt<32>, r18Out : UInt<32>, r19Out : UInt<32>, r20Out : UInt<32>, r21Out : UInt<32>, r22Out : UInt<32>, r23Out : UInt<32>, r24Out : UInt<32>, r25Out : UInt<32>, r26Out : UInt<32>, r27Out : UInt<32>, r28Out : UInt<32>, r29Out : UInt<32>, r30Out : UInt<32>, r31Out : UInt<32>}}

    cmem regBank : UInt<32> [32] @[RegFile.scala 17:22]
    node _T = neq(io.inFromWB.rWAddrO, UInt<1>("h0")) @[RegFile.scala 20:52]
    node _T_1 = and(io.inFromWB.rWEnO, _T) @[RegFile.scala 20:28]
    when _T_1 : @[RegFile.scala 20:63]
      write mport MPORT = regBank[io.inFromWB.rWAddrO], clock
      MPORT <= io.inFromWB.rWDataO
    node _T_2 = eq(io.inFromID.r1RAddr, UInt<1>("h0")) @[RegFile.scala 25:30]
    when _T_2 : @[RegFile.scala 25:39]
      io.outToID.r1RData <= UInt<1>("h0") @[RegFile.scala 26:28]
    else :
      node _T_3 = eq(io.inFromID.r1RAddr, io.inFromWB.rWAddrO) @[RegFile.scala 27:37]
      node _T_4 = eq(io.inFromID.r1REn, UInt<1>("h1")) @[RegFile.scala 28:35]
      node _T_5 = and(_T_3, _T_4) @[RegFile.scala 28:13]
      node _T_6 = eq(io.inFromWB.rWEnO, UInt<1>("h1")) @[RegFile.scala 29:35]
      node _T_7 = and(_T_5, _T_6) @[RegFile.scala 29:13]
      when _T_7 : @[RegFile.scala 29:48]
        io.outToID.r1RData <= io.inFromWB.rWDataO @[RegFile.scala 30:28]
      else :
        node _T_8 = eq(io.inFromID.r1REn, UInt<1>("h1")) @[RegFile.scala 31:35]
        when _T_8 : @[RegFile.scala 31:48]
          read mport io_outToID_r1RData_MPORT = regBank[io.inFromID.r1RAddr], clock @[RegFile.scala 32:43]
          io.outToID.r1RData <= io_outToID_r1RData_MPORT @[RegFile.scala 32:28]
        else :
          io.outToID.r1RData <= UInt<32>("h0") @[RegFile.scala 34:28]
    node _T_9 = eq(io.inFromID.r2RAddr, UInt<1>("h0")) @[RegFile.scala 38:30]
    when _T_9 : @[RegFile.scala 38:39]
      io.outToID.r2RData <= UInt<1>("h0") @[RegFile.scala 39:28]
    else :
      node _T_10 = eq(io.inFromID.r2RAddr, io.inFromWB.rWAddrO) @[RegFile.scala 40:37]
      node _T_11 = eq(io.inFromID.r2REn, UInt<1>("h1")) @[RegFile.scala 41:35]
      node _T_12 = and(_T_10, _T_11) @[RegFile.scala 41:13]
      node _T_13 = eq(io.inFromWB.rWEnO, UInt<1>("h1")) @[RegFile.scala 42:35]
      node _T_14 = and(_T_12, _T_13) @[RegFile.scala 42:13]
      when _T_14 : @[RegFile.scala 42:48]
        io.outToID.r2RData <= io.inFromWB.rWDataO @[RegFile.scala 43:28]
      else :
        node _T_15 = eq(io.inFromID.r2REn, UInt<1>("h1")) @[RegFile.scala 44:34]
        when _T_15 : @[RegFile.scala 44:46]
          read mport io_outToID_r2RData_MPORT = regBank[io.inFromID.r2RAddr], clock @[RegFile.scala 45:43]
          io.outToID.r2RData <= io_outToID_r2RData_MPORT @[RegFile.scala 45:28]
        else :
          io.outToID.r2RData <= UInt<1>("h0") @[RegFile.scala 47:28]
    read mport io_outToIDTop_r1Out_MPORT = regBank[UInt<1>("h1")], clock @[RegFile.scala 50:40]
    io.outToIDTop.r1Out <= io_outToIDTop_r1Out_MPORT @[RegFile.scala 50:25]
    read mport io_outToIDTop_r2Out_MPORT = regBank[UInt<2>("h2")], clock @[RegFile.scala 51:40]
    io.outToIDTop.r2Out <= io_outToIDTop_r2Out_MPORT @[RegFile.scala 51:25]
    read mport io_outToIDTop_r3Out_MPORT = regBank[UInt<2>("h3")], clock @[RegFile.scala 52:40]
    io.outToIDTop.r3Out <= io_outToIDTop_r3Out_MPORT @[RegFile.scala 52:25]
    read mport io_outToIDTop_r4Out_MPORT = regBank[UInt<3>("h4")], clock @[RegFile.scala 53:40]
    io.outToIDTop.r4Out <= io_outToIDTop_r4Out_MPORT @[RegFile.scala 53:25]
    read mport io_outToIDTop_r5Out_MPORT = regBank[UInt<3>("h5")], clock @[RegFile.scala 54:40]
    io.outToIDTop.r5Out <= io_outToIDTop_r5Out_MPORT @[RegFile.scala 54:25]
    read mport io_outToIDTop_r6Out_MPORT = regBank[UInt<3>("h6")], clock @[RegFile.scala 55:40]
    io.outToIDTop.r6Out <= io_outToIDTop_r6Out_MPORT @[RegFile.scala 55:25]
    read mport io_outToIDTop_r7Out_MPORT = regBank[UInt<3>("h7")], clock @[RegFile.scala 56:40]
    io.outToIDTop.r7Out <= io_outToIDTop_r7Out_MPORT @[RegFile.scala 56:25]
    read mport io_outToIDTop_r8Out_MPORT = regBank[UInt<4>("h8")], clock @[RegFile.scala 57:40]
    io.outToIDTop.r8Out <= io_outToIDTop_r8Out_MPORT @[RegFile.scala 57:25]
    read mport io_outToIDTop_r9Out_MPORT = regBank[UInt<4>("h9")], clock @[RegFile.scala 58:40]
    io.outToIDTop.r9Out <= io_outToIDTop_r9Out_MPORT @[RegFile.scala 58:25]
    read mport io_outToIDTop_r10Out_MPORT = regBank[UInt<4>("ha")], clock @[RegFile.scala 59:41]
    io.outToIDTop.r10Out <= io_outToIDTop_r10Out_MPORT @[RegFile.scala 59:26]
    read mport io_outToIDTop_r11Out_MPORT = regBank[UInt<4>("hb")], clock @[RegFile.scala 60:41]
    io.outToIDTop.r11Out <= io_outToIDTop_r11Out_MPORT @[RegFile.scala 60:26]
    read mport io_outToIDTop_r12Out_MPORT = regBank[UInt<4>("hc")], clock @[RegFile.scala 61:41]
    io.outToIDTop.r12Out <= io_outToIDTop_r12Out_MPORT @[RegFile.scala 61:26]
    read mport io_outToIDTop_r13Out_MPORT = regBank[UInt<4>("hd")], clock @[RegFile.scala 62:41]
    io.outToIDTop.r13Out <= io_outToIDTop_r13Out_MPORT @[RegFile.scala 62:26]
    read mport io_outToIDTop_r14Out_MPORT = regBank[UInt<4>("he")], clock @[RegFile.scala 63:41]
    io.outToIDTop.r14Out <= io_outToIDTop_r14Out_MPORT @[RegFile.scala 63:26]
    read mport io_outToIDTop_r15Out_MPORT = regBank[UInt<4>("hf")], clock @[RegFile.scala 64:41]
    io.outToIDTop.r15Out <= io_outToIDTop_r15Out_MPORT @[RegFile.scala 64:26]
    read mport io_outToIDTop_r16Out_MPORT = regBank[UInt<5>("h10")], clock @[RegFile.scala 65:41]
    io.outToIDTop.r16Out <= io_outToIDTop_r16Out_MPORT @[RegFile.scala 65:26]
    read mport io_outToIDTop_r17Out_MPORT = regBank[UInt<5>("h11")], clock @[RegFile.scala 66:41]
    io.outToIDTop.r17Out <= io_outToIDTop_r17Out_MPORT @[RegFile.scala 66:26]
    read mport io_outToIDTop_r18Out_MPORT = regBank[UInt<5>("h12")], clock @[RegFile.scala 67:41]
    io.outToIDTop.r18Out <= io_outToIDTop_r18Out_MPORT @[RegFile.scala 67:26]
    read mport io_outToIDTop_r19Out_MPORT = regBank[UInt<5>("h13")], clock @[RegFile.scala 68:41]
    io.outToIDTop.r19Out <= io_outToIDTop_r19Out_MPORT @[RegFile.scala 68:26]
    read mport io_outToIDTop_r20Out_MPORT = regBank[UInt<5>("h14")], clock @[RegFile.scala 69:41]
    io.outToIDTop.r20Out <= io_outToIDTop_r20Out_MPORT @[RegFile.scala 69:26]
    read mport io_outToIDTop_r21Out_MPORT = regBank[UInt<5>("h15")], clock @[RegFile.scala 70:41]
    io.outToIDTop.r21Out <= io_outToIDTop_r21Out_MPORT @[RegFile.scala 70:26]
    read mport io_outToIDTop_r22Out_MPORT = regBank[UInt<5>("h16")], clock @[RegFile.scala 71:41]
    io.outToIDTop.r22Out <= io_outToIDTop_r22Out_MPORT @[RegFile.scala 71:26]
    read mport io_outToIDTop_r23Out_MPORT = regBank[UInt<5>("h17")], clock @[RegFile.scala 72:41]
    io.outToIDTop.r23Out <= io_outToIDTop_r23Out_MPORT @[RegFile.scala 72:26]
    read mport io_outToIDTop_r24Out_MPORT = regBank[UInt<5>("h18")], clock @[RegFile.scala 73:41]
    io.outToIDTop.r24Out <= io_outToIDTop_r24Out_MPORT @[RegFile.scala 73:26]
    read mport io_outToIDTop_r25Out_MPORT = regBank[UInt<5>("h19")], clock @[RegFile.scala 74:41]
    io.outToIDTop.r25Out <= io_outToIDTop_r25Out_MPORT @[RegFile.scala 74:26]
    read mport io_outToIDTop_r26Out_MPORT = regBank[UInt<5>("h1a")], clock @[RegFile.scala 75:41]
    io.outToIDTop.r26Out <= io_outToIDTop_r26Out_MPORT @[RegFile.scala 75:26]
    read mport io_outToIDTop_r27Out_MPORT = regBank[UInt<5>("h1b")], clock @[RegFile.scala 76:41]
    io.outToIDTop.r27Out <= io_outToIDTop_r27Out_MPORT @[RegFile.scala 76:26]
    read mport io_outToIDTop_r28Out_MPORT = regBank[UInt<5>("h1c")], clock @[RegFile.scala 77:41]
    io.outToIDTop.r28Out <= io_outToIDTop_r28Out_MPORT @[RegFile.scala 77:26]
    read mport io_outToIDTop_r29Out_MPORT = regBank[UInt<5>("h1d")], clock @[RegFile.scala 78:41]
    io.outToIDTop.r29Out <= io_outToIDTop_r29Out_MPORT @[RegFile.scala 78:26]
    read mport io_outToIDTop_r30Out_MPORT = regBank[UInt<5>("h1e")], clock @[RegFile.scala 79:41]
    io.outToIDTop.r30Out <= io_outToIDTop_r30Out_MPORT @[RegFile.scala 79:26]
    read mport io_outToIDTop_r31Out_MPORT = regBank[UInt<5>("h1f")], clock @[RegFile.scala 80:41]
    io.outToIDTop.r31Out <= io_outToIDTop_r31Out_MPORT @[RegFile.scala 80:26]

  module DC :
    input clock : Clock
    input reset : Reset
    output io : { flip inFromIDTop : { fromIFTop : { iRRdDt : UInt<32>}, fromEXTop : { rWAddrO : UInt<5>, rWEnO : UInt<1>, rWDataO : UInt<32>}, fromMEMTop : { rWAddrO : UInt<5>, rWEnO : UInt<1>, rWDataO : UInt<32>}}, flip inFromRF : { r1RData : UInt<32>, r2RData : UInt<32>}, outToD : { iSK : UInt<8>, iK : UInt<3>, source1 : UInt<32>, source2 : UInt<32>, rWAddr : UInt<5>, rWEn : UInt<1>}, outToRF : { r1REn : UInt<1>, r2REn : UInt<1>, r1RAddr : UInt<5>, r2RAddr : UInt<5>}}

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
    node _op_T = bits(io.inFromIDTop.fromIFTop.iRRdDt, 31, 26) @[DC.scala 34:42]
    op <= _op_T @[DC.scala 34:8]
    node _io_outToD_rWAddr_T = bits(io.inFromIDTop.fromIFTop.iRRdDt, 20, 16) @[DC.scala 35:56]
    io.outToD.rWAddr <= _io_outToD_rWAddr_T @[DC.scala 35:22]
    node _io_outToRF_r1RAddr_T = bits(io.inFromIDTop.fromIFTop.iRRdDt, 25, 21) @[DC.scala 36:58]
    io.outToRF.r1RAddr <= _io_outToRF_r1RAddr_T @[DC.scala 36:24]
    node _io_outToRF_r2RAddr_T = bits(io.inFromIDTop.fromIFTop.iRRdDt, 20, 16) @[DC.scala 37:58]
    io.outToRF.r2RAddr <= _io_outToRF_r2RAddr_T @[DC.scala 37:24]
    node _T = eq(UInt<4>("hd"), op) @[DC.scala 40:16]
    when _T : @[DC.scala 40:16]
      io.outToD.rWEn <= UInt<1>("h1") @[DC.scala 42:28]
      io.outToRF.r1REn <= UInt<1>("h1") @[DC.scala 43:30]
      io.outToRF.r2REn <= UInt<1>("h0") @[DC.scala 44:30]
      io.outToD.iSK <= UInt<6>("h25") @[DC.scala 45:27]
      io.outToD.iK <= UInt<1>("h1") @[DC.scala 46:26]
      node _imm_T = bits(io.inFromIDTop.fromIFTop.iRRdDt, 15, 0) @[DC.scala 47:51]
      imm <= _imm_T @[DC.scala 47:17]
    node _T_1 = eq(io.outToRF.r1REn, UInt<1>("h1")) @[DC.scala 50:28]
    node _T_2 = eq(io.inFromIDTop.fromEXTop.rWEnO, UInt<1>("h1")) @[DC.scala 51:48]
    node _T_3 = and(_T_1, _T_2) @[DC.scala 51:13]
    node _T_4 = eq(io.inFromIDTop.fromEXTop.rWAddrO, io.outToRF.r1RAddr) @[DC.scala 52:50]
    node _T_5 = and(_T_3, _T_4) @[DC.scala 52:13]
    when _T_5 : @[DC.scala 52:75]
      io.outToD.source1 <= io.inFromIDTop.fromEXTop.rWDataO @[DC.scala 53:27]
    else :
      node _T_6 = eq(io.outToRF.r1REn, UInt<1>("h1")) @[DC.scala 54:34]
      node _T_7 = eq(io.inFromIDTop.fromMEMTop.rWEnO, UInt<1>("h1")) @[DC.scala 55:49]
      node _T_8 = and(_T_6, _T_7) @[DC.scala 55:13]
      node _T_9 = eq(io.inFromIDTop.fromMEMTop.rWAddrO, io.outToRF.r1RAddr) @[DC.scala 56:51]
      node _T_10 = and(_T_8, _T_9) @[DC.scala 56:13]
      when _T_10 : @[DC.scala 56:76]
        io.outToD.source1 <= io.inFromIDTop.fromMEMTop.rWDataO @[DC.scala 57:27]
      else :
        node _T_11 = eq(io.outToRF.r1REn, UInt<1>("h1")) @[DC.scala 58:33]
        when _T_11 : @[DC.scala 58:45]
          io.outToD.source1 <= io.inFromRF.r1RData @[DC.scala 59:27]
        else :
          node _T_12 = eq(io.outToRF.r1REn, UInt<1>("h0")) @[DC.scala 60:33]
          when _T_12 : @[DC.scala 60:46]
            io.outToD.source1 <= imm @[DC.scala 61:27]
    node _T_13 = eq(io.outToRF.r2REn, UInt<1>("h1")) @[DC.scala 64:28]
    node _T_14 = eq(io.inFromIDTop.fromEXTop.rWEnO, UInt<1>("h1")) @[DC.scala 65:48]
    node _T_15 = and(_T_13, _T_14) @[DC.scala 65:13]
    node _T_16 = eq(io.inFromIDTop.fromEXTop.rWAddrO, io.outToRF.r2RAddr) @[DC.scala 66:50]
    node _T_17 = and(_T_15, _T_16) @[DC.scala 66:13]
    when _T_17 : @[DC.scala 66:75]
      io.outToD.source2 <= io.inFromIDTop.fromEXTop.rWDataO @[DC.scala 67:27]
    else :
      node _T_18 = eq(io.outToRF.r2REn, UInt<1>("h1")) @[DC.scala 68:34]
      node _T_19 = eq(io.inFromIDTop.fromMEMTop.rWEnO, UInt<1>("h1")) @[DC.scala 69:49]
      node _T_20 = and(_T_18, _T_19) @[DC.scala 69:13]
      node _T_21 = eq(io.inFromIDTop.fromMEMTop.rWAddrO, io.outToRF.r2RAddr) @[DC.scala 70:51]
      node _T_22 = and(_T_20, _T_21) @[DC.scala 70:13]
      when _T_22 : @[DC.scala 70:76]
        io.outToD.source2 <= io.inFromIDTop.fromMEMTop.rWDataO @[DC.scala 71:27]
      else :
        node _T_23 = eq(io.outToRF.r2REn, UInt<1>("h1")) @[DC.scala 72:33]
        when _T_23 : @[DC.scala 72:45]
          io.outToD.source2 <= io.inFromRF.r2RData @[DC.scala 73:27]
        else :
          node _T_24 = eq(io.outToRF.r2REn, UInt<1>("h0")) @[DC.scala 74:33]
          when _T_24 : @[DC.scala 74:46]
            io.outToD.source2 <= imm @[DC.scala 75:27]

  module IDTop :
    input clock : Clock
    input reset : Reset
    output io : { flip inFromIF : { iRRdDt : UInt<32>}, flip inFromWB : { rWAddrO : UInt<5>, rWEnO : UInt<1>, rWDataO : UInt<32>}, flip inFromEX : { rWAddrO : UInt<5>, rWEnO : UInt<1>, rWDataO : UInt<32>}, flip inFromMEM : { rWAddrO : UInt<5>, rWEnO : UInt<1>, rWDataO : UInt<32>}, outToTop : { fromRF : { r1Out : UInt<32>, r2Out : UInt<32>, r3Out : UInt<32>, r4Out : UInt<32>, r5Out : UInt<32>, r6Out : UInt<32>, r7Out : UInt<32>, r8Out : UInt<32>, r9Out : UInt<32>, r10Out : UInt<32>, r11Out : UInt<32>, r12Out : UInt<32>, r13Out : UInt<32>, r14Out : UInt<32>, r15Out : UInt<32>, r16Out : UInt<32>, r17Out : UInt<32>, r18Out : UInt<32>, r19Out : UInt<32>, r20Out : UInt<32>, r21Out : UInt<32>, r22Out : UInt<32>, r23Out : UInt<32>, r24Out : UInt<32>, r25Out : UInt<32>, r26Out : UInt<32>, r27Out : UInt<32>, r28Out : UInt<32>, r29Out : UInt<32>, r30Out : UInt<32>, r31Out : UInt<32>}}, outToEX : { iSK : UInt<8>, iK : UInt<3>, source1 : UInt<32>, source2 : UInt<32>, rWAddr : UInt<5>, rWEn : UInt<1>}}

    inst d of DbtIDEX @[IDTop.scala 20:19]
    d.clock <= clock
    d.reset <= reset
    inst rf of RegFile @[IDTop.scala 21:20]
    rf.clock <= clock
    rf.reset <= reset
    inst dc of DC @[IDTop.scala 22:20]
    dc.clock <= clock
    dc.reset <= reset
    dc.io.inFromIDTop.fromIFTop.iRRdDt <= io.inFromIF.iRRdDt @[IDTop.scala 24:33]
    dc.io.inFromIDTop.fromEXTop.rWDataO <= io.inFromEX.rWDataO @[IDTop.scala 25:33]
    dc.io.inFromIDTop.fromEXTop.rWEnO <= io.inFromEX.rWEnO @[IDTop.scala 25:33]
    dc.io.inFromIDTop.fromEXTop.rWAddrO <= io.inFromEX.rWAddrO @[IDTop.scala 25:33]
    dc.io.inFromIDTop.fromMEMTop.rWDataO <= io.inFromMEM.rWDataO @[IDTop.scala 26:34]
    dc.io.inFromIDTop.fromMEMTop.rWEnO <= io.inFromMEM.rWEnO @[IDTop.scala 26:34]
    dc.io.inFromIDTop.fromMEMTop.rWAddrO <= io.inFromMEM.rWAddrO @[IDTop.scala 26:34]
    dc.io.inFromRF.r2RData <= rf.io.outToID.r2RData @[IDTop.scala 28:20]
    dc.io.inFromRF.r1RData <= rf.io.outToID.r1RData @[IDTop.scala 28:20]
    rf.io.inFromID.r2RAddr <= dc.io.outToRF.r2RAddr @[IDTop.scala 29:20]
    rf.io.inFromID.r1RAddr <= dc.io.outToRF.r1RAddr @[IDTop.scala 29:20]
    rf.io.inFromID.r2REn <= dc.io.outToRF.r2REn @[IDTop.scala 29:20]
    rf.io.inFromID.r1REn <= dc.io.outToRF.r1REn @[IDTop.scala 29:20]
    d.io.inFromID.rWEn <= dc.io.outToD.rWEn @[IDTop.scala 30:19]
    d.io.inFromID.rWAddr <= dc.io.outToD.rWAddr @[IDTop.scala 30:19]
    d.io.inFromID.source2 <= dc.io.outToD.source2 @[IDTop.scala 30:19]
    d.io.inFromID.source1 <= dc.io.outToD.source1 @[IDTop.scala 30:19]
    d.io.inFromID.iK <= dc.io.outToD.iK @[IDTop.scala 30:19]
    d.io.inFromID.iSK <= dc.io.outToD.iSK @[IDTop.scala 30:19]
    io.outToEX.rWEn <= d.io.outToEX.rWEn @[IDTop.scala 31:16]
    io.outToEX.rWAddr <= d.io.outToEX.rWAddr @[IDTop.scala 31:16]
    io.outToEX.source2 <= d.io.outToEX.source2 @[IDTop.scala 31:16]
    io.outToEX.source1 <= d.io.outToEX.source1 @[IDTop.scala 31:16]
    io.outToEX.iK <= d.io.outToEX.iK @[IDTop.scala 31:16]
    io.outToEX.iSK <= d.io.outToEX.iSK @[IDTop.scala 31:16]
    rf.io.inFromWB.rWDataO <= io.inFromWB.rWDataO @[IDTop.scala 33:20]
    rf.io.inFromWB.rWEnO <= io.inFromWB.rWEnO @[IDTop.scala 33:20]
    rf.io.inFromWB.rWAddrO <= io.inFromWB.rWAddrO @[IDTop.scala 33:20]
    io.outToTop.fromRF.r31Out <= rf.io.outToIDTop.r31Out @[IDTop.scala 35:24]
    io.outToTop.fromRF.r30Out <= rf.io.outToIDTop.r30Out @[IDTop.scala 35:24]
    io.outToTop.fromRF.r29Out <= rf.io.outToIDTop.r29Out @[IDTop.scala 35:24]
    io.outToTop.fromRF.r28Out <= rf.io.outToIDTop.r28Out @[IDTop.scala 35:24]
    io.outToTop.fromRF.r27Out <= rf.io.outToIDTop.r27Out @[IDTop.scala 35:24]
    io.outToTop.fromRF.r26Out <= rf.io.outToIDTop.r26Out @[IDTop.scala 35:24]
    io.outToTop.fromRF.r25Out <= rf.io.outToIDTop.r25Out @[IDTop.scala 35:24]
    io.outToTop.fromRF.r24Out <= rf.io.outToIDTop.r24Out @[IDTop.scala 35:24]
    io.outToTop.fromRF.r23Out <= rf.io.outToIDTop.r23Out @[IDTop.scala 35:24]
    io.outToTop.fromRF.r22Out <= rf.io.outToIDTop.r22Out @[IDTop.scala 35:24]
    io.outToTop.fromRF.r21Out <= rf.io.outToIDTop.r21Out @[IDTop.scala 35:24]
    io.outToTop.fromRF.r20Out <= rf.io.outToIDTop.r20Out @[IDTop.scala 35:24]
    io.outToTop.fromRF.r19Out <= rf.io.outToIDTop.r19Out @[IDTop.scala 35:24]
    io.outToTop.fromRF.r18Out <= rf.io.outToIDTop.r18Out @[IDTop.scala 35:24]
    io.outToTop.fromRF.r17Out <= rf.io.outToIDTop.r17Out @[IDTop.scala 35:24]
    io.outToTop.fromRF.r16Out <= rf.io.outToIDTop.r16Out @[IDTop.scala 35:24]
    io.outToTop.fromRF.r15Out <= rf.io.outToIDTop.r15Out @[IDTop.scala 35:24]
    io.outToTop.fromRF.r14Out <= rf.io.outToIDTop.r14Out @[IDTop.scala 35:24]
    io.outToTop.fromRF.r13Out <= rf.io.outToIDTop.r13Out @[IDTop.scala 35:24]
    io.outToTop.fromRF.r12Out <= rf.io.outToIDTop.r12Out @[IDTop.scala 35:24]
    io.outToTop.fromRF.r11Out <= rf.io.outToIDTop.r11Out @[IDTop.scala 35:24]
    io.outToTop.fromRF.r10Out <= rf.io.outToIDTop.r10Out @[IDTop.scala 35:24]
    io.outToTop.fromRF.r9Out <= rf.io.outToIDTop.r9Out @[IDTop.scala 35:24]
    io.outToTop.fromRF.r8Out <= rf.io.outToIDTop.r8Out @[IDTop.scala 35:24]
    io.outToTop.fromRF.r7Out <= rf.io.outToIDTop.r7Out @[IDTop.scala 35:24]
    io.outToTop.fromRF.r6Out <= rf.io.outToIDTop.r6Out @[IDTop.scala 35:24]
    io.outToTop.fromRF.r5Out <= rf.io.outToIDTop.r5Out @[IDTop.scala 35:24]
    io.outToTop.fromRF.r4Out <= rf.io.outToIDTop.r4Out @[IDTop.scala 35:24]
    io.outToTop.fromRF.r3Out <= rf.io.outToIDTop.r3Out @[IDTop.scala 35:24]
    io.outToTop.fromRF.r2Out <= rf.io.outToIDTop.r2Out @[IDTop.scala 35:24]
    io.outToTop.fromRF.r1Out <= rf.io.outToIDTop.r1Out @[IDTop.scala 35:24]

  module EX :
    input clock : Clock
    input reset : Reset
    output io : { flip inFromD : { iSK : UInt<8>, iK : UInt<3>, source1 : UInt<32>, source2 : UInt<32>, rWAddr : UInt<5>, rWEn : UInt<1>}, outToD : { rWAddrO : UInt<5>, rWEnO : UInt<1>, rWDataO : UInt<32>}, outToEXTop : { rWAddrO : UInt<5>, rWEnO : UInt<1>, rWDataO : UInt<32>}}

    wire logicResult : UInt<32>
    logicResult <= UInt<32>("h0")
    io.outToD.rWAddrO <= io.inFromD.rWAddr @[EX.scala 21:23]
    io.outToD.rWEnO <= io.inFromD.rWEn @[EX.scala 22:21]
    io.outToD.rWDataO <= UInt<1>("h0") @[EX.scala 24:23]
    io.outToEXTop.rWDataO <= io.outToD.rWDataO @[EX.scala 26:19]
    io.outToEXTop.rWEnO <= io.outToD.rWEnO @[EX.scala 26:19]
    io.outToEXTop.rWAddrO <= io.outToD.rWAddrO @[EX.scala 26:19]
    node _T = eq(UInt<6>("h25"), io.inFromD.iSK) @[EX.scala 30:28]
    when _T : @[EX.scala 30:28]
      node _logicResult_T = or(io.inFromD.source1, io.inFromD.source2) @[EX.scala 32:47]
      logicResult <= _logicResult_T @[EX.scala 32:25]
    node _T_1 = eq(UInt<1>("h1"), io.inFromD.iK) @[EX.scala 37:27]
    when _T_1 : @[EX.scala 37:27]
      io.outToD.rWDataO <= logicResult @[EX.scala 39:31]

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
    output io : { flip inFromID : { iSK : UInt<8>, iK : UInt<3>, source1 : UInt<32>, source2 : UInt<32>, rWAddr : UInt<5>, rWEn : UInt<1>}, outToMEM : { rWAddrO : UInt<5>, rWEnO : UInt<1>, rWDataO : UInt<32>}, outToID : { rWAddrO : UInt<5>, rWEnO : UInt<1>, rWDataO : UInt<32>}}

    inst ex of EX @[EXTop.scala 15:20]
    ex.clock <= clock
    ex.reset <= reset
    inst d of DbtEXMEM @[EXTop.scala 16:19]
    d.clock <= clock
    d.reset <= reset
    io.outToID.rWDataO <= ex.io.outToEXTop.rWDataO @[EXTop.scala 18:22]
    io.outToID.rWEnO <= ex.io.outToEXTop.rWEnO @[EXTop.scala 18:22]
    io.outToID.rWAddrO <= ex.io.outToEXTop.rWAddrO @[EXTop.scala 18:22]
    ex.io.inFromD.rWEn <= io.inFromID.rWEn @[EXTop.scala 19:19]
    ex.io.inFromD.rWAddr <= io.inFromID.rWAddr @[EXTop.scala 19:19]
    ex.io.inFromD.source2 <= io.inFromID.source2 @[EXTop.scala 19:19]
    ex.io.inFromD.source1 <= io.inFromID.source1 @[EXTop.scala 19:19]
    ex.io.inFromD.iK <= io.inFromID.iK @[EXTop.scala 19:19]
    ex.io.inFromD.iSK <= io.inFromID.iSK @[EXTop.scala 19:19]
    d.io.inFromEX.rWDataO <= ex.io.outToD.rWDataO @[EXTop.scala 20:18]
    d.io.inFromEX.rWEnO <= ex.io.outToD.rWEnO @[EXTop.scala 20:18]
    d.io.inFromEX.rWAddrO <= ex.io.outToD.rWAddrO @[EXTop.scala 20:18]
    io.outToMEM.rWDataO <= d.io.outToMEM.rWDataO @[EXTop.scala 21:19]
    io.outToMEM.rWEnO <= d.io.outToMEM.rWEnO @[EXTop.scala 21:19]
    io.outToMEM.rWAddrO <= d.io.outToMEM.rWAddrO @[EXTop.scala 21:19]

  module DbtMEMWB :
    input clock : Clock
    input reset : Reset
    output io : { flip inFromMEM : { rWAddrO : UInt<5>, rWEnO : UInt<1>, rWDataO : UInt<32>}, outToWB : { rWAddrO : UInt<5>, rWEnO : UInt<1>, rWDataO : UInt<32>}}

    reg rWAddrO : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[DbtMEMWB.scala 18:26]
    rWAddrO <= io.inFromMEM.rWAddrO @[DbtMEMWB.scala 18:26]
    reg rWEnO : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[DbtMEMWB.scala 19:24]
    rWEnO <= io.inFromMEM.rWEnO @[DbtMEMWB.scala 19:24]
    reg rWDataO : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[DbtMEMWB.scala 20:26]
    rWDataO <= io.inFromMEM.rWDataO @[DbtMEMWB.scala 20:26]
    io.outToWB.rWAddrO <= rWAddrO @[DbtMEMWB.scala 22:24]
    io.outToWB.rWEnO <= rWEnO @[DbtMEMWB.scala 23:22]
    io.outToWB.rWDataO <= rWDataO @[DbtMEMWB.scala 24:24]

  module MEM :
    input clock : Clock
    input reset : Reset
    output io : { flip inFromD : { rWAddrO : UInt<5>, rWEnO : UInt<1>, rWDataO : UInt<32>}, outToD : { rWAddrO : UInt<5>, rWEnO : UInt<1>, rWDataO : UInt<32>}, outToMEMTop : { rWAddrO : UInt<5>, rWEnO : UInt<1>, rWDataO : UInt<32>}}

    io.outToD.rWDataO <= io.inFromD.rWDataO @[MEM.scala 16:15]
    io.outToD.rWEnO <= io.inFromD.rWEnO @[MEM.scala 16:15]
    io.outToD.rWAddrO <= io.inFromD.rWAddrO @[MEM.scala 16:15]
    io.outToMEMTop.rWDataO <= io.outToD.rWDataO @[MEM.scala 17:20]
    io.outToMEMTop.rWEnO <= io.outToD.rWEnO @[MEM.scala 17:20]
    io.outToMEMTop.rWAddrO <= io.outToD.rWAddrO @[MEM.scala 17:20]

  module MEMTop :
    input clock : Clock
    input reset : Reset
    output io : { flip inFromEX : { rWAddrO : UInt<5>, rWEnO : UInt<1>, rWDataO : UInt<32>}, outToWB : { rWAddrO : UInt<5>, rWEnO : UInt<1>, rWDataO : UInt<32>}, out2IDTop : { rWAddrO : UInt<5>, rWEnO : UInt<1>, rWDataO : UInt<32>}}

    inst d of DbtMEMWB @[MEMTop.scala 15:19]
    d.clock <= clock
    d.reset <= reset
    inst mem of MEM @[MEMTop.scala 16:21]
    mem.clock <= clock
    mem.reset <= reset
    mem.io.inFromD.rWDataO <= io.inFromEX.rWDataO @[MEMTop.scala 18:20]
    mem.io.inFromD.rWEnO <= io.inFromEX.rWEnO @[MEMTop.scala 18:20]
    mem.io.inFromD.rWAddrO <= io.inFromEX.rWAddrO @[MEMTop.scala 18:20]
    io.out2IDTop.rWDataO <= mem.io.outToMEMTop.rWDataO @[MEMTop.scala 19:18]
    io.out2IDTop.rWEnO <= mem.io.outToMEMTop.rWEnO @[MEMTop.scala 19:18]
    io.out2IDTop.rWAddrO <= mem.io.outToMEMTop.rWAddrO @[MEMTop.scala 19:18]
    d.io.inFromMEM.rWDataO <= mem.io.outToD.rWDataO @[MEMTop.scala 20:19]
    d.io.inFromMEM.rWEnO <= mem.io.outToD.rWEnO @[MEMTop.scala 20:19]
    d.io.inFromMEM.rWAddrO <= mem.io.outToD.rWAddrO @[MEMTop.scala 20:19]
    io.outToWB.rWDataO <= d.io.outToWB.rWDataO @[MEMTop.scala 21:16]
    io.outToWB.rWEnO <= d.io.outToWB.rWEnO @[MEMTop.scala 21:16]
    io.outToWB.rWAddrO <= d.io.outToWB.rWAddrO @[MEMTop.scala 21:16]

  module WB :
    input clock : Clock
    input reset : Reset
    output io : { flip inWBTop : { rWAddrO : UInt<5>, rWEnO : UInt<1>, rWDataO : UInt<32>}, outWBTop : { rWAddrO : UInt<5>, rWEnO : UInt<1>, rWDataO : UInt<32>}}

    io.outWBTop.rWDataO <= io.inWBTop.rWDataO @[WB.scala 13:16]
    io.outWBTop.rWEnO <= io.inWBTop.rWEnO @[WB.scala 13:16]
    io.outWBTop.rWAddrO <= io.inWBTop.rWAddrO @[WB.scala 13:16]

  module WBTop :
    input clock : Clock
    input reset : Reset
    output io : { flip inFromMEM : { rWAddrO : UInt<5>, rWEnO : UInt<1>, rWDataO : UInt<32>}, outToRF : { rWAddrO : UInt<5>, rWEnO : UInt<1>, rWDataO : UInt<32>}}

    inst wb of WB @[WBTop.scala 14:20]
    wb.clock <= clock
    wb.reset <= reset
    wb.io.inWBTop.rWDataO <= io.inFromMEM.rWDataO @[WBTop.scala 15:19]
    wb.io.inWBTop.rWEnO <= io.inFromMEM.rWEnO @[WBTop.scala 15:19]
    wb.io.inWBTop.rWAddrO <= io.inFromMEM.rWAddrO @[WBTop.scala 15:19]
    io.outToRF.rWDataO <= wb.io.outWBTop.rWDataO @[WBTop.scala 16:20]
    io.outToRF.rWEnO <= wb.io.outWBTop.rWEnO @[WBTop.scala 16:20]
    io.outToRF.rWAddrO <= wb.io.outWBTop.rWAddrO @[WBTop.scala 16:20]

  module Top :
    input clock : Clock
    input reset : UInt<1>
    output io : { out : { fromIDTop : { fromRF : { r1Out : UInt<32>, r2Out : UInt<32>, r3Out : UInt<32>, r4Out : UInt<32>, r5Out : UInt<32>, r6Out : UInt<32>, r7Out : UInt<32>, r8Out : UInt<32>, r9Out : UInt<32>, r10Out : UInt<32>, r11Out : UInt<32>, r12Out : UInt<32>, r13Out : UInt<32>, r14Out : UInt<32>, r15Out : UInt<32>, r16Out : UInt<32>, r17Out : UInt<32>, r18Out : UInt<32>, r19Out : UInt<32>, r20Out : UInt<32>, r21Out : UInt<32>, r22Out : UInt<32>, r23Out : UInt<32>, r24Out : UInt<32>, r25Out : UInt<32>, r26Out : UInt<32>, r27Out : UInt<32>, r28Out : UInt<32>, r29Out : UInt<32>, r30Out : UInt<32>, r31Out : UInt<32>}}}}

    inst ifTop of IFTop @[Top.scala 22:23]
    ifTop.clock <= clock
    ifTop.reset <= reset
    inst idTop of IDTop @[Top.scala 23:23]
    idTop.clock <= clock
    idTop.reset <= reset
    inst exTop of EXTop @[Top.scala 24:23]
    exTop.clock <= clock
    exTop.reset <= reset
    inst memTop of MEMTop @[Top.scala 25:24]
    memTop.clock <= clock
    memTop.reset <= reset
    inst wbTop of WBTop @[Top.scala 26:23]
    wbTop.clock <= clock
    wbTop.reset <= reset
    idTop.io.inFromIF.iRRdDt <= ifTop.io.outToID.iRRdDt @[Top.scala 28:23]
    exTop.io.inFromID.rWEn <= idTop.io.outToEX.rWEn @[Top.scala 29:22]
    exTop.io.inFromID.rWAddr <= idTop.io.outToEX.rWAddr @[Top.scala 29:22]
    exTop.io.inFromID.source2 <= idTop.io.outToEX.source2 @[Top.scala 29:22]
    exTop.io.inFromID.source1 <= idTop.io.outToEX.source1 @[Top.scala 29:22]
    exTop.io.inFromID.iK <= idTop.io.outToEX.iK @[Top.scala 29:22]
    exTop.io.inFromID.iSK <= idTop.io.outToEX.iSK @[Top.scala 29:22]
    memTop.io.inFromEX.rWDataO <= exTop.io.outToMEM.rWDataO @[Top.scala 30:24]
    memTop.io.inFromEX.rWEnO <= exTop.io.outToMEM.rWEnO @[Top.scala 30:24]
    memTop.io.inFromEX.rWAddrO <= exTop.io.outToMEM.rWAddrO @[Top.scala 30:24]
    wbTop.io.inFromMEM.rWDataO <= memTop.io.outToWB.rWDataO @[Top.scala 31:24]
    wbTop.io.inFromMEM.rWEnO <= memTop.io.outToWB.rWEnO @[Top.scala 31:24]
    wbTop.io.inFromMEM.rWAddrO <= memTop.io.outToWB.rWAddrO @[Top.scala 31:24]
    idTop.io.inFromWB.rWDataO <= wbTop.io.outToRF.rWDataO @[Top.scala 32:23]
    idTop.io.inFromWB.rWEnO <= wbTop.io.outToRF.rWEnO @[Top.scala 32:23]
    idTop.io.inFromWB.rWAddrO <= wbTop.io.outToRF.rWAddrO @[Top.scala 32:23]
    idTop.io.inFromEX.rWDataO <= exTop.io.outToID.rWDataO @[Top.scala 34:22]
    idTop.io.inFromEX.rWEnO <= exTop.io.outToID.rWEnO @[Top.scala 34:22]
    idTop.io.inFromEX.rWAddrO <= exTop.io.outToID.rWAddrO @[Top.scala 34:22]
    idTop.io.inFromMEM.rWDataO <= memTop.io.out2IDTop.rWDataO @[Top.scala 35:25]
    idTop.io.inFromMEM.rWEnO <= memTop.io.out2IDTop.rWEnO @[Top.scala 35:25]
    idTop.io.inFromMEM.rWAddrO <= memTop.io.out2IDTop.rWAddrO @[Top.scala 35:25]
    io.out.fromIDTop.fromRF.r31Out <= idTop.io.outToTop.fromRF.r31Out @[Top.scala 37:29]
    io.out.fromIDTop.fromRF.r30Out <= idTop.io.outToTop.fromRF.r30Out @[Top.scala 37:29]
    io.out.fromIDTop.fromRF.r29Out <= idTop.io.outToTop.fromRF.r29Out @[Top.scala 37:29]
    io.out.fromIDTop.fromRF.r28Out <= idTop.io.outToTop.fromRF.r28Out @[Top.scala 37:29]
    io.out.fromIDTop.fromRF.r27Out <= idTop.io.outToTop.fromRF.r27Out @[Top.scala 37:29]
    io.out.fromIDTop.fromRF.r26Out <= idTop.io.outToTop.fromRF.r26Out @[Top.scala 37:29]
    io.out.fromIDTop.fromRF.r25Out <= idTop.io.outToTop.fromRF.r25Out @[Top.scala 37:29]
    io.out.fromIDTop.fromRF.r24Out <= idTop.io.outToTop.fromRF.r24Out @[Top.scala 37:29]
    io.out.fromIDTop.fromRF.r23Out <= idTop.io.outToTop.fromRF.r23Out @[Top.scala 37:29]
    io.out.fromIDTop.fromRF.r22Out <= idTop.io.outToTop.fromRF.r22Out @[Top.scala 37:29]
    io.out.fromIDTop.fromRF.r21Out <= idTop.io.outToTop.fromRF.r21Out @[Top.scala 37:29]
    io.out.fromIDTop.fromRF.r20Out <= idTop.io.outToTop.fromRF.r20Out @[Top.scala 37:29]
    io.out.fromIDTop.fromRF.r19Out <= idTop.io.outToTop.fromRF.r19Out @[Top.scala 37:29]
    io.out.fromIDTop.fromRF.r18Out <= idTop.io.outToTop.fromRF.r18Out @[Top.scala 37:29]
    io.out.fromIDTop.fromRF.r17Out <= idTop.io.outToTop.fromRF.r17Out @[Top.scala 37:29]
    io.out.fromIDTop.fromRF.r16Out <= idTop.io.outToTop.fromRF.r16Out @[Top.scala 37:29]
    io.out.fromIDTop.fromRF.r15Out <= idTop.io.outToTop.fromRF.r15Out @[Top.scala 37:29]
    io.out.fromIDTop.fromRF.r14Out <= idTop.io.outToTop.fromRF.r14Out @[Top.scala 37:29]
    io.out.fromIDTop.fromRF.r13Out <= idTop.io.outToTop.fromRF.r13Out @[Top.scala 37:29]
    io.out.fromIDTop.fromRF.r12Out <= idTop.io.outToTop.fromRF.r12Out @[Top.scala 37:29]
    io.out.fromIDTop.fromRF.r11Out <= idTop.io.outToTop.fromRF.r11Out @[Top.scala 37:29]
    io.out.fromIDTop.fromRF.r10Out <= idTop.io.outToTop.fromRF.r10Out @[Top.scala 37:29]
    io.out.fromIDTop.fromRF.r9Out <= idTop.io.outToTop.fromRF.r9Out @[Top.scala 37:29]
    io.out.fromIDTop.fromRF.r8Out <= idTop.io.outToTop.fromRF.r8Out @[Top.scala 37:29]
    io.out.fromIDTop.fromRF.r7Out <= idTop.io.outToTop.fromRF.r7Out @[Top.scala 37:29]
    io.out.fromIDTop.fromRF.r6Out <= idTop.io.outToTop.fromRF.r6Out @[Top.scala 37:29]
    io.out.fromIDTop.fromRF.r5Out <= idTop.io.outToTop.fromRF.r5Out @[Top.scala 37:29]
    io.out.fromIDTop.fromRF.r4Out <= idTop.io.outToTop.fromRF.r4Out @[Top.scala 37:29]
    io.out.fromIDTop.fromRF.r3Out <= idTop.io.outToTop.fromRF.r3Out @[Top.scala 37:29]
    io.out.fromIDTop.fromRF.r2Out <= idTop.io.outToTop.fromRF.r2Out @[Top.scala 37:29]
    io.out.fromIDTop.fromRF.r1Out <= idTop.io.outToTop.fromRF.r1Out @[Top.scala 37:29]

