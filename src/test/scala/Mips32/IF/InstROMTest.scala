package Mips32.IF

import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation

import chiseltest._
import chiseltest.{ChiselScalatestTester, WriteVcdAnnotation, fork}

import org.scalatest.flatspec.AnyFlatSpec

class InstROMTest extends AnyFlatSpec with ChiselScalatestTester {
    behavior of "InstROM"
    it should "Read or Write" in {
        test(new InstROM).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
            
            val testThr = fork {
                
                dut.io.wEn.poke(false.B)
                
                dut.io.rAddr.poke(0.U(8.W))
                dut.clock.step(2)
                
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