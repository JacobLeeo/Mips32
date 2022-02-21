package Mips32

import Mips32.IF.IFTop
import Mips32.ID.IDTop
import chisel3._
import chisel3.util._
import chisel3.stage.ChiselGeneratorAnnotation
import chiseltest._
import chiseltest.{ChiselScalatestTester, WriteVcdAnnotation}
import org.scalatest.flatspec.AnyFlatSpec

class TopTest extends AnyFlatSpec with ChiselScalatestTester {
    behavior of "Top"
    it should "" in {
        test(new Top).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
            dut.clock.step(10)
        }
    }
}
