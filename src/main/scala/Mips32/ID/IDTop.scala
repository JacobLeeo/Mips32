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
    
    val id = Module(new ID)
    val rf = Module(new RegFile)
    
    id.io.instData := io.instData
    
    rf.io.r1REn := id.io.r1REn
    rf.io.r2REn := id.io.r2REn
    rf.io.r1RAddr := id.io.r1RAddr
    rf.io.r2RAddr := id.io.r2RAddr
    
    id.io.r1RData := rf.io.r1RData
    id.io.r2RData := rf.io.r2RData
    
    io.source1 := id.io.source1
    io.source2 := id.io.source2
    
    io.rWEn := id.io.rWEn
    io.rWAddr := id.io.rWAddr
    
    io.iKind := id.io.iKind
    io.iSKind := id.io.iSKind
    
    rf.io.rWEn := DontCare
    rf.io.rWAddr := DontCare
    rf.io.rWData := DontCare
}

object IDTopInst extends App {
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated\\ID"), Seq(ChiselGeneratorAnnotation(() => new IDTop)))
}
