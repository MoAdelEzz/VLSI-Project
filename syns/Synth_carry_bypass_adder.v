
/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : U-2022.12-SP7
// Date      : Tue Dec 12 16:49:04 2023
/////////////////////////////////////////////////////////////


module carry_bypass_adder ( a, b, cin, sum, cout, overflow );
  input [31:0] a;
  input [31:0] b;
  output [31:0] sum;
  input cin;
  output cout, overflow;
  wire   n3, n4;
  wire   [7:0] c;
  wire   [7:0] bp;
  wire   [6:0] cp;

  ripple_carry_adder_bypass rcab1  ( .a(a[3:0]), .b(b[3:0]), 
        .cin(cin), .sum(sum[3:0]), .cout(c[0]), .bypass(bp[0]) );
  mux_2x1 mx1  ( .zero(c[0]), .one(cin), .sel(bp[0]), .out(
        cp[0]) );
  ripple_carry_adder_bypass rcab2  ( .a(a[7:4]), .b(b[7:4]), 
        .cin(c[0]), .sum(sum[7:4]), .cout(c[1]), .bypass(bp[1]) );
  mux_2x1 mx2  ( .zero(c[1]), .one(cp[0]), .sel(bp[1]), 
        .out(cp[1]) );
  ripple_carry_adder_bypass rcab3  ( .a(a[11:8]), .b(b[11:8]), .cin(c[1]), .sum(sum[11:8]), .cout(c[2]), .bypass(bp[2]) );
  mux_2x1 mx3  ( .zero(c[2]), .one(cp[1]), .sel(bp[2]), 
        .out(cp[2]) );
  ripple_carry_adder_bypass rcab4  ( .a(a[15:12]), .b(
        b[15:12]), .cin(c[2]), .sum(sum[15:12]), .cout(c[3]), .bypass(bp[3])
         );
  mux_2x1 mx4  ( .zero(c[3]), .one(cp[2]), .sel(bp[3]), 
        .out(cp[3]) );
  ripple_carry_adder_bypass rcab5  ( .a(a[19:16]), .b(
        b[19:16]), .cin(c[3]), .sum(sum[19:16]), .cout(c[4]), .bypass(bp[4])
         );
  mux_2x1 mx5  ( .zero(c[4]), .one(cp[3]), .sel(bp[4]), 
        .out(cp[4]) );
  ripple_carry_adder_bypass rcab6  ( .a(a[23:20]), .b(
        b[23:20]), .cin(c[4]), .sum(sum[23:20]), .cout(c[5]), .bypass(bp[5])
         );
  mux_2x1 mx6  ( .zero(c[5]), .one(cp[4]), .sel(bp[5]), 
        .out(cp[5]) );
  ripple_carry_adder_bypass rcab7  ( .a(a[27:24]), .b(
        b[27:24]), .cin(c[5]), .sum(sum[27:24]), .cout(c[6]), .bypass(bp[6])
         );
  mux_2x1 mx7  ( .zero(c[6]), .one(cp[5]), .sel(bp[6]), 
        .out(cp[6]) );
  ripple_carry_adder_bypass rcab8  ( .a(a[31:28]), .b(
        b[31:28]), .cin(c[6]), .sum(sum[31:28]), .cout(c[7]), .bypass(bp[7])
         );
  mux_2x1 mx8  ( .zero(c[7]), .one(cp[6]), .sel(bp[7]), 
        .out(cout) );
  NOR2X0 U4 ( .IN1(n3), .IN2(n4), .QN(overflow) );
  XOR2X1 U5 ( .IN1(b[31]), .IN2(a[31]), .Q(n4) );
  XNOR2X1 U6 ( .IN1(a[31]), .IN2(sum[31]), .Q(n3) );
endmodule


/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : U-2022.12-SP7
// Date      : Tue Dec 12 16:52:23 2023
/////////////////////////////////////////////////////////////


module full_adder_bypass ( a, b, cin, sum, propagate, cout );
  input a, b, cin;
  output sum, propagate, cout;


  XOR2X1 U4 ( .IN1(cin), .IN2(propagate), .Q(sum) );
  AO22X1 U5 ( .IN1(a), .IN2(b), .IN3(cin), .IN4(propagate), .Q(cout) );
  XOR2X1 U6 ( .IN1(a), .IN2(b), .Q(propagate) );
endmodule


/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : U-2022.12-SP7
// Date      : Tue Dec 12 16:53:10 2023
/////////////////////////////////////////////////////////////


module mux_2x1 ( zero, one, sel, out );
  input zero, one, sel;
  output out;


  MUX21X1 U3 ( .IN1(zero), .IN2(one), .S(sel), .Q(out) );
endmodule

/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : U-2022.12-SP7
// Date      : Tue Dec 12 16:49:26 2023
/////////////////////////////////////////////////////////////


module ripple_carry_adder_bypass ( a, b, cin, sum, cout, bypass );
  input [3:0] a;
  input [3:0] b;
  output [3:0] sum;
  input cin;
  output cout, bypass;

  wire   [3:0] p;
  wire   [2:0] c;

  full_adder_bypass FA_bypass1  ( .a(a[0]), .b(b[0]), .cin(
        cin), .sum(sum[0]), .propagate(p[0]), .cout(c[0]) );
  full_adder_bypass FA_bypass2  ( .a(a[1]), .b(b[1]), .cin(
        c[0]), .sum(sum[1]), .propagate(p[1]), .cout(c[1]) );
  full_adder_bypass FA_bypass3  ( .a(a[2]), .b(b[2]), .cin(
        c[1]), .sum(sum[2]), .propagate(p[2]), .cout(c[2]) );
  full_adder_bypass FA_bypass4  ( .a(a[3]), .b(b[3]), .cin(
        c[2]), .sum(sum[3]), .propagate(p[3]), .cout(cout) );
  AND4X1 U2 ( .IN1(p[3]), .IN2(p[2]), .IN3(p[1]), .IN4(p[0]), .Q(bypass) );
endmodule


