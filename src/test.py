# Copyright 2023 Google LLC.
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

FREQ = 8000

@cocotb.test()
async def test_bytebeat(dut):
    dut._log.info("start")
    clock = Clock(dut.clk, (1.0/FREQ), units="sec")
    cocotb.start_soon(clock.start())

    dut.rst_n.value = 0 # low to reset
    dut.ui_in.value = 0x57  # a=5 b=7
    dut.uio_in.value = 0x3a # c=3 d=10
    await ClockCycles(dut.clk, 1)
    dut.rst_n.value = 1 # take out of reset
    await ClockCycles(dut.clk, 65536)
    dut.rst_n.value = 0 # low to reset
    dut.ui_in.value = 0x36  # a=3 b=6
    dut.uio_in.value = 0x29 # c=2 d=9
    await ClockCycles(dut.clk, 1)
    dut.rst_n.value = 1 # take out of reset
    await ClockCycles(dut.clk, 65536)
