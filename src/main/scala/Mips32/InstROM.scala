package Mips32

import chisel3._
import chisel3.stage.{ChiselStage, ChiselGeneratorAnnotation}
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

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
    println("wEn")
  }
}

object InstROMInst extends App {
//  chisel3.emitVerilog(new InstROM)
  (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated\\ROM\\InstROM"), Seq(ChiselGeneratorAnnotation(() => new InstROM)))
  
}

class InstROMTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "InstROM"
  it should "Read or Write" in {
    test(new InstROM).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      
      val testThr = fork {
        
        dut.io.wEn.poke(true.B)
  
        dut.io.wAddr.poke(1.U(8.W))
        dut.io.wData.poke(1.U(32.W))
        dut.clock.step(2)
  
        dut.io.wAddr.poke(2.U(8.W))
        dut.io.wData.poke(2.U(32.W))
        dut.clock.step(2)
  
        dut.io.wAddr.poke(3.U(8.W))
        dut.io.wData.poke(3.U(32.W))
        dut.clock.step(2)
  
        dut.io.wEn.poke(false.B)
  
        dut.io.rAddr.poke(1.U(8.W))
        dut.clock.step(2)
  
        dut.io.rAddr.poke(2.U(8.W))
        dut.clock.step(2)
  
        dut.io.rAddr.poke(3.U(8.W))
        dut.clock.step(2)
      }
      testThr.join()
    }
  }
}
