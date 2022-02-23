module PC(
  input        clock,
  input        reset,
  output       io_outToIR_iREn,
  output [7:0] io_outToIR_iRRdAd
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] instRomAddr; // @[PC.scala 14:30]
  reg  instRomEn; // @[PC.scala 15:29]
  wire [7:0] _instRomAddr_T_1 = instRomAddr + 8'h4; // @[PC.scala 18:53]
  assign io_outToIR_iREn = instRomEn; // @[PC.scala 23:21]
  assign io_outToIR_iRRdAd = instRomAddr; // @[PC.scala 22:23]
  always @(posedge clock) begin
    if (reset) begin // @[PC.scala 14:30]
      instRomAddr <= 8'h0; // @[PC.scala 14:30]
    end else if (io_outToIR_iREn) begin // @[PC.scala 18:23]
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
  input         reset,
  input         io_inFromPC_iREn,
  input  [7:0]  io_inFromPC_iRRdAd,
  output [31:0] io_outToD_iRRdDt
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] memBank [0:255]; // @[InstROM.scala 17:30]
  wire  memBank_rdwrPort_r_en; // @[InstROM.scala 17:30]
  wire [7:0] memBank_rdwrPort_r_addr; // @[InstROM.scala 17:30]
  wire [31:0] memBank_rdwrPort_r_data; // @[InstROM.scala 17:30]
  wire [31:0] memBank_rdwrPort_w_data; // @[InstROM.scala 17:30]
  wire [7:0] memBank_rdwrPort_w_addr; // @[InstROM.scala 17:30]
  wire  memBank_rdwrPort_w_mask; // @[InstROM.scala 17:30]
  wire  memBank_rdwrPort_w_en; // @[InstROM.scala 17:30]
  reg  memBank_rdwrPort_r_en_pipe_0;
  reg [7:0] memBank_rdwrPort_r_addr_pipe_0;
  reg  enable; // @[InstROM.scala 16:25]
  wire [31:0] _GEN_2 = memBank_rdwrPort_r_data; // @[InstROM.scala 21:22 26:34 29:30]
  assign memBank_rdwrPort_r_en = memBank_rdwrPort_r_en_pipe_0;
  assign memBank_rdwrPort_r_addr = memBank_rdwrPort_r_addr_pipe_0;
  assign memBank_rdwrPort_r_data = memBank[memBank_rdwrPort_r_addr]; // @[InstROM.scala 17:30]
  assign memBank_rdwrPort_w_data = 32'h0;
  assign memBank_rdwrPort_w_addr = io_inFromPC_iRRdAd;
  assign memBank_rdwrPort_w_mask = 1'h0;
  assign memBank_rdwrPort_w_en = enable & 1'h0;
  assign io_outToD_iRRdDt = enable ? _GEN_2 : 32'h0; // @[InstROM.scala 24:18 21:22]
  always @(posedge clock) begin
    if (memBank_rdwrPort_w_en & memBank_rdwrPort_w_mask) begin
      memBank[memBank_rdwrPort_w_addr] <= memBank_rdwrPort_w_data; // @[InstROM.scala 17:30]
    end
    memBank_rdwrPort_r_en_pipe_0 <= enable & ~1'h0;
    if (enable & ~1'h0) begin
      memBank_rdwrPort_r_addr_pipe_0 <= io_inFromPC_iRRdAd;
    end
    if (reset) begin // @[InstROM.scala 16:25]
      enable <= 1'h0; // @[InstROM.scala 16:25]
    end else begin
      enable <= io_inFromPC_iREn; // @[InstROM.scala 22:12]
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
module DBtIFID(
  input  [31:0] io_inFromIF_iRRdDt,
  output [31:0] io_outToID_iRRdDt
);
  assign io_outToID_iRRdDt = io_inFromIF_iRRdDt; // @[DBtIFID.scala 18:23]
endmodule
module IFTop(
  input         clock,
  input         reset,
  output [31:0] io_outToID_iRRdDt
);
  wire  pc_clock; // @[IFTop.scala 21:20]
  wire  pc_reset; // @[IFTop.scala 21:20]
  wire  pc_io_outToIR_iREn; // @[IFTop.scala 21:20]
  wire [7:0] pc_io_outToIR_iRRdAd; // @[IFTop.scala 21:20]
  wire  ir_clock; // @[IFTop.scala 22:20]
  wire  ir_reset; // @[IFTop.scala 22:20]
  wire  ir_io_inFromPC_iREn; // @[IFTop.scala 22:20]
  wire [7:0] ir_io_inFromPC_iRRdAd; // @[IFTop.scala 22:20]
  wire [31:0] ir_io_outToD_iRRdDt; // @[IFTop.scala 22:20]
  wire [31:0] d_io_inFromIF_iRRdDt; // @[IFTop.scala 23:19]
  wire [31:0] d_io_outToID_iRRdDt; // @[IFTop.scala 23:19]
  PC pc ( // @[IFTop.scala 21:20]
    .clock(pc_clock),
    .reset(pc_reset),
    .io_outToIR_iREn(pc_io_outToIR_iREn),
    .io_outToIR_iRRdAd(pc_io_outToIR_iRRdAd)
  );
  InstROM ir ( // @[IFTop.scala 22:20]
    .clock(ir_clock),
    .reset(ir_reset),
    .io_inFromPC_iREn(ir_io_inFromPC_iREn),
    .io_inFromPC_iRRdAd(ir_io_inFromPC_iRRdAd),
    .io_outToD_iRRdDt(ir_io_outToD_iRRdDt)
  );
  DBtIFID d ( // @[IFTop.scala 23:19]
    .io_inFromIF_iRRdDt(d_io_inFromIF_iRRdDt),
    .io_outToID_iRRdDt(d_io_outToID_iRRdDt)
  );
  assign io_outToID_iRRdDt = d_io_outToID_iRRdDt; // @[IFTop.scala 27:16]
  assign pc_clock = clock;
  assign pc_reset = reset;
  assign ir_clock = clock;
  assign ir_reset = reset;
  assign ir_io_inFromPC_iREn = pc_io_outToIR_iREn; // @[IFTop.scala 25:20]
  assign ir_io_inFromPC_iRRdAd = pc_io_outToIR_iRRdAd; // @[IFTop.scala 25:20]
  assign d_io_inFromIF_iRRdDt = ir_io_outToD_iRRdDt; // @[IFTop.scala 26:19]
endmodule
module DbtIDEX(
  input         clock,
  input         reset,
  input  [7:0]  io_inFromID_iSK,
  input  [2:0]  io_inFromID_iK,
  input  [31:0] io_inFromID_source1,
  input  [31:0] io_inFromID_source2,
  input  [4:0]  io_inFromID_rWAddr,
  input         io_inFromID_rWEn,
  output [7:0]  io_outToEX_iSK,
  output [2:0]  io_outToEX_iK,
  output [31:0] io_outToEX_source1,
  output [31:0] io_outToEX_source2,
  output [4:0]  io_outToEX_rWAddr,
  output        io_outToEX_rWEn
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] iSK; // @[DbtIDEX.scala 14:22]
  reg [2:0] iK; // @[DbtIDEX.scala 15:21]
  reg [31:0] s1; // @[DbtIDEX.scala 16:21]
  reg [31:0] s2; // @[DbtIDEX.scala 17:21]
  reg [4:0] rWAddr; // @[DbtIDEX.scala 18:25]
  reg  rWEn; // @[DbtIDEX.scala 19:23]
  assign io_outToEX_iSK = iSK; // @[DbtIDEX.scala 21:20]
  assign io_outToEX_iK = iK; // @[DbtIDEX.scala 22:19]
  assign io_outToEX_source1 = s1; // @[DbtIDEX.scala 23:24]
  assign io_outToEX_source2 = s2; // @[DbtIDEX.scala 24:24]
  assign io_outToEX_rWAddr = rWAddr; // @[DbtIDEX.scala 25:23]
  assign io_outToEX_rWEn = rWEn; // @[DbtIDEX.scala 26:21]
  always @(posedge clock) begin
    if (reset) begin // @[DbtIDEX.scala 14:22]
      iSK <= 8'h0; // @[DbtIDEX.scala 14:22]
    end else begin
      iSK <= io_inFromID_iSK; // @[DbtIDEX.scala 14:22]
    end
    if (reset) begin // @[DbtIDEX.scala 15:21]
      iK <= 3'h0; // @[DbtIDEX.scala 15:21]
    end else begin
      iK <= io_inFromID_iK; // @[DbtIDEX.scala 15:21]
    end
    if (reset) begin // @[DbtIDEX.scala 16:21]
      s1 <= 32'h0; // @[DbtIDEX.scala 16:21]
    end else begin
      s1 <= io_inFromID_source1; // @[DbtIDEX.scala 16:21]
    end
    if (reset) begin // @[DbtIDEX.scala 17:21]
      s2 <= 32'h0; // @[DbtIDEX.scala 17:21]
    end else begin
      s2 <= io_inFromID_source2; // @[DbtIDEX.scala 17:21]
    end
    if (reset) begin // @[DbtIDEX.scala 18:25]
      rWAddr <= 5'h0; // @[DbtIDEX.scala 18:25]
    end else begin
      rWAddr <= io_inFromID_rWAddr; // @[DbtIDEX.scala 18:25]
    end
    if (reset) begin // @[DbtIDEX.scala 19:23]
      rWEn <= 1'h0; // @[DbtIDEX.scala 19:23]
    end else begin
      rWEn <= io_inFromID_rWEn; // @[DbtIDEX.scala 19:23]
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
  iSK = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  iK = _RAND_1[2:0];
  _RAND_2 = {1{`RANDOM}};
  s1 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  s2 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  rWAddr = _RAND_4[4:0];
  _RAND_5 = {1{`RANDOM}};
  rWEn = _RAND_5[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module RegFile(
  input         clock,
  input         io_inFromID_r1REn,
  input  [4:0]  io_inFromID_r1RAddr,
  input  [4:0]  io_inFromID_r2RAddr,
  output [31:0] io_outToID_r1RData
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [31:0] regBank [0:31]; // @[RegFile.scala 16:22]
  wire  regBank_io_outToID_r1RData_MPORT_en; // @[RegFile.scala 16:22]
  wire [4:0] regBank_io_outToID_r1RData_MPORT_addr; // @[RegFile.scala 16:22]
  wire [31:0] regBank_io_outToID_r1RData_MPORT_data; // @[RegFile.scala 16:22]
  wire  regBank_io_outToID_r2RData_MPORT_en; // @[RegFile.scala 16:22]
  wire [4:0] regBank_io_outToID_r2RData_MPORT_addr; // @[RegFile.scala 16:22]
  wire [31:0] regBank_io_outToID_r2RData_MPORT_data; // @[RegFile.scala 16:22]
  wire [31:0] regBank_MPORT_data; // @[RegFile.scala 16:22]
  wire [4:0] regBank_MPORT_addr; // @[RegFile.scala 16:22]
  wire  regBank_MPORT_mask; // @[RegFile.scala 16:22]
  wire  regBank_MPORT_en; // @[RegFile.scala 16:22]
  wire  _T_3 = io_inFromID_r1RAddr == 5'h0; // @[RegFile.scala 24:30]
  wire [31:0] _GEN_8 = io_inFromID_r1REn ? regBank_io_outToID_r1RData_MPORT_data : 32'h0; // @[RegFile.scala 30:48 31:28 33:28]
  assign regBank_io_outToID_r1RData_MPORT_en = _T_3 ? 1'h0 : io_inFromID_r1REn;
  assign regBank_io_outToID_r1RData_MPORT_addr = io_inFromID_r1RAddr;
  assign regBank_io_outToID_r1RData_MPORT_data = regBank[regBank_io_outToID_r1RData_MPORT_addr]; // @[RegFile.scala 16:22]
  assign regBank_io_outToID_r2RData_MPORT_en = 1'h0;
  assign regBank_io_outToID_r2RData_MPORT_addr = io_inFromID_r2RAddr;
  assign regBank_io_outToID_r2RData_MPORT_data = regBank[regBank_io_outToID_r2RData_MPORT_addr]; // @[RegFile.scala 16:22]
  assign regBank_MPORT_data = 32'h0;
  assign regBank_MPORT_addr = 5'h0;
  assign regBank_MPORT_mask = 1'h1;
  assign regBank_MPORT_en = 1'h0;
  assign io_outToID_r1RData = io_inFromID_r1RAddr == 5'h0 ? 32'h0 : _GEN_8; // @[RegFile.scala 24:39 25:28]
  always @(posedge clock) begin
    if (regBank_MPORT_en & regBank_MPORT_mask) begin
      regBank[regBank_MPORT_addr] <= regBank_MPORT_data; // @[RegFile.scala 16:22]
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
module DC(
  input  [31:0] io_inFromD_iRRdDt,
  input  [31:0] io_inFromRF_r1RData,
  output [7:0]  io_outToD_iSK,
  output [2:0]  io_outToD_iK,
  output [31:0] io_outToD_source1,
  output [31:0] io_outToD_source2,
  output [4:0]  io_outToD_rWAddr,
  output        io_outToD_rWEn,
  output        io_outToRF_r1REn,
  output        io_outToRF_r2REn,
  output [4:0]  io_outToRF_r1RAddr,
  output [4:0]  io_outToRF_r2RAddr
);
  wire [5:0] op = io_inFromD_iRRdDt[31:26]; // @[DC.scala 34:28]
  wire  _T = 6'hd == op; // @[DC.scala 40:16]
  wire [5:0] _GEN_2 = 6'hd == op ? 6'h25 : 6'h0; // @[DC.scala 40:16 29:19 45:27]
  wire [31:0] imm = 6'hd == op ? {{16'd0}, io_inFromD_iRRdDt[15:0]} : 32'h0; // @[DC.scala 40:16 47:17]
  wire [31:0] _GEN_4 = ~io_outToRF_r1REn ? imm : 32'h0; // @[DC.scala 31:23 53:46 54:27]
  wire [31:0] _GEN_6 = ~io_outToRF_r2REn ? imm : 32'h0; // @[DC.scala 32:23 59:46 60:27]
  assign io_outToD_iSK = {{2'd0}, _GEN_2};
  assign io_outToD_iK = {{2'd0}, _T};
  assign io_outToD_source1 = io_outToRF_r1REn ? io_inFromRF_r1RData : _GEN_4; // @[DC.scala 51:39 52:27]
  assign io_outToD_source2 = io_outToRF_r2REn ? 32'h0 : _GEN_6; // @[DC.scala 57:39 58:27]
  assign io_outToD_rWAddr = io_inFromD_iRRdDt[20:16]; // @[DC.scala 35:42]
  assign io_outToD_rWEn = 6'hd == op; // @[DC.scala 40:16]
  assign io_outToRF_r1REn = 6'hd == op; // @[DC.scala 40:16]
  assign io_outToRF_r2REn = 1'h0; // @[DC.scala 40:16 27:22 44:30]
  assign io_outToRF_r1RAddr = io_inFromD_iRRdDt[25:21]; // @[DC.scala 36:44]
  assign io_outToRF_r2RAddr = io_inFromD_iRRdDt[20:16]; // @[DC.scala 37:44]
endmodule
module IDTop(
  input         clock,
  input         reset,
  input  [31:0] io_inFromIF_iRRdDt,
  output [7:0]  io_outToEX_iSK,
  output [2:0]  io_outToEX_iK,
  output [31:0] io_outToEX_source1,
  output [31:0] io_outToEX_source2,
  output [4:0]  io_outToEX_rWAddr,
  output        io_outToEX_rWEn
);
  wire  d_clock; // @[IDTop.scala 15:19]
  wire  d_reset; // @[IDTop.scala 15:19]
  wire [7:0] d_io_inFromID_iSK; // @[IDTop.scala 15:19]
  wire [2:0] d_io_inFromID_iK; // @[IDTop.scala 15:19]
  wire [31:0] d_io_inFromID_source1; // @[IDTop.scala 15:19]
  wire [31:0] d_io_inFromID_source2; // @[IDTop.scala 15:19]
  wire [4:0] d_io_inFromID_rWAddr; // @[IDTop.scala 15:19]
  wire  d_io_inFromID_rWEn; // @[IDTop.scala 15:19]
  wire [7:0] d_io_outToEX_iSK; // @[IDTop.scala 15:19]
  wire [2:0] d_io_outToEX_iK; // @[IDTop.scala 15:19]
  wire [31:0] d_io_outToEX_source1; // @[IDTop.scala 15:19]
  wire [31:0] d_io_outToEX_source2; // @[IDTop.scala 15:19]
  wire [4:0] d_io_outToEX_rWAddr; // @[IDTop.scala 15:19]
  wire  d_io_outToEX_rWEn; // @[IDTop.scala 15:19]
  wire  rf_clock; // @[IDTop.scala 16:20]
  wire  rf_io_inFromID_r1REn; // @[IDTop.scala 16:20]
  wire [4:0] rf_io_inFromID_r1RAddr; // @[IDTop.scala 16:20]
  wire [4:0] rf_io_inFromID_r2RAddr; // @[IDTop.scala 16:20]
  wire [31:0] rf_io_outToID_r1RData; // @[IDTop.scala 16:20]
  wire [31:0] dc_io_inFromD_iRRdDt; // @[IDTop.scala 17:20]
  wire [31:0] dc_io_inFromRF_r1RData; // @[IDTop.scala 17:20]
  wire [7:0] dc_io_outToD_iSK; // @[IDTop.scala 17:20]
  wire [2:0] dc_io_outToD_iK; // @[IDTop.scala 17:20]
  wire [31:0] dc_io_outToD_source1; // @[IDTop.scala 17:20]
  wire [31:0] dc_io_outToD_source2; // @[IDTop.scala 17:20]
  wire [4:0] dc_io_outToD_rWAddr; // @[IDTop.scala 17:20]
  wire  dc_io_outToD_rWEn; // @[IDTop.scala 17:20]
  wire  dc_io_outToRF_r1REn; // @[IDTop.scala 17:20]
  wire  dc_io_outToRF_r2REn; // @[IDTop.scala 17:20]
  wire [4:0] dc_io_outToRF_r1RAddr; // @[IDTop.scala 17:20]
  wire [4:0] dc_io_outToRF_r2RAddr; // @[IDTop.scala 17:20]
  DbtIDEX d ( // @[IDTop.scala 15:19]
    .clock(d_clock),
    .reset(d_reset),
    .io_inFromID_iSK(d_io_inFromID_iSK),
    .io_inFromID_iK(d_io_inFromID_iK),
    .io_inFromID_source1(d_io_inFromID_source1),
    .io_inFromID_source2(d_io_inFromID_source2),
    .io_inFromID_rWAddr(d_io_inFromID_rWAddr),
    .io_inFromID_rWEn(d_io_inFromID_rWEn),
    .io_outToEX_iSK(d_io_outToEX_iSK),
    .io_outToEX_iK(d_io_outToEX_iK),
    .io_outToEX_source1(d_io_outToEX_source1),
    .io_outToEX_source2(d_io_outToEX_source2),
    .io_outToEX_rWAddr(d_io_outToEX_rWAddr),
    .io_outToEX_rWEn(d_io_outToEX_rWEn)
  );
  RegFile rf ( // @[IDTop.scala 16:20]
    .clock(rf_clock),
    .io_inFromID_r1REn(rf_io_inFromID_r1REn),
    .io_inFromID_r1RAddr(rf_io_inFromID_r1RAddr),
    .io_inFromID_r2RAddr(rf_io_inFromID_r2RAddr),
    .io_outToID_r1RData(rf_io_outToID_r1RData)
  );
  DC dc ( // @[IDTop.scala 17:20]
    .io_inFromD_iRRdDt(dc_io_inFromD_iRRdDt),
    .io_inFromRF_r1RData(dc_io_inFromRF_r1RData),
    .io_outToD_iSK(dc_io_outToD_iSK),
    .io_outToD_iK(dc_io_outToD_iK),
    .io_outToD_source1(dc_io_outToD_source1),
    .io_outToD_source2(dc_io_outToD_source2),
    .io_outToD_rWAddr(dc_io_outToD_rWAddr),
    .io_outToD_rWEn(dc_io_outToD_rWEn),
    .io_outToRF_r1REn(dc_io_outToRF_r1REn),
    .io_outToRF_r2REn(dc_io_outToRF_r2REn),
    .io_outToRF_r1RAddr(dc_io_outToRF_r1RAddr),
    .io_outToRF_r2RAddr(dc_io_outToRF_r2RAddr)
  );
  assign io_outToEX_iSK = d_io_outToEX_iSK; // @[IDTop.scala 23:16]
  assign io_outToEX_iK = d_io_outToEX_iK; // @[IDTop.scala 23:16]
  assign io_outToEX_source1 = d_io_outToEX_source1; // @[IDTop.scala 23:16]
  assign io_outToEX_source2 = d_io_outToEX_source2; // @[IDTop.scala 23:16]
  assign io_outToEX_rWAddr = d_io_outToEX_rWAddr; // @[IDTop.scala 23:16]
  assign io_outToEX_rWEn = d_io_outToEX_rWEn; // @[IDTop.scala 23:16]
  assign d_clock = clock;
  assign d_reset = reset;
  assign d_io_inFromID_iSK = dc_io_outToD_iSK; // @[IDTop.scala 22:19]
  assign d_io_inFromID_iK = dc_io_outToD_iK; // @[IDTop.scala 22:19]
  assign d_io_inFromID_source1 = dc_io_outToD_source1; // @[IDTop.scala 22:19]
  assign d_io_inFromID_source2 = dc_io_outToD_source2; // @[IDTop.scala 22:19]
  assign d_io_inFromID_rWAddr = dc_io_outToD_rWAddr; // @[IDTop.scala 22:19]
  assign d_io_inFromID_rWEn = dc_io_outToD_rWEn; // @[IDTop.scala 22:19]
  assign rf_clock = clock;
  assign rf_io_inFromID_r1REn = dc_io_outToRF_r1REn; // @[IDTop.scala 21:20]
  assign rf_io_inFromID_r1RAddr = dc_io_outToRF_r1RAddr; // @[IDTop.scala 21:20]
  assign rf_io_inFromID_r2RAddr = dc_io_outToRF_r2RAddr; // @[IDTop.scala 21:20]
  assign dc_io_inFromD_iRRdDt = io_inFromIF_iRRdDt; // @[IDTop.scala 19:19]
  assign dc_io_inFromRF_r1RData = rf_io_outToID_r1RData; // @[IDTop.scala 20:20]
endmodule
module EX(
  input  [7:0]  io_inFromD_iSK,
  input  [2:0]  io_inFromD_iK,
  input  [31:0] io_inFromD_source1,
  input  [31:0] io_inFromD_source2,
  input  [4:0]  io_inFromD_rWAddr,
  input         io_inFromD_rWEn,
  output [4:0]  io_outToD_rWAddrO,
  output        io_outToD_rWEnO,
  output [31:0] io_outToD_rWDataO
);
  wire [31:0] _logicResult_T = io_inFromD_source1 | io_inFromD_source2; // @[EX.scala 30:47]
  wire [31:0] logicResult = 8'h25 == io_inFromD_iSK ? _logicResult_T : 32'h0; // @[EX.scala 28:28 30:25]
  assign io_outToD_rWAddrO = io_inFromD_rWAddr; // @[EX.scala 21:23]
  assign io_outToD_rWEnO = io_inFromD_rWEn; // @[EX.scala 22:21]
  assign io_outToD_rWDataO = 3'h1 == io_inFromD_iK ? logicResult : 32'h0; // @[EX.scala 24:23 35:27 37:31]
endmodule
module DbtEXMEM(
  input         clock,
  input  [4:0]  io_inFromEX_rWAddrO,
  input         io_inFromEX_rWEnO,
  input  [31:0] io_inFromEX_rWDataO,
  output [4:0]  io_outToMEM_rWAddrO,
  output        io_outToMEM_rWEnO,
  output [31:0] io_outToMEM_rWDataO
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [4:0] rWAddr; // @[DbtEXMEM.scala 19:25]
  reg  rWEn; // @[DbtEXMEM.scala 20:23]
  reg [31:0] rWData; // @[DbtEXMEM.scala 21:25]
  assign io_outToMEM_rWAddrO = rWAddr; // @[DbtEXMEM.scala 23:25]
  assign io_outToMEM_rWEnO = rWEn; // @[DbtEXMEM.scala 24:23]
  assign io_outToMEM_rWDataO = rWData; // @[DbtEXMEM.scala 25:25]
  always @(posedge clock) begin
    rWAddr <= io_inFromEX_rWAddrO; // @[DbtEXMEM.scala 19:25]
    rWEn <= io_inFromEX_rWEnO; // @[DbtEXMEM.scala 20:23]
    rWData <= io_inFromEX_rWDataO; // @[DbtEXMEM.scala 21:25]
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
  rWAddr = _RAND_0[4:0];
  _RAND_1 = {1{`RANDOM}};
  rWEn = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  rWData = _RAND_2[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module EXTop(
  input         clock,
  input  [7:0]  io_inFromID_iSK,
  input  [2:0]  io_inFromID_iK,
  input  [31:0] io_inFromID_source1,
  input  [31:0] io_inFromID_source2,
  input  [4:0]  io_inFromID_rWAddr,
  input         io_inFromID_rWEn,
  output [4:0]  io_outToMEM_rWAddrO,
  output        io_outToMEM_rWEnO,
  output [31:0] io_outToMEM_rWDataO
);
  wire [7:0] ex_io_inFromD_iSK; // @[EXTop.scala 13:20]
  wire [2:0] ex_io_inFromD_iK; // @[EXTop.scala 13:20]
  wire [31:0] ex_io_inFromD_source1; // @[EXTop.scala 13:20]
  wire [31:0] ex_io_inFromD_source2; // @[EXTop.scala 13:20]
  wire [4:0] ex_io_inFromD_rWAddr; // @[EXTop.scala 13:20]
  wire  ex_io_inFromD_rWEn; // @[EXTop.scala 13:20]
  wire [4:0] ex_io_outToD_rWAddrO; // @[EXTop.scala 13:20]
  wire  ex_io_outToD_rWEnO; // @[EXTop.scala 13:20]
  wire [31:0] ex_io_outToD_rWDataO; // @[EXTop.scala 13:20]
  wire  d_clock; // @[EXTop.scala 14:19]
  wire [4:0] d_io_inFromEX_rWAddrO; // @[EXTop.scala 14:19]
  wire  d_io_inFromEX_rWEnO; // @[EXTop.scala 14:19]
  wire [31:0] d_io_inFromEX_rWDataO; // @[EXTop.scala 14:19]
  wire [4:0] d_io_outToMEM_rWAddrO; // @[EXTop.scala 14:19]
  wire  d_io_outToMEM_rWEnO; // @[EXTop.scala 14:19]
  wire [31:0] d_io_outToMEM_rWDataO; // @[EXTop.scala 14:19]
  EX ex ( // @[EXTop.scala 13:20]
    .io_inFromD_iSK(ex_io_inFromD_iSK),
    .io_inFromD_iK(ex_io_inFromD_iK),
    .io_inFromD_source1(ex_io_inFromD_source1),
    .io_inFromD_source2(ex_io_inFromD_source2),
    .io_inFromD_rWAddr(ex_io_inFromD_rWAddr),
    .io_inFromD_rWEn(ex_io_inFromD_rWEn),
    .io_outToD_rWAddrO(ex_io_outToD_rWAddrO),
    .io_outToD_rWEnO(ex_io_outToD_rWEnO),
    .io_outToD_rWDataO(ex_io_outToD_rWDataO)
  );
  DbtEXMEM d ( // @[EXTop.scala 14:19]
    .clock(d_clock),
    .io_inFromEX_rWAddrO(d_io_inFromEX_rWAddrO),
    .io_inFromEX_rWEnO(d_io_inFromEX_rWEnO),
    .io_inFromEX_rWDataO(d_io_inFromEX_rWDataO),
    .io_outToMEM_rWAddrO(d_io_outToMEM_rWAddrO),
    .io_outToMEM_rWEnO(d_io_outToMEM_rWEnO),
    .io_outToMEM_rWDataO(d_io_outToMEM_rWDataO)
  );
  assign io_outToMEM_rWAddrO = d_io_outToMEM_rWAddrO; // @[EXTop.scala 18:19]
  assign io_outToMEM_rWEnO = d_io_outToMEM_rWEnO; // @[EXTop.scala 18:19]
  assign io_outToMEM_rWDataO = d_io_outToMEM_rWDataO; // @[EXTop.scala 18:19]
  assign ex_io_inFromD_iSK = io_inFromID_iSK; // @[EXTop.scala 16:19]
  assign ex_io_inFromD_iK = io_inFromID_iK; // @[EXTop.scala 16:19]
  assign ex_io_inFromD_source1 = io_inFromID_source1; // @[EXTop.scala 16:19]
  assign ex_io_inFromD_source2 = io_inFromID_source2; // @[EXTop.scala 16:19]
  assign ex_io_inFromD_rWAddr = io_inFromID_rWAddr; // @[EXTop.scala 16:19]
  assign ex_io_inFromD_rWEn = io_inFromID_rWEn; // @[EXTop.scala 16:19]
  assign d_clock = clock;
  assign d_io_inFromEX_rWAddrO = ex_io_outToD_rWAddrO; // @[EXTop.scala 17:18]
  assign d_io_inFromEX_rWEnO = ex_io_outToD_rWEnO; // @[EXTop.scala 17:18]
  assign d_io_inFromEX_rWDataO = ex_io_outToD_rWDataO; // @[EXTop.scala 17:18]
endmodule
module Top(
  input         clock,
  input         reset,
  output [4:0]  io_out_rWAddrO,
  output        io_out_rWEnO,
  output [31:0] io_out_rWDataO
);
  wire  ifTop_clock; // @[Top.scala 20:23]
  wire  ifTop_reset; // @[Top.scala 20:23]
  wire [31:0] ifTop_io_outToID_iRRdDt; // @[Top.scala 20:23]
  wire  idTop_clock; // @[Top.scala 21:23]
  wire  idTop_reset; // @[Top.scala 21:23]
  wire [31:0] idTop_io_inFromIF_iRRdDt; // @[Top.scala 21:23]
  wire [7:0] idTop_io_outToEX_iSK; // @[Top.scala 21:23]
  wire [2:0] idTop_io_outToEX_iK; // @[Top.scala 21:23]
  wire [31:0] idTop_io_outToEX_source1; // @[Top.scala 21:23]
  wire [31:0] idTop_io_outToEX_source2; // @[Top.scala 21:23]
  wire [4:0] idTop_io_outToEX_rWAddr; // @[Top.scala 21:23]
  wire  idTop_io_outToEX_rWEn; // @[Top.scala 21:23]
  wire  exTop_clock; // @[Top.scala 22:23]
  wire [7:0] exTop_io_inFromID_iSK; // @[Top.scala 22:23]
  wire [2:0] exTop_io_inFromID_iK; // @[Top.scala 22:23]
  wire [31:0] exTop_io_inFromID_source1; // @[Top.scala 22:23]
  wire [31:0] exTop_io_inFromID_source2; // @[Top.scala 22:23]
  wire [4:0] exTop_io_inFromID_rWAddr; // @[Top.scala 22:23]
  wire  exTop_io_inFromID_rWEn; // @[Top.scala 22:23]
  wire [4:0] exTop_io_outToMEM_rWAddrO; // @[Top.scala 22:23]
  wire  exTop_io_outToMEM_rWEnO; // @[Top.scala 22:23]
  wire [31:0] exTop_io_outToMEM_rWDataO; // @[Top.scala 22:23]
  IFTop ifTop ( // @[Top.scala 20:23]
    .clock(ifTop_clock),
    .reset(ifTop_reset),
    .io_outToID_iRRdDt(ifTop_io_outToID_iRRdDt)
  );
  IDTop idTop ( // @[Top.scala 21:23]
    .clock(idTop_clock),
    .reset(idTop_reset),
    .io_inFromIF_iRRdDt(idTop_io_inFromIF_iRRdDt),
    .io_outToEX_iSK(idTop_io_outToEX_iSK),
    .io_outToEX_iK(idTop_io_outToEX_iK),
    .io_outToEX_source1(idTop_io_outToEX_source1),
    .io_outToEX_source2(idTop_io_outToEX_source2),
    .io_outToEX_rWAddr(idTop_io_outToEX_rWAddr),
    .io_outToEX_rWEn(idTop_io_outToEX_rWEn)
  );
  EXTop exTop ( // @[Top.scala 22:23]
    .clock(exTop_clock),
    .io_inFromID_iSK(exTop_io_inFromID_iSK),
    .io_inFromID_iK(exTop_io_inFromID_iK),
    .io_inFromID_source1(exTop_io_inFromID_source1),
    .io_inFromID_source2(exTop_io_inFromID_source2),
    .io_inFromID_rWAddr(exTop_io_inFromID_rWAddr),
    .io_inFromID_rWEn(exTop_io_inFromID_rWEn),
    .io_outToMEM_rWAddrO(exTop_io_outToMEM_rWAddrO),
    .io_outToMEM_rWEnO(exTop_io_outToMEM_rWEnO),
    .io_outToMEM_rWDataO(exTop_io_outToMEM_rWDataO)
  );
  assign io_out_rWAddrO = exTop_io_outToMEM_rWAddrO; // @[Top.scala 26:12]
  assign io_out_rWEnO = exTop_io_outToMEM_rWEnO; // @[Top.scala 26:12]
  assign io_out_rWDataO = exTop_io_outToMEM_rWDataO; // @[Top.scala 26:12]
  assign ifTop_clock = clock;
  assign ifTop_reset = reset;
  assign idTop_clock = clock;
  assign idTop_reset = reset;
  assign idTop_io_inFromIF_iRRdDt = ifTop_io_outToID_iRRdDt; // @[Top.scala 24:23]
  assign exTop_clock = clock;
  assign exTop_io_inFromID_iSK = idTop_io_outToEX_iSK; // @[Top.scala 25:22]
  assign exTop_io_inFromID_iK = idTop_io_outToEX_iK; // @[Top.scala 25:22]
  assign exTop_io_inFromID_source1 = idTop_io_outToEX_source1; // @[Top.scala 25:22]
  assign exTop_io_inFromID_source2 = idTop_io_outToEX_source2; // @[Top.scala 25:22]
  assign exTop_io_inFromID_rWAddr = idTop_io_outToEX_rWAddr; // @[Top.scala 25:22]
  assign exTop_io_inFromID_rWEn = idTop_io_outToEX_rWEn; // @[Top.scala 25:22]
endmodule
