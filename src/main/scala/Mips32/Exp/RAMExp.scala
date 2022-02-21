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


// 尝试解决Bram上电读取错误的问题与读取逻辑错误的问题，并验证修改后的代码能够被推断为Bram
class RAMExp(memoryFile: String = "memexp.txt") extends Module {
    val width: Int = 32
    val io = IO(new Bundle {
        val enable = Input(Bool())
        val write = Input(Bool())
        val addr = Input(UInt(10.W))
        val dataIn = Input(UInt(width.W))
        val dataOut = Output(UInt(width.W))
    })
    
    val enable = RegInit(false.B)
    val mem = SyncReadMem(1024, UInt(width.W))
    
    // Initialize memory
    if (memoryFile.trim().nonEmpty) {
        loadMemoryFromFileInline(mem, memoryFile)
    }
    
    // 之前是DontCare，不在意其他任何条件下dataOut的输出值
    io.dataOut := 0.U // 使能信号无效时，读数据为0
    
    // 经过实验，发现由SyncReadMem函数生成的同步读异步写BRAM，在使用mem函数读取时，enable信号给出后，会立即给出读数据，没有遵循同步读时序
    // 所以此处手动完成满足其时序要求
    enable := io.enable // 将外部输入的使能信号，打一个节拍之后再送给寄存器变量
    
    when(enable) {
        val rdwrPort = mem(io.addr) // 获取当前地址的读写端口
        when(io.write) {
            rdwrPort := io.dataIn // 当写信号有效时，将写数据写入指定地址
        }.otherwise {
            io.dataOut := rdwrPort // 当写信号无效时，从指定地址读取读数据
        }
    }
}

object RAMExpInst extends App {
    //  chisel3.emitVerilog(new InstROM)
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated\\Exp\\RAM"), Seq(ChiselGeneratorAnnotation(() => new RAMExp)))
}
