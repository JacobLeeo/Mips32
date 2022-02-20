package Mips32.IF

import Mips32.ID.IDTop
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

// 实现IF模块与Carrier
class IFTop extends Module {
    val io = IO(new Bundle() {
        val instRomAddr = Output(UInt(8.W)) // 指令存储器地址信号
        val instRomData = Output(UInt(32.W)) // 指令存储器数据信号
    })
    
    val instAddr = RegInit(0.U(8.W)) // 阻塞总线的IF阶段和ID阶段
    
    val pc = Module(new PC()) // 调用PC模块
    val instROM = Module(new InstROM()) // 调用instROM模块
    
    instROM.io.wEn := DontCare // instROM的写使能不连接
    instROM.io.wAddr := DontCare // instROM的写地址不连接
    instROM.io.wData := DontCare // instROM的写数据不连接
    
    instROM.io.rAddr := (pc.io.instRomAddr >> 2) // PC输出到InstROM的instROM地址信号
    instROM.io.ena := pc.io.instRomEn // PC输出到instROM的instROM使能信号
    
    io.instRomData := instROM.io.rData // InstROM输出到IF的instROM读数据，由于InstROM需要被自动推断为BRAM，本来就会占用一个时钟周期来读取数据，故不需要再打一个节拍
    
    instAddr := (pc.io.instRomAddr >> 2) // 将PC输出的指令地址向右移动两位，再打一个节拍后，传给instROM的读地址输入信号。BRAM本身无法按照字节寻址，PC自加4，再移位的意义应该不大
    io.instRomAddr := instAddr
}

object IFInst extends App {
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated\\IF"), Seq(ChiselGeneratorAnnotation(() => new IFTop)))
}
