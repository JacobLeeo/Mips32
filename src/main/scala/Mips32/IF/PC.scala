package Mips32.IF

import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class PC extends Module {
    val io = IO(new Bundle() {
        val instRomEn = Output(Bool())
        val instRomAddr = Output(UInt(8.W))
    })
    
    val instRomAddr = RegInit(0.U(8.W))
    val instRomEn =  RegInit(0.U)
    
    instRomEn := true.B
    instRomAddr := Mux(io.instRomEn, instRomAddr + 4.U, 0.U)
//      when(instRomEn === true.B) {
//        instRomAddr := instRomAddr + 4.U
//      }.otherwise {
//        instRomAddr := 0.U
//      }
    
    io.instRomAddr := instRomAddr
    io.instRomEn := instRomEn
}

object PCInst extends App {
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated\\IF\\PC"), Seq(ChiselGeneratorAnnotation(() => new PC)))
}

