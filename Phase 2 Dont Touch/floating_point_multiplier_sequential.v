
module floating_point_multiplier_sequential ( 
    input [31:0] a,
    input [31:0] b,
    output [63:0] result,
    output overflow,
    input wire clk,  
    input wire rst
);

  reg [31:0] reg_a;  
  reg [31:0] reg_b;  
  wire [63:0] temp_result;  
  wire temp_overflow;  

  reg [31:0] counter;  
  reg slow_clk;  
  reg [63:0] req_result;
  reg req_overflow;



  assign result = req_result;
  assign overflow = req_overflow;

  always @(posedge slow_clk or posedge rst) begin
    if (rst) begin
      reg_a <= 32'h0;
      reg_b <= 32'h0;
    end else begin
      reg_a <= a;
      reg_b <= b;
    end
  end

  floating_point_multiplier mult (.a(reg_a),.b(reg_b),.result(temp_result),.overflow(temp_overflow));

  always @(posedge slow_clk or posedge rst) begin
    if (rst) begin
      req_result <= 64'h0;
      req_overflow <= 1'b0;
    end else begin
      req_result <= temp_result;
      req_overflow <= temp_overflow;
    end
  end

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      counter <= 32'h1;
      slow_clk <= 1'b0;
    end else begin
      if (counter[1] == 1'b1) begin
        counter <= 32'h1;
        slow_clk <= ~slow_clk; 
      end else begin
        counter[31:0] <= {counter[30:0],1'b0};
      end
    end
  end

endmodule





