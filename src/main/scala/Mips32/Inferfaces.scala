package Mips32

import chisel3._


class PC2IR extends Bundle {
    val iREn = Output(Bool()) // 使能信号
    val iRRdAd = Output(UInt(8.W)) // 读地址（写地址）
    val iRWrEn = Output(Bool()) // 写使能
    val iRWrDt = Output(UInt(32.W)) // 写数据
}

class IR2D extends Bundle {
    val iRRdDt = Output(UInt(32.W))
}

class D2ID extends Bundle {
    val iRRdDt = Output(UInt(32.W))
}

class ID2RF extends Bundle {
    val r1REn = Output(Bool()) // 寄存器1读使能
    val r2REn = Output(Bool()) // 寄存器2读使能
    val r1RAddr = Output(UInt(5.W)) // 寄存器1读地址
    val r2RAddr = Output(UInt(5.W)) // 寄存器2读地址
}

class RF2ID extends Bundle {
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

class D2EX extends Bundle {
    val iSK = Output(UInt(8.W)) // 指令类型
    val iK = Output(UInt(3.W)) // 指令子类型
    val source1 = Output(UInt(32.W)) // 操作数1
    val source2 = Output(UInt(32.W)) // 操作数2
    val rWAddr = Output(UInt(5.W)) // 寄存器写地址
    val rWEn = Output(Bool()) // 寄存器写使能
}

class EX2D extends Bundle {
    val rWAddrO = Output(UInt(5.W)) // 执行阶段寄存器写地址输出
    val rWEnO = Output(Bool()) // 执行阶段寄存器写使能输出
    val rWDataO = Output(UInt(32.W)) // 执行阶段寄存器写数据输出
}

 // TODO 改成继承试一试
class D2MEM extends Bundle {
    val rWAddrO = Output(UInt(5.W)) // 执行阶段寄存器写地址输出
    val rWEnO = Output(Bool()) // 执行阶段寄存器写使能输出
    val rWDataO = Output(UInt(32.W)) // 执行阶段寄存器写数据输出
}

class WB2RF extends Bundle {
    val rWEn = Output(Bool()) // 寄存器写使能
    val rWAddr = Output(UInt(32.W)) // 寄存器1读使能
    val rWData = Output(UInt(32.W)) // 寄存器2读使能
}
