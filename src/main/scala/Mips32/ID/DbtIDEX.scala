package Mips32.ID

import Mips32._
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation


class DbtIDEX extends Module {
    val io = IO(new Bundle() {
        val inFromID = Flipped(new ID2D)
        val outToEX = new D2EX
    })
    
    val iSK = RegNext(io.inFromID.iSK, 0.U)
    val iK = RegNext(io.inFromID.iK, 0.U)
    val s1 = RegNext(io.inFromID.source1, 0.U)
    val s2 = RegNext(io.inFromID.source2, 0.U)
    val rWAddr = RegNext(io.inFromID.rWAddr, 0.U)
    val rWEn = RegNext(io.inFromID.rWEn, 0.U)
    
    io.outToEX.iSK := iSK
    io.outToEX.iK := iK
    io.outToEX.source1 := s1
    io.outToEX.source2 := s2
    io.outToEX.rWAddr := rWAddr
    io.outToEX.rWEn := rWEn
}
object DbtIDEX extends App {
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated\\ID\\D"), Seq(ChiselGeneratorAnnotation(() => new DbtIDEX)))
}