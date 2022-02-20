package Mips32.IF

import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class PCTest extends AnyFlatSpec with ChiselScalatestTester {
    behavior of "PC"
    it should "count up" in {
        test(new PC).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
            dut.clock.step(50)
            dut.reset.poke(true.B)
            dut.clock.step(10)
        }
    }
}
