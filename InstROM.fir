circuit InstROM :
  module InstROM :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip rAddr : UInt<8>, rData : UInt<32>, flip wEn : UInt<1>, flip wAddr : UInt<8>, flip wData : UInt<32>}

    smem memBank : UInt<32> [256] @[InstROM.scala 14:28]
    wire _io_rData_WIRE : UInt @[InstROM.scala 16:27]
    _io_rData_WIRE is invalid @[InstROM.scala 16:27]
    when UInt<1>("h1") : @[InstROM.scala 16:27]
      _io_rData_WIRE <= io.rAddr @[InstROM.scala 16:27]
      node _io_rData_T = or(_io_rData_WIRE, UInt<8>("h0")) @[InstROM.scala 16:27]
      node _io_rData_T_1 = bits(_io_rData_T, 7, 0) @[InstROM.scala 16:27]
      read mport io_rData_MPORT = memBank[_io_rData_T_1], clock @[InstROM.scala 16:27]
    io.rData <= io_rData_MPORT @[InstROM.scala 16:12]
    when io.wEn : @[InstROM.scala 18:16]
      write mport MPORT = memBank[io.wAddr], clock
      MPORT <= io.wData

