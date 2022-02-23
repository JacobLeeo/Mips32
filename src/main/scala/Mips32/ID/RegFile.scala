package Mips32.ID

import Mips32._
import chisel3._
import chisel3.stage.ChiselGeneratorAnnotation


class RegFile extends Module {
    
    val io = IO(new Bundle() {
        val inFromID = Flipped(new ID2RF) // 从ID输入
        val inFromWB = Flipped(new WB2RF) // 从WB输入
        val outToID = new RF2ID // 向ID输出
        val outToIDTop = new RF2IDTop
    })
    
    val regBank = Mem(32, UInt(32.W)) // 例化同步写，异步读的RAM作为寄存器组
    
     // 寄存器写逻辑
    when(io.inFromWB.rWEnO && (io.inFromWB.rWAddrO =/=  0.U)) { // 寄存器写有效，且不是写0号寄存器，则将数据写入指定地址
        regBank.write(io.inFromWB.rWAddrO, io.inFromWB.rWDataO)
    }
    
     // 寄存器1读逻辑
    when(io.inFromID.r1RAddr === 0.U) { // 读0号寄存器
        io.outToID.r1RData := 0.U
    }.elsewhen((io.inFromID.r1RAddr === io.inFromWB.rWAddrO) // 寄存器1读地址等于寄存器写地址
            && (io.inFromID.r1REn === true.B) // 寄存器1读有效
            && (io.inFromWB.rWEnO === true.B)) { // 寄存器写地址
        io.outToID.r1RData := io.inFromWB.rWDataO
    }.elsewhen((io.inFromID.r1REn === true.B)) { // 寄存器1读有效
        io.outToID.r1RData := regBank.read(io.inFromID.r1RAddr)
    }.otherwise { // 其他情况
        io.outToID.r1RData := 0.U(32.W)
    }
     
     // 寄存器2读逻辑，同上
    when(io.inFromID.r2RAddr === 0.U) {
        io.outToID.r2RData := 0.U
    }.elsewhen((io.inFromID.r2RAddr === io.inFromWB.rWAddrO)
            && (io.inFromID.r2REn === true.B)
            && (io.inFromWB.rWEnO === true.B)) {
        io.outToID.r2RData := io.inFromWB.rWDataO
    }.elsewhen(io.inFromID.r2REn === true.B) {
        io.outToID.r2RData := regBank.read(io.inFromID.r2RAddr)
    }.otherwise {
        io.outToID.r2RData := 0.U
    }
    
    io.outToIDTop.r1Out := regBank.read(1.U)
    io.outToIDTop.r2Out := regBank.read(2.U)
    io.outToIDTop.r3Out := regBank.read(3.U)
    io.outToIDTop.r4Out := regBank.read(4.U)
    io.outToIDTop.r5Out := regBank.read(5.U)
    io.outToIDTop.r6Out := regBank.read(6.U)
    io.outToIDTop.r7Out := regBank.read(7.U)
    io.outToIDTop.r8Out := regBank.read(8.U)
    io.outToIDTop.r9Out := regBank.read(9.U)
    io.outToIDTop.r10Out := regBank.read(10.U)
    io.outToIDTop.r11Out := regBank.read(11.U)
    io.outToIDTop.r12Out := regBank.read(12.U)
    io.outToIDTop.r13Out := regBank.read(13.U)
    io.outToIDTop.r14Out := regBank.read(14.U)
    io.outToIDTop.r15Out := regBank.read(15.U)
    io.outToIDTop.r16Out := regBank.read(16.U)
    io.outToIDTop.r17Out := regBank.read(17.U)
    io.outToIDTop.r18Out := regBank.read(18.U)
    io.outToIDTop.r19Out := regBank.read(19.U)
    io.outToIDTop.r20Out := regBank.read(20.U)
    io.outToIDTop.r21Out := regBank.read(21.U)
    io.outToIDTop.r22Out := regBank.read(22.U)
    io.outToIDTop.r23Out := regBank.read(23.U)
    io.outToIDTop.r24Out := regBank.read(24.U)
    io.outToIDTop.r25Out := regBank.read(25.U)
    io.outToIDTop.r26Out := regBank.read(26.U)
    io.outToIDTop.r27Out := regBank.read(27.U)
    io.outToIDTop.r28Out := regBank.read(28.U)
    io.outToIDTop.r29Out := regBank.read(29.U)
    io.outToIDTop.r30Out := regBank.read(30.U)
    io.outToIDTop.r31Out := regBank.read(31.U)
}

object RegFile extends App {
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated\\ID\\RF"), Seq(ChiselGeneratorAnnotation(() => new RegFile)))
}
