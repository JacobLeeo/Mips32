package Mips32.EX

import Mips32.Def.INST._
import Mips32._

import chisel3._
import chisel3.util._
import chisel3.stage.ChiselGeneratorAnnotation



class EX extends Module {
    
    val io = IO(new Bundle() {
        val inFromD = Flipped(new EXTop2EX)
        val outToD = new EX2D
        val outToEXTop = new EX2EXTop
    })
    
    val logicResult = WireInit(0.U(32.W)) // 逻辑结果
    val shiftResult = WireInit(0.U(32.W)) // 移位结果
    
    io.outToD.rWAddrO := 0.U // 寄存器写地址
    io.outToD.rWEnO := 0.U // 寄存器写使能
    io.outToD.rWDataO := 0.U // 寄存器写数据
    
    io.outToEXTop := io.outToD // 数据前推
    
    // 根据子类型确定当前运算为逻辑运算中的或运算
    switch(io.inFromD.iSK) {
        is(ORI.INST_SK) { // 立即数或
            logicResult := io.inFromD.source1 | io.inFromD.source2
        }
        
        is(AND.INST_SK) { // 与
            logicResult := io.inFromD.source1 & io.inFromD.source2
        }
        
        is(OR.INST_SK) { // 或
            logicResult := io.inFromD.source1 | io.inFromD.source2
        }
        
        is(XOR.INST_SK) { // 异或
            logicResult := io.inFromD.source1 ^ io.inFromD.source2
        }
        
        is(NOR.INST_SK) { // 或非
            logicResult := ~(io.inFromD.source1 | io.inFromD.source2)
        }
        
        is(SLLV.INST_SK) { // 逻辑左移
            shiftResult := io.inFromD.source2 << io.inFromD.source1(4, 0)
        }
        
        is(SRLV.INST_SK) { // 逻辑右移
            shiftResult := io.inFromD.source2 >> io.inFromD.source1(4, 0)
        }
        
        is(SRAV.INST_SK) { // 算数右移
            shiftResult := (io.inFromD.source2.asSInt >> io.inFromD.source1(4, 0)).asUInt
        }
        
        is(ANDI.INST_SK) { // 立即数与
            logicResult := io.inFromD.source1 & io.inFromD.source2 // 立即数与
        }
        
        is(XORI.INST_SK) { // 立即数异或
            logicResult := io.inFromD.source1 ^ io.inFromD.source2 // 立即数异或
        }
        
        is(LUI.INST_SK) { // 立即数低位扩展
            logicResult := io.inFromD.source1 // 立即数拓展
        }
        
        is(SLL.INST_SK) { // 立即数逻辑左移
            shiftResult := io.inFromD.source2 << io.inFromD.source1(4, 0)
        }
        
        is(SRL.INST_SK) { // 立即数逻辑右移
            shiftResult := io.inFromD.source2 >> io.inFromD.source1(4, 0)
        }
        
        is(SRA.INST_SK) { // 立即数算数右移
            shiftResult := (io.inFromD.source2.asSInt >> io.inFromD.source1(4, 0)).asUInt
        }
    }
    
    // 根据指令类型确定当前运算为逻辑运算
    switch(io.inFromD.iK) {
        is(INST_LOGIC.INST_K) {
            io.outToD.rWAddrO := io.inFromD.rWAddr // 寄存器写地址
            io.outToD.rWEnO := io.inFromD.rWEn // 寄存器写使能
            io.outToD.rWDataO := logicResult
        }
        
        is(INST_SHIFT.INST_K) {
            io.outToD.rWAddrO := io.inFromD.rWAddr // 寄存器写地址
            io.outToD.rWEnO := io.inFromD.rWEn // 寄存器写使能
            io.outToD.rWDataO := shiftResult
        }
    }
}

object EX extends App {
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated\\EX\\EX"), Seq(ChiselGeneratorAnnotation(() => new EX)))
}
