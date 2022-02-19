circuit IF :
  module PC :
    input clock : Clock
    input reset : Reset
    output io : { instRomEn : UInt<1>, instRomAddr : UInt<8>}

    reg instRomEn : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[PC.scala 14:26]
    reg instRomAddr : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[PC.scala 15:28]
    instRomEn <= UInt<1>("h1") @[PC.scala 17:13]
    node _instRomAddr_T = add(instRomAddr, UInt<3>("h4")) @[PC.scala 19:45]
    node _instRomAddr_T_1 = tail(_instRomAddr_T, 1) @[PC.scala 19:45]
    node _instRomAddr_T_2 = mux(instRomEn, _instRomAddr_T_1, UInt<1>("h0")) @[PC.scala 19:21]
    instRomAddr <= _instRomAddr_T_2 @[PC.scala 19:15]
    io.instRomEn <= instRomEn @[PC.scala 26:16]
    io.instRomAddr <= instRomAddr @[PC.scala 27:18]

  module InstROM :
    input clock : Clock
    input reset : Reset
    output io : { flip rAddr : UInt<8>, rData : UInt<32>, flip wEn : UInt<1>, flip wAddr : UInt<8>, flip wData : UInt<32>}

    smem memBank : UInt<32> [256] @[InstROM.scala 21:28]
    wire _io_rData_WIRE : UInt @[InstROM.scala 25:27]
    _io_rData_WIRE is invalid @[InstROM.scala 25:27]
    when UInt<1>("h1") : @[InstROM.scala 25:27]
      _io_rData_WIRE <= io.rAddr @[InstROM.scala 25:27]
      node _io_rData_T = or(_io_rData_WIRE, UInt<8>("h0")) @[InstROM.scala 25:27]
      node _io_rData_T_1 = bits(_io_rData_T, 7, 0) @[InstROM.scala 25:27]
      read mport io_rData_MPORT = memBank[_io_rData_T_1], clock @[InstROM.scala 25:27]
    io.rData <= io_rData_MPORT @[InstROM.scala 25:12]
    when io.wEn : @[InstROM.scala 28:16]
      write mport MPORT = memBank[io.wAddr], clock
      MPORT <= io.wData

  module IF :
    input clock : Clock
    input reset : UInt<1>
    output io : { instAddr : UInt<8>, inst : UInt<32>, flip wEn : UInt<1>, flip wAddr : UInt<8>, flip wData : UInt<32>}

    inst pc of PC @[IF.scala 19:18]
    pc.clock <= clock
    pc.reset <= reset
    inst instROM of InstROM @[IF.scala 20:23]
    instROM.clock <= clock
    instROM.reset <= reset
    node _instROM_io_rAddr_T = shr(pc.io.instRomAddr, 2) @[IF.scala 22:42]
    instROM.io.rAddr <= _instROM_io_rAddr_T @[IF.scala 22:20]
    instROM.io.wEn <= io.wEn @[IF.scala 24:18]
    instROM.io.wAddr <= io.wAddr @[IF.scala 25:20]
    instROM.io.wData <= io.wData @[IF.scala 26:20]
    io.inst <= instROM.io.rData @[IF.scala 28:11]
    io.instAddr <= instROM.io.rAddr @[IF.scala 29:15]

