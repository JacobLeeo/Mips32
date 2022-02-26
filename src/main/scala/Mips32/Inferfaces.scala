package Mips32

import Mips32.Def.DataPath._

import chisel3._


// .1.
// PC向IR
class PC2IR extends Bundle {
    val iREn = Output(Bool()) // 使能信号
    val iRRdAd = Output(IR.IR_ADDR_WIDTH) // 读地址（写地址）
    val iRWrEn = Output(Bool()) // 写使能
    val iRWrDt = Output(IR.IR_DATA_WIDTH) // 写数据
}

// IR向D触发器
class IR2D extends Bundle {
    val iRRdDt = Output(IR.IR_DATA_WIDTH)
}

// D触发器向IFTop
class D2IFTop extends IR2D {}

// IFTop向IDTop
class IFTop2IDTop extends D2IFTop {}


// .2.
// IDTop向DC
class IDTop2DC extends Bundle {
    val fromIFTop = new IFTop2IDTop
    val fromEXTop = new EXTop2IDTop
    val fromMEMTop = new MEMTop2IDTop
}

// DC向RF
class DC2RF extends Bundle {
    val r1REn = Output(Bool()) // 寄存器1读使能
    val r2REn = Output(Bool()) // 寄存器2读使能
    val r1RAddr = Output(RF.RF_ADDR_WIDTH) // 寄存器1读地址
    val r2RAddr = Output(RF.RF_ADDR_WIDTH) // 寄存器2读地址
}

// RF向DC
class RF2DC extends Bundle {
    val r1RData = Output(RF.RF_DATA_WIDTH) // 寄存器1读数据
    val r2RData = Output(RF.RF_DATA_WIDTH) // 寄存器2读数据
}

// ID向D触发器
class DC2D extends Bundle {
    val iSK = Output(UInt(8.W)) // 指令类型
    val iK = Output(UInt(3.W)) // 指令子类型
    val source1 = Output(UInt(32.W)) // 操作数1
    val source2 = Output(UInt(32.W)) // 操作数2
    val rWAddr = Output(RF.RF_ADDR_WIDTH) // 寄存器写地址
    val rWEn = Output(Bool()) // 寄存器写使能
}

// D触发器向IDTop
class D2IDTop extends DC2D {}

// IDTop向EXTop
class IDTop2EXTop extends D2IDTop {}

// IDTop向RF
class IDTop2RF extends WBTop2IDTop {}

// RF向IDTop
class RF2IDTop extends Bundle {
    val r1Out = Output(RF.RF_DATA_WIDTH)
    val r2Out = Output(RF.RF_DATA_WIDTH)
    val r3Out = Output(RF.RF_DATA_WIDTH)
    val r4Out = Output(RF.RF_DATA_WIDTH)
    val r5Out = Output(RF.RF_DATA_WIDTH)
    val r6Out = Output(RF.RF_DATA_WIDTH)
    val r7Out = Output(RF.RF_DATA_WIDTH)
    val r8Out = Output(RF.RF_DATA_WIDTH)
    val r9Out = Output(RF.RF_DATA_WIDTH)
    val r10Out = Output(RF.RF_DATA_WIDTH)
    val r11Out = Output(RF.RF_DATA_WIDTH)
    val r12Out = Output(RF.RF_DATA_WIDTH)
    val r13Out = Output(RF.RF_DATA_WIDTH)
    val r14Out = Output(RF.RF_DATA_WIDTH)
    val r15Out = Output(RF.RF_DATA_WIDTH)
    val r16Out = Output(RF.RF_DATA_WIDTH)
    val r17Out = Output(RF.RF_DATA_WIDTH)
    val r18Out = Output(RF.RF_DATA_WIDTH)
    val r19Out = Output(RF.RF_DATA_WIDTH)
    val r20Out = Output(RF.RF_DATA_WIDTH)
    val r21Out = Output(RF.RF_DATA_WIDTH)
    val r22Out = Output(RF.RF_DATA_WIDTH)
    val r23Out = Output(RF.RF_DATA_WIDTH)
    val r24Out = Output(RF.RF_DATA_WIDTH)
    val r25Out = Output(RF.RF_DATA_WIDTH)
    val r26Out = Output(RF.RF_DATA_WIDTH)
    val r27Out = Output(RF.RF_DATA_WIDTH)
    val r28Out = Output(RF.RF_DATA_WIDTH)
    val r29Out = Output(RF.RF_DATA_WIDTH)
    val r30Out = Output(RF.RF_DATA_WIDTH)
    val r31Out = Output(RF.RF_DATA_WIDTH)
}

// IDTop向Top
class IDTop2Top extends Bundle {
    val fromRF = new RF2IDTop
}


// .3.
// EXTop向EX
class EXTop2EX extends IDTop2EXTop {}

// EX向D触发器
class EX2D extends Bundle {
    val rWAddrO = Output(RF.RF_ADDR_WIDTH) // 执行阶段寄存器写地址输出
    val rWEnO = Output(Bool()) // 执行阶段寄存器写使能输出
    val rWDataO = Output(RF.RF_DATA_WIDTH) // 执行阶段寄存器写数据输出
}

// EX向EXTop
class EX2EXTop extends EX2D {}

// EXTop向IDTop
class EXTop2IDTop extends EX2EXTop {}

// D触发器向EXTop
class D2EXTop extends EX2D {}

// EXTop向MEMTop
class EXTop2MEMTop extends D2EXTop {}


// .4.
// MEMTop向MEM
class MEMTop2MEM extends EXTop2MEMTop {}

// MEM向D触发器
class MEM2D extends Bundle {
    val rWAddrO = Output(RF.RF_ADDR_WIDTH) // 执行阶段寄存器写地址输出
    val rWEnO = Output(Bool()) // 执行阶段寄存器写使能输出
    val rWDataO = Output(RF.RF_DATA_WIDTH) // 执行阶段寄存器写数据输出
}

// D触发器向MEMTop
class D2MEMTop extends MEM2D {}

// MEMTop向WBTop
class MEMTop2WBTop extends D2MEMTop {}

class MEM2MEMTop extends MEM2D {}

class MEMTop2IDTop extends MEM2MEMTop {}


// .5.
// WBTop向WB
class WBTop2WB extends MEMTop2WBTop {}

// WB向WBTop
class WB2WBTop extends Bundle {
    val rWAddrO = Output(RF.RF_ADDR_WIDTH) // 执行阶段寄存器写地址输出
    val rWEnO = Output(Bool()) // 执行阶段寄存器写使能输出
    val rWDataO = Output(RF.RF_DATA_WIDTH) // 执行阶段寄存器写数据输出
}

// WBTop向IDTop
class WBTop2IDTop extends WB2WBTop {}


// .6.
// Top向Out
class Top2Out extends Bundle {
    val fromIDTop = new IDTop2Top
}
