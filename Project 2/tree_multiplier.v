module tree_multiplier(
    input wire [31:0] a,
    input wire [31:0] b,
    output wire [63:0] result
);
    wire [63:0] temp [31:0];
    wire [63:0] tempResults [59:0];
    wire [63:0] unsignedTempA[31:0];
    wire [31:0] tempA;
    wire [31:0] tempB;
    removeSign rs(a,tempA);
    removeSign rs2(b,tempB);
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : u1
            assign unsignedTempA[i] = tempB[i]?tempA:32'b0;
            assign temp[i] = unsignedTempA[i] << i;
        end
    endgenerate

//level 0
    genvar j;
    generate
        for (j = 0; j < 10; j = j + 1) begin : u2
            shiftAdder sa1(temp[3*j],temp[3*j+1],temp[3*j+2],tempResults[2*j],tempResults[2*j+1]);
        end
    endgenerate

//level 1
    shiftAdder sa2(temp[30],temp[31],tempResults[0],tempResults[20],tempResults[21]);
    genvar k;
    generate
        for (k = 0; k < 6; k = k + 1) begin : u3
            shiftAdder sa3(tempResults[3*k+1],tempResults[3*k+2],tempResults[3*k+3],tempResults[2*k+22],tempResults[2*k+23]);
        end
    endgenerate

//level 2
    genvar l;
    generate
        for (l = 0; l < 5; l = l + 1) begin : u4
            shiftAdder sa4(tempResults[3*l+19],tempResults[3*l+20],tempResults[3*l+21],tempResults[2*l+34],tempResults[2*l+35]);
        end
    endgenerate

//level 3
    genvar m;
    generate
        for (m = 0; m < 3; m = m + 1) begin : u5
            shiftAdder sa5(tempResults[3*m+34],tempResults[3*m+35],tempResults[3*m+36],tempResults[2*m+44],tempResults[2*m+45]);
        end
    endgenerate

//level 4
    genvar n;
    generate
        for (n = 0; n < 2; n = n + 1) begin : u6
            shiftAdder sa6(tempResults[3*n+43],tempResults[3*n+44],tempResults[3*n+45],tempResults[2*n+50],tempResults[2*n+51]);
        end
    endgenerate

//finale
    shiftAdder sa7(tempResults[49],tempResults[50],tempResults[51],tempResults[54],tempResults[55]);
    shiftAdder sa8(tempResults[52],tempResults[53],tempResults[54],tempResults[56],tempResults[57]);
    shiftAdder sa9(tempResults[55],tempResults[56],tempResults[57],tempResults[58],tempResults[59]);

// final summation
wire [63:0]unsignedP;
assign unsignedP = tempResults[58]+tempResults[59];

fixSign fs(unsignedP,a[31],b[31],result);

endmodule

module removeSign(a,newA);
    input [31:0] a;
    output [31:0] newA;

    assign newA = a[31]?((a ^ 32'b1111_1111_1111_1111_1111_1111_1111_1111) + 32'b1):a;
endmodule

module fixSign(p,aCheck,bCheck,newP);
    input [63:0] p;
    input aCheck;
    input bCheck;
    output [63:0] newP;

    assign newP = (aCheck ^ bCheck)?((p ^ 64'b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111) + 64'b1):p;
endmodule

module shiftAdder( a,b,c, sum, carry );
    input [63:0] a;
    input [63:0] b;
    input [63:0] c;
    output [63:0] sum;
    output [63:0] carry;

    assign carry[0]=0;
    wire cout;
    fulladder fal (a[63],b[63],c[63],sum[63],cout);
    genvar i;
    generate
    for (i = 0; i < 63; i = i + 1) begin : u1
        fulladder fa (a[i],b[i],c[i],sum[i],carry[i+1]);
    end
    endgenerate
    
endmodule

module fulladder( a,b,cin, sum, carry );
    input a;
    input b;
    input cin;
    output sum;
    output carry;
    
    wire t1,t2,t3;
   xor (sum, a, b, cin);
   and  (t1, a, b);
   and  (t2, b, cin);
   and (t3, a, cin);
   or (carry, t1, t2, t3);
    
endmodule

module halfadder(a,b,sum, carry);
    input a;
    input b;
    output carry;
    output sum;
    
    wire t2,t3,t4,t5;
    and g1(carry,a,b);
    not g3(t2,a);
    not g4(t3,b);
    and g5(t4,t2,b);
    and g6(t5,t3,a);
    or g7(sum,t4,t5);
    
endmodule