package Mips32.ID

import Mips32.IF.IFTop
import Mips32.ID.IDTop
import chisel3._
import chisel3.util._
import chisel3.stage.ChiselGeneratorAnnotation
import chiseltest._
import chiseltest.{ChiselScalatestTester, WriteVcdAnnotation}
import org.scalatest.flatspec.AnyFlatSpec

class IDTopTest extends AnyFlatSpec with ChiselScalatestTester {
    behavior of "ID"
    it should "" in {
        test(new ID).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
            dut.clock.step(50)
            dut.reset.poke(true.B)
            dut.clock.step(10)
        }
    }
}
