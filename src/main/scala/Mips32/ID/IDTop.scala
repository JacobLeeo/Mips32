package Mips32.ID

import Mips32.IF.IFTop
import chisel3._
import chisel3.util._
import chisel3.stage.ChiselGeneratorAnnotation
import chiseltest._
import chiseltest.{ChiselScalatestTester, WriteVcdAnnotation}
import org.scalatest.flatspec.AnyFlatSpec

class IDTop extends Module {
    val io = IO(new Bundle() {
        val instAddr = Input(UInt(8.W))
        val instData = Input(UInt(32.W))
    
        val iKind = Output(UInt(8.W)) // 指令类型
        val iSKind = Output(UInt(3.W)) // 指令子类型
    
        val source1 = Output(UInt(32.W)) // 操作数1
        val source2 = Output(UInt(32.W)) // 操作数2
    
        val rWAddr = Output(UInt(5.W)) // 寄存器写地址
        val rWEn = Output(Bool()) // 寄存器写使能
    })
    
    val iKind = RegInit(0.U(8.W)) // 指令类型
    val iSKind = RegInit(0.U(3.W)) // 指令子类型
    
    val source1 = RegInit(0.U(32.W)) // 操作数1
    val source2 = RegInit(0.U(32.W)) // 操作数2
    
    val rWAddr = RegInit(0.U(5.W)) // 寄存器写地址
    val rWEn = RegInit(false.B) // 寄存器写使能
    
    val id = Module(new ID)
    val rf = Module(new RegFile)
    
    id.io.instData := io.instData
    
    rf.io.r1REn := id.io.r1REn
    rf.io.r2REn := id.io.r2REn
    rf.io.r1RAddr := id.io.r1RAddr
    rf.io.r2RAddr := id.io.r2RAddr
    
    id.io.r1RData := rf.io.r1RData
    id.io.r2RData := rf.io.r2RData
    
    source1 := id.io.source1
    io.source1 := source1
    source2 := id.io.source2
    io.source2 := source2
    
    rWEn := id.io.rWEn
    io.rWEn := rWEn
    rWAddr := id.io.rWAddr
    io.rWAddr := rWAddr
    
    iKind := id.io.rWAddr
    io.iKind := iKind
    iSKind := id.io.iSKind
    io.iSKind := iSKind
    
    rf.io.rWEn := DontCare
    rf.io.rWAddr := DontCare
    rf.io.rWData := DontCare
}

object IDTopInst extends App {
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated\\ID"), Seq(ChiselGeneratorAnnotation(() => new IDTop)))
}
