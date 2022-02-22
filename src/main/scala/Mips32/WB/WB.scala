package Mips32.WB

import Mips32._
import chisel3._


class WB extends Module {
    val io = IO(new Bundle() {
        val outToRF = new WB2RF
    })
}
