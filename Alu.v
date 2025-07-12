`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.06.2025 18:56:43
// Design Name: 
// Module Name: Alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module carry_look_ahead_adder #(parameter n = 4)(
 input [n-1:0] A,B,
 input C_in, 
 output [n-1:0] Sum,
 output C_out);
 wire [n-1:0] P ,G; 
 wire [n-1:0] C;
 assign P = A^B; 
 assign G = A&B;
assign C[0] = G[0] | (P[0] & C_in);
assign C[1] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C_in);
assign C[2] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & C_in);
assign C[3] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & C_in);

assign C_out = C[3] ;
assign Sum[0]=  P[0] ^ C_in;
genvar i; 
generate
for (i = 1;i<n;i = i+1) begin
 assign Sum[i] = P[i] ^ C[i-1];
end
endgenerate
endmodule
module addition(A,B,Sum,C_out);
input [15:0] A,B;
output [15:0] Sum;
output C_out ;
wire [0:3] C;
carry_look_ahead_adder cla1(A[3:0],B[3:0],1'b0,Sum[3:0],C[0]);
carry_look_ahead_adder cla2(A[7:4],B[7:4],C[0],Sum[7:4],C[1]);
carry_look_ahead_adder cla3(A[11:8],B[11:8],C[1],Sum[11:8],C[2]);
carry_look_ahead_adder cla4(A[15:12],B[15:12],C[2],Sum[15:12],C[3]);
assign C_out = C[3];
endmodule    
 
module subtractor(
 input [15:0] A,B,
 output reg [15:0] Result);
 wire [15:0] B_2compliment;
 assign B_2compliment = ~B + 1;
 wire [15:0] Sum;
 wire Carry_out_CLA;
  
 addition add_inst(
   .A(A),
   .B(B_2compliment),
   .Sum(Sum),
   .C_out(Carry_out_CLA));

always @(*) begin
   Result = Sum;
end



endmodule


 module multiplication(
  input signed [15:0] A,B,
  output signed [31:0] Result);
assign Result = A*B;
endmodule 
module restoring_division #(parameter N = 16)(
    input signed [N-1:0] Dividend,
    input signed [N-1:0] Divisor,
    output reg signed [N-1:0] Quotient,
    output reg signed [N-1:0] Remainder
);
    reg [N-1:0] abs_Dividend, abs_Divisor;
    reg [2*N-1:0] Reg;
    reg [N-1:0] D;
    reg sign_Q, sign_R;
    integer i;

    always @(*) begin
        if (Divisor == 0) begin
            Quotient = 0;
            Remainder = 0;
        end else begin
            abs_Dividend = Dividend[N-1] ? -Dividend : Dividend;
            abs_Divisor  = Divisor[N-1] ? -Divisor  : Divisor;
            Reg = { {N{abs_Dividend[N-1]}}, abs_Dividend }; // fixed sign extension
            D = abs_Divisor;

            for (i = 0; i < N; i = i + 1) begin
                Reg = Reg << 1;
                Reg[2*N-1:N] = Reg[2*N-1:N] - D;
                if (Reg[2*N-1]) begin
                    Reg[2*N-1:N] = Reg[2*N-1:N] + D;
                    Reg[0] = 1'b0;
                end else begin
                    Reg[0] = 1'b1;
                end
            end

            sign_Q = Dividend[N-1] ^ Divisor[N-1];
            sign_R = Dividend[N-1];
            Quotient = sign_Q ? -Reg[N-1:0] : Reg[N-1:0];
            Remainder = sign_R ? -Reg[2*N-1:N] : Reg[2*N-1:N];
        end
    end
endmodule


module enhanced_ALU(
  input signed [15:0] A, B,
  input [3:0] operation,
  output reg [31:0] Result,
  output reg [15:0] Remainder,
  output reg C_out,
  output reg Z,N,C,V
);

  wire [15:0] Result1;
  wire C_out1;
  addition add_inst(.A(A), .B(B), .Sum(Result1), .C_out(C_out1));

  wire [15:0] Result2;
  subtractor sub_inst(.A(A), .B(B), .Result(Result2));

  wire [31:0] Result3;
  multiplication mult_inst(.A(A), .B(B), .Result(Result3));

  wire [15:0] Result4;
  wire [15:0] Remainder1;
  restoring_division div_inst(.Dividend(A), .Divisor(B), .Quotient(Result4), .Remainder(Remainder1));

  always @(*) begin
    case (operation)
      4'b0000: begin // ADD
        Result = {{16{Result1[15]}},Result1};
        C_out = C_out1;
        Remainder = 0;
      end

      4'b0001: begin // SUB
        Result = {{16{Result2[15]}},Result2};
        C_out = 0;
        Remainder = 0;
      end

      4'b0010: begin // MULT
        Result = Result3;
        C_out = 0;
        Remainder = 0;
      end

      4'b0011: begin // DIV
        Result = {{16{Result4[15]}},Result4};
        Remainder = Remainder1;
        C_out = 0;
      end

      4'b0100: begin // AND
        Result = A & B;
        C_out = 0;
        Remainder = 0;
      end

      4'b0101: begin // OR
        Result = A | B;
        C_out = 0;
        Remainder = 0;
      end

      4'b0110: begin // NOR
        Result = ~(A | B);
        C_out = 0;
        Remainder = 0;
      end

      4'b0111: begin // NAND
        Result = ~(A & B);
        C_out = 0;
        Remainder = 0;
      end

      4'b1000: begin // XOR
        Result = A ^ B;
        C_out = 0;
        Remainder = 0;
      end

      4'b1001: begin // XNOR
        Result = ~(A ^ B);
        C_out = 0;
        Remainder = 0;
      end

      4'b1010: begin // LEFT SHIFT
        Result = A << 1;
        C_out = 0;
        Remainder = 0;
      end

      4'b1011: begin // RIGHT SHIFT
        Result = A >> 1;
        C_out = 0;
        Remainder = 0;
      end

      default: begin
        Result = 0;
        C_out = 0;
        Remainder = 0;
      end
    endcase
  end
always @(*) begin
  Z = (Result == 0);
  N = Result[31];

  case(operation)
    4'b0000: begin // ADD
      C = C_out1;
      V = (A[15] == B[15]) && (Result[15] != A[15]);
    end
    4'b0001: begin // SUB
      C = (A < B);
      V = (A[15] != B[15]) && (Result[15] != A[15]);
    end
    default: begin
      C = 0;
      V = 0;
    end
  endcase
end
endmodule
