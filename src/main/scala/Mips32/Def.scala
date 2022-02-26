package Mips32

import chisel3._


class INST_LOGIC {
    val INST_K = "b001".asUInt
}

class INST_SHIFT {
    val INST_K = "b010".asUInt
}

class INST_NOP {
    val INST_K = "b000".asUInt
}


object Def {
    
    object DataPath {
        
        object IR {
            val IR_ADDR_WIDTH = UInt(8.W)
            val IR_DATA_WIDTH = UInt(32.W)
        }
        
        object RF {
            val RF_ADDR_WIDTH = UInt(5.W)
            val RF_DATA_WIDTH = UInt(32.W)
        }
    }
    
    object INST {
    
        val SPECIAL_31To26 =  "b000000".asUInt
        
        object INST_LOGIC extends INST_LOGIC {}
        object INST_SHIFT extends INST_SHIFT {}
        object INST_NOP extends INST_NOP {}
        
        
        object NOP extends INST_NOP {
            val INST_SK = "b00000000".asUInt
        }
        
        object OR extends INST_LOGIC {
            val INST_5To0 = "b100101".asUInt
            val INST_SK = "b00100101".asUInt // 指令类型号码
        }
        
        object ORI extends INST_LOGIC {
            val INST_31To26 = "b001101".asUInt
            val INST_SK = "b01100101".asUInt
        }
        
        object AND extends INST_LOGIC {
            val INST_5To0 = "b100100".asUInt
            val INST_SK = "b00100100".asUInt
        }
        
        object ANDI extends INST_LOGIC { //
            val INST_31To26 = "b001100".asUInt
            val INST_SK = "b01011001".asUInt
        }
        
        object XOR extends INST_LOGIC {
            val INST_5To0 = "b100110".asUInt
            val INST_SK = "b00100110".asUInt
        }
        
        object XORI extends INST_LOGIC { //
            val INST_32To26 = "b001110".asUInt
            val INST_SK = "b01011011".asUInt
        }
        
        object NOR extends INST_LOGIC {
            val INST_5To0 = "b100111".asUInt
            val INST_SK = "b00100111".asUInt
        }
        
        object LUI extends INST_LOGIC { //
            val INST_32To26 = "b001111".asUInt
            val INST_SK = "b01011100".asUInt
        }
        
        object SLL extends INST_SHIFT { //
            val INST_5To0 = "b000000".asUInt
            val INST_SK = "b01111100".asUInt
        }
        
        object SRL extends INST_SHIFT { //
            val INST_5To0 = "b000010".asUInt
            val INST_SK = "b00000010".asUInt
        }
        
        object SRA extends INST_SHIFT { //
            val INST_5To0 = "b000011".asUInt
            val INST_SK = "b00000011".asUInt
        }
        
        object SLLV extends INST_SHIFT {
            val INST_5To0 = "b000100".asUInt
            val INST_SK = "b00000100".asUInt
        }
        
        object SRLV extends INST_SHIFT {
            val INST_5To0 = "b000110".asUInt
            val INST_SK = "b00000110".asUInt
        }
        
        object SRAV extends INST_SHIFT {
            val INST_5To0 = "b000111".asUInt
            val INST_SK = "b00000111".asUInt
        }
    }
}
