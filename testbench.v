`timescale 1ns / 1ps

module enhanced_ALU_tb;

  reg signed [15:0] A, B;
  reg [3:0] operation;
  wire [31:0] Result;
  wire [15:0] Remainder;
  wire C_out, Z, N, C, V;

  enhanced_ALU uut (
    .A(A),
    .B(B),
    .operation(operation),
    .Result(Result),
    .Remainder(Remainder),
    .C_out(C_out),
    .Z(Z),
    .N(N),
    .C(C),
    .V(V)
  );

  initial begin
    $display("A\tB\tOp\tResult\tRemainder\tZ N C V");

    // ADD tests
    A = 16'sd10; B = 16'sd5; operation = 4'b0000; #10;
    $display("%d\t%d\tADD\t%d\t%d\t\t%b %b %b %b", A, B, Result, Remainder, Z, N, C, V);

    A = -16'sd10; B = 16'sd5; operation = 4'b0000; #10;
    $display("%d\t%d\tADD\t%d\t%d\t\t%b %b %b %b", A, B, Result, Remainder, Z, N, C, V);

    // SUB tests
    A = 16'sd10; B = 16'sd5; operation = 4'b0001; #10;
    $display("%d\t%d\tSUB\t%d\t%d\t\t%b %b %b %b", A, B, Result, Remainder, Z, N, C, V);

    A = 16'sd5; B = 16'sd10; operation = 4'b0001; #10;
    $display("%d\t%d\tSUB\t%d\t%d\t\t%b %b %b %b", A, B, Result, Remainder, Z, N, C, V);

    // MULT tests
    A = 16'sd3; B = -16'sd4; operation = 4'b0010; #10;
    $display("%d\t%d\tMUL\t%d\t%d\t\t%b %b %b %b", A, B, Result, Remainder, Z, N, C, V);

    // DIV tests
    A = -16'sd20; B = 16'sd4; operation = 4'b0011; #10;
    $display("%d\t%d\tDIV\t%d\t%d\t\t%b %b %b %b", A, B, Result, Remainder, Z, N, C, V);

    // Zero result test
    A = 16'sd8; B = -16'sd8; operation = 4'b0000; #10;
    $display("%d\t%d\tADD\t%d\t%d\t\t%b %b %b %b", A, B, Result, Remainder, Z, N, C, V);

    $finish;
  end

endmodule
