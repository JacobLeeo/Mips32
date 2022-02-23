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
