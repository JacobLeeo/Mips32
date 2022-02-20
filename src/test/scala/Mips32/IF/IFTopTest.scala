package Mips32.IF

import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation

import chiseltest._
import chiseltest.{ChiselScalatestTester, WriteVcdAnnotation, fork}

import org.scalatest.flatspec.AnyFlatSpec

class IFTopTest extends AnyFlatSpec with ChiselScalatestTester {
    behavior of "IF"
    it should "output the ID's InstROMData and InstROMAddr" in {
        test(new IFTop).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
            val testThr = fork {
                dut.clock.step(4)
                dut.reset.poke(true.B)
                dut.clock.step(5)
            }
            testThr.join()
        }
    }
}