import cocotb
from cocotb.triggers import Timer
from cocotb.result import TestFailure
from itertools import repeat
import random
@cocotb.test()
async def alu_test(dut):
    def mask(val, bits=16):
     val &= (2**bits - 1)          # keep only the lowest `bits` bits
     if val >= 2**(bits - 1):      # if sign bit is set
        val -= 2**bits            # convert to negative equivalent
     return val

    dut.log.info('STARTING OF SIMULATION')
    for _ in range(50):
     await Timer(1,'ns')
     op = random.randint(0,9)
     a = random.randint(-2**15,2**15-1)
     b = random.randint(-2**15,2**15-1)
     
     if op == 3 and b == 0:
        b = random.randint(1, 2**15 - 1)
     dut.operation.value = op
     dut.A.value = a
     dut.B.value = b
     await Timer(2,'ns')
     result = dut.Result.value.signed_integer
     if op == 0:
        expected = a + b
     elif op == 1:
        expected = a - b
     elif op == 2:
        expected = a * b
     elif op == 3:
        expected = int(a/b)
     elif op == 4:
        expected = a & b
     elif op ==5:
        expected = a | b
     elif op == 6:
        expected = ~(a | b)
     elif op == 7:
        expected = ~(a & b)
     elif op == 8:
        expected = a ^ b
     elif op == 9:
        expected = ~(a ^ b)
     elif op == 10:
        expected = a<<1
     elif op == 11:
        expected = a>>1
     if (op==0 or op==1 or op==3 or op==10 or op==11):
         expected_result = mask(expected,16)
     else:
         expected_result = expected
     if (result == expected_result):
        dut.log.info('result passes')
     else:
        raise TestFailure(f"Test failed | operation: {op} | A={a} | B={b} | expected: {expected} | result: {result}")

        
    
    
        
        
    