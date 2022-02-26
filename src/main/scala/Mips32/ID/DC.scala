package Mips32.ID

import Mips32.Def.INST._

import Mips32._
import chisel3._
import chisel3.util._
import chisel3.stage.ChiselGeneratorAnnotation


class DC extends Module {
    
    val io = IO(new Bundle() {
        val inFromIDTop = Flipped(new IDTop2DC) // 从D触发器输入
        val inFromRF = Flipped(new RF2DC) // 从RF输入
        val outToD = new DC2D // 向D输出
        val outToRF = new DC2RF // 向RF输出
    })
    val inst31To26 = WireInit(io.inFromIDTop.fromIFTop.iRRdDt(31, 26))
    val inst25To21 = WireInit(io.inFromIDTop.fromIFTop.iRRdDt(25, 21))
    val inst20To16 = WireInit(io.inFromIDTop.fromIFTop.iRRdDt(20, 16))
    val inst15To11 = WireInit(io.inFromIDTop.fromIFTop.iRRdDt(15, 11))
    val inst10To6 = WireInit(io.inFromIDTop.fromIFTop.iRRdDt(10, 6))
    val inst5To0 = WireInit(io.inFromIDTop.fromIFTop.iRRdDt(5, 0))
    
    val inst31To21 = WireInit(io.inFromIDTop.fromIFTop.iRRdDt(31, 21))
    val inst15To0 = WireInit(io.inFromIDTop.fromIFTop.iRRdDt(15, 0))
    
    val imm = WireInit(0.U(32.W)) // 立即数
    
    // 初始化
    io.outToD.rWEn := false.B // 寄存器写使能初始化
    io.outToD.iSK := NOP.INST_SK // 指令类型初始化
    io.outToD.iK := NOP.INST_K // 指令子类型初始化
    io.outToD.source1 := 0.U // 操作数1初始化
    io.outToD.source2 := 0.U // 操作数2初始化
    io.outToD.rWAddr := 0.U // 寄存器写地址
    
    io.outToRF.r1REn := false.B // 寄存器1读使能初始化
    io.outToRF.r2REn := false.B // 寄存器2读使能初始化
    io.outToRF.r1RAddr := 0.U // 寄存器1读地址
    io.outToRF.r2RAddr := 0.U // 寄存器2读地址
    
