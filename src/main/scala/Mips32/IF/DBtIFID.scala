package Mips32.IF

import Mips32._
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation


class DBtIFID extends Module {
    
    val io = IO(new Bundle() {
        val inFromIF = Flipped(new IR2D) // 从IF阶段输入的信号
        val outToID = new D2ID // 向ID阶段输出的信号
    })
    
    val instRomData = WireInit(0.U(32.W))
    
    instRomData := io.inFromIF.iRRdDt
    io.outToID.iRRdDt := instRomData
}

object DBtIFID extends App {
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated\\IF"), Seq(ChiselGeneratorAnnotation(() => new DBtIFID)))
}
