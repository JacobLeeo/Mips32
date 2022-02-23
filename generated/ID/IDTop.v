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
