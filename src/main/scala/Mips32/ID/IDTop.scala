package Mips32.ID

import Mips32._
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation


class IDTop extends Module {
    
    val io = IO(new Bundle() {
        val inFromIF = Flipped(new IFTop2IDTop)
        val inFromWB = Flipped(new WBTop2IDTop)
        val inFromEX = Flipped(new EXTop2IDTop)
        val inFromMEM = Flipped(new MEMTop2IDTop)
    
        val outToTop = new IDTop2Top
        val outToEX = new IDTop2EXTop
    })
    
    val d = Module(new DbtIDEX)
    val rf = Module(new RegFile)
    val dc = Module(new DC)
    
    dc.io.inFromIDTop.fromIFTop := io.inFromIF
    dc.io.inFromIDTop.fromEXTop := io.inFromEX
    dc.io.inFromIDTop.fromMEMTop := io.inFromMEM
    
    dc.io.inFromRF <> rf.io.outToID
    rf.io.inFromID <> dc.io.outToRF
    d.io.inFromID <> dc.io.outToD
    io.outToEX <> d.io.outToEX
    
    rf.io.inFromWB <> io.inFromWB // 写回阶段连接到寄存器堆的写地址、写数据和写使能
    
    io.outToTop.fromRF := rf.io.outToIDTop
}

object IDTop extends App {
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated\\ID"), Seq(ChiselGeneratorAnnotation(() => new IDTop)))
}
