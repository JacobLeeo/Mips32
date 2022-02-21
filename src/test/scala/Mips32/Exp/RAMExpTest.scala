package Mips32.Exp

import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFileInline
import chisel3.stage.ChiselGeneratorAnnotation
import chiseltest._
import chiseltest.{ChiselScalatestTester, WriteVcdAnnotation}
import org.scalatest.flatspec.AnyFlatSpec
import chisel3.experimental.{annotate, ChiselAnnotation}
import firrtl.annotations.MemorySynthInit


class RAMExpTest extends AnyFlatSpec with ChiselScalatestTester {
    behavior of "Mem"
    it should "read data from memBank" in {
        test(new RAMExp()).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
            
            dut.io.enable.poke(false.B)
            dut.io.write.poke(false.B)
            dut.clock.step(10)
            
            dut.io.enable.poke(true.B)
            
            dut.io.addr.poke(0.U)
            dut.clock.step(2)
            dut.io.addr.poke(1.U)
            dut.clock.step(2)
            dut.io.addr.poke(2.U)
            dut.clock.step(2)
            dut.io.addr.poke(3.U)
            dut.clock.step(2)
        }
    }
}