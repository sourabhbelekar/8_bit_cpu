create_clock -name SysClk -period 10 -waveform {0 5} [get_ports clk_in]

# Clock signal
set_property PACKAGE_PIN W5 [get_ports clk_in]
set_property IOSTANDARD LVCMOS33 [get_ports clk_in]
set_property PACKAGE_PIN T18 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]

set_property PACKAGE_PIN R2 [get_ports mem_prog]
set_property IOSTANDARD LVCMOS33 [get_ports mem_prog]


set_property PACKAGE_PIN W19 [get_ports ext_mem_clk]
set_property IOSTANDARD LVCMOS33 [get_ports ext_mem_clk]


set_property PACKAGE_PIN T1 [get_ports {ext_mem_addr[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ext_mem_addr[3]}]
set_property PACKAGE_PIN U1 [get_ports {ext_mem_addr[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ext_mem_addr[2]}]
set_property PACKAGE_PIN W2 [get_ports {ext_mem_addr[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ext_mem_addr[1]}]
set_property PACKAGE_PIN R3 [get_ports {ext_mem_addr[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ext_mem_addr[0]}]

set_property PACKAGE_PIN W13 [get_ports {ext_mem_bus[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ext_mem_bus[7]}]
set_property PACKAGE_PIN W14 [get_ports {ext_mem_bus[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ext_mem_bus[6]}]
set_property PACKAGE_PIN V15 [get_ports {ext_mem_bus[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ext_mem_bus[5]}]
set_property PACKAGE_PIN W15 [get_ports {ext_mem_bus[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ext_mem_bus[4]}]
set_property PACKAGE_PIN W17 [get_ports {ext_mem_bus[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ext_mem_bus[3]}]
set_property PACKAGE_PIN W16 [get_ports {ext_mem_bus[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ext_mem_bus[2]}]
set_property PACKAGE_PIN V16 [get_ports {ext_mem_bus[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ext_mem_bus[1]}]
set_property PACKAGE_PIN V17 [get_ports {ext_mem_bus[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ext_mem_bus[0]}]



#seven-segment LED display
set_property PACKAGE_PIN W7 [get_ports {LED_out[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_out[6]}]
set_property PACKAGE_PIN W6 [get_ports {LED_out[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_out[5]}]
set_property PACKAGE_PIN U8 [get_ports {LED_out[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_out[4]}]
set_property PACKAGE_PIN V8 [get_ports {LED_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_out[3]}]
set_property PACKAGE_PIN U5 [get_ports {LED_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_out[2]}]
set_property PACKAGE_PIN V5 [get_ports {LED_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_out[1]}]
set_property PACKAGE_PIN U7 [get_ports {LED_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_out[0]}]
set_property PACKAGE_PIN U2 [get_ports {Anode_Activate[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Anode_Activate[0]}]
set_property PACKAGE_PIN U4 [get_ports {Anode_Activate[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Anode_Activate[1]}]
set_property PACKAGE_PIN V4 [get_ports {Anode_Activate[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Anode_Activate[2]}]
set_property PACKAGE_PIN W4 [get_ports {Anode_Activate[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Anode_Activate[3]}]