circuit InstROM :
  module InstROM :
    input clock : Clock
    input reset : UInt<1>
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

