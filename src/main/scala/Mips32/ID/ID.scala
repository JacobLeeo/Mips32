package Mips32.ID

import chisel3._
import chisel3.util._
import chisel3.stage.ChiselGeneratorAnnotation
import chiseltest._
import chiseltest.{ChiselScalatestTester, WriteVcdAnnotation}
import org.scalatest.flatspec.AnyFlatSpec

class ID extends Module {
    val io = IO(new Bundle() {
        val instData = Input(UInt(32.W)) // 指令
        
        val r1RData = Input(UInt(32.W)) // 寄存器1读数据
        val r2RData = Input(UInt(32.W)) // 寄存器2读数据
        
        val r1REn = Output(Bool()) // 寄存器1读使能
        val r2REn = Output(Bool()) // 寄存器2读使能
        
        val r1RAddr = Output(UInt(5.W)) // 寄存器1读地址
        val r2RAddr = Output(UInt(5.W)) // 寄存器2读地址
        
        val iKind = Output(UInt(8.W)) // 指令类型
        val iSKind = Output(UInt(3.W)) // 指令子类型
        
        val source1 = Output(UInt(32.W)) // 操作数1
        val source2 = Output(UInt(32.W)) // 操作数2
        
        val rWAddr = Output(UInt(5.W)) // 寄存器写地址
        val rWEn = Output(Bool()) // 寄存器写使能
    })
    
    val op = WireInit(0.U(6.W)) // 指令码
    val imm = WireInit(0.U(32.W)) // 立即数
    
     // 初始化
    io.r1REn := false.B // 寄存器1读使能初始化
    io.r2REn := false.B // 寄存器2读使能初始化
    io.rWEn := false.B // 寄存器写使能初始化
    io.iKind := "b00000000".asUInt // 指令类型初始化
    io.iSKind := "b000".asUInt // 指令子类型初始化
    io.source1 := 0.U // 操作数1初始化
    io.source2 := 0.U // 操作数2初始化
    
    op := io.instData(31, 26) // 指令操作码
    io.rWAddr := io.instData(20, 16) // 寄存器写地址
    io.r1RAddr := io.instData(25, 21) // 寄存器1读地址
    io.r2RAddr := io.instData(20, 16) // 寄存器2读地址
    
     // 解码指令
    switch(op) {
        is ("b001101".asUInt) { // 指令码为001101
            io.rWEn := true.B // 寄存器写使能有效
            io.r1REn := true.B // 寄存器1读使能有效
            io.r2REn := false.B // 寄存器2读使能无效
            io.iKind := "b00100101".asUInt // 指令类型为00100101
            io.iSKind := "b001".asUInt // 指令子类型为001
            imm := io.instData(15, 0) // 获取指令中的立即数，并将其扩展为32位
        }
    }
    
    when(io.r1REn === true.B) { // 当寄存器1读使能有效时，将操作数1重定向为寄存器1读数据
        io.source1 := io.r1RData
    }.elsewhen(io.r1REn === false.B) { // 当寄存器1读使能无效时，将操作数1重定向为立即数
        io.source1 := imm
    }
    
    when(io.r2REn === true.B) { // 当寄存器2读使能有效时，将操作数2重定向为寄存器2读数据
        io.source2 := io.r2RData
    }.elsewhen(io.r2REn === false.B) { // 当寄存器2读使能无效时，将操作数2重定向为立即数
        io.source2 := imm
    }
}
