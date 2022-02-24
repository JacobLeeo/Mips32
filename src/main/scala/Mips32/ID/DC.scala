package Mips32.ID

import Mips32._

import chisel3._
import chisel3.util._
import chisel3.stage.ChiselGeneratorAnnotation
import chiseltest._
import chiseltest.{ChiselScalatestTester, WriteVcdAnnotation}
import org.scalatest.flatspec.AnyFlatSpec


class DC extends Module {
    
    val io = IO(new Bundle() {
        val inFromIDTop = Flipped(new IDTop2DC) // 从D触发器输入
        val inFromRF = Flipped(new RF2DC) // 从RF输入
        val outToD = new DC2D// 向D输出
        val outToRF = new DC2RF // 向RF输出
    })
    
    val op = WireInit(0.U(6.W)) // 指令码
    val imm = WireInit(0.U(32.W)) // 立即数
    
     // 初始化
    io.outToRF.r1REn := false.B // 寄存器1读使能初始化
    io.outToRF.r2REn := false.B // 寄存器2读使能初始化
    io.outToD.rWEn := false.B // 寄存器写使能初始化
    io.outToD.iSK := "b00000000".asUInt // 指令类型初始化
    io.outToD.iK := "b000".asUInt // 指令子类型初始化
    io.outToD.source1 := 0.U // 操作数1初始化
    io.outToD.source2 := 0.U // 操作数2初始化
    
    op := io.inFromIDTop.fromIFTop.iRRdDt(31, 26) // 指令操作码
    io.outToD.rWAddr := io.inFromIDTop.fromIFTop.iRRdDt(20, 16) // 寄存器写地址
    io.outToRF.r1RAddr := io.inFromIDTop.fromIFTop.iRRdDt(25, 21) // 寄存器1读地址
    io.outToRF.r2RAddr := io.inFromIDTop.fromIFTop.iRRdDt(20, 16) // 寄存器2读地址
    
     // 解码指令
    switch(op) {
        is ("b001101".asUInt) { // 指令码为001101
            io.outToD.rWEn := true.B // 寄存器写使能有效
            io.outToRF.r1REn := true.B // 寄存器1读使能有效
            io.outToRF.r2REn := false.B // 寄存器2读使能无效
            io.outToD.iSK := "b00100101".asUInt // 指令类型为00100101
            io.outToD.iK := "b001".asUInt // 指令子类型为001
            imm := io.inFromIDTop.fromIFTop.iRRdDt(15, 0) // 获取指令中的立即数，并将其扩展为32位
        }
    }
    when((io.outToRF.r1REn === true.B)
            && (io.inFromIDTop.fromEXTop.rWEnO === true.B)
            && (io.inFromIDTop.fromEXTop.rWAddrO === io.outToRF.r1RAddr)) {
        io.outToD.source1 := io.inFromIDTop.fromEXTop.rWDataO
    }.elsewhen((io.outToRF.r1REn === true.B)
            && (io.inFromIDTop.fromMEMTop.rWEnO === true.B)
            && (io.inFromIDTop.fromMEMTop.rWAddrO === io.outToRF.r1RAddr)) {
        io.outToD.source1 := io.inFromIDTop.fromMEMTop.rWDataO
    }.elsewhen(io.outToRF.r1REn === true.B) { // 当寄存器1读使能有效时，将操作数1重定向为寄存器1读数据
        io.outToD.source1 := io.inFromRF.r1RData
    }.elsewhen(io.outToRF.r1REn === false.B) { // 当寄存器1读使能无效时，将操作数1重定向为立即数
        io.outToD.source1 := imm
    }
    
    when((io.outToRF.r2REn === true.B)
            && (io.inFromIDTop.fromEXTop.rWEnO === true.B)
            && (io.inFromIDTop.fromEXTop.rWAddrO === io.outToRF.r2RAddr)) {
        io.outToD.source2 := io.inFromIDTop.fromEXTop.rWDataO
    }.elsewhen((io.outToRF.r2REn === true.B)
            && (io.inFromIDTop.fromMEMTop.rWEnO === true.B)
            && (io.inFromIDTop.fromMEMTop.rWAddrO === io.outToRF.r2RAddr)) {
        io.outToD.source2 := io.inFromIDTop.fromMEMTop.rWDataO
    }.elsewhen(io.outToRF.r2REn === true.B) { // 当寄存器2读使能有效时，将操作数2重定向为寄存器2读数据
        io.outToD.source2 := io.inFromRF.r2RData
    }.elsewhen(io.outToRF.r2REn === false.B) { // 当寄存器2读使能无效时，将操作数2重定向为立即数
        io.outToD.source2 := imm
    }
}

object DC extends App {
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated\\ID\\DC"), Seq(ChiselGeneratorAnnotation(() => new DC)))
}
