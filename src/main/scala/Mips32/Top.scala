package Mips32

import Mips32.EX._
import Mips32.ID._
import Mips32.IF._
import Mips32.MEM._
import Mips32.WB._
import chisel3._
import chisel3.util._
import chisel3.stage.ChiselGeneratorAnnotation
import chiseltest._
import chiseltest.{ChiselScalatestTester, WriteVcdAnnotation}
import org.scalatest.flatspec.AnyFlatSpec


class Top extends Module {
    
    val io = IO(new Bundle() {
        val out = new Top2Out
    })
    
    val ifTop = Module(new IFTop)
    val idTop = Module(new IDTop)
    val exTop = Module(new EXTop)
    val memTop = Module(new MEMTop)
    val wbTop = Module(new WBTop)
    
    idTop.io.inFromIF <> ifTop.io.outToID
    idTop.io.outToEX <> exTop.io.inFromID
    memTop.io.inFromEX <> exTop.io.outToMEM
    wbTop.io.inFromMEM <> memTop.io.outToWB
    idTop.io.inFromWB <> wbTop.io.outToRF
    
    io.out.fromIDTop := idTop.io.outToTop
}

object Top extends App {
    (new chisel3.stage.ChiselStage)
        .execute(Array("--target-dir", "generated"), Seq(ChiselGeneratorAnnotation(() => new Top)))
}
