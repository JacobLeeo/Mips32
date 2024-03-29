package Mips32.IF

import Mips32._
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec


// 实现IF模块与D触发器
class IFTop extends Module {
    
    val io = IO(new Bundle() {
        val outToID = new IFTop2IDTop
    })
    
    val pc = Module(new PC)
    val ir = Module(new InstROM)
    val d = Module(new DBtIFID)
    
    ir.io.inFromPC <> pc.io.outToIR // 如果PC按字节寻址，不能这样直接连接，且不在IR中做任何处理
    d.io.inFromIF <> ir.io.outToD
    io.outToID <> d.io.outToID
}

object IFTop extends App {
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated\\IF"), Seq(ChiselGeneratorAnnotation(() => new IFTop)))
}