    // 解码指令
    switch(inst31To26) { // 判断31 - 26
        is(SPECIAL_31To26) { // 31 - 26 为SPECIAL
            switch(inst10To6) { // 判断10 - 6
                is("b00000".asUInt) { // 10 - 6 为00000
                    switch(inst5To0) { // 判断5 - 0
                        is(AND.INST_5To0) {
                            io.outToD.rWEn := true.B // 寄存器写使能有效
                            io.outToD.rWAddr := inst15To11 // 寄存器写地址
                            io.outToD.iSK := AND.INST_SK // 指令类型为00100101
                            io.outToD.iK := AND.INST_K // 指令子类型为001
                            
                            io.outToRF.r1REn := true.B // 寄存器1读使能有效
                            io.outToRF.r2REn := true.B // 寄存器2读使能无效
                            io.outToRF.r1RAddr := inst25To21 // 寄存器1读地址
                            io.outToRF.r2RAddr := inst20To16 // 寄存器2读地址
                        }
                        is(OR.INST_5To0) {
                            io.outToD.rWEn := true.B // 寄存器写使能有效
                            io.outToD.rWAddr := inst15To11 // 寄存器写地址
                            io.outToD.iSK := OR.INST_SK // 指令类型为00100101
                            io.outToD.iK := OR.INST_K // 指令子类型为001
                            
                            io.outToRF.r1REn := true.B // 寄存器1读使能有效
                            io.outToRF.r1RAddr := inst25To21 // 寄存器1读地址
                            io.outToRF.r2REn := true.B // 寄存器2读使能无效
                            io.outToRF.r2RAddr := inst20To16 // 寄存器2读地址
                        }
                        is(XOR.INST_5To0) {
                            io.outToD.rWEn := true.B // 寄存器写使能有效
                            io.outToD.rWAddr := inst15To11 // 寄存器写地址
                            io.outToD.iSK := XOR.INST_SK // 指令类型为00100101
                            io.outToD.iK := XOR.INST_K // 指令子类型为001
                            
                            io.outToRF.r1REn := true.B // 寄存器1读使能有效
                            io.outToRF.r1RAddr := inst25To21 // 寄存器1读地址
                            io.outToRF.r2REn := true.B // 寄存器2读使能无效
                            io.outToRF.r2RAddr := inst20To16 // 寄存器2读地址
                        }
                        is(NOR.INST_5To0) {
                            io.outToD.rWEn := true.B // 寄存器写使能有效
                            io.outToD.rWAddr := inst15To11 // 寄存器写地址
                            io.outToD.iSK := NOR.INST_SK // 指令类型为00100101
                            io.outToD.iK := NOR.INST_K // 指令子类型为001
                            
                            io.outToRF.r1REn := true.B // 寄存器1读使能有效
                            io.outToRF.r1RAddr := inst25To21 // 寄存器1读地址
                            io.outToRF.r2REn := true.B // 寄存器2读使能无效
                            io.outToRF.r2RAddr := inst20To16 // 寄存器2读地址
                        }
                        is(SLLV.INST_5To0) {
                            io.outToD.rWEn := true.B // 寄存器写使能有效
                            io.outToD.rWAddr := inst15To11 // 寄存器写地址
                            io.outToD.iSK := SLLV.INST_SK // 指令类型为00100101
                            io.outToD.iK := SLLV.INST_K // 指令子类型为001
                            
                            io.outToRF.r1REn := true.B // 寄存器1读使能有效
                            io.outToRF.r1RAddr := inst25To21 // 寄存器1读地址
                            io.outToRF.r2REn := true.B // 寄存器2读使能无效
                            io.outToRF.r2RAddr := inst20To16 // 寄存器2读地址
                        }
                        is(SRLV.INST_5To0) {
                            io.outToD.rWEn := true.B // 寄存器写使能有效
                            io.outToD.rWAddr := inst15To11 // 寄存器写地址
                            io.outToD.iSK := SRLV.INST_SK // 指令类型为00100101
                            io.outToD.iK := SRLV.INST_K // 指令子类型为001
                            
                            io.outToRF.r1REn := true.B // 寄存器1读使能有效
                            io.outToRF.r1RAddr := inst25To21 // 寄存器1读地址
                            io.outToRF.r2REn := true.B // 寄存器2读使能无效
                            io.outToRF.r2RAddr := inst20To16 // 寄存器2读地址
                        }
                        is(SRAV.INST_5To0) {
                            io.outToD.rWEn := true.B // 寄存器写使能有效
                            io.outToD.rWAddr := inst15To11 // 寄存器写地址
                            io.outToD.iSK := SRAV.INST_SK // 指令类型为00100101
                            io.outToD.iK := SRAV.INST_K // 指令子类型为001
                            
                            io.outToRF.r1REn := true.B // 寄存器1读使能有效
                            io.outToRF.r1RAddr := inst25To21 // 寄存器1读地址
                            io.outToRF.r2REn := true.B // 寄存器2读使能无效
                            io.outToRF.r2RAddr := inst20To16 // 寄存器2读地址
                        }
                    }
                }
                // 10 - 6不是00000
            }
        }
        // 31 - 26不是000000
        
        is(ORI.INST_31To26) { // 指令码为001101
            io.outToD.rWEn := true.B // 寄存器写使能有效
            io.outToD.rWAddr := inst20To16
            io.outToD.iSK := ORI.INST_SK // 指令类型为00100101
            io.outToD.iK := ORI.INST_K // 指令子类型为001
            
            io.outToRF.r1REn := true.B // 寄存器1读使能有效
            io.outToRF.r2REn := false.B // 寄存器2读使能无效
            io.outToRF.r1RAddr := inst25To21 // 寄存器1读地址
            io.outToRF.r2RAddr := 0.U // 寄存器2读地址
            
            imm := inst15To0 // 获取指令中的立即数，并将其扩展为32位
        }
        
        is(ANDI.INST_31To26) {
            io.outToD.rWEn := true.B // 寄存器写使能有效
            io.outToD.rWAddr := inst20To16
            io.outToD.iSK := ANDI.INST_SK // 指令类型为00100101
            io.outToD.iK := ANDI.INST_K // 指令子类型为001
    
            io.outToRF.r1REn := true.B // 寄存器1读使能有效
            io.outToRF.r2REn := false.B // 寄存器2读使能无效
            io.outToRF.r1RAddr := inst25To21 // 寄存器1读地址
            io.outToRF.r2RAddr := 0.U // 寄存器2读地址
    
            imm := inst15To0 // 获取指令中的立即数，并将其扩展为32位
        }
        
        is(XORI.INST_32To26) {
            io.outToD.rWEn := true.B // 寄存器写使能有效
            io.outToD.rWAddr := inst20To16
            io.outToD.iSK := XORI.INST_SK // 指令类型为00100101
            io.outToD.iK := XORI.INST_K // 指令子类型为001
    
            io.outToRF.r1REn := true.B // 寄存器1读使能有效
            io.outToRF.r2REn := false.B // 寄存器2读使能无效
            io.outToRF.r1RAddr := inst25To21 // 寄存器1读地址
            io.outToRF.r2RAddr := 0.U // 寄存器2读地址
    
            imm := inst15To0 // 获取指令中的立即数，并将其扩展为32位
        }
        
        is(LUI.INST_32To26) {
            io.outToD.rWEn := true.B // 寄存器写使能有效
            io.outToD.rWAddr := inst20To16
            io.outToD.iSK := LUI.INST_SK // 指令类型为00100101
            io.outToD.iK := LUI.INST_K // 指令子类型为001
    
            io.outToRF.r1REn := false.B // 寄存器1读使能有效
            io.outToRF.r2REn := false.B // 寄存器2读使能无效
            io.outToRF.r1RAddr := 0.U // 寄存器1读地址
            io.outToRF.r2RAddr := 0.U // 寄存器2读地址
            
            imm := Cat(inst15To0,  Fill(16, "b0".U))
        }
        
    }
    
