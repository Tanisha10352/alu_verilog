TOPLEVEL_LANG = verilog
SIM = icarus
VERILOG_SOURCES = $(shell pwd)/Alu.v
TOPLEVEL = enhanced_ALU
MODULE = alu
include $(shell cocotb-config --makefiles)/Makefile.sim
