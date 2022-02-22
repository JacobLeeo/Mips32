package Mips32.IF

import Mips32._
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation


class PC extends Module {
    
    val io = IO(new Bundle() {
        val outToIR = new PC2IR // 从PC输出到IR的信号
    })
    
    val instRomAddr = RegInit(0.U(8.W))
    val instRomEn =  RegInit(false.B)
    
    instRomEn := true.B
    instRomAddr := Mux(io.outToIR.iREn, instRomAddr + 4.U, 0.U)
    
    io.outToIR.iRWrDt := DontCare
    io.outToIR.iRWrEn := DontCare
    io.outToIR.iRRdAd := instRomAddr
    io.outToIR.iREn := instRomEn
}

object PC extends App {
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated\\IF\\PC"), Seq(ChiselGeneratorAnnotation(() => new PC)))
}
