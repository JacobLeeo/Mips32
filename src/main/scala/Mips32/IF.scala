package Mips32

import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class IF extends Module {
    val io = IO(new Bundle() {
        val instAddr = Output(UInt(8.W))
        val inst = Output(UInt(32.W))
    })
    
    val pc = Module(new PC())
    val instROM = Module(new InstROM())
    
    instROM.io.rAddr := (pc.io.instRomAddr >> 2)
    instROM.io.ena := pc.io.instRomEn
    
    instROM.io.wEn := DontCare
    instROM.io.wAddr := DontCare
    instROM.io.wData := DontCare
    
    io.inst := instROM.io.rData
    io.instAddr := instROM.io.rAddr
}

object IFInst extends App {
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated\\IF"), Seq(ChiselGeneratorAnnotation(() => new IF)))
}

class IFTest extends AnyFlatSpec with ChiselScalatestTester {
    behavior of "IF"
    it should "output the Inst and InstAddr" in {
        test(new IF).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
            
            val testThr = fork {
                dut.clock.step(20)
            }
            testThr.join()
        }
    }
}