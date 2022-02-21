module InstROM(
  input         clock,
  input         reset,
  input         io_ena,
  input  [7:0]  io_rAddr,
  output [31:0] io_rData,
  input         io_wEn,
  input  [31:0] io_wData
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] memBank [0:255]; // @[InstROM.scala 23:30]
  wire  memBank_rdwrPort_r_en; // @[InstROM.scala 23:30]
  wire [7:0] memBank_rdwrPort_r_addr; // @[InstROM.scala 23:30]
  wire [31:0] memBank_rdwrPort_r_data; // @[InstROM.scala 23:30]
  wire [31:0] memBank_rdwrPort_w_data; // @[InstROM.scala 23:30]
  wire [7:0] memBank_rdwrPort_w_addr; // @[InstROM.scala 23:30]
  wire  memBank_rdwrPort_w_mask; // @[InstROM.scala 23:30]
  wire  memBank_rdwrPort_w_en; // @[InstROM.scala 23:30]
  reg  memBank_rdwrPort_r_en_pipe_0;
  reg [7:0] memBank_rdwrPort_r_addr_pipe_0;
  reg  enable; // @[InstROM.scala 22:25]
  wire [31:0] _GEN_2 = io_wEn ? 32'h0 : memBank_rdwrPort_r_data; // @[InstROM.scala 26:14 31:22 34:22]
  assign memBank_rdwrPort_r_en = memBank_rdwrPort_r_en_pipe_0;
  assign memBank_rdwrPort_r_addr = memBank_rdwrPort_r_addr_pipe_0;
  assign memBank_rdwrPort_r_data = memBank[memBank_rdwrPort_r_addr]; // @[InstROM.scala 23:30]
  assign memBank_rdwrPort_w_data = io_wData;
  assign memBank_rdwrPort_w_addr = io_rAddr;
  assign memBank_rdwrPort_w_mask = io_wEn;
  assign memBank_rdwrPort_w_en = enable & (enable & io_wEn);
  assign io_rData = enable ? _GEN_2 : 32'h0; // @[InstROM.scala 26:14 29:18]
  always @(posedge clock) begin
    if (memBank_rdwrPort_w_en & memBank_rdwrPort_w_mask) begin
      memBank[memBank_rdwrPort_w_addr] <= memBank_rdwrPort_w_data; // @[InstROM.scala 23:30]
    end
    memBank_rdwrPort_r_en_pipe_0 <= enable & ~(enable & io_wEn);
    if (enable & ~(enable & io_wEn)) begin
      memBank_rdwrPort_r_addr_pipe_0 <= io_rAddr;
    end
    if (reset) begin // @[InstROM.scala 22:25]
      enable <= 1'h0; // @[InstROM.scala 22:25]
    end else begin
      enable <= io_ena; // @[InstROM.scala 27:12]
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 256; initvar = initvar+1)
    memBank[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  memBank_rdwrPort_r_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  memBank_rdwrPort_r_addr_pipe_0 = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  enable = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
