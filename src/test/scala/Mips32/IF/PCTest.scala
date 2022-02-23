package Mips32.IF

import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class PCTest extends AnyFlatSpec with ChiselScalatestTester {
    behavior of "PC"
    it should "" in {
        test(new PC).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
            dut.clock.step(10)
        }
    }
}
