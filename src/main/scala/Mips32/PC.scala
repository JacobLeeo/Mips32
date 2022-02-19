package Mips32

import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class PC extends Module {
    val io = IO(new Bundle() {
        val instRomEn = Output(Bool())
        val instRomAddr = Output(UInt(8.W))
    })
    
    val instRomEn = RegInit(false.B)
    val instRomAddr = RegInit(0.U(8.W))
    
    instRomEn := true.B
    
    instRomAddr := Mux(instRomEn, instRomAddr + 4.U, 0.U)
    //  when(instRonEn === true.B) {
    //    instRomAddr := instRomAddr + 4.U
    //  }.otherwise {
    //    instRomAddr := 0.U
    //  }
    
    io.instRomEn := instRomEn
    io.instRomAddr := instRomAddr
}

object PCInst extends App {
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated\\IF\\PC"), Seq(ChiselGeneratorAnnotation(() => new PC)))
}

class PCTest extends AnyFlatSpec with ChiselScalatestTester {
    behavior of "PC"
    it should "count up" in {
        test(new PC).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
            dut.clock.step(50)
        }
    }
}
