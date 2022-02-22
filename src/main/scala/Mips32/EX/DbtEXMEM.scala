package Mips32.EX

import Mips32.{D2MEM, EX2D}
import chisel3._
import chisel3.util._
import chisel3.stage.ChiselGeneratorAnnotation
import chiseltest._
import chiseltest.{ChiselScalatestTester, WriteVcdAnnotation}
import org.scalatest.flatspec.AnyFlatSpec


class DbtEXMEM extends Module {
    
    val io = IO(new Bundle() {
        val inFromEX = Flipped(new EX2D)
        val outToMEM = new D2MEM
    })
    
    val rWAddr = RegNext(io.inFromEX.rWAddrO)
    val rWEn = RegNext(io.inFromEX.rWEnO)
    val rWData = RegNext(io.inFromEX.rWDataO)
    
    io.outToMEM.rWAddrO := rWAddr
    io.outToMEM.rWEnO := rWEn
    io.outToMEM.rWDataO := rWData
}

object DbtEXMEM extends App {
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated\\ID"), Seq(ChiselGeneratorAnnotation(() => new DbtEXMEM)))
}
