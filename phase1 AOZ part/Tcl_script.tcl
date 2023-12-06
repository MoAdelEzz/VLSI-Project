create_clock -period 20 [get_ports clk]
set_input_delay -clock [get_ports clk] 1 [get_ports A]
set_input_delay -clock [get_ports clk] 1 [get_ports B]
set_input_delay -clock [get_ports clk] 1 [get_ports Cin]
set_load 10 [get_ports A]
set_load 10 [get_ports B]
set_load 10 [get_ports Cin]
set_output_delay 0.5 [get_ports Sum]
set_output_delay 0.5 [get_ports Cout]
set_output_delay 0.5 [get_ports Overflow]
set_global_assignment -name RESOURCE_USAGE_TARGET "60"
