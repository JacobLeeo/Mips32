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
module InstROM(
  input         clock,
  input         io_ena,
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
  reg [31:0] memBank [0:255]; // @[InstROM.scala 21:30]
  wire  memBank_io_rData_MPORT_en; // @[InstROM.scala 21:30]
  wire [7:0] memBank_io_rData_MPORT_addr; // @[InstROM.scala 21:30]
  wire [31:0] memBank_io_rData_MPORT_data; // @[InstROM.scala 21:30]
  wire [31:0] memBank_MPORT_data; // @[InstROM.scala 21:30]
  wire [7:0] memBank_MPORT_addr; // @[InstROM.scala 21:30]
  wire  memBank_MPORT_mask; // @[InstROM.scala 21:30]
  wire  memBank_MPORT_en; // @[InstROM.scala 21:30]
  reg  memBank_io_rData_MPORT_en_pipe_0;
  reg [7:0] memBank_io_rData_MPORT_addr_pipe_0;
  assign memBank_io_rData_MPORT_en = memBank_io_rData_MPORT_en_pipe_0;
  assign memBank_io_rData_MPORT_addr = memBank_io_rData_MPORT_addr_pipe_0;
  assign memBank_io_rData_MPORT_data = memBank[memBank_io_rData_MPORT_addr]; // @[InstROM.scala 21:30]
  assign memBank_MPORT_data = 32'h0;
  assign memBank_MPORT_addr = 8'h0;
  assign memBank_MPORT_mask = 1'h1;
  assign memBank_MPORT_en = 1'h0;
  assign io_rData = memBank_io_rData_MPORT_data; // @[InstROM.scala 24:15]
  always @(posedge clock) begin
    if (memBank_MPORT_en & memBank_MPORT_mask) begin
      memBank[memBank_MPORT_addr] <= memBank_MPORT_data; // @[InstROM.scala 21:30]
    end
    memBank_io_rData_MPORT_en_pipe_0 <= io_ena;
    if (io_ena) begin
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
module IFTop(
  input         clock,
  input         reset,
  output [31:0] io_instRomData
);
  wire  pc_clock; // @[IFTop.scala 18:20]
  wire  pc_reset; // @[IFTop.scala 18:20]
  wire  pc_io_instRomEn; // @[IFTop.scala 18:20]
  wire [7:0] pc_io_instRomAddr; // @[IFTop.scala 18:20]
  wire  instROM_clock; // @[IFTop.scala 19:25]
  wire  instROM_io_ena; // @[IFTop.scala 19:25]
  wire [7:0] instROM_io_rAddr; // @[IFTop.scala 19:25]
  wire [31:0] instROM_io_rData; // @[IFTop.scala 19:25]
  PC pc ( // @[IFTop.scala 18:20]
    .clock(pc_clock),
    .reset(pc_reset),
    .io_instRomEn(pc_io_instRomEn),
    .io_instRomAddr(pc_io_instRomAddr)
  );
  InstROM instROM ( // @[IFTop.scala 19:25]
    .clock(instROM_clock),
    .io_ena(instROM_io_ena),
    .io_rAddr(instROM_io_rAddr),
    .io_rData(instROM_io_rData)
  );
  assign io_instRomData = instROM_io_rData; // @[IFTop.scala 28:20]
  assign pc_clock = clock;
  assign pc_reset = reset;
  assign instROM_clock = clock;
  assign instROM_io_ena = pc_io_instRomEn; // @[IFTop.scala 26:20]
  assign instROM_io_rAddr = {{2'd0}, pc_io_instRomAddr[7:2]}; // @[IFTop.scala 25:22]
endmodule
module ID(
  input  [31:0] io_instData,
  input  [31:0] io_r1RData,
  input  [31:0] io_r2RData,
  output        io_r1REn,
  output        io_r2REn,
  output [4:0]  io_r1RAddr,
  output [4:0]  io_r2RAddr,
  output [7:0]  io_iKind,
  output [2:0]  io_iSKind,
  output [31:0] io_source1,
  output [31:0] io_source2,
  output [4:0]  io_rWAddr,
  output        io_rWEn
);
  wire [5:0] op = io_instData[31:26]; // @[ID.scala 36:22]
  wire  _T = 6'hd == op; // @[ID.scala 48:16]
  wire [5:0] _GEN_1 = 6'hd == op ? 6'h25 : 6'h0; // @[ID.scala 45:14 48:16 51:22]
  wire [31:0] imm = 6'hd == op ? {{16'd0}, io_instData[15:0]} : 32'h0; // @[ID.scala 48:16 55:17]
  wire [31:0] _GEN_4 = ~io_r1REn ? imm : 32'h0; // @[ID.scala 61:38 62:20 64:20]
  wire [31:0] _GEN_6 = ~io_r2REn ? imm : 32'h0; // @[ID.scala 69:38 70:20 72:20]
  assign io_r1REn = 6'hd == op; // @[ID.scala 48:16]
  assign io_r2REn = 1'h0; // @[ID.scala 39:14 48:16 54:22]
  assign io_r1RAddr = io_instData[25:21]; // @[ID.scala 42:30]
  assign io_r2RAddr = io_instData[20:16]; // @[ID.scala 43:30]
  assign io_iKind = {{2'd0}, _GEN_1};
  assign io_iSKind = {{2'd0}, _T};
  assign io_source1 = io_r1REn ? io_r1RData : _GEN_4; // @[ID.scala 59:31 60:20]
  assign io_source2 = io_r2REn ? io_r2RData : _GEN_6; // @[ID.scala 67:31 68:20]
  assign io_rWAddr = io_instData[20:16]; // @[ID.scala 41:29]
  assign io_rWEn = 6'hd == op; // @[ID.scala 48:16]
endmodule
module RegFile(
  input         clock,
  input         io_r1REn,
  input  [4:0]  io_r1RAddr,
  output [31:0] io_r1RData,
  input  [4:0]  io_r2RAddr,
  output [31:0] io_r2RData
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [31:0] regBank [0:31]; // @[RegFile.scala 28:22]
  wire  regBank_io_r1RData_MPORT_en; // @[RegFile.scala 28:22]
  wire [4:0] regBank_io_r1RData_MPORT_addr; // @[RegFile.scala 28:22]
  wire [31:0] regBank_io_r1RData_MPORT_data; // @[RegFile.scala 28:22]
  wire  regBank_io_r2RData_MPORT_en; // @[RegFile.scala 28:22]
  wire [4:0] regBank_io_r2RData_MPORT_addr; // @[RegFile.scala 28:22]
  wire [31:0] regBank_io_r2RData_MPORT_data; // @[RegFile.scala 28:22]
  wire [31:0] regBank_MPORT_data; // @[RegFile.scala 28:22]
  wire [4:0] regBank_MPORT_addr; // @[RegFile.scala 28:22]
  wire  regBank_MPORT_mask; // @[RegFile.scala 28:22]
  wire  regBank_MPORT_en; // @[RegFile.scala 28:22]
  wire  _T_2 = io_r1RAddr == 5'h0; // @[RegFile.scala 36:21]
  wire [31:0] _GEN_8 = io_r1REn ? regBank_io_r1RData_MPORT_data : 32'h0; // @[RegFile.scala 42:39 43:20 45:20]
  assign regBank_io_r1RData_MPORT_en = _T_2 ? 1'h0 : io_r1REn;
  assign regBank_io_r1RData_MPORT_addr = io_r1RAddr;
  assign regBank_io_r1RData_MPORT_data = regBank[regBank_io_r1RData_MPORT_addr]; // @[RegFile.scala 28:22]
  assign regBank_io_r2RData_MPORT_en = 1'h0;
  assign regBank_io_r2RData_MPORT_addr = io_r2RAddr;
  assign regBank_io_r2RData_MPORT_data = regBank[regBank_io_r2RData_MPORT_addr]; // @[RegFile.scala 28:22]
  assign regBank_MPORT_data = 32'h0;
  assign regBank_MPORT_addr = 5'h0;
  assign regBank_MPORT_mask = 1'h1;
  assign regBank_MPORT_en = 1'h0;
  assign io_r1RData = io_r1RAddr == 5'h0 ? 32'h0 : _GEN_8; // @[RegFile.scala 36:30 37:20]
  assign io_r2RData = io_r2RAddr == 5'h0 ? 32'h0 : 32'h2; // @[RegFile.scala 49:30 50:20]
  always @(posedge clock) begin
    if (regBank_MPORT_en & regBank_MPORT_mask) begin
      regBank[regBank_MPORT_addr] <= regBank_MPORT_data; // @[RegFile.scala 28:22]
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
  for (initvar = 0; initvar < 32; initvar = initvar+1)
    regBank[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module IDTop(
  input         clock,
  input  [31:0] io_instData,
  output [7:0]  io_iKind,
  output [2:0]  io_iSKind,
  output [31:0] io_source1,
  output [31:0] io_source2,
  output [4:0]  io_rWAddr,
  output        io_rWEn
);
  wire [31:0] id_io_instData; // @[IDTop.scala 26:20]
  wire [31:0] id_io_r1RData; // @[IDTop.scala 26:20]
  wire [31:0] id_io_r2RData; // @[IDTop.scala 26:20]
  wire  id_io_r1REn; // @[IDTop.scala 26:20]
  wire  id_io_r2REn; // @[IDTop.scala 26:20]
  wire [4:0] id_io_r1RAddr; // @[IDTop.scala 26:20]
  wire [4:0] id_io_r2RAddr; // @[IDTop.scala 26:20]
  wire [7:0] id_io_iKind; // @[IDTop.scala 26:20]
  wire [2:0] id_io_iSKind; // @[IDTop.scala 26:20]
  wire [31:0] id_io_source1; // @[IDTop.scala 26:20]
  wire [31:0] id_io_source2; // @[IDTop.scala 26:20]
  wire [4:0] id_io_rWAddr; // @[IDTop.scala 26:20]
  wire  id_io_rWEn; // @[IDTop.scala 26:20]
  wire  rf_clock; // @[IDTop.scala 27:20]
  wire  rf_io_r1REn; // @[IDTop.scala 27:20]
  wire [4:0] rf_io_r1RAddr; // @[IDTop.scala 27:20]
  wire [31:0] rf_io_r1RData; // @[IDTop.scala 27:20]
  wire [4:0] rf_io_r2RAddr; // @[IDTop.scala 27:20]
  wire [31:0] rf_io_r2RData; // @[IDTop.scala 27:20]
  ID id ( // @[IDTop.scala 26:20]
    .io_instData(id_io_instData),
    .io_r1RData(id_io_r1RData),
    .io_r2RData(id_io_r2RData),
    .io_r1REn(id_io_r1REn),
    .io_r2REn(id_io_r2REn),
    .io_r1RAddr(id_io_r1RAddr),
    .io_r2RAddr(id_io_r2RAddr),
    .io_iKind(id_io_iKind),
    .io_iSKind(id_io_iSKind),
    .io_source1(id_io_source1),
    .io_source2(id_io_source2),
    .io_rWAddr(id_io_rWAddr),
    .io_rWEn(id_io_rWEn)
  );
  RegFile rf ( // @[IDTop.scala 27:20]
    .clock(rf_clock),
    .io_r1REn(rf_io_r1REn),
    .io_r1RAddr(rf_io_r1RAddr),
    .io_r1RData(rf_io_r1RData),
    .io_r2RAddr(rf_io_r2RAddr),
    .io_r2RData(rf_io_r2RData)
  );
  assign io_iKind = id_io_iKind; // @[IDTop.scala 45:14]
  assign io_iSKind = id_io_iSKind; // @[IDTop.scala 46:15]
  assign io_source1 = id_io_source1; // @[IDTop.scala 39:16]
  assign io_source2 = id_io_source2; // @[IDTop.scala 40:16]
  assign io_rWAddr = id_io_rWAddr; // @[IDTop.scala 43:15]
  assign io_rWEn = id_io_rWEn; // @[IDTop.scala 42:13]
  assign id_io_instData = io_instData; // @[IDTop.scala 29:20]
  assign id_io_r1RData = rf_io_r1RData; // @[IDTop.scala 36:19]
  assign id_io_r2RData = rf_io_r2RData; // @[IDTop.scala 37:19]
  assign rf_clock = clock;
  assign rf_io_r1REn = id_io_r1REn; // @[IDTop.scala 31:17]
  assign rf_io_r1RAddr = id_io_r1RAddr; // @[IDTop.scala 33:19]
  assign rf_io_r2RAddr = id_io_r2RAddr; // @[IDTop.scala 34:19]
endmodule
module Top(
  input         clock,
  input         reset,
  output [7:0]  io_iKind,
  output [2:0]  io_iSKind,
  output [31:0] io_source1,
  output [31:0] io_source2,
  output [4:0]  io_rWAddr,
  output        io_rWEn
);
  wire  iftop_clock; // @[Top.scala 24:23]
  wire  iftop_reset; // @[Top.scala 24:23]
  wire [31:0] iftop_io_instRomData; // @[Top.scala 24:23]
  wire  idTop_clock; // @[Top.scala 25:23]
  wire [31:0] idTop_io_instData; // @[Top.scala 25:23]
  wire [7:0] idTop_io_iKind; // @[Top.scala 25:23]
  wire [2:0] idTop_io_iSKind; // @[Top.scala 25:23]
  wire [31:0] idTop_io_source1; // @[Top.scala 25:23]
  wire [31:0] idTop_io_source2; // @[Top.scala 25:23]
  wire [4:0] idTop_io_rWAddr; // @[Top.scala 25:23]
  wire  idTop_io_rWEn; // @[Top.scala 25:23]
  IFTop iftop ( // @[Top.scala 24:23]
    .clock(iftop_clock),
    .reset(iftop_reset),
    .io_instRomData(iftop_io_instRomData)
  );
  IDTop idTop ( // @[Top.scala 25:23]
    .clock(idTop_clock),
    .io_instData(idTop_io_instData),
    .io_iKind(idTop_io_iKind),
    .io_iSKind(idTop_io_iSKind),
    .io_source1(idTop_io_source1),
    .io_source2(idTop_io_source2),
    .io_rWAddr(idTop_io_rWAddr),
    .io_rWEn(idTop_io_rWEn)
  );
  assign io_iKind = idTop_io_iKind; // @[Top.scala 30:14]
  assign io_iSKind = idTop_io_iSKind; // @[Top.scala 31:15]
  assign io_source1 = idTop_io_source1; // @[Top.scala 32:16]
  assign io_source2 = idTop_io_source2; // @[Top.scala 33:16]
  assign io_rWAddr = idTop_io_rWAddr; // @[Top.scala 34:15]
  assign io_rWEn = idTop_io_rWEn; // @[Top.scala 35:13]
  assign iftop_clock = clock;
  assign iftop_reset = reset;
  assign idTop_clock = clock;
  assign idTop_io_instData = iftop_io_instRomData; // @[Top.scala 27:23]
endmodule
