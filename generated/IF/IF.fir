circuit IF :
  module PC :
    input clock : Clock
    input reset : Reset
    output io : { instRomEn : UInt<1>, instRomAddr : UInt<8>}

    reg instRomEn : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[PC.scala 14:28]
    reg instRomAddr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[PC.scala 15:30]
    instRomEn <= UInt<1>("h1") @[PC.scala 17:15]
    node _instRomAddr_T = add(instRomAddr, UInt<3>("h4")) @[PC.scala 19:47]
    node _instRomAddr_T_1 = tail(_instRomAddr_T, 1) @[PC.scala 19:47]
    node _instRomAddr_T_2 = mux(instRomEn, _instRomAddr_T_1, UInt<1>("h0")) @[PC.scala 19:23]
    instRomAddr <= _instRomAddr_T_2 @[PC.scala 19:17]
    io.instRomEn <= instRomEn @[PC.scala 26:18]
    io.instRomAddr <= instRomAddr @[PC.scala 27:20]

  module InstROM :
    input clock : Clock
    input reset : Reset
    output io : { flip ena : UInt<1>, flip rAddr : UInt<8>, rData : UInt<32>, flip wEn : UInt<1>, flip wAddr : UInt<8>, flip wData : UInt<32>}

    smem memBank : UInt<32> [256] @[InstROM.scala 19:30]
    wire _io_rData_WIRE : UInt @[InstROM.scala 22:29]
    _io_rData_WIRE is invalid @[InstROM.scala 22:29]
    when io.ena : @[InstROM.scala 22:29]
      _io_rData_WIRE <= io.rAddr @[InstROM.scala 22:29]
      node _io_rData_T = or(_io_rData_WIRE, UInt<8>("h0")) @[InstROM.scala 22:29]
      node _io_rData_T_1 = bits(_io_rData_T, 7, 0) @[InstROM.scala 22:29]
      read mport io_rData_MPORT = memBank[_io_rData_T_1], clock @[InstROM.scala 22:29]
    io.rData <= io_rData_MPORT @[InstROM.scala 22:14]
    node _T = and(io.ena, io.wEn) @[InstROM.scala 24:17]
    when _T : @[InstROM.scala 24:28]
      write mport MPORT = memBank[io.wAddr], clock
      MPORT <= io.wData

  module IF :
    input clock : Clock
    input reset : UInt<1>
    output io : { instAddr : UInt<8>, inst : UInt<32>}

    reg instAddr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[IF.scala 14:27]
    inst pc of PC @[IF.scala 16:20]
    pc.clock <= clock
    pc.reset <= reset
    inst instROM of InstROM @[IF.scala 17:25]
    instROM.clock <= clock
    instROM.reset <= reset
    instROM.io.wEn is invalid @[IF.scala 19:20]
    instROM.io.wAddr is invalid @[IF.scala 20:22]
    instROM.io.wData is invalid @[IF.scala 21:22]
    node _instROM_io_rAddr_T = shr(pc.io.instRomAddr, 2) @[IF.scala 24:44]
    instROM.io.rAddr <= _instROM_io_rAddr_T @[IF.scala 24:22]
    instROM.io.ena <= pc.io.instRomEn @[IF.scala 25:20]
    io.inst <= instROM.io.rData @[IF.scala 27:13]
    io.instAddr <= instROM.io.rAddr @[IF.scala 28:17]

