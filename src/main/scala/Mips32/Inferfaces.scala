package Mips32

import chisel3._


/*
    基础功能模块：PC、IR、DC、RF、EX、MEM、D触发器
    阶段功能模块：IFTop、IDTop、EXTop、MEMTop、WBTop
    顶层模块：Top、Out
 */

 // PC向IR
class PC2IR extends Bundle {
    val iREn = Output(Bool()) // 使能信号
    val iRRdAd = Output(UInt(8.W)) // 读地址（写地址）
    val iRWrEn = Output(Bool()) // 写使能
    val iRWrDt = Output(UInt(32.W)) // 写数据
}

 // IR向D触发器
class IR2D extends Bundle {
    val iRRdDt = Output(UInt(32.W))
}

 // TODO 可能需要修改继承关系，D触发器到IFTop的输出，不一定全部来自IR
class D2IF extends IR2D {}

// TODO 可能需要修改继承关系，IFTop到IDTop的输出，不一定全部来自IFTop
class IFTop2IDTop extends D2IF {}

class DC2RF extends Bundle {
    val r1REn = Output(Bool()) // 寄存器1读使能
    val r2REn = Output(Bool()) // 寄存器2读使能
    val r1RAddr = Output(UInt(5.W)) // 寄存器1读地址
    val r2RAddr = Output(UInt(5.W)) // 寄存器2读地址
}

class RF2DC extends Bundle {
    val r1RData = Output(UInt(32.W)) // 寄存器1读数据
    val r2RData = Output(UInt(32.W)) // 寄存器2读数据
}

class ID2D extends Bundle {
    val iSK = Output(UInt(8.W)) // 指令类型
    val iK = Output(UInt(3.W)) // 指令子类型
    val source1 = Output(UInt(32.W)) // 操作数1
    val source2 = Output(UInt(32.W)) // 操作数2
    val rWAddr = Output(UInt(5.W)) // 寄存器写地址
    val rWEn = Output(Bool()) // 寄存器写使能
}

class D2EX extends ID2D {}

class ID2EX extends D2EX {}

class EX2D extends Bundle {
    val rWAddrO = Output(UInt(5.W)) // 执行阶段寄存器写地址输出
    val rWEnO = Output(Bool()) // 执行阶段寄存器写使能输出
    val rWDataO = Output(UInt(32.W)) // 执行阶段寄存器写数据输出
}

class D2MEM extends EX2D {}

class EX2MEM extends D2MEM {}

class MEM2D extends Bundle {
    val rWAddrO = Output(UInt(5.W)) // 执行阶段寄存器写地址输出
    val rWEnO = Output(Bool()) // 执行阶段寄存器写使能输出
    val rWDataO = Output(UInt(32.W)) // 执行阶段寄存器写数据输出
}

class D2WB extends MEM2D {}

class MEM2WB extends  D2WB {}

class WB2RF extends Bundle {
    val rWEnO = Output(Bool()) // 寄存器写使能
    val rWAddrO = Output(UInt(5.W)) // 寄存器1读使能
    val rWDataO = Output(UInt(32.W)) // 寄存器2读使能
}

class RF2IDTop extends Bundle {
    val r1Out = Output(UInt(32.W))
    val r2Out = Output(UInt(32.W))
    val r3Out = Output(UInt(32.W))
    val r4Out = Output(UInt(32.W))
    val r5Out = Output(UInt(32.W))
    val r6Out = Output(UInt(32.W))
    val r7Out = Output(UInt(32.W))
    val r8Out = Output(UInt(32.W))
    val r9Out = Output(UInt(32.W))
    val r10Out = Output(UInt(32.W))
    val r11Out = Output(UInt(32.W))
    val r12Out = Output(UInt(32.W))
    val r13Out = Output(UInt(32.W))
    val r14Out = Output(UInt(32.W))
    val r15Out = Output(UInt(32.W))
    val r16Out = Output(UInt(32.W))
    val r17Out = Output(UInt(32.W))
    val r18Out = Output(UInt(32.W))
    val r19Out = Output(UInt(32.W))
    val r20Out = Output(UInt(32.W))
    val r21Out = Output(UInt(32.W))
    val r22Out = Output(UInt(32.W))
    val r23Out = Output(UInt(32.W))
    val r24Out = Output(UInt(32.W))
    val r25Out = Output(UInt(32.W))
    val r26Out = Output(UInt(32.W))
    val r27Out = Output(UInt(32.W))
    val r28Out = Output(UInt(32.W))
    val r29Out = Output(UInt(32.W))
    val r30Out = Output(UInt(32.W))
    val r31Out = Output(UInt(32.W))
}


class IDTop2Top extends Bundle {
    val fromRF = new RF2IDTop
}

class Top2Out extends Bundle {
    val fromIDTop = new IDTop2Top
}
