package Mips32.ID

import Mips32._
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation


class IDTop extends Module {
    
    val io = IO(new Bundle() {
        val inFromIF = Flipped(new D2ID)
        val outToEX = new ID2EX
    })
    
    val d = Module(new DbtIDEX)
    val rf = Module(new RegFile)
    val dc = Module(new DC)
    
    dc.io.inFromD <> io.inFromIF
    dc.io.inFromRF <> rf.io.outToID
    rf.io.inFromID <> dc.io.outToRF
    d.io.inFromID <> dc.io.outToD
    io.outToEX <> d.io.outToEX
    
    rf.io.inFromWB := DontCare // 写回阶段连接到寄存器堆的写地址、写数据和写使能
}

object IDTop extends App {
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated\\ID"), Seq(ChiselGeneratorAnnotation(() => new IDTop)))
}
