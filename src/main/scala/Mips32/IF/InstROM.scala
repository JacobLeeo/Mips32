package Mips32.IF

import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util.experimental.loadMemoryFromFile
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec


class InstROM extends Module {
    val width = 32.W
    val depth = 8.W
    
    val io = IO(new Bundle() {
        val ena = Input(Bool())
        val rAddr = Input(UInt(depth))
        val rData = Output(UInt(width))
        val wEn = Input(Bool())
        val wData = Input(UInt(width))
    })
    
    val enable = RegInit(false.B)
    val memBank = SyncReadMem(256, UInt(width))
    loadMemoryFromFile(memBank, "mem.txt")
    
     // 这两个信号至关重要
    io.rData := 0.U
    enable := io.ena // 将外部输入的使能信号，打一个节拍之后再送给寄存器变量
    
    when(enable) {
        val rdwrPort = memBank(io.rAddr) // 获取当前地址的读写端口
        when(io.wEn) {
            rdwrPort := io.wData // 当写信号有效时，将写数据写入指定地址
        }.otherwise {
            io.rData := rdwrPort // 当写信号无效时，从指定地址读取读数据
        }
    }
}

object InstROMInst extends App {
//  chisel3.emitVerilog(new InstROM)
  (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated\\IF\\InstROM"), Seq(ChiselGeneratorAnnotation(() => new InstROM)))
}
