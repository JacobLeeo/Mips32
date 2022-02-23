package Mips32.MEM

import Mips32._
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation


class MEMTop extends Module {
    val io = IO(new Bundle() {
        val inFromEX = Flipped(new EX2MEM)
        val outToWB = new MEM2WB
    })
    
    val d = Module(new DbtMEMWB)
    val mem = Module(new MEM)
    
    mem.io.inFromD <> io.inFromEX
    mem.io.outToD <> d.io.inFromMEM
    io.outToWB <> d.io.outToWB
}

object MEMTop extends App {
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated\\MEM"), Seq(ChiselGeneratorAnnotation(() => new MEMTop)))
}