    when(inst31To21 === Fill(11, "b0".U)) {
        switch(inst5To0) {
            is(SLL.INST_5To0) {
                io.outToD.rWEn := true.B // 寄存器写使能有效
                io.outToD.rWAddr := inst15To11 // 寄存器写地址
                io.outToD.iSK := SLL.INST_SK // 指令类型为00100101
                io.outToD.iK := SLL.INST_K // 指令子类型为001
    
                io.outToRF.r1REn := false.B // 寄存器1读使能有效
                io.outToRF.r2REn := true.B // 寄存器2读使能无效
                io.outToRF.r1RAddr := 0.U // 寄存器1读地址
                io.outToRF.r2RAddr := inst20To16 // 寄存器2读地址
                
                imm := inst10To6 // 操作数1换成指令的6 - 10
            }
            is(SRL.INST_5To0) {
                io.outToD.rWEn := true.B // 寄存器写使能有效
                io.outToD.rWAddr := inst15To11 // 寄存器写地址
                io.outToD.iSK := SRL.INST_SK // 指令类型为00100101
                io.outToD.iK := SRL.INST_K // 指令子类型为001
    
                io.outToRF.r1REn := false.B // 寄存器1读使能有效
                io.outToRF.r2REn := true.B // 寄存器2读使能无效
                io.outToRF.r1RAddr := 0.U // 寄存器1读地址
                io.outToRF.r2RAddr := inst20To16 // 寄存器2读地址
    
                imm := inst10To6 // 操作数1换成指令6 - 10
            }
            is(SRA.INST_5To0) {
                io.outToD.rWEn := true.B // 寄存器写使能有效
                io.outToD.rWAddr := inst15To11 // 寄存器写地址
                io.outToD.iSK := SRA.INST_SK // 指令类型为00100101
                io.outToD.iK := SRA.INST_K // 指令子类型为001
    
                io.outToRF.r1REn := false.B
                io.outToRF.r2REn := true.B // 寄存器2读使能无效
                io.outToRF.r1RAddr := 0.U // 寄存器1读地址
                io.outToRF.r2RAddr := inst20To16 // 寄存器2读地址
    
                imm := inst10To6 // 操作数1换成指令6 - 10
            }
        }
    }
    
    when((io.outToRF.r1REn === true.B)
        && (io.inFromIDTop.fromEXTop.rWEnO === true.B)
        && (io.inFromIDTop.fromEXTop.rWAddrO === io.outToRF.r1RAddr)) {
        io.outToD.source1 := io.inFromIDTop.fromEXTop.rWDataO
    }.elsewhen((io.outToRF.r1REn === true.B)
        && (io.inFromIDTop.fromMEMTop.rWEnO === true.B)
        && (io.inFromIDTop.fromMEMTop.rWAddrO === io.outToRF.r1RAddr)) {
        io.outToD.source1 := io.inFromIDTop.fromMEMTop.rWDataO
    }.elsewhen(io.outToRF.r1REn === true.B) { // 当寄存器1读使能有效时，将操作数1重定向为寄存器1读数据
        io.outToD.source1 := io.inFromRF.r1RData
    }.elsewhen(io.outToRF.r1REn === false.B) { // 当寄存器1读使能无效时，将操作数1重定向为立即数
        io.outToD.source1 := imm
    }
    
    when((io.outToRF.r2REn === true.B)
        && (io.inFromIDTop.fromEXTop.rWEnO === true.B)
        && (io.inFromIDTop.fromEXTop.rWAddrO === io.outToRF.r2RAddr)) {
        io.outToD.source2 := io.inFromIDTop.fromEXTop.rWDataO
    }.elsewhen((io.outToRF.r2REn === true.B)
        && (io.inFromIDTop.fromMEMTop.rWEnO === true.B)
        && (io.inFromIDTop.fromMEMTop.rWAddrO === io.outToRF.r2RAddr)) {
        io.outToD.source2 := io.inFromIDTop.fromMEMTop.rWDataO
    }.elsewhen(io.outToRF.r2REn === true.B) { // 当寄存器2读使能有效时，将操作数2重定向为寄存器2读数据
        io.outToD.source2 := io.inFromRF.r2RData
    }.elsewhen(io.outToRF.r2REn === false.B) { // 当寄存器2读使能无效时，将操作数2重定向为立即数
        io.outToD.source2 := imm
    }
}

object DC extends App {
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated\\ID\\DC"), Seq(ChiselGeneratorAnnotation(() => new DC)))
}
