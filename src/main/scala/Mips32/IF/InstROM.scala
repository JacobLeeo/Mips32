package Mips32.IF

import Mips32._
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chisel3.util.experimental.loadMemoryFromFile


class InstROM extends Module {
    
    val io = IO(new Bundle() {
        val inFromPC = Flipped(new PC2IR) // 从PC输出到IR的信号
        val outToD = new IR2D // 从IR输出到D触发器的信号
    })
    
    val enable = RegInit(false.B)
    val memBank = SyncReadMem(256, UInt(32.W))
    loadMemoryFromFile(memBank, "mem.txt")
    
     // 这两个信号至关重要
    io.outToD.iRRdDt := 0.U
    enable := io.inFromPC.iREn // 将外部输入的使能信号，打一个节拍之后再送给寄存器变量
    
    when(enable) {
        val rdwrPort = memBank(io.inFromPC.iRRdAd) // 获取当前地址的读写端口
        when(io.inFromPC.iRWrEn) {
            rdwrPort := io.inFromPC.iRWrDt // 当写信号有效时，将写数据写入指定地址
        }.otherwise {
            io.outToD.iRRdDt := rdwrPort // 当写信号无效时，从指定地址读取读数据
        }
    }
}

object InstROM extends App {
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated\\IF\\InstROM"), Seq(ChiselGeneratorAnnotation(() => new InstROM)))
}
