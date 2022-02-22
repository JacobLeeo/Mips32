package Mips32.ID

import Mips32._
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation


class RegFile extends Module {
    
    val io = IO(new Bundle() {
        val inFromID = Flipped(new ID2RF) // 从ID输入
        val inFromWB = Flipped(new WB2RF) // 从WB输入
        val outToID = new RF2ID // 向ID输出
    })
    
    val regBank = Mem(32, UInt(32.W)) // 例化同步写，异步读的RAM作为寄存器组
    
     // 寄存器写逻辑
    when(io.inFromWB.rWEn && (io.inFromWB.rWAddr =/=  0.U)) { // 寄存器写有效，且不是写0号寄存器，则将数据写入指定地址
        regBank.write(io.inFromWB.rWAddr, io.inFromWB.rWData)
    }
    
     // 寄存器1读逻辑
    when(io.inFromID.r1RAddr === 0.U) { // 读0号寄存器
        io.outToID.r1RData := 0.U
    }.elsewhen((io.inFromID.r1RAddr === io.inFromWB.rWAddr) // 寄存器1读地址等于寄存器写地址
            && (io.inFromID.r1REn === true.B) // 寄存器1读有效
            && (io.inFromWB.rWEn === true.B)) { // 寄存器写地址
        io.outToID.r1RData := io.inFromWB.rWData
    }.elsewhen((io.inFromID.r1REn === true.B)) { // 寄存器1读有效
        io.outToID.r1RData := regBank.read(io.inFromID.r1RAddr)
    }.otherwise { // 其他情况
        io.outToID.r1RData := 0.U(32.W)
    }
     
     // 寄存器2读逻辑，同上
    when(io.inFromID.r2RAddr === 0.U) {
        io.outToID.r2RData := 0.U
    }.elsewhen((io.inFromID.r2RAddr === io.inFromWB.rWAddr)
            && (io.inFromID.r2REn === true.B)
            && (io.inFromWB.rWEn === true.B)) {
        io.outToID.r2RData := io.inFromWB.rWData
    }.elsewhen(io.inFromID.r2REn === true.B) {
        io.outToID.r2RData := regBank.read(io.inFromID.r2RAddr)
    }.otherwise {
        io.outToID.r2RData := 0.U
    }
    
}

object RegFile extends App {
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated\\ID\\RegFile"), Seq(ChiselGeneratorAnnotation(() => new RegFile)))
}
