package Mips32.ID

import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation

import chiseltest._
import chiseltest.{ChiselScalatestTester, WriteVcdAnnotation, fork}

import org.scalatest.flatspec.AnyFlatSpec


class RegFileTest extends AnyFlatSpec with ChiselScalatestTester {
    behavior of "RF"
    it should "write and read" in {
        test(new RegFile).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
            val testThr = fork {
                
                // 写数据
                dut.io.rWEn.poke(true.B)
                dut.io.r1REn.poke(false.B)
                dut.io.r2REn.poke(false.B)
                
                dut.io.rWAddr.poke(1.U(5.W))
                dut.io.rWData.poke(1.U(32.W))
                dut.clock.step(2)
                
                dut.io.rWAddr.poke(2.U(5.W))
                dut.io.rWData.poke(2.U(32.W))
                dut.clock.step(2)
                
                dut.io.rWAddr.poke(3.U(5.W))
                dut.io.rWData.poke(3.U(32.W))
                dut.clock.step(2)
                
                dut.io.rWAddr.poke(4.U(5.W))
                dut.io.rWData.poke(4.U(32.W))
                dut.clock.step(2)
                
                // 读数据
                dut.io.rWEn.poke(false.B)
                dut.io.r1REn.poke(true.B)
                dut.io.r2REn.poke(true.B)
                
                dut.io.r2RAddr.poke(1.U(5.W))
                dut.clock.step(1)
                
                dut.io.r2RAddr.poke(2.U(5.W))
                dut.clock.step(1)
                
                dut.io.r2RAddr.poke(3.U(5.W))
                dut.clock.step(1)
                
                dut.io.r2RAddr.poke(4.U(5.W))
                dut.clock.step(1)
                
                dut.io.r2RAddr.poke(5.U(5.W))
                dut.clock.step(1)
                
                dut.io.r1RAddr.poke(1.U(5.W))
                dut.clock.step(1)
                
                dut.io.r1RAddr.poke(2.U(5.W))
                dut.clock.step(1)
                
                dut.io.r1RAddr.poke(3.U(5.W))
                dut.clock.step(1)
                
                dut.io.r1RAddr.poke(4.U(5.W))
                dut.clock.step(1)
                
                dut.io.r1RAddr.poke(5.U(5.W))
                dut.clock.step(1)
            }
            testThr.join()
        }
    }
}
