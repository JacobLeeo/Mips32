package Mips32.IF

import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation

import chiseltest._
import chiseltest.{ChiselScalatestTester, WriteVcdAnnotation, fork}

import org.scalatest.flatspec.AnyFlatSpec

class IFTest extends AnyFlatSpec with ChiselScalatestTester {
    behavior of "IF"
    it should "output the ID's InstROMData and InstROMAddr" in {
        test(new IF).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
            val testThr = fork {
                dut.clock.step(20)
            }
            testThr.join()
        }
    }
}