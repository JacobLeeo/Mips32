package Mips32

import Mips32.EX.EXTop
import Mips32.ID._
import Mips32.IF._
import chisel3._
import chisel3.util._
import chisel3.stage.ChiselGeneratorAnnotation
import chiseltest._
import chiseltest.{ChiselScalatestTester, WriteVcdAnnotation}
import org.scalatest.flatspec.AnyFlatSpec


class Top extends Module {
    
    val io = IO(new Bundle() {
        val out= new D2MEM
    })
    
    val ifTop = Module(new IFTop)
    val idTop = Module(new IDTop)
    val exTop = Module(new EXTop)
    
    idTop.io.inFromIF <> ifTop.io.outToID
    idTop.io.outToEX <> exTop.io.inFromID
    io.out <> exTop.io.outToMEM
}

object Top extends App {
    (new chisel3.stage.ChiselStage)
        .execute(Array("--target-dir", "generated"), Seq(ChiselGeneratorAnnotation(() => new Top)))
}
