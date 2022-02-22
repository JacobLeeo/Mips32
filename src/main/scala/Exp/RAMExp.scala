package Exp

import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFileInline
import chisel3.stage.ChiselGeneratorAnnotation
import chiseltest._
import chiseltest.{ChiselScalatestTester, WriteVcdAnnotation}
import org.scalatest.flatspec.AnyFlatSpec
import chisel3.experimental.{annotate, ChiselAnnotation}
import firrtl.annotations.MemorySynthInit

// 本程序为实装前的实验程序

// 本程序尝试解决Bram使能逻辑错误的问题（上电、第一次使能），并验证修改后的代码能够被自动推断为Bram
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
    
    if (memoryFile.trim().nonEmpty) {
        loadMemoryFromFileInline(mem, memoryFile)
    }
    
    // 之前是DontCare，除了下列情况外，不在意dataOut的输出值
    io.dataOut := 0.U // 使能信号无效时，强制读数据输出为0
    
    // 经过实验，发现由SyncReadMem函数生成的同步读、异步写BRAM，在使用mem函数读取时，enable信号给出后，会立即给出读数据，没有遵循同步读时序
    // 所以此处手动满足其时序要求，将enable信号打一个节拍之后，再连接到BRAM的使能端
    enable := io.enable // 将外部输入的使能信号，打一个节拍之后再连接到BRAM的使能端
    
    when(enable) { // 使能信号有效时
        val rdwrPort = mem(io.addr) // 获取当前地址对应的的读写端口
        when(io.write) {
            rdwrPort := io.dataIn // 当写信号有效时，将数据写入指定地址
        }.otherwise {
            io.dataOut := rdwrPort // 当写信号无效时，从指定地址读取数据
        }
    }
}

object RAMExpInst extends App {
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated\\Exp\\RAM"), Seq(ChiselGeneratorAnnotation(() => new RAMExp)))
}
