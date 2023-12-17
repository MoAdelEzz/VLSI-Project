module tree_multiplier(
    input wire [31:0] A,
    input wire [31:0] B,
    output wire [63:0] P
);
    wire [63:0] temp [63:0];
    wire [63:0] tempResults [123:0];
    wire [31:0] unsignedTempA[63:0];
    wire [63:0] tempA[63:0];
    wire [63:0] tempB;
    genvar i;
    assign tempB = B[31]?{32'b11111111111111111111111111111111,B}:{32'b0,B};
    generate
        for (i = 0; i < 64; i = i + 1) begin : u1
            assign unsignedTempA[i] = tempB[i]?A:32'b0;
            assign tempA[i] = unsignedTempA[i][31]?{32'b11111111111111111111111111111111,unsignedTempA[i]}:{32'b0,unsignedTempA[i]};
            assign temp[i] = tempA[i] << i;
        end
    endgenerate

//level 0
    genvar j;
    generate
        for (j = 0; j < 21; j = j + 1) begin : u2
            shiftAdder sa1(temp[3*j],temp[3*j+1],temp[3*j+2],tempResults[2*j],tempResults[2*j+1]);
        end
    endgenerate

//level 1
    shiftAdder sa2(temp[63],tempResults[0],tempResults[1],tempResults[42],tempResults[43]);
    genvar k;
    generate
        for (k = 0; k < 13; k = k + 1) begin : u3
            shiftAdder sa3(tempResults[3*k+2],tempResults[3*k+3],tempResults[3*k+4],tempResults[2*k+44],tempResults[2*k+45]);
        end
    endgenerate

//level 2
    genvar l;
    generate
        for (l = 0; l < 9; l = l + 1) begin : u4
            shiftAdder sa4(tempResults[3*l+41],tempResults[3*l+42],tempResults[3*l+43],tempResults[2*l+70],tempResults[2*l+71]);
        end
    endgenerate

//level 3
    genvar m;
    generate
        for (m = 0; m < 6; m = m + 1) begin : u5
            shiftAdder sa5(tempResults[3*m+68],tempResults[3*m+69],tempResults[3*m+70],tempResults[2*m+88],tempResults[2*m+89]);
        end
    endgenerate

//level 4
    genvar n;
    generate
        for (n = 0; n < 4; n = n + 1) begin : u6
            shiftAdder sa6(tempResults[3*n+86],tempResults[3*n+87],tempResults[3*n+88],tempResults[2*n+100],tempResults[2*n+101]);
        end
    endgenerate

//level 5
    genvar o;
    generate
        for (o = 0; o < 3; o = o + 1) begin : u7
            shiftAdder sa7(tempResults[3*o+98],tempResults[3*o+99],tempResults[3*o+100],tempResults[2*o+108],tempResults[2*o+109]);
        end
    endgenerate

//level 6
    genvar p;
    generate
        for (p = 0; p < 2; p = p + 1) begin : u8
            shiftAdder sa8(tempResults[3*p+107],tempResults[3*p+108],tempResults[3*p+109],tempResults[2*p+114],tempResults[2*p+115]);
        end
    endgenerate

//finale
    shiftAdder sa7(tempResults[113],tempResults[114],tempResults[115],tempResults[118],tempResults[119]);
    shiftAdder sa8(tempResults[116],tempResults[117],tempResults[118],tempResults[120],tempResults[121]);
    shiftAdder sa9(tempResults[119],tempResults[120],tempResults[121],tempResults[122],tempResults[123]);

// final summation

assign P = tempResults[122]+tempResults[123];
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