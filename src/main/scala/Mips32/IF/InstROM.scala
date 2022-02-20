package Mips32.IF


import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util.experimental.loadMemoryFromFile
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec


class InstROM extends Module {
    val io = IO(new Bundle() {
        val ena = Input(Bool())
        val rAddr = Input(UInt(8.W))
        val rData = Output(UInt(32.W))
        val wEn = Input(Bool())
        val wAddr = Input(UInt(8.W))
        val wData = Input(UInt(32.W))
    })
    
    val memBank = SyncReadMem(256, UInt(32.W))
    loadMemoryFromFile(memBank, "mem.txt")
    
    io.rData := memBank.read(io.rAddr, io.ena)
    
    when(io.ena && io.wEn) {
        memBank.write(io.wAddr, io.wData)
    }
}

object InstROMInst extends App {
//  chisel3.emitVerilog(new InstROM)
  (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated\\IF\\InstROM"), Seq(ChiselGeneratorAnnotation(() => new InstROM)))
}
