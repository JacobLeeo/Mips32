package Mips32.EX

import Mips32._
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation

class EXTop extends Module {
    
    val io = IO(new Bundle() {
        val inFromID = Flipped(new IDTop2EXTop)
        val outToMEM = new EXTop2MEMTop
        val outToID = new EXTop2IDTop
    })
    
    val ex = Module(new EX)
    val d = Module(new DbtEXMEM)
    
    ex.io.outToEXTop <> io.outToID
    ex.io.inFromD <> io.inFromID
    ex.io.outToD <> d.io.inFromEX
    d.io.outToMEM <> io.outToMEM
}

object EXTop extends App {
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated\\EX"), Seq(ChiselGeneratorAnnotation(() => new EXTop)))
}
