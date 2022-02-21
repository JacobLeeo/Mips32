package Mips32

import Mips32.IF.IFTop
import Mips32.ID.IDTop

import chisel3._
import chisel3.util._
import chisel3.stage.ChiselGeneratorAnnotation
import chiseltest._
import chiseltest.{ChiselScalatestTester, WriteVcdAnnotation}
import org.scalatest.flatspec.AnyFlatSpec

class Top extends Module {
    val io = IO(new Bundle() {
        
        val iKind = Output(UInt(8.W)) // 指令类型
        val iSKind = Output(UInt(3.W)) // 指令子类型
    
        val source1 = Output(UInt(32.W)) // 操作数1
        val source2 = Output(UInt(32.W)) // 操作数2
    
        val rWAddr = Output(UInt(5.W)) // 寄存器写地址
        val rWEn = Output(Bool()) // 寄存器写使能
    })
    
    val iftop = Module(new IFTop)
    val idTop = Module(new IDTop)
    
    idTop.io.instData := iftop.io.instRomData
    idTop.io.instAddr := iftop.io.instRomAddr
    
    io.iKind := idTop.io.iKind
    io.iSKind := idTop.io.iSKind
    io.source1 := idTop.io.source1
    io.source2 := idTop.io.source2
    io.rWAddr := idTop.io.rWAddr
    io.rWEn := idTop.io.rWEn
}

object TopInst extends App {
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated"), Seq(ChiselGeneratorAnnotation(() => new Top)))
}
