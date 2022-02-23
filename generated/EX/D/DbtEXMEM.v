module DbtEXMEM(
  input         clock,
  input         reset,
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
