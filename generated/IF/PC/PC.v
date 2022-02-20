module PC(
  input        clock,
  input        reset,
  output       io_instRomEn,
  output [7:0] io_instRomAddr
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] instRomAddr; // @[PC.scala 14:30]
  reg  instRomEn; // @[PC.scala 15:29]
  wire [7:0] _instRomAddr_T_1 = instRomAddr + 8'h4; // @[PC.scala 18:50]
  assign io_instRomEn = instRomEn; // @[PC.scala 26:18]
  assign io_instRomAddr = instRomAddr; // @[PC.scala 25:20]
  always @(posedge clock) begin
    if (reset) begin // @[PC.scala 14:30]
      instRomAddr <= 8'h0; // @[PC.scala 14:30]
    end else if (io_instRomEn) begin // @[PC.scala 18:23]
      instRomAddr <= _instRomAddr_T_1;
    end else begin
      instRomAddr <= 8'h0;
    end
    if (reset) begin // @[PC.scala 15:29]
      instRomEn <= 1'h0; // @[PC.scala 15:29]
    end else begin
      instRomEn <= 1'h1; // @[PC.scala 17:15]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  instRomAddr = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  instRomEn = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
