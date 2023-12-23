module plus_adder(
  input [31:0] a,  
  input [31:0] b,  
  input cin,    
  output [31:0] sum,  
  output cout,   
  output overflow        
);

  wire [32:0] tempSum;  
  assign tempSum = a + b + cin;

  assign sum = tempSum[31:0];
  assign cout = tempSum[32];
  assign overflow = ((a[31] == b[31]) && (a[31] != sum[31]));

endmodule


