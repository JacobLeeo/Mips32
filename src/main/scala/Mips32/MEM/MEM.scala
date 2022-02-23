package Mips32.MEM

import Mips32._
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation


class MEM extends Module {
    
    val io = IO(new Bundle() {
        val inFromD = Flipped(new D2MEM)
        val outToD = new MEM2D
    })
    
    io.outToD <> io.inFromD
}

object MEM extends App {
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated\\MEM\\MEM"), Seq(ChiselGeneratorAnnotation(() => new MEM)))
}
