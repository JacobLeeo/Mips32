package Mips32

import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation

class InstROM extends Module {
  val io = IO(new Bundle() {
    val rAddr = Input(UInt(8.W))
    val rData = Output(UInt(32.W))
    val wEn = Input(Bool())
    val wAddr = Input(UInt(8.W))
    val wData = Input(UInt(32.W))
  })
  
  val memBank = SyncReadMem(256, UInt(32.W))
  
  io.rData := memBank.read(io.rAddr)
  
  when(io.wEn) {
    memBank.write(io.wAddr, io.wData)
  }
}

object InstROMInst extends App {
//  chisel3.emitVerilog(new InstROM)
  (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated\\ROM\\InstROM"), Seq(ChiselGeneratorAnnotation(() => new InstROM)))
  
}

