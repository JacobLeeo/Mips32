package Mips32.EX

import chisel3._
import chisel3.util._
import chisel3.stage.ChiselGeneratorAnnotation
import chiseltest._
import chiseltest.{ChiselScalatestTester, WriteVcdAnnotation}
import org.scalatest.flatspec.AnyFlatSpec


class EX_MEM extends Module {
    val width = 32.W
    val io = IO(new Bundle() {
        val rWAddrIn = Input(UInt(5.W)) // 执行阶段寄存器写地址输出
        val rWEnIn = Input(Bool()) // 执行阶段寄存器写使能输出
        val rWDataIn = Input(UInt(width)) // 执行阶段寄存器写数据输出
    
        val rWAddrOut = Output(UInt(5.W)) // 执行阶段寄存器写地址输出
        val rWEnOut = Output(Bool()) // 执行阶段寄存器写使能输出
        val rWDataOut = Output(UInt(width)) // 执行阶段寄存器写数据输出
    })
    
    val rWAddr = RegInit(0.U(5.W))
    val rWEn = RegInit(false.B)
    val rWData = RegInit(0.U(width))
    
    rWAddr := io.rWAddrIn
    rWEn := io.rWEnIn
    rWData := io.rWDataIn
    
    io.rWAddrOut := rWAddr
    io.rWEnOut := rWEn
    io.rWDataOut := rWData
}
