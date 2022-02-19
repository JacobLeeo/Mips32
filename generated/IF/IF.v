module PC(
  input        clock,
  input        reset,
  output       io_instRomEn,
  output [7:0] io_instRomAddr
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] instRomAddr; // @[PC.scala 14:30]
  wire [7:0] _instRomAddr_T_1 = instRomAddr + 8'h4; // @[PC.scala 18:50]
  assign io_instRomEn = 1'h1; // @[PC.scala 16:18]
  assign io_instRomAddr = instRomAddr; // @[PC.scala 25:20]
  always @(posedge clock) begin
    if (reset) begin // @[PC.scala 14:30]
      instRomAddr <= 8'h0; // @[PC.scala 14:30]
    end else if (io_instRomEn) begin // @[PC.scala 18:23]
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
  instRomAddr = _RAND_0[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module InstROM(
  input         clock,
  input  [7:0]  io_rAddr,
  output [31:0] io_rData
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] memBank [0:255]; // @[InstROM.scala 19:30]
  wire  memBank_io_rData_MPORT_en; // @[InstROM.scala 19:30]
  wire [7:0] memBank_io_rData_MPORT_addr; // @[InstROM.scala 19:30]
  wire [31:0] memBank_io_rData_MPORT_data; // @[InstROM.scala 19:30]
  wire [31:0] memBank_MPORT_data; // @[InstROM.scala 19:30]
  wire [7:0] memBank_MPORT_addr; // @[InstROM.scala 19:30]
  wire  memBank_MPORT_mask; // @[InstROM.scala 19:30]
  wire  memBank_MPORT_en; // @[InstROM.scala 19:30]
  reg  memBank_io_rData_MPORT_en_pipe_0;
  reg [7:0] memBank_io_rData_MPORT_addr_pipe_0;
  assign memBank_io_rData_MPORT_en = memBank_io_rData_MPORT_en_pipe_0;
  assign memBank_io_rData_MPORT_addr = memBank_io_rData_MPORT_addr_pipe_0;
  assign memBank_io_rData_MPORT_data = memBank[memBank_io_rData_MPORT_addr]; // @[InstROM.scala 19:30]
  assign memBank_MPORT_data = 32'h0;
  assign memBank_MPORT_addr = 8'h0;
  assign memBank_MPORT_mask = 1'h1;
  assign memBank_MPORT_en = 1'h0;
  assign io_rData = memBank_io_rData_MPORT_data; // @[InstROM.scala 22:14]
  always @(posedge clock) begin
    if (memBank_MPORT_en & memBank_MPORT_mask) begin
      memBank[memBank_MPORT_addr] <= memBank_MPORT_data; // @[InstROM.scala 19:30]
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
module IF(
  input         clock,
  input         reset,
  output [7:0]  io_instRomAddr,
  output [31:0] io_instRomData
);
  wire  pc_clock; // @[IF.scala 17:20]
  wire  pc_reset; // @[IF.scala 17:20]
  wire  pc_io_instRomEn; // @[IF.scala 17:20]
  wire [7:0] pc_io_instRomAddr; // @[IF.scala 17:20]
  wire  instROM_clock; // @[IF.scala 18:25]
  wire [7:0] instROM_io_rAddr; // @[IF.scala 18:25]
  wire [31:0] instROM_io_rData; // @[IF.scala 18:25]
  PC pc ( // @[IF.scala 17:20]
    .clock(pc_clock),
    .reset(pc_reset),
    .io_instRomEn(pc_io_instRomEn),
    .io_instRomAddr(pc_io_instRomAddr)
  );
  InstROM instROM ( // @[IF.scala 18:25]
    .clock(instROM_clock),
    .io_rAddr(instROM_io_rAddr),
    .io_rData(instROM_io_rData)
  );
  assign io_instRomAddr = {{2'd0}, pc_io_instRomAddr[7:2]}; // @[IF.scala 30:20]
  assign io_instRomData = instROM_io_rData; // @[IF.scala 27:20]
  assign pc_clock = clock;
  assign pc_reset = reset;
  assign instROM_clock = clock;
  assign instROM_io_rAddr = {{2'd0}, pc_io_instRomAddr[7:2]}; // @[IF.scala 24:22]
endmodule
