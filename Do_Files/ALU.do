vsim -gui work.alu

radix hex

add wave -position end  sim:/alu/aluControl
add wave -position end  sim:/alu/R1
add wave -position end  sim:/alu/R2
add wave -position end  sim:/alu/oldCCR
add wave -position end  sim:/alu/result
add wave -position end  sim:/alu/newCCR

-- add 1, 2
force -freeze sim:/alu/aluControl 3 0
force -freeze sim:/alu/R1 1 0
force -freeze sim:/alu/R2 2 0
force -freeze sim:/alu/oldCCR 0 0
run

-- sub 1, 2
force -freeze sim:/alu/aluControl 4 0
run

-- sub 5, 3
force -freeze sim:/alu/R1 5 0
force -freeze sim:/alu/R2 3 0
force -freeze sim:/alu/aluControl 4 0
run


-- NOP
force -freeze sim:/alu/aluControl 0 0
run

-- NOT
force -freeze sim:/alu/aluControl 2 0
run

-- AND
force -freeze sim:/alu/aluControl 5 0
run 

-- INC
force -freeze sim:/alu/R1 FFFF 0
force -freeze sim:/alu/aluControl 6 0
run

