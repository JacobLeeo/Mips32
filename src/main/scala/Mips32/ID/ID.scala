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
    
    op := io.instData(31, 26) // 识别指令码
    
    io.r1REn := false.B
    io.r2REn := false.B
    io.rWEn := false.B
    io.iKind := "b00000000".asUInt
    io.iSKind := "b000".asUInt
    io.source1 := 0.U
    io.source2 := 0.U
    io.rWAddr := io.instData(20, 16)
    io.r1RAddr := io.instData(25, 21)
    io.r2RAddr := io.instData(20, 16)
    
    switch(op) {
        is ("b001101".asUInt) {
            io.rWEn := true.B // 需要写寄存器
            io.iKind := "b00100101".asUInt
            io.iSKind := "b001".asUInt
            io.r1REn := true.B
            io.r2REn := false.B
            imm := io.instData(15, 0)
        }
    }
    
    when(io.r1REn === true.B) {
        io.source1 := io.r1RData
    }.elsewhen(io.r1REn === false.B) {
        io.source1 := imm
    }
    
    when(io.r2REn === true.B) {
        io.source2 := io.r2RData
    }.elsewhen(io.r2REn === false.B) {
        io.source2 := imm
    }
}
