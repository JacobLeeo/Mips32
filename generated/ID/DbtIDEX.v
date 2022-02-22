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
