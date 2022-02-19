module InstROM(
  input         clock,
  input         reset,
  input  [7:0]  io_rAddr,
  output [31:0] io_rData,
  input         io_wEn,
  input  [7:0]  io_wAddr,
  input  [31:0] io_wData
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] memBank [0:255]; // @[InstROM.scala 17:28]
  wire  memBank_io_rData_MPORT_en; // @[InstROM.scala 17:28]
  wire [7:0] memBank_io_rData_MPORT_addr; // @[InstROM.scala 17:28]
  wire [31:0] memBank_io_rData_MPORT_data; // @[InstROM.scala 17:28]
  wire [31:0] memBank_MPORT_data; // @[InstROM.scala 17:28]
  wire [7:0] memBank_MPORT_addr; // @[InstROM.scala 17:28]
  wire  memBank_MPORT_mask; // @[InstROM.scala 17:28]
  wire  memBank_MPORT_en; // @[InstROM.scala 17:28]
  reg  memBank_io_rData_MPORT_en_pipe_0;
  reg [7:0] memBank_io_rData_MPORT_addr_pipe_0;
  assign memBank_io_rData_MPORT_en = memBank_io_rData_MPORT_en_pipe_0;
  assign memBank_io_rData_MPORT_addr = memBank_io_rData_MPORT_addr_pipe_0;
  assign memBank_io_rData_MPORT_data = memBank[memBank_io_rData_MPORT_addr]; // @[InstROM.scala 17:28]
  assign memBank_MPORT_data = io_wData;
  assign memBank_MPORT_addr = io_wAddr;
  assign memBank_MPORT_mask = 1'h1;
  assign memBank_MPORT_en = io_wEn;
  assign io_rData = memBank_io_rData_MPORT_data; // @[InstROM.scala 19:12]
  always @(posedge clock) begin
    if (memBank_MPORT_en & memBank_MPORT_mask) begin
      memBank[memBank_MPORT_addr] <= memBank_MPORT_data; // @[InstROM.scala 17:28]
    end
    memBank_io_rData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      memBank_io_rData_MPORT_addr_pipe_0 <= io_rAddr;
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
  memBank_io_rData_MPORT_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  memBank_io_rData_MPORT_addr_pipe_0 = _RAND_2[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
