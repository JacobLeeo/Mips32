package Mips32.WB

import Mips32._
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation


class WBTop extends Module {
    val io = IO(new Bundle() {
        val inFromMEM = Flipped(new MEM2WB)
        val outToRF = new WB2RF
    })
    
    io.inFromMEM <> io.outToRF
}

object WBTop extends App {
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated\\MEM"), Seq(ChiselGeneratorAnnotation(() => new WBTop)))
}
