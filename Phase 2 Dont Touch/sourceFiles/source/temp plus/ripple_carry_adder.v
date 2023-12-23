module ripple_carry_adder(
  input [31:0] a,  
  input [31:0] b,  
  input cin,      
  output [31:0] sum,  
  output cout,   
  output overflow        
);

  wire [31:0] c; 
  
  genvar i;
  generate
    for (i = 0; i < 32; i = i + 1) begin : full_adder_ripple
      full_adder_ripple FA(
        .a(a[i]),
        .b(b[i]),
        .cin((i == 0) ? cin : c[i - 1]),
        .sum(sum[i]),
        .cout(c[i])
      );
    end
  endgenerate

  assign cout = c[31];
  assign overflow = (((a[31] == b[31]) && (a[31] != sum[31])) || (1'b0));   

endmodule


module full_adder_ripple(
  input a,   
  input b,    
  input cin,  
  output sum, 
  output cout 
);

  assign sum = a ^ b ^ cin;  
  assign cout = (a & b) | (b & cin) | (a & cin);  

endmodule

