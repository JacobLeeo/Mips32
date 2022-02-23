circuit IFTop :
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
    instRomData <= io.inFromIF.iRRdDt @[DBtIFID.scala 17:17]
    io.outToID.iRRdDt <= instRomData @[DBtIFID.scala 18:23]

  module IFTop :
    input clock : Clock
    input reset : UInt<1>
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

