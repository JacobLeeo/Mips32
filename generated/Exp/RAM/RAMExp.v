module RAMExp(
  input         clock,
  input         reset,
  input         io_enable,
  input         io_write,
  input  [9:0]  io_addr,
  input  [31:0] io_dataIn,
  output [31:0] io_dataOut
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] mem [0:1023]; // @[RAM.scala 25:26]
  wire  mem_rdwrPort_r_en; // @[RAM.scala 25:26]
  wire [9:0] mem_rdwrPort_r_addr; // @[RAM.scala 25:26]
  wire [31:0] mem_rdwrPort_r_data; // @[RAM.scala 25:26]
  wire [31:0] mem_rdwrPort_w_data; // @[RAM.scala 25:26]
  wire [9:0] mem_rdwrPort_w_addr; // @[RAM.scala 25:26]
  wire  mem_rdwrPort_w_mask; // @[RAM.scala 25:26]
  wire  mem_rdwrPort_w_en; // @[RAM.scala 25:26]
  reg  mem_rdwrPort_r_en_pipe_0;
  reg [9:0] mem_rdwrPort_r_addr_pipe_0;
  reg  enable; // @[RAM.scala 24:25]
  wire [31:0] _GEN_2 = io_write ? 32'h0 : mem_rdwrPort_r_data; // @[RAM.scala 31:16 36:24 40:28]
  assign mem_rdwrPort_r_en = mem_rdwrPort_r_en_pipe_0;
  assign mem_rdwrPort_r_addr = mem_rdwrPort_r_addr_pipe_0;
  assign mem_rdwrPort_r_data = mem[mem_rdwrPort_r_addr]; // @[RAM.scala 25:26]
  assign mem_rdwrPort_w_data = io_dataIn;
  assign mem_rdwrPort_w_addr = io_addr;
  assign mem_rdwrPort_w_mask = io_write;
  assign mem_rdwrPort_w_en = enable & (enable & io_write);
  assign io_dataOut = enable ? _GEN_2 : 32'h0; // @[RAM.scala 31:16 34:18]
  always @(posedge clock) begin
    if (mem_rdwrPort_w_en & mem_rdwrPort_w_mask) begin
      mem[mem_rdwrPort_w_addr] <= mem_rdwrPort_w_data; // @[RAM.scala 25:26]
    end
    mem_rdwrPort_r_en_pipe_0 <= enable & ~(enable & io_write);
    if (enable & ~(enable & io_write)) begin
      mem_rdwrPort_r_addr_pipe_0 <= io_addr;
    end
    if (reset) begin // @[RAM.scala 24:25]
      enable <= 1'h0; // @[RAM.scala 24:25]
    end else begin
      enable <= io_enable; // @[RAM.scala 32:12]
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
  integer initvar;
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
  mem_rdwrPort_r_en_pipe_0 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  mem_rdwrPort_r_addr_pipe_0 = _RAND_1[9:0];
  _RAND_2 = {1{`RANDOM}};
  enable = _RAND_2[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
  $readmemh("memexp.txt", mem);
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
