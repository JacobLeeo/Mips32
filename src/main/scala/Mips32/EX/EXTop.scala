package Mips32.EX

import Mips32.{D2EX, D2MEM, EX2D}
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation

class EXTop extends Module {
    val io = IO(new Bundle() {
        val inFromID = Flipped(new D2EX)
        val outToMEM = new D2MEM
    })
    
    val ex = Module(new EX)
    val d = Module(new DbtEXMEM)
    
    ex.io.inFromD <> io.inFromID
    ex.io.outToD <> d.io.inFromEX
    d.io.outToMEM <> io.outToMEM
    
}

object EXTop extends App {
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated\\ID"), Seq(ChiselGeneratorAnnotation(() => new EXTop)))
}
