package Mips32.EX

import Mips32._
import chisel3._
import chisel3.util._
import chisel3.stage.ChiselGeneratorAnnotation
import chiseltest._
import chiseltest.{ChiselScalatestTester, WriteVcdAnnotation}
import org.scalatest.flatspec.AnyFlatSpec


class EX extends Module {
    val io = IO(new Bundle() {
        val inFromD = Flipped(new D2EX)
        val outToD = new EX2D
    })

    
    val logicResult = WireInit(0.U(32.W)) // 逻辑结果
    
    io.outToD.rWAddrO := io.inFromD.rWAddr // 寄存器写地址
    io.outToD.rWEnO := io.inFromD.rWEn // 寄存器写使能
    
    io.outToD.rWDataO := 0.U // 寄存器写数据
    
    
     // 根据子类型确定当前运算为逻辑运算中的或运算
    switch(io.inFromD.iSK) {
        is("b00100101".asUInt) {
            logicResult := io.inFromD.source1 | io.inFromD.source2
        }
    }
    
     // 根据指令类型确定当前运算为逻辑运算
    switch(io.inFromD.iK) {
        is("b001".asUInt) {
            io.outToD.rWDataO := logicResult
        }
    }
}

object EX extends App {
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated\\ID"), Seq(ChiselGeneratorAnnotation(() => new EX)))
}
