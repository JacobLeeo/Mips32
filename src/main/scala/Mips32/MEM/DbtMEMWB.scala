package Mips32.MEM

import Mips32._
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation

import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec


class DbtMEMWB extends Module {
    
    val io = IO(new Bundle() {
        val inFromMEM = Flipped(new MEM2D)
        val outToWB = new D2WB
    })
    
    val rWAddrO = RegNext(io.inFromMEM.rWAddrO, 0.U) // 执行阶段寄存器写地址输出
    val rWEnO = RegNext(io.inFromMEM.rWEnO, false.B) // 执行阶段寄存器写使能输出
    val rWDataO = RegNext(io.inFromMEM.rWDataO, 0.U) // 执行阶段寄存器写数据输出
    
    io.outToWB.rWAddrO := rWAddrO
    io.outToWB.rWEnO := rWEnO
    io.outToWB.rWDataO := rWDataO
}

object DbtMEMWB extends App {
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated\\MEM\\D"), Seq(ChiselGeneratorAnnotation(() => new DbtMEMWB)))
}
