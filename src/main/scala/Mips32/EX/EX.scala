package Mips32.EX

import chisel3._
import chisel3.util._
import chisel3.stage.ChiselGeneratorAnnotation
import chiseltest._
import chiseltest.{ChiselScalatestTester, WriteVcdAnnotation}
import org.scalatest.flatspec.AnyFlatSpec

class EX extends Module {
    val width = 32.W
    
    val io = IO(new Bundle() {
        val instSubKind = Input(UInt(8.W)) // op 子类型
        val instKind = Input(UInt(3.W)) // sel 类型
        
        val source1 = Input(UInt(width)) // 操作数1
        val source2 = Input(UInt(width)) // 操作数2
        
        val rWAddr = Input(UInt(5.W)) // 寄存器写地址
        val rWEn = Input(Bool()) // 寄存器写使能
        
        val rWAddrO = Output(UInt(5.W)) // 执行阶段寄存器写地址输出
        val rWEnO = Output(Bool()) // 执行阶段寄存器写使能输出
        val rWDataO = Output(UInt(width)) // 执行阶段寄存器写数据输出
    })
    
    val logicResult = WireInit(0.U(width)) // 逻辑结果
    
    io.rWAddrO := io.rWAddr // 寄存器写地址
    io.rWEnO := io.rWEn // 寄存器写使能
    
    io.rWDataO := 0.U // 寄存器写数据
    
    
    
    switch(io.instSubKind) {
        is("b00100101".asUInt) {
            logicResult := io.source1 | io.source2
        }
    }
    
    switch(io.instKind) {
        is("b001".asUInt) {
            io.rWDataO := logicResult
        }
    }
    
    
}
