circuit DBtIFID :
  module DBtIFID :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip inFromIF : { iRRdDt : UInt<32>}, outToID : { iRRdDt : UInt<32>}}

    wire instRomData : UInt<32>
    instRomData <= UInt<32>("h0")
    instRomData <= io.inFromIF.iRRdDt @[DBtIFID.scala 17:17]
    io.outToID.iRRdDt <= instRomData @[DBtIFID.scala 18:23]

