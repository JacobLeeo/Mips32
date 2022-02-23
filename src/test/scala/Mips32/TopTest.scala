package Mips32

import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec


class TopTest extends AnyFlatSpec with ChiselScalatestTester {
    behavior of "Top"
    it should "" in {
        test(new Top).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
            dut.clock.step(12)
        }
    }
}
