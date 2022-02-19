module PC(
  input        clock,
  input        reset,
  output       io_instRonEn,
  output [7:0] io_instRomAddr
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg  instRonEn; // @[PC.scala 14:26]
  reg [7:0] instRomAddr; // @[PC.scala 15:28]
  wire [7:0] _instRomAddr_T_1 = instRomAddr + 8'h4; // @[PC.scala 19:45]
  assign io_instRonEn = instRonEn; // @[PC.scala 21:16]
  assign io_instRomAddr = instRomAddr; // @[PC.scala 22:18]
  always @(posedge clock) begin
    if (reset) begin // @[PC.scala 14:26]
      instRonEn <= 1'h0; // @[PC.scala 14:26]
    end else begin
      instRonEn <= 1'h1; // @[PC.scala 17:13]
    end
    if (reset) begin // @[PC.scala 15:28]
      instRomAddr <= 8'h0; // @[PC.scala 15:28]
    end else if (instRonEn) begin // @[PC.scala 19:21]
      instRomAddr <= _instRomAddr_T_1;
    end else begin
      instRomAddr <= 8'h0;
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
  instRonEn = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  instRomAddr = _RAND_1[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
