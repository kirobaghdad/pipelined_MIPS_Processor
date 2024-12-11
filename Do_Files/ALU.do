vsim -gui work.alu

add wave -position end  sim:/alu/aluControl
add wave -position end  sim:/alu/R1
add wave -position end  sim:/alu/R2
add wave -position end  sim:/alu/oldCCR
add wave -position end  sim:/alu/result
add wave -position end  sim:/alu/newCCR
add wave -position end  sim:/alu/invR2

-- add 1, 2
force -freeze sim:/alu/aluControl 011 0
force -freeze sim:/alu/R1 0000000000000001 0
force -freeze sim:/alu/R2 0000000000000010 0
force -freeze sim:/alu/oldCCR 000 0

run

-- sub 1, 2
force -freeze sim:/alu/aluControl 100 0

run 