package Mips32.ID

import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation

import chiseltest._
import chiseltest.{ChiselScalatestTester, WriteVcdAnnotation, fork}

import org.scalatest.flatspec.AnyFlatSpec

class RegFile extends Module {
    val io = IO(new Bundle() {
        val rWEn = Input(Bool()) // 寄存器写使能
        val r1REn = Input(Bool()) // 寄存器1读使能
        val r2REn = Input(Bool()) // 寄存器2读使能
        
        val rWAddr = Input(UInt(5.W)) // 寄存器写地址
        val rWData = Input(UInt(32.W)) // 寄存器写数据
        
        val r1RAddr = Input(UInt(5.W)) // 寄存器1读地址
        val r1RData = Output(UInt(32.W)) // 寄存器1读数据
        
        val r2RAddr = Input(UInt(5.W)) // 寄存器2读地址
        val r2RData = Output(UInt(32.W)) // 寄存器2读数据
    })
    
    val regBank = Mem(32, UInt(32.W)) // 例化同步写，异步读的RAM作为寄存器组
    
     // 寄存器写逻辑
    when(io.rWEn && (io.rWAddr =/=  0.U)) { // 寄存器写有效，且不是写0号寄存器，则将数据写入指定地址
        regBank.write(io.rWAddr, io.rWData)
    }
    
     // 寄存器1读逻辑
    when(io.r1RAddr === 0.U) { // 读0号寄存器
        io.r1RData := 0.U
    }.elsewhen((io.r1RAddr === io.rWAddr) // 寄存器1读地址等于寄存器写地址
            && (io.r1REn === true.B) // 寄存器1读有效
            && (io.rWEn === true.B)) { // 寄存器写地址
        io.r1RData := io.rWData
    }.elsewhen((io.r1REn === true.B)) { // 寄存器1读有效
        io.r1RData := regBank.read(io.r1RAddr)
    }.otherwise { // 其他情况
        io.r1RData := 0.U
    }
     
     // 寄存器2读逻辑，同上
    when(io.r2RAddr === 0.U) {
        io.r2RData := 0.U
    }.elsewhen((io.r2RAddr === io.rWAddr)
            && (io.r2REn === true.B)
            && (io.rWEn === true.B)) {
        io.r2RData := io.rWData
    }.elsewhen(io.r2REn === true.B) {
        io.r2RData := regBank.read(io.r2RAddr)
    }.otherwise {
        io.r2RData := 0.U
    }
    
}

object RegFileInst extends App {
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated\\ID\\RegFile"), Seq(ChiselGeneratorAnnotation(() => new RegFile)))
}

