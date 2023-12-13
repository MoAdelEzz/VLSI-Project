
/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : U-2022.12-SP7
// Date      : Tue Dec 12 16:58:51 2023
/////////////////////////////////////////////////////////////


module ripple_carry_adder ( a, b, cin, sum, cout, overflow );
  input [31:0] a;
  input [31:0] b;
  output [31:0] sum;
  input cin;
  output cout, overflow;
  wire   n3, n4;
  wire   [30:0] c;

  full_adder_ripple FA1  ( .a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .cout(c[0]) );
  full_adder_ripple FA  ( .a(a[1]), .b(b[1]), .cin(
        c[0]), .sum(sum[1]), .cout(c[1]) );
  full_adder_ripple FA2  ( .a(a[2]), .b(b[2]), .cin(
        c[1]), .sum(sum[2]), .cout(c[2]) );
  full_adder_ripple FA3  ( .a(a[3]), .b(b[3]), .cin(
        c[2]), .sum(sum[3]), .cout(c[3]) );
  full_adder_ripple FA4  ( .a(a[4]), .b(b[4]), .cin(
        c[3]), .sum(sum[4]), .cout(c[4]) );
  full_adder_ripple FA5  ( .a(a[5]), .b(b[5]), .cin(
        c[4]), .sum(sum[5]), .cout(c[5]) );
  full_adder_ripple FA6  ( .a(a[6]), .b(b[6]), .cin(
        c[5]), .sum(sum[6]), .cout(c[6]) );
  full_adder_ripple FA7  ( .a(a[7]), .b(b[7]), .cin(
        c[6]), .sum(sum[7]), .cout(c[7]) );
  full_adder_ripple FA8  ( .a(a[8]), .b(b[8]), .cin(
        c[7]), .sum(sum[8]), .cout(c[8]) );
  full_adder_ripple FA9  ( .a(a[9]), .b(b[9]), .cin(
        c[8]), .sum(sum[9]), .cout(c[9]) );
  full_adder_ripple FA10  ( .a(a[10]), .b(b[10]), 
        .cin(c[9]), .sum(sum[10]), .cout(c[10]) );
  full_adder_ripple FA11  ( .a(a[11]), .b(b[11]), 
        .cin(c[10]), .sum(sum[11]), .cout(c[11]) );
  full_adder_ripple FA12  ( .a(a[12]), .b(b[12]), 
        .cin(c[11]), .sum(sum[12]), .cout(c[12]) );
  full_adder_ripple FA13  ( .a(a[13]), .b(b[13]), 
        .cin(c[12]), .sum(sum[13]), .cout(c[13]) );
  full_adder_ripple FA14  ( .a(a[14]), .b(b[14]), 
        .cin(c[13]), .sum(sum[14]), .cout(c[14]) );
  full_adder_ripple FA15  ( .a(a[15]), .b(b[15]), 
        .cin(c[14]), .sum(sum[15]), .cout(c[15]) );
  full_adder_ripple FA16  ( .a(a[16]), .b(b[16]), 
        .cin(c[15]), .sum(sum[16]), .cout(c[16]) );
  full_adder_ripple FA17  ( .a(a[17]), .b(b[17]), 
        .cin(c[16]), .sum(sum[17]), .cout(c[17]) );
  full_adder_ripple FA18  ( .a(a[18]), .b(b[18]), 
        .cin(c[17]), .sum(sum[18]), .cout(c[18]) );
  full_adder_ripple FA19  ( .a(a[19]), .b(b[19]), 
        .cin(c[18]), .sum(sum[19]), .cout(c[19]) );
  full_adder_ripple FA20  ( .a(a[20]), .b(b[20]), 
        .cin(c[19]), .sum(sum[20]), .cout(c[20]) );
  full_adder_ripple FA21  ( .a(a[21]), .b(b[21]), 
        .cin(c[20]), .sum(sum[21]), .cout(c[21]) );
  full_adder_ripple FA22  ( .a(a[22]), .b(b[22]), 
        .cin(c[21]), .sum(sum[22]), .cout(c[22]) );
  full_adder_ripple FA23  ( .a(a[23]), .b(b[23]), .cin(
        c[22]), .sum(sum[23]), .cout(c[23]) );
  full_adder_ripple FA24  ( .a(a[24]), .b(b[24]), .cin(
        c[23]), .sum(sum[24]), .cout(c[24]) );
  full_adder_ripple FA25  ( .a(a[25]), .b(b[25]), .cin(
        c[24]), .sum(sum[25]), .cout(c[25]) );
  full_adder_ripple FA26  ( .a(a[26]), .b(b[26]), .cin(
        c[25]), .sum(sum[26]), .cout(c[26]) );
  full_adder_ripple FA27  ( .a(a[27]), .b(b[27]), .cin(
        c[26]), .sum(sum[27]), .cout(c[27]) );
  full_adder_ripple FA28  ( .a(a[28]), .b(b[28]), .cin(
        c[27]), .sum(sum[28]), .cout(c[28]) );
  full_adder_ripple FA29  ( .a(a[29]), .b(b[29]), .cin(
        c[28]), .sum(sum[29]), .cout(c[29]) );
  full_adder_ripple FA30  ( .a(a[30]), .b(b[30]), .cin(
        c[29]), .sum(sum[30]), .cout(c[30]) );
  full_adder_ripple FA31  ( .a(a[31]), .b(b[31]), .cin(
        c[30]), .sum(sum[31]), .cout(cout) );
  NOR2X0 U4 ( .IN1(n3), .IN2(n4), .QN(overflow) );
  XOR2X1 U5 ( .IN1(b[31]), .IN2(a[31]), .Q(n4) );
  XNOR2X1 U6 ( .IN1(a[31]), .IN2(sum[31]), .Q(n3) );
endmodule


/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : U-2022.12-SP7
// Date      : Tue Dec 12 16:59:15 2023
/////////////////////////////////////////////////////////////


module full_adder_ripple ( a, b, cin, sum, cout );
  input a, b, cin;
  output sum, cout;
  wire   n2;

  XOR2X1 U4 ( .IN1(cin), .IN2(n2), .Q(sum) );
  AO22X1 U5 ( .IN1(a), .IN2(b), .IN3(cin), .IN4(n2), .Q(cout) );
  XOR2X1 U6 ( .IN1(a), .IN2(b), .Q(n2) );
endmodule
