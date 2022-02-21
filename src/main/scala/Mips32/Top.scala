package Mips32

import Mips32.IF.IFTop
import Mips32.ID.IDTop
import Mips32.EX.EX


import chisel3._
import chisel3.util._
import chisel3.stage.ChiselGeneratorAnnotation
import chiseltest._
import chiseltest.{ChiselScalatestTester, WriteVcdAnnotation}
import org.scalatest.flatspec.AnyFlatSpec

class Top extends Module {
    val width = 32.W
    
    val io = IO(new Bundle() {
        val rWAddrO = Output(UInt(5.W)) // 执行阶段寄存器写地址输出
        val rWEnO = Output(Bool()) // 执行阶段寄存器写使能输出
        val rWDataO = Output(UInt(width)) // 执行阶段寄存器写数据输出
    })
    
    val iftop = Module(new IFTop)
    val idTop = Module(new IDTop)
    val ex = Module(new EX)
    
    idTop.io.instData := iftop.io.instRomData
    idTop.io.instAddr := iftop.io.instRomAddr
    
    ex.io.iKind := idTop.io.iKind
    ex.io.iSKind := idTop.io.iSKind
    ex.io.source1 := idTop.io.source1
    ex.io.source2 := idTop.io.source2
    ex.io.rWAddr := idTop.io.rWAddr
    ex.io.rWEn := idTop.io.rWEn
    
    io.rWDataO := ex.io.rWDataO
    io.rWEnO := ex.io.rWEn
    io.rWAddrO := ex.io.rWAddrO
}

object TopInst extends App {
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated"), Seq(ChiselGeneratorAnnotation(() => new Top)))
}
