package Mips32.WB

import Mips32._
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation

class WB extends Module {
    val io = IO(new Bundle() {
        val inWBTop = Flipped(new WBTop2WB)
        val outWBTop = new WB2WBTop
    })
    
    io.inWBTop <> io.outWBTop
}