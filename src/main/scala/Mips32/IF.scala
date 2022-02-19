package Mips32

import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class IF extends Module {
    val io = IO(new Bundle() {
        val instRomAddr = Output(UInt(8.W))
        val instRomData = Output(UInt(32.W))
    })
    
    val instAddr = RegInit(0.U(8.W)) // 阻塞总线的IF阶段和ID阶段
    
    val pc = Module(new PC())
    val instROM = Module(new InstROM())
    
    instROM.io.wEn := DontCare
    instROM.io.wAddr := DontCare
    instROM.io.wData := DontCare
    
    instROM.io.rAddr := (pc.io.instRomAddr >> 2)
    instROM.io.ena := pc.io.instRomEn
    
    io.instRomData := instROM.io.rData
    
    instAddr := (pc.io.instRomAddr >> 2)
    io.instRomAddr := instAddr
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