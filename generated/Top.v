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
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] memBank [0:255]; // @[InstROM.scala 31:30]
  wire  memBank_rdwrPort_r_en; // @[InstROM.scala 31:30]
  wire [7:0] memBank_rdwrPort_r_addr; // @[InstROM.scala 31:30]
  wire [31:0] memBank_rdwrPort_r_data; // @[InstROM.scala 31:30]
  wire [31:0] memBank_rdwrPort_w_data; // @[InstROM.scala 31:30]
  wire [7:0] memBank_rdwrPort_w_addr; // @[InstROM.scala 31:30]
  wire  memBank_rdwrPort_w_mask; // @[InstROM.scala 31:30]
  wire  memBank_rdwrPort_w_en; // @[InstROM.scala 31:30]
  reg  memBank_rdwrPort_r_en_pipe_0;
  reg [7:0] memBank_rdwrPort_r_addr_pipe_0;
  reg  enable; // @[InstROM.scala 19:25]
  wire [5:0] iAdRS2 = io_inFromPC_iRRdAd[7:2]; // @[InstROM.scala 40:34]
  wire [31:0] _GEN_2 = memBank_rdwrPort_r_data; // @[InstROM.scala 37:22 44:34 47:30]
  assign memBank_rdwrPort_r_en = memBank_rdwrPort_r_en_pipe_0;
  assign memBank_rdwrPort_r_addr = memBank_rdwrPort_r_addr_pipe_0;
  assign memBank_rdwrPort_r_data = memBank[memBank_rdwrPort_r_addr]; // @[InstROM.scala 31:30]
  assign memBank_rdwrPort_w_data = 32'h0;
  assign memBank_rdwrPort_w_addr = {{2'd0}, iAdRS2};
  assign memBank_rdwrPort_w_mask = 1'h0;
  assign memBank_rdwrPort_w_en = enable & 1'h0;
  assign io_outToD_iRRdDt = enable ? _GEN_2 : 32'h0; // @[InstROM.scala 42:18 37:22]
  always @(posedge clock) begin
    if (memBank_rdwrPort_w_en & memBank_rdwrPort_w_mask) begin
      memBank[memBank_rdwrPort_w_addr] <= memBank_rdwrPort_w_data; // @[InstROM.scala 31:30]
    end
    memBank_rdwrPort_r_en_pipe_0 <= enable & ~1'h0;
    if (enable & ~1'h0) begin
      memBank_rdwrPort_r_addr_pipe_0 <= {{2'd0}, iAdRS2};
    end
    if (reset) begin // @[InstROM.scala 19:25]
      enable <= 1'h0; // @[InstROM.scala 19:25]
    end else begin
      enable <= io_inFromPC_iREn; // @[InstROM.scala 38:12]
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
  memBank_rdwrPort_r_en_pipe_0 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  memBank_rdwrPort_r_addr_pipe_0 = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  enable = _RAND_2[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
initial begin
  $readmemh("mem.txt", memBank);
end
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
  wire  pc_clock; // @[IFTop.scala 17:20]
  wire  pc_reset; // @[IFTop.scala 17:20]
  wire  pc_io_outToIR_iREn; // @[IFTop.scala 17:20]
  wire [7:0] pc_io_outToIR_iRRdAd; // @[IFTop.scala 17:20]
  wire  ir_clock; // @[IFTop.scala 18:20]
  wire  ir_reset; // @[IFTop.scala 18:20]
  wire  ir_io_inFromPC_iREn; // @[IFTop.scala 18:20]
  wire [7:0] ir_io_inFromPC_iRRdAd; // @[IFTop.scala 18:20]
  wire [31:0] ir_io_outToD_iRRdDt; // @[IFTop.scala 18:20]
  wire [31:0] d_io_inFromIF_iRRdDt; // @[IFTop.scala 19:19]
  wire [31:0] d_io_outToID_iRRdDt; // @[IFTop.scala 19:19]
  PC pc ( // @[IFTop.scala 17:20]
    .clock(pc_clock),
    .reset(pc_reset),
    .io_outToIR_iREn(pc_io_outToIR_iREn),
    .io_outToIR_iRRdAd(pc_io_outToIR_iRRdAd)
  );
  InstROM ir ( // @[IFTop.scala 18:20]
    .clock(ir_clock),
    .reset(ir_reset),
    .io_inFromPC_iREn(ir_io_inFromPC_iREn),
    .io_inFromPC_iRRdAd(ir_io_inFromPC_iRRdAd),
    .io_outToD_iRRdDt(ir_io_outToD_iRRdDt)
  );
  DBtIFID d ( // @[IFTop.scala 19:19]
    .io_inFromIF_iRRdDt(d_io_inFromIF_iRRdDt),
    .io_outToID_iRRdDt(d_io_outToID_iRRdDt)
  );
  assign io_outToID_iRRdDt = d_io_outToID_iRRdDt; // @[IFTop.scala 23:16]
  assign pc_clock = clock;
  assign pc_reset = reset;
  assign ir_clock = clock;
  assign ir_reset = reset;
  assign ir_io_inFromPC_iREn = pc_io_outToIR_iREn; // @[IFTop.scala 21:20]
  assign ir_io_inFromPC_iRRdAd = pc_io_outToIR_iRRdAd; // @[IFTop.scala 21:20]
  assign d_io_inFromIF_iRRdDt = ir_io_outToD_iRRdDt; // @[IFTop.scala 22:19]
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
  input  [4:0]  io_inFromWB_rWAddrO,
  input         io_inFromWB_rWEnO,
  input  [31:0] io_inFromWB_rWDataO,
  output [31:0] io_outToID_r1RData,
  output [31:0] io_outToIDTop_r1Out,
  output [31:0] io_outToIDTop_r2Out,
  output [31:0] io_outToIDTop_r3Out,
  output [31:0] io_outToIDTop_r4Out,
  output [31:0] io_outToIDTop_r5Out,
  output [31:0] io_outToIDTop_r6Out,
  output [31:0] io_outToIDTop_r7Out,
  output [31:0] io_outToIDTop_r8Out,
  output [31:0] io_outToIDTop_r9Out,
  output [31:0] io_outToIDTop_r10Out,
  output [31:0] io_outToIDTop_r11Out,
  output [31:0] io_outToIDTop_r12Out,
  output [31:0] io_outToIDTop_r13Out,
  output [31:0] io_outToIDTop_r14Out,
  output [31:0] io_outToIDTop_r15Out,
  output [31:0] io_outToIDTop_r16Out,
  output [31:0] io_outToIDTop_r17Out,
  output [31:0] io_outToIDTop_r18Out,
  output [31:0] io_outToIDTop_r19Out,
  output [31:0] io_outToIDTop_r20Out,
  output [31:0] io_outToIDTop_r21Out,
  output [31:0] io_outToIDTop_r22Out,
  output [31:0] io_outToIDTop_r23Out,
  output [31:0] io_outToIDTop_r24Out,
  output [31:0] io_outToIDTop_r25Out,
  output [31:0] io_outToIDTop_r26Out,
  output [31:0] io_outToIDTop_r27Out,
  output [31:0] io_outToIDTop_r28Out,
  output [31:0] io_outToIDTop_r29Out,
  output [31:0] io_outToIDTop_r30Out,
  output [31:0] io_outToIDTop_r31Out
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [31:0] regBank [0:31]; // @[RegFile.scala 17:22]
  wire  regBank_io_outToID_r1RData_MPORT_en; // @[RegFile.scala 17:22]
  wire [4:0] regBank_io_outToID_r1RData_MPORT_addr; // @[RegFile.scala 17:22]
  wire [31:0] regBank_io_outToID_r1RData_MPORT_data; // @[RegFile.scala 17:22]
  wire  regBank_io_outToID_r2RData_MPORT_en; // @[RegFile.scala 17:22]
  wire [4:0] regBank_io_outToID_r2RData_MPORT_addr; // @[RegFile.scala 17:22]
  wire [31:0] regBank_io_outToID_r2RData_MPORT_data; // @[RegFile.scala 17:22]
  wire  regBank_io_outToIDTop_r1Out_MPORT_en; // @[RegFile.scala 17:22]
  wire [4:0] regBank_io_outToIDTop_r1Out_MPORT_addr; // @[RegFile.scala 17:22]
  wire [31:0] regBank_io_outToIDTop_r1Out_MPORT_data; // @[RegFile.scala 17:22]
  wire  regBank_io_outToIDTop_r2Out_MPORT_en; // @[RegFile.scala 17:22]
  wire [4:0] regBank_io_outToIDTop_r2Out_MPORT_addr; // @[RegFile.scala 17:22]
  wire [31:0] regBank_io_outToIDTop_r2Out_MPORT_data; // @[RegFile.scala 17:22]
  wire  regBank_io_outToIDTop_r3Out_MPORT_en; // @[RegFile.scala 17:22]
  wire [4:0] regBank_io_outToIDTop_r3Out_MPORT_addr; // @[RegFile.scala 17:22]
  wire [31:0] regBank_io_outToIDTop_r3Out_MPORT_data; // @[RegFile.scala 17:22]
  wire  regBank_io_outToIDTop_r4Out_MPORT_en; // @[RegFile.scala 17:22]
  wire [4:0] regBank_io_outToIDTop_r4Out_MPORT_addr; // @[RegFile.scala 17:22]
  wire [31:0] regBank_io_outToIDTop_r4Out_MPORT_data; // @[RegFile.scala 17:22]
  wire  regBank_io_outToIDTop_r5Out_MPORT_en; // @[RegFile.scala 17:22]
  wire [4:0] regBank_io_outToIDTop_r5Out_MPORT_addr; // @[RegFile.scala 17:22]
  wire [31:0] regBank_io_outToIDTop_r5Out_MPORT_data; // @[RegFile.scala 17:22]
  wire  regBank_io_outToIDTop_r6Out_MPORT_en; // @[RegFile.scala 17:22]
  wire [4:0] regBank_io_outToIDTop_r6Out_MPORT_addr; // @[RegFile.scala 17:22]
  wire [31:0] regBank_io_outToIDTop_r6Out_MPORT_data; // @[RegFile.scala 17:22]
  wire  regBank_io_outToIDTop_r7Out_MPORT_en; // @[RegFile.scala 17:22]
  wire [4:0] regBank_io_outToIDTop_r7Out_MPORT_addr; // @[RegFile.scala 17:22]
  wire [31:0] regBank_io_outToIDTop_r7Out_MPORT_data; // @[RegFile.scala 17:22]
  wire  regBank_io_outToIDTop_r8Out_MPORT_en; // @[RegFile.scala 17:22]
  wire [4:0] regBank_io_outToIDTop_r8Out_MPORT_addr; // @[RegFile.scala 17:22]
  wire [31:0] regBank_io_outToIDTop_r8Out_MPORT_data; // @[RegFile.scala 17:22]
  wire  regBank_io_outToIDTop_r9Out_MPORT_en; // @[RegFile.scala 17:22]
  wire [4:0] regBank_io_outToIDTop_r9Out_MPORT_addr; // @[RegFile.scala 17:22]
  wire [31:0] regBank_io_outToIDTop_r9Out_MPORT_data; // @[RegFile.scala 17:22]
  wire  regBank_io_outToIDTop_r10Out_MPORT_en; // @[RegFile.scala 17:22]
  wire [4:0] regBank_io_outToIDTop_r10Out_MPORT_addr; // @[RegFile.scala 17:22]
  wire [31:0] regBank_io_outToIDTop_r10Out_MPORT_data; // @[RegFile.scala 17:22]
  wire  regBank_io_outToIDTop_r11Out_MPORT_en; // @[RegFile.scala 17:22]
  wire [4:0] regBank_io_outToIDTop_r11Out_MPORT_addr; // @[RegFile.scala 17:22]
  wire [31:0] regBank_io_outToIDTop_r11Out_MPORT_data; // @[RegFile.scala 17:22]
  wire  regBank_io_outToIDTop_r12Out_MPORT_en; // @[RegFile.scala 17:22]
  wire [4:0] regBank_io_outToIDTop_r12Out_MPORT_addr; // @[RegFile.scala 17:22]
  wire [31:0] regBank_io_outToIDTop_r12Out_MPORT_data; // @[RegFile.scala 17:22]
  wire  regBank_io_outToIDTop_r13Out_MPORT_en; // @[RegFile.scala 17:22]
  wire [4:0] regBank_io_outToIDTop_r13Out_MPORT_addr; // @[RegFile.scala 17:22]
  wire [31:0] regBank_io_outToIDTop_r13Out_MPORT_data; // @[RegFile.scala 17:22]
  wire  regBank_io_outToIDTop_r14Out_MPORT_en; // @[RegFile.scala 17:22]
  wire [4:0] regBank_io_outToIDTop_r14Out_MPORT_addr; // @[RegFile.scala 17:22]
  wire [31:0] regBank_io_outToIDTop_r14Out_MPORT_data; // @[RegFile.scala 17:22]
  wire  regBank_io_outToIDTop_r15Out_MPORT_en; // @[RegFile.scala 17:22]
  wire [4:0] regBank_io_outToIDTop_r15Out_MPORT_addr; // @[RegFile.scala 17:22]
  wire [31:0] regBank_io_outToIDTop_r15Out_MPORT_data; // @[RegFile.scala 17:22]
  wire  regBank_io_outToIDTop_r16Out_MPORT_en; // @[RegFile.scala 17:22]
  wire [4:0] regBank_io_outToIDTop_r16Out_MPORT_addr; // @[RegFile.scala 17:22]
  wire [31:0] regBank_io_outToIDTop_r16Out_MPORT_data; // @[RegFile.scala 17:22]
  wire  regBank_io_outToIDTop_r17Out_MPORT_en; // @[RegFile.scala 17:22]
  wire [4:0] regBank_io_outToIDTop_r17Out_MPORT_addr; // @[RegFile.scala 17:22]
  wire [31:0] regBank_io_outToIDTop_r17Out_MPORT_data; // @[RegFile.scala 17:22]
  wire  regBank_io_outToIDTop_r18Out_MPORT_en; // @[RegFile.scala 17:22]
  wire [4:0] regBank_io_outToIDTop_r18Out_MPORT_addr; // @[RegFile.scala 17:22]
  wire [31:0] regBank_io_outToIDTop_r18Out_MPORT_data; // @[RegFile.scala 17:22]
  wire  regBank_io_outToIDTop_r19Out_MPORT_en; // @[RegFile.scala 17:22]
  wire [4:0] regBank_io_outToIDTop_r19Out_MPORT_addr; // @[RegFile.scala 17:22]
  wire [31:0] regBank_io_outToIDTop_r19Out_MPORT_data; // @[RegFile.scala 17:22]
  wire  regBank_io_outToIDTop_r20Out_MPORT_en; // @[RegFile.scala 17:22]
  wire [4:0] regBank_io_outToIDTop_r20Out_MPORT_addr; // @[RegFile.scala 17:22]
  wire [31:0] regBank_io_outToIDTop_r20Out_MPORT_data; // @[RegFile.scala 17:22]
  wire  regBank_io_outToIDTop_r21Out_MPORT_en; // @[RegFile.scala 17:22]
  wire [4:0] regBank_io_outToIDTop_r21Out_MPORT_addr; // @[RegFile.scala 17:22]
  wire [31:0] regBank_io_outToIDTop_r21Out_MPORT_data; // @[RegFile.scala 17:22]
  wire  regBank_io_outToIDTop_r22Out_MPORT_en; // @[RegFile.scala 17:22]
  wire [4:0] regBank_io_outToIDTop_r22Out_MPORT_addr; // @[RegFile.scala 17:22]
  wire [31:0] regBank_io_outToIDTop_r22Out_MPORT_data; // @[RegFile.scala 17:22]
  wire  regBank_io_outToIDTop_r23Out_MPORT_en; // @[RegFile.scala 17:22]
  wire [4:0] regBank_io_outToIDTop_r23Out_MPORT_addr; // @[RegFile.scala 17:22]
  wire [31:0] regBank_io_outToIDTop_r23Out_MPORT_data; // @[RegFile.scala 17:22]
  wire  regBank_io_outToIDTop_r24Out_MPORT_en; // @[RegFile.scala 17:22]
  wire [4:0] regBank_io_outToIDTop_r24Out_MPORT_addr; // @[RegFile.scala 17:22]
  wire [31:0] regBank_io_outToIDTop_r24Out_MPORT_data; // @[RegFile.scala 17:22]
  wire  regBank_io_outToIDTop_r25Out_MPORT_en; // @[RegFile.scala 17:22]
  wire [4:0] regBank_io_outToIDTop_r25Out_MPORT_addr; // @[RegFile.scala 17:22]
  wire [31:0] regBank_io_outToIDTop_r25Out_MPORT_data; // @[RegFile.scala 17:22]
  wire  regBank_io_outToIDTop_r26Out_MPORT_en; // @[RegFile.scala 17:22]
  wire [4:0] regBank_io_outToIDTop_r26Out_MPORT_addr; // @[RegFile.scala 17:22]
  wire [31:0] regBank_io_outToIDTop_r26Out_MPORT_data; // @[RegFile.scala 17:22]
  wire  regBank_io_outToIDTop_r27Out_MPORT_en; // @[RegFile.scala 17:22]
  wire [4:0] regBank_io_outToIDTop_r27Out_MPORT_addr; // @[RegFile.scala 17:22]
  wire [31:0] regBank_io_outToIDTop_r27Out_MPORT_data; // @[RegFile.scala 17:22]
  wire  regBank_io_outToIDTop_r28Out_MPORT_en; // @[RegFile.scala 17:22]
  wire [4:0] regBank_io_outToIDTop_r28Out_MPORT_addr; // @[RegFile.scala 17:22]
  wire [31:0] regBank_io_outToIDTop_r28Out_MPORT_data; // @[RegFile.scala 17:22]
  wire  regBank_io_outToIDTop_r29Out_MPORT_en; // @[RegFile.scala 17:22]
  wire [4:0] regBank_io_outToIDTop_r29Out_MPORT_addr; // @[RegFile.scala 17:22]
  wire [31:0] regBank_io_outToIDTop_r29Out_MPORT_data; // @[RegFile.scala 17:22]
  wire  regBank_io_outToIDTop_r30Out_MPORT_en; // @[RegFile.scala 17:22]
  wire [4:0] regBank_io_outToIDTop_r30Out_MPORT_addr; // @[RegFile.scala 17:22]
  wire [31:0] regBank_io_outToIDTop_r30Out_MPORT_data; // @[RegFile.scala 17:22]
  wire  regBank_io_outToIDTop_r31Out_MPORT_en; // @[RegFile.scala 17:22]
  wire [4:0] regBank_io_outToIDTop_r31Out_MPORT_addr; // @[RegFile.scala 17:22]
  wire [31:0] regBank_io_outToIDTop_r31Out_MPORT_data; // @[RegFile.scala 17:22]
  wire [31:0] regBank_MPORT_data; // @[RegFile.scala 17:22]
  wire [4:0] regBank_MPORT_addr; // @[RegFile.scala 17:22]
  wire  regBank_MPORT_mask; // @[RegFile.scala 17:22]
  wire  regBank_MPORT_en; // @[RegFile.scala 17:22]
  wire  _T = io_inFromWB_rWAddrO != 5'h0; // @[RegFile.scala 20:52]
  wire  _T_2 = io_inFromID_r1RAddr == 5'h0; // @[RegFile.scala 25:30]
  wire  _T_3 = io_inFromID_r1RAddr == io_inFromWB_rWAddrO; // @[RegFile.scala 27:37]
  wire  _T_5 = _T_3 & io_inFromID_r1REn; // @[RegFile.scala 28:13]
  wire [31:0] _GEN_8 = io_inFromID_r1REn ? regBank_io_outToID_r1RData_MPORT_data : 32'h0; // @[RegFile.scala 31:48 32:28 34:28]
  wire [31:0] _GEN_9 = _T_5 & io_inFromWB_rWEnO ? io_inFromWB_rWDataO : _GEN_8; // @[RegFile.scala 29:48 30:28]
  wire  _GEN_12 = _T_5 & io_inFromWB_rWEnO ? 1'h0 : io_inFromID_r1REn; // @[RegFile.scala 17:22 29:48]
  assign regBank_io_outToID_r1RData_MPORT_en = _T_2 ? 1'h0 : _GEN_12;
  assign regBank_io_outToID_r1RData_MPORT_addr = io_inFromID_r1RAddr;
  assign regBank_io_outToID_r1RData_MPORT_data = regBank[regBank_io_outToID_r1RData_MPORT_addr]; // @[RegFile.scala 17:22]
  assign regBank_io_outToID_r2RData_MPORT_en = 1'h0;
  assign regBank_io_outToID_r2RData_MPORT_addr = io_inFromID_r2RAddr;
  assign regBank_io_outToID_r2RData_MPORT_data = regBank[regBank_io_outToID_r2RData_MPORT_addr]; // @[RegFile.scala 17:22]
  assign regBank_io_outToIDTop_r1Out_MPORT_en = 1'h1;
  assign regBank_io_outToIDTop_r1Out_MPORT_addr = 5'h1;
  assign regBank_io_outToIDTop_r1Out_MPORT_data = regBank[regBank_io_outToIDTop_r1Out_MPORT_addr]; // @[RegFile.scala 17:22]
  assign regBank_io_outToIDTop_r2Out_MPORT_en = 1'h1;
  assign regBank_io_outToIDTop_r2Out_MPORT_addr = 5'h2;
  assign regBank_io_outToIDTop_r2Out_MPORT_data = regBank[regBank_io_outToIDTop_r2Out_MPORT_addr]; // @[RegFile.scala 17:22]
  assign regBank_io_outToIDTop_r3Out_MPORT_en = 1'h1;
  assign regBank_io_outToIDTop_r3Out_MPORT_addr = 5'h3;
  assign regBank_io_outToIDTop_r3Out_MPORT_data = regBank[regBank_io_outToIDTop_r3Out_MPORT_addr]; // @[RegFile.scala 17:22]
  assign regBank_io_outToIDTop_r4Out_MPORT_en = 1'h1;
  assign regBank_io_outToIDTop_r4Out_MPORT_addr = 5'h4;
  assign regBank_io_outToIDTop_r4Out_MPORT_data = regBank[regBank_io_outToIDTop_r4Out_MPORT_addr]; // @[RegFile.scala 17:22]
  assign regBank_io_outToIDTop_r5Out_MPORT_en = 1'h1;
  assign regBank_io_outToIDTop_r5Out_MPORT_addr = 5'h5;
  assign regBank_io_outToIDTop_r5Out_MPORT_data = regBank[regBank_io_outToIDTop_r5Out_MPORT_addr]; // @[RegFile.scala 17:22]
  assign regBank_io_outToIDTop_r6Out_MPORT_en = 1'h1;
  assign regBank_io_outToIDTop_r6Out_MPORT_addr = 5'h6;
  assign regBank_io_outToIDTop_r6Out_MPORT_data = regBank[regBank_io_outToIDTop_r6Out_MPORT_addr]; // @[RegFile.scala 17:22]
  assign regBank_io_outToIDTop_r7Out_MPORT_en = 1'h1;
  assign regBank_io_outToIDTop_r7Out_MPORT_addr = 5'h7;
  assign regBank_io_outToIDTop_r7Out_MPORT_data = regBank[regBank_io_outToIDTop_r7Out_MPORT_addr]; // @[RegFile.scala 17:22]
  assign regBank_io_outToIDTop_r8Out_MPORT_en = 1'h1;
  assign regBank_io_outToIDTop_r8Out_MPORT_addr = 5'h8;
  assign regBank_io_outToIDTop_r8Out_MPORT_data = regBank[regBank_io_outToIDTop_r8Out_MPORT_addr]; // @[RegFile.scala 17:22]
  assign regBank_io_outToIDTop_r9Out_MPORT_en = 1'h1;
  assign regBank_io_outToIDTop_r9Out_MPORT_addr = 5'h9;
  assign regBank_io_outToIDTop_r9Out_MPORT_data = regBank[regBank_io_outToIDTop_r9Out_MPORT_addr]; // @[RegFile.scala 17:22]
  assign regBank_io_outToIDTop_r10Out_MPORT_en = 1'h1;
  assign regBank_io_outToIDTop_r10Out_MPORT_addr = 5'ha;
  assign regBank_io_outToIDTop_r10Out_MPORT_data = regBank[regBank_io_outToIDTop_r10Out_MPORT_addr]; // @[RegFile.scala 17:22]
  assign regBank_io_outToIDTop_r11Out_MPORT_en = 1'h1;
  assign regBank_io_outToIDTop_r11Out_MPORT_addr = 5'hb;
  assign regBank_io_outToIDTop_r11Out_MPORT_data = regBank[regBank_io_outToIDTop_r11Out_MPORT_addr]; // @[RegFile.scala 17:22]
  assign regBank_io_outToIDTop_r12Out_MPORT_en = 1'h1;
  assign regBank_io_outToIDTop_r12Out_MPORT_addr = 5'hc;
  assign regBank_io_outToIDTop_r12Out_MPORT_data = regBank[regBank_io_outToIDTop_r12Out_MPORT_addr]; // @[RegFile.scala 17:22]
  assign regBank_io_outToIDTop_r13Out_MPORT_en = 1'h1;
  assign regBank_io_outToIDTop_r13Out_MPORT_addr = 5'hd;
  assign regBank_io_outToIDTop_r13Out_MPORT_data = regBank[regBank_io_outToIDTop_r13Out_MPORT_addr]; // @[RegFile.scala 17:22]
  assign regBank_io_outToIDTop_r14Out_MPORT_en = 1'h1;
  assign regBank_io_outToIDTop_r14Out_MPORT_addr = 5'he;
  assign regBank_io_outToIDTop_r14Out_MPORT_data = regBank[regBank_io_outToIDTop_r14Out_MPORT_addr]; // @[RegFile.scala 17:22]
  assign regBank_io_outToIDTop_r15Out_MPORT_en = 1'h1;
  assign regBank_io_outToIDTop_r15Out_MPORT_addr = 5'hf;
  assign regBank_io_outToIDTop_r15Out_MPORT_data = regBank[regBank_io_outToIDTop_r15Out_MPORT_addr]; // @[RegFile.scala 17:22]
  assign regBank_io_outToIDTop_r16Out_MPORT_en = 1'h1;
  assign regBank_io_outToIDTop_r16Out_MPORT_addr = 5'h10;
  assign regBank_io_outToIDTop_r16Out_MPORT_data = regBank[regBank_io_outToIDTop_r16Out_MPORT_addr]; // @[RegFile.scala 17:22]
  assign regBank_io_outToIDTop_r17Out_MPORT_en = 1'h1;
  assign regBank_io_outToIDTop_r17Out_MPORT_addr = 5'h11;
  assign regBank_io_outToIDTop_r17Out_MPORT_data = regBank[regBank_io_outToIDTop_r17Out_MPORT_addr]; // @[RegFile.scala 17:22]
  assign regBank_io_outToIDTop_r18Out_MPORT_en = 1'h1;
  assign regBank_io_outToIDTop_r18Out_MPORT_addr = 5'h12;
  assign regBank_io_outToIDTop_r18Out_MPORT_data = regBank[regBank_io_outToIDTop_r18Out_MPORT_addr]; // @[RegFile.scala 17:22]
  assign regBank_io_outToIDTop_r19Out_MPORT_en = 1'h1;
  assign regBank_io_outToIDTop_r19Out_MPORT_addr = 5'h13;
  assign regBank_io_outToIDTop_r19Out_MPORT_data = regBank[regBank_io_outToIDTop_r19Out_MPORT_addr]; // @[RegFile.scala 17:22]
  assign regBank_io_outToIDTop_r20Out_MPORT_en = 1'h1;
  assign regBank_io_outToIDTop_r20Out_MPORT_addr = 5'h14;
  assign regBank_io_outToIDTop_r20Out_MPORT_data = regBank[regBank_io_outToIDTop_r20Out_MPORT_addr]; // @[RegFile.scala 17:22]
  assign regBank_io_outToIDTop_r21Out_MPORT_en = 1'h1;
  assign regBank_io_outToIDTop_r21Out_MPORT_addr = 5'h15;
  assign regBank_io_outToIDTop_r21Out_MPORT_data = regBank[regBank_io_outToIDTop_r21Out_MPORT_addr]; // @[RegFile.scala 17:22]
  assign regBank_io_outToIDTop_r22Out_MPORT_en = 1'h1;
  assign regBank_io_outToIDTop_r22Out_MPORT_addr = 5'h16;
  assign regBank_io_outToIDTop_r22Out_MPORT_data = regBank[regBank_io_outToIDTop_r22Out_MPORT_addr]; // @[RegFile.scala 17:22]
  assign regBank_io_outToIDTop_r23Out_MPORT_en = 1'h1;
  assign regBank_io_outToIDTop_r23Out_MPORT_addr = 5'h17;
  assign regBank_io_outToIDTop_r23Out_MPORT_data = regBank[regBank_io_outToIDTop_r23Out_MPORT_addr]; // @[RegFile.scala 17:22]
  assign regBank_io_outToIDTop_r24Out_MPORT_en = 1'h1;
  assign regBank_io_outToIDTop_r24Out_MPORT_addr = 5'h18;
  assign regBank_io_outToIDTop_r24Out_MPORT_data = regBank[regBank_io_outToIDTop_r24Out_MPORT_addr]; // @[RegFile.scala 17:22]
  assign regBank_io_outToIDTop_r25Out_MPORT_en = 1'h1;
  assign regBank_io_outToIDTop_r25Out_MPORT_addr = 5'h19;
  assign regBank_io_outToIDTop_r25Out_MPORT_data = regBank[regBank_io_outToIDTop_r25Out_MPORT_addr]; // @[RegFile.scala 17:22]
  assign regBank_io_outToIDTop_r26Out_MPORT_en = 1'h1;
  assign regBank_io_outToIDTop_r26Out_MPORT_addr = 5'h1a;
  assign regBank_io_outToIDTop_r26Out_MPORT_data = regBank[regBank_io_outToIDTop_r26Out_MPORT_addr]; // @[RegFile.scala 17:22]
  assign regBank_io_outToIDTop_r27Out_MPORT_en = 1'h1;
  assign regBank_io_outToIDTop_r27Out_MPORT_addr = 5'h1b;
  assign regBank_io_outToIDTop_r27Out_MPORT_data = regBank[regBank_io_outToIDTop_r27Out_MPORT_addr]; // @[RegFile.scala 17:22]
  assign regBank_io_outToIDTop_r28Out_MPORT_en = 1'h1;
  assign regBank_io_outToIDTop_r28Out_MPORT_addr = 5'h1c;
  assign regBank_io_outToIDTop_r28Out_MPORT_data = regBank[regBank_io_outToIDTop_r28Out_MPORT_addr]; // @[RegFile.scala 17:22]
  assign regBank_io_outToIDTop_r29Out_MPORT_en = 1'h1;
  assign regBank_io_outToIDTop_r29Out_MPORT_addr = 5'h1d;
  assign regBank_io_outToIDTop_r29Out_MPORT_data = regBank[regBank_io_outToIDTop_r29Out_MPORT_addr]; // @[RegFile.scala 17:22]
  assign regBank_io_outToIDTop_r30Out_MPORT_en = 1'h1;
  assign regBank_io_outToIDTop_r30Out_MPORT_addr = 5'h1e;
  assign regBank_io_outToIDTop_r30Out_MPORT_data = regBank[regBank_io_outToIDTop_r30Out_MPORT_addr]; // @[RegFile.scala 17:22]
  assign regBank_io_outToIDTop_r31Out_MPORT_en = 1'h1;
  assign regBank_io_outToIDTop_r31Out_MPORT_addr = 5'h1f;
  assign regBank_io_outToIDTop_r31Out_MPORT_data = regBank[regBank_io_outToIDTop_r31Out_MPORT_addr]; // @[RegFile.scala 17:22]
  assign regBank_MPORT_data = io_inFromWB_rWDataO;
  assign regBank_MPORT_addr = io_inFromWB_rWAddrO;
  assign regBank_MPORT_mask = 1'h1;
  assign regBank_MPORT_en = io_inFromWB_rWEnO & _T;
  assign io_outToID_r1RData = io_inFromID_r1RAddr == 5'h0 ? 32'h0 : _GEN_9; // @[RegFile.scala 25:39 26:28]
  assign io_outToIDTop_r1Out = regBank_io_outToIDTop_r1Out_MPORT_data; // @[RegFile.scala 50:25]
  assign io_outToIDTop_r2Out = regBank_io_outToIDTop_r2Out_MPORT_data; // @[RegFile.scala 51:25]
  assign io_outToIDTop_r3Out = regBank_io_outToIDTop_r3Out_MPORT_data; // @[RegFile.scala 52:25]
  assign io_outToIDTop_r4Out = regBank_io_outToIDTop_r4Out_MPORT_data; // @[RegFile.scala 53:25]
  assign io_outToIDTop_r5Out = regBank_io_outToIDTop_r5Out_MPORT_data; // @[RegFile.scala 54:25]
  assign io_outToIDTop_r6Out = regBank_io_outToIDTop_r6Out_MPORT_data; // @[RegFile.scala 55:25]
  assign io_outToIDTop_r7Out = regBank_io_outToIDTop_r7Out_MPORT_data; // @[RegFile.scala 56:25]
  assign io_outToIDTop_r8Out = regBank_io_outToIDTop_r8Out_MPORT_data; // @[RegFile.scala 57:25]
  assign io_outToIDTop_r9Out = regBank_io_outToIDTop_r9Out_MPORT_data; // @[RegFile.scala 58:25]
  assign io_outToIDTop_r10Out = regBank_io_outToIDTop_r10Out_MPORT_data; // @[RegFile.scala 59:26]
  assign io_outToIDTop_r11Out = regBank_io_outToIDTop_r11Out_MPORT_data; // @[RegFile.scala 60:26]
  assign io_outToIDTop_r12Out = regBank_io_outToIDTop_r12Out_MPORT_data; // @[RegFile.scala 61:26]
  assign io_outToIDTop_r13Out = regBank_io_outToIDTop_r13Out_MPORT_data; // @[RegFile.scala 62:26]
  assign io_outToIDTop_r14Out = regBank_io_outToIDTop_r14Out_MPORT_data; // @[RegFile.scala 63:26]
  assign io_outToIDTop_r15Out = regBank_io_outToIDTop_r15Out_MPORT_data; // @[RegFile.scala 64:26]
  assign io_outToIDTop_r16Out = regBank_io_outToIDTop_r16Out_MPORT_data; // @[RegFile.scala 65:26]
  assign io_outToIDTop_r17Out = regBank_io_outToIDTop_r17Out_MPORT_data; // @[RegFile.scala 66:26]
  assign io_outToIDTop_r18Out = regBank_io_outToIDTop_r18Out_MPORT_data; // @[RegFile.scala 67:26]
  assign io_outToIDTop_r19Out = regBank_io_outToIDTop_r19Out_MPORT_data; // @[RegFile.scala 68:26]
  assign io_outToIDTop_r20Out = regBank_io_outToIDTop_r20Out_MPORT_data; // @[RegFile.scala 69:26]
  assign io_outToIDTop_r21Out = regBank_io_outToIDTop_r21Out_MPORT_data; // @[RegFile.scala 70:26]
  assign io_outToIDTop_r22Out = regBank_io_outToIDTop_r22Out_MPORT_data; // @[RegFile.scala 71:26]
  assign io_outToIDTop_r23Out = regBank_io_outToIDTop_r23Out_MPORT_data; // @[RegFile.scala 72:26]
  assign io_outToIDTop_r24Out = regBank_io_outToIDTop_r24Out_MPORT_data; // @[RegFile.scala 73:26]
  assign io_outToIDTop_r25Out = regBank_io_outToIDTop_r25Out_MPORT_data; // @[RegFile.scala 74:26]
  assign io_outToIDTop_r26Out = regBank_io_outToIDTop_r26Out_MPORT_data; // @[RegFile.scala 75:26]
  assign io_outToIDTop_r27Out = regBank_io_outToIDTop_r27Out_MPORT_data; // @[RegFile.scala 76:26]
  assign io_outToIDTop_r28Out = regBank_io_outToIDTop_r28Out_MPORT_data; // @[RegFile.scala 77:26]
  assign io_outToIDTop_r29Out = regBank_io_outToIDTop_r29Out_MPORT_data; // @[RegFile.scala 78:26]
  assign io_outToIDTop_r30Out = regBank_io_outToIDTop_r30Out_MPORT_data; // @[RegFile.scala 79:26]
  assign io_outToIDTop_r31Out = regBank_io_outToIDTop_r31Out_MPORT_data; // @[RegFile.scala 80:26]
  always @(posedge clock) begin
    if (regBank_MPORT_en & regBank_MPORT_mask) begin
      regBank[regBank_MPORT_addr] <= regBank_MPORT_data; // @[RegFile.scala 17:22]
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
  input  [31:0] io_inFromIDTop_fromIFTop_iRRdDt,
  input  [4:0]  io_inFromIDTop_fromEXTop_rWAddrO,
  input         io_inFromIDTop_fromEXTop_rWEnO,
  input  [31:0] io_inFromIDTop_fromEXTop_rWDataO,
  input  [4:0]  io_inFromIDTop_fromMEMTop_rWAddrO,
  input         io_inFromIDTop_fromMEMTop_rWEnO,
  input  [31:0] io_inFromIDTop_fromMEMTop_rWDataO,
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
  wire [5:0] op = io_inFromIDTop_fromIFTop_iRRdDt[31:26]; // @[DC.scala 34:42]
  wire  _T = 6'hd == op; // @[DC.scala 40:16]
  wire [5:0] _GEN_2 = 6'hd == op ? 6'h25 : 6'h0; // @[DC.scala 40:16 29:19 45:27]
  wire [31:0] imm = 6'hd == op ? {{16'd0}, io_inFromIDTop_fromIFTop_iRRdDt[15:0]} : 32'h0; // @[DC.scala 40:16 47:17]
  wire  _T_3 = io_outToRF_r1REn & io_inFromIDTop_fromEXTop_rWEnO; // @[DC.scala 51:13]
  wire  _T_8 = io_outToRF_r1REn & io_inFromIDTop_fromMEMTop_rWEnO; // @[DC.scala 55:13]
  wire [31:0] _GEN_4 = ~io_outToRF_r1REn ? imm : 32'h0; // @[DC.scala 31:23 60:46 61:27]
  wire [31:0] _GEN_5 = io_outToRF_r1REn ? io_inFromRF_r1RData : _GEN_4; // @[DC.scala 58:45 59:27]
  wire [31:0] _GEN_6 = _T_8 & io_inFromIDTop_fromMEMTop_rWAddrO == io_outToRF_r1RAddr ?
    io_inFromIDTop_fromMEMTop_rWDataO : _GEN_5; // @[DC.scala 56:76 57:27]
  wire  _T_15 = io_outToRF_r2REn & io_inFromIDTop_fromEXTop_rWEnO; // @[DC.scala 65:13]
  wire  _T_20 = io_outToRF_r2REn & io_inFromIDTop_fromMEMTop_rWEnO; // @[DC.scala 69:13]
  wire [31:0] _GEN_8 = ~io_outToRF_r2REn ? imm : 32'h0; // @[DC.scala 32:23 74:46 75:27]
  wire [31:0] _GEN_9 = io_outToRF_r2REn ? 32'h0 : _GEN_8; // @[DC.scala 72:45 73:27]
  wire [31:0] _GEN_10 = _T_20 & io_inFromIDTop_fromMEMTop_rWAddrO == io_outToRF_r2RAddr ?
    io_inFromIDTop_fromMEMTop_rWDataO : _GEN_9; // @[DC.scala 70:76 71:27]
  assign io_outToD_iSK = {{2'd0}, _GEN_2};
  assign io_outToD_iK = {{2'd0}, _T};
  assign io_outToD_source1 = _T_3 & io_inFromIDTop_fromEXTop_rWAddrO == io_outToRF_r1RAddr ?
    io_inFromIDTop_fromEXTop_rWDataO : _GEN_6; // @[DC.scala 52:75 53:27]
  assign io_outToD_source2 = _T_15 & io_inFromIDTop_fromEXTop_rWAddrO == io_outToRF_r2RAddr ?
    io_inFromIDTop_fromEXTop_rWDataO : _GEN_10; // @[DC.scala 66:75 67:27]
  assign io_outToD_rWAddr = io_inFromIDTop_fromIFTop_iRRdDt[20:16]; // @[DC.scala 35:56]
  assign io_outToD_rWEn = 6'hd == op; // @[DC.scala 40:16]
  assign io_outToRF_r1REn = 6'hd == op; // @[DC.scala 40:16]
  assign io_outToRF_r2REn = 1'h0; // @[DC.scala 40:16 27:22 44:30]
  assign io_outToRF_r1RAddr = io_inFromIDTop_fromIFTop_iRRdDt[25:21]; // @[DC.scala 36:58]
  assign io_outToRF_r2RAddr = io_inFromIDTop_fromIFTop_iRRdDt[20:16]; // @[DC.scala 37:58]
endmodule
module IDTop(
  input         clock,
  input         reset,
  input  [31:0] io_inFromIF_iRRdDt,
  input  [4:0]  io_inFromWB_rWAddrO,
  input         io_inFromWB_rWEnO,
  input  [31:0] io_inFromWB_rWDataO,
  input  [4:0]  io_inFromEX_rWAddrO,
  input         io_inFromEX_rWEnO,
  input  [31:0] io_inFromEX_rWDataO,
  input  [4:0]  io_inFromMEM_rWAddrO,
  input         io_inFromMEM_rWEnO,
  input  [31:0] io_inFromMEM_rWDataO,
  output [31:0] io_outToTop_fromRF_r1Out,
  output [31:0] io_outToTop_fromRF_r2Out,
  output [31:0] io_outToTop_fromRF_r3Out,
  output [31:0] io_outToTop_fromRF_r4Out,
  output [31:0] io_outToTop_fromRF_r5Out,
  output [31:0] io_outToTop_fromRF_r6Out,
  output [31:0] io_outToTop_fromRF_r7Out,
  output [31:0] io_outToTop_fromRF_r8Out,
  output [31:0] io_outToTop_fromRF_r9Out,
  output [31:0] io_outToTop_fromRF_r10Out,
  output [31:0] io_outToTop_fromRF_r11Out,
  output [31:0] io_outToTop_fromRF_r12Out,
  output [31:0] io_outToTop_fromRF_r13Out,
  output [31:0] io_outToTop_fromRF_r14Out,
  output [31:0] io_outToTop_fromRF_r15Out,
  output [31:0] io_outToTop_fromRF_r16Out,
  output [31:0] io_outToTop_fromRF_r17Out,
  output [31:0] io_outToTop_fromRF_r18Out,
  output [31:0] io_outToTop_fromRF_r19Out,
  output [31:0] io_outToTop_fromRF_r20Out,
  output [31:0] io_outToTop_fromRF_r21Out,
  output [31:0] io_outToTop_fromRF_r22Out,
  output [31:0] io_outToTop_fromRF_r23Out,
  output [31:0] io_outToTop_fromRF_r24Out,
  output [31:0] io_outToTop_fromRF_r25Out,
  output [31:0] io_outToTop_fromRF_r26Out,
  output [31:0] io_outToTop_fromRF_r27Out,
  output [31:0] io_outToTop_fromRF_r28Out,
  output [31:0] io_outToTop_fromRF_r29Out,
  output [31:0] io_outToTop_fromRF_r30Out,
  output [31:0] io_outToTop_fromRF_r31Out,
  output [7:0]  io_outToEX_iSK,
  output [2:0]  io_outToEX_iK,
  output [31:0] io_outToEX_source1,
  output [31:0] io_outToEX_source2,
  output [4:0]  io_outToEX_rWAddr,
  output        io_outToEX_rWEn
);
  wire  d_clock; // @[IDTop.scala 20:19]
  wire  d_reset; // @[IDTop.scala 20:19]
  wire [7:0] d_io_inFromID_iSK; // @[IDTop.scala 20:19]
  wire [2:0] d_io_inFromID_iK; // @[IDTop.scala 20:19]
  wire [31:0] d_io_inFromID_source1; // @[IDTop.scala 20:19]
  wire [31:0] d_io_inFromID_source2; // @[IDTop.scala 20:19]
  wire [4:0] d_io_inFromID_rWAddr; // @[IDTop.scala 20:19]
  wire  d_io_inFromID_rWEn; // @[IDTop.scala 20:19]
  wire [7:0] d_io_outToEX_iSK; // @[IDTop.scala 20:19]
  wire [2:0] d_io_outToEX_iK; // @[IDTop.scala 20:19]
  wire [31:0] d_io_outToEX_source1; // @[IDTop.scala 20:19]
  wire [31:0] d_io_outToEX_source2; // @[IDTop.scala 20:19]
  wire [4:0] d_io_outToEX_rWAddr; // @[IDTop.scala 20:19]
  wire  d_io_outToEX_rWEn; // @[IDTop.scala 20:19]
  wire  rf_clock; // @[IDTop.scala 21:20]
  wire  rf_io_inFromID_r1REn; // @[IDTop.scala 21:20]
  wire [4:0] rf_io_inFromID_r1RAddr; // @[IDTop.scala 21:20]
  wire [4:0] rf_io_inFromID_r2RAddr; // @[IDTop.scala 21:20]
  wire [4:0] rf_io_inFromWB_rWAddrO; // @[IDTop.scala 21:20]
  wire  rf_io_inFromWB_rWEnO; // @[IDTop.scala 21:20]
  wire [31:0] rf_io_inFromWB_rWDataO; // @[IDTop.scala 21:20]
  wire [31:0] rf_io_outToID_r1RData; // @[IDTop.scala 21:20]
  wire [31:0] rf_io_outToIDTop_r1Out; // @[IDTop.scala 21:20]
  wire [31:0] rf_io_outToIDTop_r2Out; // @[IDTop.scala 21:20]
  wire [31:0] rf_io_outToIDTop_r3Out; // @[IDTop.scala 21:20]
  wire [31:0] rf_io_outToIDTop_r4Out; // @[IDTop.scala 21:20]
  wire [31:0] rf_io_outToIDTop_r5Out; // @[IDTop.scala 21:20]
  wire [31:0] rf_io_outToIDTop_r6Out; // @[IDTop.scala 21:20]
  wire [31:0] rf_io_outToIDTop_r7Out; // @[IDTop.scala 21:20]
  wire [31:0] rf_io_outToIDTop_r8Out; // @[IDTop.scala 21:20]
  wire [31:0] rf_io_outToIDTop_r9Out; // @[IDTop.scala 21:20]
  wire [31:0] rf_io_outToIDTop_r10Out; // @[IDTop.scala 21:20]
  wire [31:0] rf_io_outToIDTop_r11Out; // @[IDTop.scala 21:20]
  wire [31:0] rf_io_outToIDTop_r12Out; // @[IDTop.scala 21:20]
  wire [31:0] rf_io_outToIDTop_r13Out; // @[IDTop.scala 21:20]
  wire [31:0] rf_io_outToIDTop_r14Out; // @[IDTop.scala 21:20]
  wire [31:0] rf_io_outToIDTop_r15Out; // @[IDTop.scala 21:20]
  wire [31:0] rf_io_outToIDTop_r16Out; // @[IDTop.scala 21:20]
  wire [31:0] rf_io_outToIDTop_r17Out; // @[IDTop.scala 21:20]
  wire [31:0] rf_io_outToIDTop_r18Out; // @[IDTop.scala 21:20]
  wire [31:0] rf_io_outToIDTop_r19Out; // @[IDTop.scala 21:20]
  wire [31:0] rf_io_outToIDTop_r20Out; // @[IDTop.scala 21:20]
  wire [31:0] rf_io_outToIDTop_r21Out; // @[IDTop.scala 21:20]
  wire [31:0] rf_io_outToIDTop_r22Out; // @[IDTop.scala 21:20]
  wire [31:0] rf_io_outToIDTop_r23Out; // @[IDTop.scala 21:20]
  wire [31:0] rf_io_outToIDTop_r24Out; // @[IDTop.scala 21:20]
  wire [31:0] rf_io_outToIDTop_r25Out; // @[IDTop.scala 21:20]
  wire [31:0] rf_io_outToIDTop_r26Out; // @[IDTop.scala 21:20]
  wire [31:0] rf_io_outToIDTop_r27Out; // @[IDTop.scala 21:20]
  wire [31:0] rf_io_outToIDTop_r28Out; // @[IDTop.scala 21:20]
  wire [31:0] rf_io_outToIDTop_r29Out; // @[IDTop.scala 21:20]
  wire [31:0] rf_io_outToIDTop_r30Out; // @[IDTop.scala 21:20]
  wire [31:0] rf_io_outToIDTop_r31Out; // @[IDTop.scala 21:20]
  wire [31:0] dc_io_inFromIDTop_fromIFTop_iRRdDt; // @[IDTop.scala 22:20]
  wire [4:0] dc_io_inFromIDTop_fromEXTop_rWAddrO; // @[IDTop.scala 22:20]
  wire  dc_io_inFromIDTop_fromEXTop_rWEnO; // @[IDTop.scala 22:20]
  wire [31:0] dc_io_inFromIDTop_fromEXTop_rWDataO; // @[IDTop.scala 22:20]
  wire [4:0] dc_io_inFromIDTop_fromMEMTop_rWAddrO; // @[IDTop.scala 22:20]
  wire  dc_io_inFromIDTop_fromMEMTop_rWEnO; // @[IDTop.scala 22:20]
  wire [31:0] dc_io_inFromIDTop_fromMEMTop_rWDataO; // @[IDTop.scala 22:20]
  wire [31:0] dc_io_inFromRF_r1RData; // @[IDTop.scala 22:20]
  wire [7:0] dc_io_outToD_iSK; // @[IDTop.scala 22:20]
  wire [2:0] dc_io_outToD_iK; // @[IDTop.scala 22:20]
  wire [31:0] dc_io_outToD_source1; // @[IDTop.scala 22:20]
  wire [31:0] dc_io_outToD_source2; // @[IDTop.scala 22:20]
  wire [4:0] dc_io_outToD_rWAddr; // @[IDTop.scala 22:20]
  wire  dc_io_outToD_rWEn; // @[IDTop.scala 22:20]
  wire  dc_io_outToRF_r1REn; // @[IDTop.scala 22:20]
  wire  dc_io_outToRF_r2REn; // @[IDTop.scala 22:20]
  wire [4:0] dc_io_outToRF_r1RAddr; // @[IDTop.scala 22:20]
  wire [4:0] dc_io_outToRF_r2RAddr; // @[IDTop.scala 22:20]
  DbtIDEX d ( // @[IDTop.scala 20:19]
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
  RegFile rf ( // @[IDTop.scala 21:20]
    .clock(rf_clock),
    .io_inFromID_r1REn(rf_io_inFromID_r1REn),
    .io_inFromID_r1RAddr(rf_io_inFromID_r1RAddr),
    .io_inFromID_r2RAddr(rf_io_inFromID_r2RAddr),
    .io_inFromWB_rWAddrO(rf_io_inFromWB_rWAddrO),
    .io_inFromWB_rWEnO(rf_io_inFromWB_rWEnO),
    .io_inFromWB_rWDataO(rf_io_inFromWB_rWDataO),
    .io_outToID_r1RData(rf_io_outToID_r1RData),
    .io_outToIDTop_r1Out(rf_io_outToIDTop_r1Out),
    .io_outToIDTop_r2Out(rf_io_outToIDTop_r2Out),
    .io_outToIDTop_r3Out(rf_io_outToIDTop_r3Out),
    .io_outToIDTop_r4Out(rf_io_outToIDTop_r4Out),
    .io_outToIDTop_r5Out(rf_io_outToIDTop_r5Out),
    .io_outToIDTop_r6Out(rf_io_outToIDTop_r6Out),
    .io_outToIDTop_r7Out(rf_io_outToIDTop_r7Out),
    .io_outToIDTop_r8Out(rf_io_outToIDTop_r8Out),
    .io_outToIDTop_r9Out(rf_io_outToIDTop_r9Out),
    .io_outToIDTop_r10Out(rf_io_outToIDTop_r10Out),
    .io_outToIDTop_r11Out(rf_io_outToIDTop_r11Out),
    .io_outToIDTop_r12Out(rf_io_outToIDTop_r12Out),
    .io_outToIDTop_r13Out(rf_io_outToIDTop_r13Out),
    .io_outToIDTop_r14Out(rf_io_outToIDTop_r14Out),
    .io_outToIDTop_r15Out(rf_io_outToIDTop_r15Out),
    .io_outToIDTop_r16Out(rf_io_outToIDTop_r16Out),
    .io_outToIDTop_r17Out(rf_io_outToIDTop_r17Out),
    .io_outToIDTop_r18Out(rf_io_outToIDTop_r18Out),
    .io_outToIDTop_r19Out(rf_io_outToIDTop_r19Out),
    .io_outToIDTop_r20Out(rf_io_outToIDTop_r20Out),
    .io_outToIDTop_r21Out(rf_io_outToIDTop_r21Out),
    .io_outToIDTop_r22Out(rf_io_outToIDTop_r22Out),
    .io_outToIDTop_r23Out(rf_io_outToIDTop_r23Out),
    .io_outToIDTop_r24Out(rf_io_outToIDTop_r24Out),
    .io_outToIDTop_r25Out(rf_io_outToIDTop_r25Out),
    .io_outToIDTop_r26Out(rf_io_outToIDTop_r26Out),
    .io_outToIDTop_r27Out(rf_io_outToIDTop_r27Out),
    .io_outToIDTop_r28Out(rf_io_outToIDTop_r28Out),
    .io_outToIDTop_r29Out(rf_io_outToIDTop_r29Out),
    .io_outToIDTop_r30Out(rf_io_outToIDTop_r30Out),
    .io_outToIDTop_r31Out(rf_io_outToIDTop_r31Out)
  );
  DC dc ( // @[IDTop.scala 22:20]
    .io_inFromIDTop_fromIFTop_iRRdDt(dc_io_inFromIDTop_fromIFTop_iRRdDt),
    .io_inFromIDTop_fromEXTop_rWAddrO(dc_io_inFromIDTop_fromEXTop_rWAddrO),
    .io_inFromIDTop_fromEXTop_rWEnO(dc_io_inFromIDTop_fromEXTop_rWEnO),
    .io_inFromIDTop_fromEXTop_rWDataO(dc_io_inFromIDTop_fromEXTop_rWDataO),
    .io_inFromIDTop_fromMEMTop_rWAddrO(dc_io_inFromIDTop_fromMEMTop_rWAddrO),
    .io_inFromIDTop_fromMEMTop_rWEnO(dc_io_inFromIDTop_fromMEMTop_rWEnO),
    .io_inFromIDTop_fromMEMTop_rWDataO(dc_io_inFromIDTop_fromMEMTop_rWDataO),
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
  assign io_outToTop_fromRF_r1Out = rf_io_outToIDTop_r1Out; // @[IDTop.scala 35:24]
  assign io_outToTop_fromRF_r2Out = rf_io_outToIDTop_r2Out; // @[IDTop.scala 35:24]
  assign io_outToTop_fromRF_r3Out = rf_io_outToIDTop_r3Out; // @[IDTop.scala 35:24]
  assign io_outToTop_fromRF_r4Out = rf_io_outToIDTop_r4Out; // @[IDTop.scala 35:24]
  assign io_outToTop_fromRF_r5Out = rf_io_outToIDTop_r5Out; // @[IDTop.scala 35:24]
  assign io_outToTop_fromRF_r6Out = rf_io_outToIDTop_r6Out; // @[IDTop.scala 35:24]
  assign io_outToTop_fromRF_r7Out = rf_io_outToIDTop_r7Out; // @[IDTop.scala 35:24]
  assign io_outToTop_fromRF_r8Out = rf_io_outToIDTop_r8Out; // @[IDTop.scala 35:24]
  assign io_outToTop_fromRF_r9Out = rf_io_outToIDTop_r9Out; // @[IDTop.scala 35:24]
  assign io_outToTop_fromRF_r10Out = rf_io_outToIDTop_r10Out; // @[IDTop.scala 35:24]
  assign io_outToTop_fromRF_r11Out = rf_io_outToIDTop_r11Out; // @[IDTop.scala 35:24]
  assign io_outToTop_fromRF_r12Out = rf_io_outToIDTop_r12Out; // @[IDTop.scala 35:24]
  assign io_outToTop_fromRF_r13Out = rf_io_outToIDTop_r13Out; // @[IDTop.scala 35:24]
  assign io_outToTop_fromRF_r14Out = rf_io_outToIDTop_r14Out; // @[IDTop.scala 35:24]
  assign io_outToTop_fromRF_r15Out = rf_io_outToIDTop_r15Out; // @[IDTop.scala 35:24]
  assign io_outToTop_fromRF_r16Out = rf_io_outToIDTop_r16Out; // @[IDTop.scala 35:24]
  assign io_outToTop_fromRF_r17Out = rf_io_outToIDTop_r17Out; // @[IDTop.scala 35:24]
  assign io_outToTop_fromRF_r18Out = rf_io_outToIDTop_r18Out; // @[IDTop.scala 35:24]
  assign io_outToTop_fromRF_r19Out = rf_io_outToIDTop_r19Out; // @[IDTop.scala 35:24]
  assign io_outToTop_fromRF_r20Out = rf_io_outToIDTop_r20Out; // @[IDTop.scala 35:24]
  assign io_outToTop_fromRF_r21Out = rf_io_outToIDTop_r21Out; // @[IDTop.scala 35:24]
  assign io_outToTop_fromRF_r22Out = rf_io_outToIDTop_r22Out; // @[IDTop.scala 35:24]
  assign io_outToTop_fromRF_r23Out = rf_io_outToIDTop_r23Out; // @[IDTop.scala 35:24]
  assign io_outToTop_fromRF_r24Out = rf_io_outToIDTop_r24Out; // @[IDTop.scala 35:24]
  assign io_outToTop_fromRF_r25Out = rf_io_outToIDTop_r25Out; // @[IDTop.scala 35:24]
  assign io_outToTop_fromRF_r26Out = rf_io_outToIDTop_r26Out; // @[IDTop.scala 35:24]
  assign io_outToTop_fromRF_r27Out = rf_io_outToIDTop_r27Out; // @[IDTop.scala 35:24]
  assign io_outToTop_fromRF_r28Out = rf_io_outToIDTop_r28Out; // @[IDTop.scala 35:24]
  assign io_outToTop_fromRF_r29Out = rf_io_outToIDTop_r29Out; // @[IDTop.scala 35:24]
  assign io_outToTop_fromRF_r30Out = rf_io_outToIDTop_r30Out; // @[IDTop.scala 35:24]
  assign io_outToTop_fromRF_r31Out = rf_io_outToIDTop_r31Out; // @[IDTop.scala 35:24]
  assign io_outToEX_iSK = d_io_outToEX_iSK; // @[IDTop.scala 31:16]
  assign io_outToEX_iK = d_io_outToEX_iK; // @[IDTop.scala 31:16]
  assign io_outToEX_source1 = d_io_outToEX_source1; // @[IDTop.scala 31:16]
  assign io_outToEX_source2 = d_io_outToEX_source2; // @[IDTop.scala 31:16]
  assign io_outToEX_rWAddr = d_io_outToEX_rWAddr; // @[IDTop.scala 31:16]
  assign io_outToEX_rWEn = d_io_outToEX_rWEn; // @[IDTop.scala 31:16]
  assign d_clock = clock;
  assign d_reset = reset;
  assign d_io_inFromID_iSK = dc_io_outToD_iSK; // @[IDTop.scala 30:19]
  assign d_io_inFromID_iK = dc_io_outToD_iK; // @[IDTop.scala 30:19]
  assign d_io_inFromID_source1 = dc_io_outToD_source1; // @[IDTop.scala 30:19]
  assign d_io_inFromID_source2 = dc_io_outToD_source2; // @[IDTop.scala 30:19]
  assign d_io_inFromID_rWAddr = dc_io_outToD_rWAddr; // @[IDTop.scala 30:19]
  assign d_io_inFromID_rWEn = dc_io_outToD_rWEn; // @[IDTop.scala 30:19]
  assign rf_clock = clock;
  assign rf_io_inFromID_r1REn = dc_io_outToRF_r1REn; // @[IDTop.scala 29:20]
  assign rf_io_inFromID_r1RAddr = dc_io_outToRF_r1RAddr; // @[IDTop.scala 29:20]
  assign rf_io_inFromID_r2RAddr = dc_io_outToRF_r2RAddr; // @[IDTop.scala 29:20]
  assign rf_io_inFromWB_rWAddrO = io_inFromWB_rWAddrO; // @[IDTop.scala 33:20]
  assign rf_io_inFromWB_rWEnO = io_inFromWB_rWEnO; // @[IDTop.scala 33:20]
  assign rf_io_inFromWB_rWDataO = io_inFromWB_rWDataO; // @[IDTop.scala 33:20]
  assign dc_io_inFromIDTop_fromIFTop_iRRdDt = io_inFromIF_iRRdDt; // @[IDTop.scala 24:33]
  assign dc_io_inFromIDTop_fromEXTop_rWAddrO = io_inFromEX_rWAddrO; // @[IDTop.scala 25:33]
  assign dc_io_inFromIDTop_fromEXTop_rWEnO = io_inFromEX_rWEnO; // @[IDTop.scala 25:33]
  assign dc_io_inFromIDTop_fromEXTop_rWDataO = io_inFromEX_rWDataO; // @[IDTop.scala 25:33]
  assign dc_io_inFromIDTop_fromMEMTop_rWAddrO = io_inFromMEM_rWAddrO; // @[IDTop.scala 26:34]
  assign dc_io_inFromIDTop_fromMEMTop_rWEnO = io_inFromMEM_rWEnO; // @[IDTop.scala 26:34]
  assign dc_io_inFromIDTop_fromMEMTop_rWDataO = io_inFromMEM_rWDataO; // @[IDTop.scala 26:34]
  assign dc_io_inFromRF_r1RData = rf_io_outToID_r1RData; // @[IDTop.scala 28:20]
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
  output [31:0] io_outToD_rWDataO,
  output [4:0]  io_outToEXTop_rWAddrO,
  output        io_outToEXTop_rWEnO,
  output [31:0] io_outToEXTop_rWDataO
);
  wire [31:0] _logicResult_T = io_inFromD_source1 | io_inFromD_source2; // @[EX.scala 32:47]
  wire [31:0] logicResult = 8'h25 == io_inFromD_iSK ? _logicResult_T : 32'h0; // @[EX.scala 30:28 32:25]
  assign io_outToD_rWAddrO = io_inFromD_rWAddr; // @[EX.scala 21:23]
  assign io_outToD_rWEnO = io_inFromD_rWEn; // @[EX.scala 22:21]
  assign io_outToD_rWDataO = 3'h1 == io_inFromD_iK ? logicResult : 32'h0; // @[EX.scala 24:23 37:27 39:31]
  assign io_outToEXTop_rWAddrO = io_outToD_rWAddrO; // @[EX.scala 26:19]
  assign io_outToEXTop_rWEnO = io_outToD_rWEnO; // @[EX.scala 26:19]
  assign io_outToEXTop_rWDataO = io_outToD_rWDataO; // @[EX.scala 26:19]
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
  output [31:0] io_outToMEM_rWDataO,
  output [4:0]  io_outToID_rWAddrO,
  output        io_outToID_rWEnO,
  output [31:0] io_outToID_rWDataO
);
  wire [7:0] ex_io_inFromD_iSK; // @[EXTop.scala 15:20]
  wire [2:0] ex_io_inFromD_iK; // @[EXTop.scala 15:20]
  wire [31:0] ex_io_inFromD_source1; // @[EXTop.scala 15:20]
  wire [31:0] ex_io_inFromD_source2; // @[EXTop.scala 15:20]
  wire [4:0] ex_io_inFromD_rWAddr; // @[EXTop.scala 15:20]
  wire  ex_io_inFromD_rWEn; // @[EXTop.scala 15:20]
  wire [4:0] ex_io_outToD_rWAddrO; // @[EXTop.scala 15:20]
  wire  ex_io_outToD_rWEnO; // @[EXTop.scala 15:20]
  wire [31:0] ex_io_outToD_rWDataO; // @[EXTop.scala 15:20]
  wire [4:0] ex_io_outToEXTop_rWAddrO; // @[EXTop.scala 15:20]
  wire  ex_io_outToEXTop_rWEnO; // @[EXTop.scala 15:20]
  wire [31:0] ex_io_outToEXTop_rWDataO; // @[EXTop.scala 15:20]
  wire  d_clock; // @[EXTop.scala 16:19]
  wire [4:0] d_io_inFromEX_rWAddrO; // @[EXTop.scala 16:19]
  wire  d_io_inFromEX_rWEnO; // @[EXTop.scala 16:19]
  wire [31:0] d_io_inFromEX_rWDataO; // @[EXTop.scala 16:19]
  wire [4:0] d_io_outToMEM_rWAddrO; // @[EXTop.scala 16:19]
  wire  d_io_outToMEM_rWEnO; // @[EXTop.scala 16:19]
  wire [31:0] d_io_outToMEM_rWDataO; // @[EXTop.scala 16:19]
  EX ex ( // @[EXTop.scala 15:20]
    .io_inFromD_iSK(ex_io_inFromD_iSK),
    .io_inFromD_iK(ex_io_inFromD_iK),
    .io_inFromD_source1(ex_io_inFromD_source1),
    .io_inFromD_source2(ex_io_inFromD_source2),
    .io_inFromD_rWAddr(ex_io_inFromD_rWAddr),
    .io_inFromD_rWEn(ex_io_inFromD_rWEn),
    .io_outToD_rWAddrO(ex_io_outToD_rWAddrO),
    .io_outToD_rWEnO(ex_io_outToD_rWEnO),
    .io_outToD_rWDataO(ex_io_outToD_rWDataO),
    .io_outToEXTop_rWAddrO(ex_io_outToEXTop_rWAddrO),
    .io_outToEXTop_rWEnO(ex_io_outToEXTop_rWEnO),
    .io_outToEXTop_rWDataO(ex_io_outToEXTop_rWDataO)
  );
  DbtEXMEM d ( // @[EXTop.scala 16:19]
    .clock(d_clock),
    .io_inFromEX_rWAddrO(d_io_inFromEX_rWAddrO),
    .io_inFromEX_rWEnO(d_io_inFromEX_rWEnO),
    .io_inFromEX_rWDataO(d_io_inFromEX_rWDataO),
    .io_outToMEM_rWAddrO(d_io_outToMEM_rWAddrO),
    .io_outToMEM_rWEnO(d_io_outToMEM_rWEnO),
    .io_outToMEM_rWDataO(d_io_outToMEM_rWDataO)
  );
  assign io_outToMEM_rWAddrO = d_io_outToMEM_rWAddrO; // @[EXTop.scala 21:19]
  assign io_outToMEM_rWEnO = d_io_outToMEM_rWEnO; // @[EXTop.scala 21:19]
  assign io_outToMEM_rWDataO = d_io_outToMEM_rWDataO; // @[EXTop.scala 21:19]
  assign io_outToID_rWAddrO = ex_io_outToEXTop_rWAddrO; // @[EXTop.scala 18:22]
  assign io_outToID_rWEnO = ex_io_outToEXTop_rWEnO; // @[EXTop.scala 18:22]
  assign io_outToID_rWDataO = ex_io_outToEXTop_rWDataO; // @[EXTop.scala 18:22]
  assign ex_io_inFromD_iSK = io_inFromID_iSK; // @[EXTop.scala 19:19]
  assign ex_io_inFromD_iK = io_inFromID_iK; // @[EXTop.scala 19:19]
  assign ex_io_inFromD_source1 = io_inFromID_source1; // @[EXTop.scala 19:19]
  assign ex_io_inFromD_source2 = io_inFromID_source2; // @[EXTop.scala 19:19]
  assign ex_io_inFromD_rWAddr = io_inFromID_rWAddr; // @[EXTop.scala 19:19]
  assign ex_io_inFromD_rWEn = io_inFromID_rWEn; // @[EXTop.scala 19:19]
  assign d_clock = clock;
  assign d_io_inFromEX_rWAddrO = ex_io_outToD_rWAddrO; // @[EXTop.scala 20:18]
  assign d_io_inFromEX_rWEnO = ex_io_outToD_rWEnO; // @[EXTop.scala 20:18]
  assign d_io_inFromEX_rWDataO = ex_io_outToD_rWDataO; // @[EXTop.scala 20:18]
endmodule
module DbtMEMWB(
  input         clock,
  input         reset,
  input  [4:0]  io_inFromMEM_rWAddrO,
  input         io_inFromMEM_rWEnO,
  input  [31:0] io_inFromMEM_rWDataO,
  output [4:0]  io_outToWB_rWAddrO,
  output        io_outToWB_rWEnO,
  output [31:0] io_outToWB_rWDataO
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [4:0] rWAddrO; // @[DbtMEMWB.scala 18:26]
  reg  rWEnO; // @[DbtMEMWB.scala 19:24]
  reg [31:0] rWDataO; // @[DbtMEMWB.scala 20:26]
  assign io_outToWB_rWAddrO = rWAddrO; // @[DbtMEMWB.scala 22:24]
  assign io_outToWB_rWEnO = rWEnO; // @[DbtMEMWB.scala 23:22]
  assign io_outToWB_rWDataO = rWDataO; // @[DbtMEMWB.scala 24:24]
  always @(posedge clock) begin
    if (reset) begin // @[DbtMEMWB.scala 18:26]
      rWAddrO <= 5'h0; // @[DbtMEMWB.scala 18:26]
    end else begin
      rWAddrO <= io_inFromMEM_rWAddrO; // @[DbtMEMWB.scala 18:26]
    end
    if (reset) begin // @[DbtMEMWB.scala 19:24]
      rWEnO <= 1'h0; // @[DbtMEMWB.scala 19:24]
    end else begin
      rWEnO <= io_inFromMEM_rWEnO; // @[DbtMEMWB.scala 19:24]
    end
    if (reset) begin // @[DbtMEMWB.scala 20:26]
      rWDataO <= 32'h0; // @[DbtMEMWB.scala 20:26]
    end else begin
      rWDataO <= io_inFromMEM_rWDataO; // @[DbtMEMWB.scala 20:26]
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
  rWAddrO = _RAND_0[4:0];
  _RAND_1 = {1{`RANDOM}};
  rWEnO = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  rWDataO = _RAND_2[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module MEM(
  input  [4:0]  io_inFromD_rWAddrO,
  input         io_inFromD_rWEnO,
  input  [31:0] io_inFromD_rWDataO,
  output [4:0]  io_outToD_rWAddrO,
  output        io_outToD_rWEnO,
  output [31:0] io_outToD_rWDataO,
  output [4:0]  io_outToMEMTop_rWAddrO,
  output        io_outToMEMTop_rWEnO,
  output [31:0] io_outToMEMTop_rWDataO
);
  assign io_outToD_rWAddrO = io_inFromD_rWAddrO; // @[MEM.scala 16:15]
  assign io_outToD_rWEnO = io_inFromD_rWEnO; // @[MEM.scala 16:15]
  assign io_outToD_rWDataO = io_inFromD_rWDataO; // @[MEM.scala 16:15]
  assign io_outToMEMTop_rWAddrO = io_outToD_rWAddrO; // @[MEM.scala 17:20]
  assign io_outToMEMTop_rWEnO = io_outToD_rWEnO; // @[MEM.scala 17:20]
  assign io_outToMEMTop_rWDataO = io_outToD_rWDataO; // @[MEM.scala 17:20]
endmodule
module MEMTop(
  input         clock,
  input         reset,
  input  [4:0]  io_inFromEX_rWAddrO,
  input         io_inFromEX_rWEnO,
  input  [31:0] io_inFromEX_rWDataO,
  output [4:0]  io_outToWB_rWAddrO,
  output        io_outToWB_rWEnO,
  output [31:0] io_outToWB_rWDataO,
  output [4:0]  io_out2IDTop_rWAddrO,
  output        io_out2IDTop_rWEnO,
  output [31:0] io_out2IDTop_rWDataO
);
  wire  d_clock; // @[MEMTop.scala 15:19]
  wire  d_reset; // @[MEMTop.scala 15:19]
  wire [4:0] d_io_inFromMEM_rWAddrO; // @[MEMTop.scala 15:19]
  wire  d_io_inFromMEM_rWEnO; // @[MEMTop.scala 15:19]
  wire [31:0] d_io_inFromMEM_rWDataO; // @[MEMTop.scala 15:19]
  wire [4:0] d_io_outToWB_rWAddrO; // @[MEMTop.scala 15:19]
  wire  d_io_outToWB_rWEnO; // @[MEMTop.scala 15:19]
  wire [31:0] d_io_outToWB_rWDataO; // @[MEMTop.scala 15:19]
  wire [4:0] mem_io_inFromD_rWAddrO; // @[MEMTop.scala 16:21]
  wire  mem_io_inFromD_rWEnO; // @[MEMTop.scala 16:21]
  wire [31:0] mem_io_inFromD_rWDataO; // @[MEMTop.scala 16:21]
  wire [4:0] mem_io_outToD_rWAddrO; // @[MEMTop.scala 16:21]
  wire  mem_io_outToD_rWEnO; // @[MEMTop.scala 16:21]
  wire [31:0] mem_io_outToD_rWDataO; // @[MEMTop.scala 16:21]
  wire [4:0] mem_io_outToMEMTop_rWAddrO; // @[MEMTop.scala 16:21]
  wire  mem_io_outToMEMTop_rWEnO; // @[MEMTop.scala 16:21]
  wire [31:0] mem_io_outToMEMTop_rWDataO; // @[MEMTop.scala 16:21]
  DbtMEMWB d ( // @[MEMTop.scala 15:19]
    .clock(d_clock),
    .reset(d_reset),
    .io_inFromMEM_rWAddrO(d_io_inFromMEM_rWAddrO),
    .io_inFromMEM_rWEnO(d_io_inFromMEM_rWEnO),
    .io_inFromMEM_rWDataO(d_io_inFromMEM_rWDataO),
    .io_outToWB_rWAddrO(d_io_outToWB_rWAddrO),
    .io_outToWB_rWEnO(d_io_outToWB_rWEnO),
    .io_outToWB_rWDataO(d_io_outToWB_rWDataO)
  );
  MEM mem ( // @[MEMTop.scala 16:21]
    .io_inFromD_rWAddrO(mem_io_inFromD_rWAddrO),
    .io_inFromD_rWEnO(mem_io_inFromD_rWEnO),
    .io_inFromD_rWDataO(mem_io_inFromD_rWDataO),
    .io_outToD_rWAddrO(mem_io_outToD_rWAddrO),
    .io_outToD_rWEnO(mem_io_outToD_rWEnO),
    .io_outToD_rWDataO(mem_io_outToD_rWDataO),
    .io_outToMEMTop_rWAddrO(mem_io_outToMEMTop_rWAddrO),
    .io_outToMEMTop_rWEnO(mem_io_outToMEMTop_rWEnO),
    .io_outToMEMTop_rWDataO(mem_io_outToMEMTop_rWDataO)
  );
  assign io_outToWB_rWAddrO = d_io_outToWB_rWAddrO; // @[MEMTop.scala 21:16]
  assign io_outToWB_rWEnO = d_io_outToWB_rWEnO; // @[MEMTop.scala 21:16]
  assign io_outToWB_rWDataO = d_io_outToWB_rWDataO; // @[MEMTop.scala 21:16]
  assign io_out2IDTop_rWAddrO = mem_io_outToMEMTop_rWAddrO; // @[MEMTop.scala 19:18]
  assign io_out2IDTop_rWEnO = mem_io_outToMEMTop_rWEnO; // @[MEMTop.scala 19:18]
  assign io_out2IDTop_rWDataO = mem_io_outToMEMTop_rWDataO; // @[MEMTop.scala 19:18]
  assign d_clock = clock;
  assign d_reset = reset;
  assign d_io_inFromMEM_rWAddrO = mem_io_outToD_rWAddrO; // @[MEMTop.scala 20:19]
  assign d_io_inFromMEM_rWEnO = mem_io_outToD_rWEnO; // @[MEMTop.scala 20:19]
  assign d_io_inFromMEM_rWDataO = mem_io_outToD_rWDataO; // @[MEMTop.scala 20:19]
  assign mem_io_inFromD_rWAddrO = io_inFromEX_rWAddrO; // @[MEMTop.scala 18:20]
  assign mem_io_inFromD_rWEnO = io_inFromEX_rWEnO; // @[MEMTop.scala 18:20]
  assign mem_io_inFromD_rWDataO = io_inFromEX_rWDataO; // @[MEMTop.scala 18:20]
endmodule
module WB(
  input  [4:0]  io_inWBTop_rWAddrO,
  input         io_inWBTop_rWEnO,
  input  [31:0] io_inWBTop_rWDataO,
  output [4:0]  io_outWBTop_rWAddrO,
  output        io_outWBTop_rWEnO,
  output [31:0] io_outWBTop_rWDataO
);
  assign io_outWBTop_rWAddrO = io_inWBTop_rWAddrO; // @[WB.scala 13:16]
  assign io_outWBTop_rWEnO = io_inWBTop_rWEnO; // @[WB.scala 13:16]
  assign io_outWBTop_rWDataO = io_inWBTop_rWDataO; // @[WB.scala 13:16]
endmodule
module WBTop(
  input  [4:0]  io_inFromMEM_rWAddrO,
  input         io_inFromMEM_rWEnO,
  input  [31:0] io_inFromMEM_rWDataO,
  output [4:0]  io_outToRF_rWAddrO,
  output        io_outToRF_rWEnO,
  output [31:0] io_outToRF_rWDataO
);
  wire [4:0] wb_io_inWBTop_rWAddrO; // @[WBTop.scala 14:20]
  wire  wb_io_inWBTop_rWEnO; // @[WBTop.scala 14:20]
  wire [31:0] wb_io_inWBTop_rWDataO; // @[WBTop.scala 14:20]
  wire [4:0] wb_io_outWBTop_rWAddrO; // @[WBTop.scala 14:20]
  wire  wb_io_outWBTop_rWEnO; // @[WBTop.scala 14:20]
  wire [31:0] wb_io_outWBTop_rWDataO; // @[WBTop.scala 14:20]
  WB wb ( // @[WBTop.scala 14:20]
    .io_inWBTop_rWAddrO(wb_io_inWBTop_rWAddrO),
    .io_inWBTop_rWEnO(wb_io_inWBTop_rWEnO),
    .io_inWBTop_rWDataO(wb_io_inWBTop_rWDataO),
    .io_outWBTop_rWAddrO(wb_io_outWBTop_rWAddrO),
    .io_outWBTop_rWEnO(wb_io_outWBTop_rWEnO),
    .io_outWBTop_rWDataO(wb_io_outWBTop_rWDataO)
  );
  assign io_outToRF_rWAddrO = wb_io_outWBTop_rWAddrO; // @[WBTop.scala 16:20]
  assign io_outToRF_rWEnO = wb_io_outWBTop_rWEnO; // @[WBTop.scala 16:20]
  assign io_outToRF_rWDataO = wb_io_outWBTop_rWDataO; // @[WBTop.scala 16:20]
  assign wb_io_inWBTop_rWAddrO = io_inFromMEM_rWAddrO; // @[WBTop.scala 15:19]
  assign wb_io_inWBTop_rWEnO = io_inFromMEM_rWEnO; // @[WBTop.scala 15:19]
  assign wb_io_inWBTop_rWDataO = io_inFromMEM_rWDataO; // @[WBTop.scala 15:19]
endmodule
module Top(
  input         clock,
  input         reset,
  output [31:0] io_out_fromIDTop_fromRF_r1Out,
  output [31:0] io_out_fromIDTop_fromRF_r2Out,
  output [31:0] io_out_fromIDTop_fromRF_r3Out,
  output [31:0] io_out_fromIDTop_fromRF_r4Out,
  output [31:0] io_out_fromIDTop_fromRF_r5Out,
  output [31:0] io_out_fromIDTop_fromRF_r6Out,
  output [31:0] io_out_fromIDTop_fromRF_r7Out,
  output [31:0] io_out_fromIDTop_fromRF_r8Out,
  output [31:0] io_out_fromIDTop_fromRF_r9Out,
  output [31:0] io_out_fromIDTop_fromRF_r10Out,
  output [31:0] io_out_fromIDTop_fromRF_r11Out,
  output [31:0] io_out_fromIDTop_fromRF_r12Out,
  output [31:0] io_out_fromIDTop_fromRF_r13Out,
  output [31:0] io_out_fromIDTop_fromRF_r14Out,
  output [31:0] io_out_fromIDTop_fromRF_r15Out,
  output [31:0] io_out_fromIDTop_fromRF_r16Out,
  output [31:0] io_out_fromIDTop_fromRF_r17Out,
  output [31:0] io_out_fromIDTop_fromRF_r18Out,
  output [31:0] io_out_fromIDTop_fromRF_r19Out,
  output [31:0] io_out_fromIDTop_fromRF_r20Out,
  output [31:0] io_out_fromIDTop_fromRF_r21Out,
  output [31:0] io_out_fromIDTop_fromRF_r22Out,
  output [31:0] io_out_fromIDTop_fromRF_r23Out,
  output [31:0] io_out_fromIDTop_fromRF_r24Out,
  output [31:0] io_out_fromIDTop_fromRF_r25Out,
  output [31:0] io_out_fromIDTop_fromRF_r26Out,
  output [31:0] io_out_fromIDTop_fromRF_r27Out,
  output [31:0] io_out_fromIDTop_fromRF_r28Out,
  output [31:0] io_out_fromIDTop_fromRF_r29Out,
  output [31:0] io_out_fromIDTop_fromRF_r30Out,
  output [31:0] io_out_fromIDTop_fromRF_r31Out
);
  wire  ifTop_clock; // @[Top.scala 22:23]
  wire  ifTop_reset; // @[Top.scala 22:23]
  wire [31:0] ifTop_io_outToID_iRRdDt; // @[Top.scala 22:23]
  wire  idTop_clock; // @[Top.scala 23:23]
  wire  idTop_reset; // @[Top.scala 23:23]
  wire [31:0] idTop_io_inFromIF_iRRdDt; // @[Top.scala 23:23]
  wire [4:0] idTop_io_inFromWB_rWAddrO; // @[Top.scala 23:23]
  wire  idTop_io_inFromWB_rWEnO; // @[Top.scala 23:23]
  wire [31:0] idTop_io_inFromWB_rWDataO; // @[Top.scala 23:23]
  wire [4:0] idTop_io_inFromEX_rWAddrO; // @[Top.scala 23:23]
  wire  idTop_io_inFromEX_rWEnO; // @[Top.scala 23:23]
  wire [31:0] idTop_io_inFromEX_rWDataO; // @[Top.scala 23:23]
  wire [4:0] idTop_io_inFromMEM_rWAddrO; // @[Top.scala 23:23]
  wire  idTop_io_inFromMEM_rWEnO; // @[Top.scala 23:23]
  wire [31:0] idTop_io_inFromMEM_rWDataO; // @[Top.scala 23:23]
  wire [31:0] idTop_io_outToTop_fromRF_r1Out; // @[Top.scala 23:23]
  wire [31:0] idTop_io_outToTop_fromRF_r2Out; // @[Top.scala 23:23]
  wire [31:0] idTop_io_outToTop_fromRF_r3Out; // @[Top.scala 23:23]
  wire [31:0] idTop_io_outToTop_fromRF_r4Out; // @[Top.scala 23:23]
  wire [31:0] idTop_io_outToTop_fromRF_r5Out; // @[Top.scala 23:23]
  wire [31:0] idTop_io_outToTop_fromRF_r6Out; // @[Top.scala 23:23]
  wire [31:0] idTop_io_outToTop_fromRF_r7Out; // @[Top.scala 23:23]
  wire [31:0] idTop_io_outToTop_fromRF_r8Out; // @[Top.scala 23:23]
  wire [31:0] idTop_io_outToTop_fromRF_r9Out; // @[Top.scala 23:23]
  wire [31:0] idTop_io_outToTop_fromRF_r10Out; // @[Top.scala 23:23]
  wire [31:0] idTop_io_outToTop_fromRF_r11Out; // @[Top.scala 23:23]
  wire [31:0] idTop_io_outToTop_fromRF_r12Out; // @[Top.scala 23:23]
  wire [31:0] idTop_io_outToTop_fromRF_r13Out; // @[Top.scala 23:23]
  wire [31:0] idTop_io_outToTop_fromRF_r14Out; // @[Top.scala 23:23]
  wire [31:0] idTop_io_outToTop_fromRF_r15Out; // @[Top.scala 23:23]
  wire [31:0] idTop_io_outToTop_fromRF_r16Out; // @[Top.scala 23:23]
  wire [31:0] idTop_io_outToTop_fromRF_r17Out; // @[Top.scala 23:23]
  wire [31:0] idTop_io_outToTop_fromRF_r18Out; // @[Top.scala 23:23]
  wire [31:0] idTop_io_outToTop_fromRF_r19Out; // @[Top.scala 23:23]
  wire [31:0] idTop_io_outToTop_fromRF_r20Out; // @[Top.scala 23:23]
  wire [31:0] idTop_io_outToTop_fromRF_r21Out; // @[Top.scala 23:23]
  wire [31:0] idTop_io_outToTop_fromRF_r22Out; // @[Top.scala 23:23]
  wire [31:0] idTop_io_outToTop_fromRF_r23Out; // @[Top.scala 23:23]
  wire [31:0] idTop_io_outToTop_fromRF_r24Out; // @[Top.scala 23:23]
  wire [31:0] idTop_io_outToTop_fromRF_r25Out; // @[Top.scala 23:23]
  wire [31:0] idTop_io_outToTop_fromRF_r26Out; // @[Top.scala 23:23]
  wire [31:0] idTop_io_outToTop_fromRF_r27Out; // @[Top.scala 23:23]
  wire [31:0] idTop_io_outToTop_fromRF_r28Out; // @[Top.scala 23:23]
  wire [31:0] idTop_io_outToTop_fromRF_r29Out; // @[Top.scala 23:23]
  wire [31:0] idTop_io_outToTop_fromRF_r30Out; // @[Top.scala 23:23]
  wire [31:0] idTop_io_outToTop_fromRF_r31Out; // @[Top.scala 23:23]
  wire [7:0] idTop_io_outToEX_iSK; // @[Top.scala 23:23]
  wire [2:0] idTop_io_outToEX_iK; // @[Top.scala 23:23]
  wire [31:0] idTop_io_outToEX_source1; // @[Top.scala 23:23]
  wire [31:0] idTop_io_outToEX_source2; // @[Top.scala 23:23]
  wire [4:0] idTop_io_outToEX_rWAddr; // @[Top.scala 23:23]
  wire  idTop_io_outToEX_rWEn; // @[Top.scala 23:23]
  wire  exTop_clock; // @[Top.scala 24:23]
  wire [7:0] exTop_io_inFromID_iSK; // @[Top.scala 24:23]
  wire [2:0] exTop_io_inFromID_iK; // @[Top.scala 24:23]
  wire [31:0] exTop_io_inFromID_source1; // @[Top.scala 24:23]
  wire [31:0] exTop_io_inFromID_source2; // @[Top.scala 24:23]
  wire [4:0] exTop_io_inFromID_rWAddr; // @[Top.scala 24:23]
  wire  exTop_io_inFromID_rWEn; // @[Top.scala 24:23]
  wire [4:0] exTop_io_outToMEM_rWAddrO; // @[Top.scala 24:23]
  wire  exTop_io_outToMEM_rWEnO; // @[Top.scala 24:23]
  wire [31:0] exTop_io_outToMEM_rWDataO; // @[Top.scala 24:23]
  wire [4:0] exTop_io_outToID_rWAddrO; // @[Top.scala 24:23]
  wire  exTop_io_outToID_rWEnO; // @[Top.scala 24:23]
  wire [31:0] exTop_io_outToID_rWDataO; // @[Top.scala 24:23]
  wire  memTop_clock; // @[Top.scala 25:24]
  wire  memTop_reset; // @[Top.scala 25:24]
  wire [4:0] memTop_io_inFromEX_rWAddrO; // @[Top.scala 25:24]
  wire  memTop_io_inFromEX_rWEnO; // @[Top.scala 25:24]
  wire [31:0] memTop_io_inFromEX_rWDataO; // @[Top.scala 25:24]
  wire [4:0] memTop_io_outToWB_rWAddrO; // @[Top.scala 25:24]
  wire  memTop_io_outToWB_rWEnO; // @[Top.scala 25:24]
  wire [31:0] memTop_io_outToWB_rWDataO; // @[Top.scala 25:24]
  wire [4:0] memTop_io_out2IDTop_rWAddrO; // @[Top.scala 25:24]
  wire  memTop_io_out2IDTop_rWEnO; // @[Top.scala 25:24]
  wire [31:0] memTop_io_out2IDTop_rWDataO; // @[Top.scala 25:24]
  wire [4:0] wbTop_io_inFromMEM_rWAddrO; // @[Top.scala 26:23]
  wire  wbTop_io_inFromMEM_rWEnO; // @[Top.scala 26:23]
  wire [31:0] wbTop_io_inFromMEM_rWDataO; // @[Top.scala 26:23]
  wire [4:0] wbTop_io_outToRF_rWAddrO; // @[Top.scala 26:23]
  wire  wbTop_io_outToRF_rWEnO; // @[Top.scala 26:23]
  wire [31:0] wbTop_io_outToRF_rWDataO; // @[Top.scala 26:23]
  IFTop ifTop ( // @[Top.scala 22:23]
    .clock(ifTop_clock),
    .reset(ifTop_reset),
    .io_outToID_iRRdDt(ifTop_io_outToID_iRRdDt)
  );
  IDTop idTop ( // @[Top.scala 23:23]
    .clock(idTop_clock),
    .reset(idTop_reset),
    .io_inFromIF_iRRdDt(idTop_io_inFromIF_iRRdDt),
    .io_inFromWB_rWAddrO(idTop_io_inFromWB_rWAddrO),
    .io_inFromWB_rWEnO(idTop_io_inFromWB_rWEnO),
    .io_inFromWB_rWDataO(idTop_io_inFromWB_rWDataO),
    .io_inFromEX_rWAddrO(idTop_io_inFromEX_rWAddrO),
    .io_inFromEX_rWEnO(idTop_io_inFromEX_rWEnO),
    .io_inFromEX_rWDataO(idTop_io_inFromEX_rWDataO),
    .io_inFromMEM_rWAddrO(idTop_io_inFromMEM_rWAddrO),
    .io_inFromMEM_rWEnO(idTop_io_inFromMEM_rWEnO),
    .io_inFromMEM_rWDataO(idTop_io_inFromMEM_rWDataO),
    .io_outToTop_fromRF_r1Out(idTop_io_outToTop_fromRF_r1Out),
    .io_outToTop_fromRF_r2Out(idTop_io_outToTop_fromRF_r2Out),
    .io_outToTop_fromRF_r3Out(idTop_io_outToTop_fromRF_r3Out),
    .io_outToTop_fromRF_r4Out(idTop_io_outToTop_fromRF_r4Out),
    .io_outToTop_fromRF_r5Out(idTop_io_outToTop_fromRF_r5Out),
    .io_outToTop_fromRF_r6Out(idTop_io_outToTop_fromRF_r6Out),
    .io_outToTop_fromRF_r7Out(idTop_io_outToTop_fromRF_r7Out),
    .io_outToTop_fromRF_r8Out(idTop_io_outToTop_fromRF_r8Out),
    .io_outToTop_fromRF_r9Out(idTop_io_outToTop_fromRF_r9Out),
    .io_outToTop_fromRF_r10Out(idTop_io_outToTop_fromRF_r10Out),
    .io_outToTop_fromRF_r11Out(idTop_io_outToTop_fromRF_r11Out),
    .io_outToTop_fromRF_r12Out(idTop_io_outToTop_fromRF_r12Out),
    .io_outToTop_fromRF_r13Out(idTop_io_outToTop_fromRF_r13Out),
    .io_outToTop_fromRF_r14Out(idTop_io_outToTop_fromRF_r14Out),
    .io_outToTop_fromRF_r15Out(idTop_io_outToTop_fromRF_r15Out),
    .io_outToTop_fromRF_r16Out(idTop_io_outToTop_fromRF_r16Out),
    .io_outToTop_fromRF_r17Out(idTop_io_outToTop_fromRF_r17Out),
    .io_outToTop_fromRF_r18Out(idTop_io_outToTop_fromRF_r18Out),
    .io_outToTop_fromRF_r19Out(idTop_io_outToTop_fromRF_r19Out),
    .io_outToTop_fromRF_r20Out(idTop_io_outToTop_fromRF_r20Out),
    .io_outToTop_fromRF_r21Out(idTop_io_outToTop_fromRF_r21Out),
    .io_outToTop_fromRF_r22Out(idTop_io_outToTop_fromRF_r22Out),
    .io_outToTop_fromRF_r23Out(idTop_io_outToTop_fromRF_r23Out),
    .io_outToTop_fromRF_r24Out(idTop_io_outToTop_fromRF_r24Out),
    .io_outToTop_fromRF_r25Out(idTop_io_outToTop_fromRF_r25Out),
    .io_outToTop_fromRF_r26Out(idTop_io_outToTop_fromRF_r26Out),
    .io_outToTop_fromRF_r27Out(idTop_io_outToTop_fromRF_r27Out),
    .io_outToTop_fromRF_r28Out(idTop_io_outToTop_fromRF_r28Out),
    .io_outToTop_fromRF_r29Out(idTop_io_outToTop_fromRF_r29Out),
    .io_outToTop_fromRF_r30Out(idTop_io_outToTop_fromRF_r30Out),
    .io_outToTop_fromRF_r31Out(idTop_io_outToTop_fromRF_r31Out),
    .io_outToEX_iSK(idTop_io_outToEX_iSK),
    .io_outToEX_iK(idTop_io_outToEX_iK),
    .io_outToEX_source1(idTop_io_outToEX_source1),
    .io_outToEX_source2(idTop_io_outToEX_source2),
    .io_outToEX_rWAddr(idTop_io_outToEX_rWAddr),
    .io_outToEX_rWEn(idTop_io_outToEX_rWEn)
  );
  EXTop exTop ( // @[Top.scala 24:23]
    .clock(exTop_clock),
    .io_inFromID_iSK(exTop_io_inFromID_iSK),
    .io_inFromID_iK(exTop_io_inFromID_iK),
    .io_inFromID_source1(exTop_io_inFromID_source1),
    .io_inFromID_source2(exTop_io_inFromID_source2),
    .io_inFromID_rWAddr(exTop_io_inFromID_rWAddr),
    .io_inFromID_rWEn(exTop_io_inFromID_rWEn),
    .io_outToMEM_rWAddrO(exTop_io_outToMEM_rWAddrO),
    .io_outToMEM_rWEnO(exTop_io_outToMEM_rWEnO),
    .io_outToMEM_rWDataO(exTop_io_outToMEM_rWDataO),
    .io_outToID_rWAddrO(exTop_io_outToID_rWAddrO),
    .io_outToID_rWEnO(exTop_io_outToID_rWEnO),
    .io_outToID_rWDataO(exTop_io_outToID_rWDataO)
  );
  MEMTop memTop ( // @[Top.scala 25:24]
    .clock(memTop_clock),
    .reset(memTop_reset),
    .io_inFromEX_rWAddrO(memTop_io_inFromEX_rWAddrO),
    .io_inFromEX_rWEnO(memTop_io_inFromEX_rWEnO),
    .io_inFromEX_rWDataO(memTop_io_inFromEX_rWDataO),
    .io_outToWB_rWAddrO(memTop_io_outToWB_rWAddrO),
    .io_outToWB_rWEnO(memTop_io_outToWB_rWEnO),
    .io_outToWB_rWDataO(memTop_io_outToWB_rWDataO),
    .io_out2IDTop_rWAddrO(memTop_io_out2IDTop_rWAddrO),
    .io_out2IDTop_rWEnO(memTop_io_out2IDTop_rWEnO),
    .io_out2IDTop_rWDataO(memTop_io_out2IDTop_rWDataO)
  );
  WBTop wbTop ( // @[Top.scala 26:23]
    .io_inFromMEM_rWAddrO(wbTop_io_inFromMEM_rWAddrO),
    .io_inFromMEM_rWEnO(wbTop_io_inFromMEM_rWEnO),
    .io_inFromMEM_rWDataO(wbTop_io_inFromMEM_rWDataO),
    .io_outToRF_rWAddrO(wbTop_io_outToRF_rWAddrO),
    .io_outToRF_rWEnO(wbTop_io_outToRF_rWEnO),
    .io_outToRF_rWDataO(wbTop_io_outToRF_rWDataO)
  );
  assign io_out_fromIDTop_fromRF_r1Out = idTop_io_outToTop_fromRF_r1Out; // @[Top.scala 37:29]
  assign io_out_fromIDTop_fromRF_r2Out = idTop_io_outToTop_fromRF_r2Out; // @[Top.scala 37:29]
  assign io_out_fromIDTop_fromRF_r3Out = idTop_io_outToTop_fromRF_r3Out; // @[Top.scala 37:29]
  assign io_out_fromIDTop_fromRF_r4Out = idTop_io_outToTop_fromRF_r4Out; // @[Top.scala 37:29]
  assign io_out_fromIDTop_fromRF_r5Out = idTop_io_outToTop_fromRF_r5Out; // @[Top.scala 37:29]
  assign io_out_fromIDTop_fromRF_r6Out = idTop_io_outToTop_fromRF_r6Out; // @[Top.scala 37:29]
  assign io_out_fromIDTop_fromRF_r7Out = idTop_io_outToTop_fromRF_r7Out; // @[Top.scala 37:29]
  assign io_out_fromIDTop_fromRF_r8Out = idTop_io_outToTop_fromRF_r8Out; // @[Top.scala 37:29]
  assign io_out_fromIDTop_fromRF_r9Out = idTop_io_outToTop_fromRF_r9Out; // @[Top.scala 37:29]
  assign io_out_fromIDTop_fromRF_r10Out = idTop_io_outToTop_fromRF_r10Out; // @[Top.scala 37:29]
  assign io_out_fromIDTop_fromRF_r11Out = idTop_io_outToTop_fromRF_r11Out; // @[Top.scala 37:29]
  assign io_out_fromIDTop_fromRF_r12Out = idTop_io_outToTop_fromRF_r12Out; // @[Top.scala 37:29]
  assign io_out_fromIDTop_fromRF_r13Out = idTop_io_outToTop_fromRF_r13Out; // @[Top.scala 37:29]
  assign io_out_fromIDTop_fromRF_r14Out = idTop_io_outToTop_fromRF_r14Out; // @[Top.scala 37:29]
  assign io_out_fromIDTop_fromRF_r15Out = idTop_io_outToTop_fromRF_r15Out; // @[Top.scala 37:29]
  assign io_out_fromIDTop_fromRF_r16Out = idTop_io_outToTop_fromRF_r16Out; // @[Top.scala 37:29]
  assign io_out_fromIDTop_fromRF_r17Out = idTop_io_outToTop_fromRF_r17Out; // @[Top.scala 37:29]
  assign io_out_fromIDTop_fromRF_r18Out = idTop_io_outToTop_fromRF_r18Out; // @[Top.scala 37:29]
  assign io_out_fromIDTop_fromRF_r19Out = idTop_io_outToTop_fromRF_r19Out; // @[Top.scala 37:29]
  assign io_out_fromIDTop_fromRF_r20Out = idTop_io_outToTop_fromRF_r20Out; // @[Top.scala 37:29]
  assign io_out_fromIDTop_fromRF_r21Out = idTop_io_outToTop_fromRF_r21Out; // @[Top.scala 37:29]
  assign io_out_fromIDTop_fromRF_r22Out = idTop_io_outToTop_fromRF_r22Out; // @[Top.scala 37:29]
  assign io_out_fromIDTop_fromRF_r23Out = idTop_io_outToTop_fromRF_r23Out; // @[Top.scala 37:29]
  assign io_out_fromIDTop_fromRF_r24Out = idTop_io_outToTop_fromRF_r24Out; // @[Top.scala 37:29]
  assign io_out_fromIDTop_fromRF_r25Out = idTop_io_outToTop_fromRF_r25Out; // @[Top.scala 37:29]
  assign io_out_fromIDTop_fromRF_r26Out = idTop_io_outToTop_fromRF_r26Out; // @[Top.scala 37:29]
  assign io_out_fromIDTop_fromRF_r27Out = idTop_io_outToTop_fromRF_r27Out; // @[Top.scala 37:29]
  assign io_out_fromIDTop_fromRF_r28Out = idTop_io_outToTop_fromRF_r28Out; // @[Top.scala 37:29]
  assign io_out_fromIDTop_fromRF_r29Out = idTop_io_outToTop_fromRF_r29Out; // @[Top.scala 37:29]
  assign io_out_fromIDTop_fromRF_r30Out = idTop_io_outToTop_fromRF_r30Out; // @[Top.scala 37:29]
  assign io_out_fromIDTop_fromRF_r31Out = idTop_io_outToTop_fromRF_r31Out; // @[Top.scala 37:29]
  assign ifTop_clock = clock;
  assign ifTop_reset = reset;
  assign idTop_clock = clock;
  assign idTop_reset = reset;
  assign idTop_io_inFromIF_iRRdDt = ifTop_io_outToID_iRRdDt; // @[Top.scala 28:23]
  assign idTop_io_inFromWB_rWAddrO = wbTop_io_outToRF_rWAddrO; // @[Top.scala 32:23]
  assign idTop_io_inFromWB_rWEnO = wbTop_io_outToRF_rWEnO; // @[Top.scala 32:23]
  assign idTop_io_inFromWB_rWDataO = wbTop_io_outToRF_rWDataO; // @[Top.scala 32:23]
  assign idTop_io_inFromEX_rWAddrO = exTop_io_outToID_rWAddrO; // @[Top.scala 34:22]
  assign idTop_io_inFromEX_rWEnO = exTop_io_outToID_rWEnO; // @[Top.scala 34:22]
  assign idTop_io_inFromEX_rWDataO = exTop_io_outToID_rWDataO; // @[Top.scala 34:22]
  assign idTop_io_inFromMEM_rWAddrO = memTop_io_out2IDTop_rWAddrO; // @[Top.scala 35:25]
  assign idTop_io_inFromMEM_rWEnO = memTop_io_out2IDTop_rWEnO; // @[Top.scala 35:25]
  assign idTop_io_inFromMEM_rWDataO = memTop_io_out2IDTop_rWDataO; // @[Top.scala 35:25]
  assign exTop_clock = clock;
  assign exTop_io_inFromID_iSK = idTop_io_outToEX_iSK; // @[Top.scala 29:22]
  assign exTop_io_inFromID_iK = idTop_io_outToEX_iK; // @[Top.scala 29:22]
  assign exTop_io_inFromID_source1 = idTop_io_outToEX_source1; // @[Top.scala 29:22]
  assign exTop_io_inFromID_source2 = idTop_io_outToEX_source2; // @[Top.scala 29:22]
  assign exTop_io_inFromID_rWAddr = idTop_io_outToEX_rWAddr; // @[Top.scala 29:22]
  assign exTop_io_inFromID_rWEn = idTop_io_outToEX_rWEn; // @[Top.scala 29:22]
  assign memTop_clock = clock;
  assign memTop_reset = reset;
  assign memTop_io_inFromEX_rWAddrO = exTop_io_outToMEM_rWAddrO; // @[Top.scala 30:24]
  assign memTop_io_inFromEX_rWEnO = exTop_io_outToMEM_rWEnO; // @[Top.scala 30:24]
  assign memTop_io_inFromEX_rWDataO = exTop_io_outToMEM_rWDataO; // @[Top.scala 30:24]
  assign wbTop_io_inFromMEM_rWAddrO = memTop_io_outToWB_rWAddrO; // @[Top.scala 31:24]
  assign wbTop_io_inFromMEM_rWEnO = memTop_io_outToWB_rWEnO; // @[Top.scala 31:24]
  assign wbTop_io_inFromMEM_rWDataO = memTop_io_outToWB_rWDataO; // @[Top.scala 31:24]
endmodule
