vsim -gui work.processor

add wave -position end  sim:/processor/clk
add wave -position end  sim:/processor/rst
add wave -position end  sim:/processor/updated_pc
add wave -position end  sim:/processor/d_instruction
add wave -position end  sim:/processor/e_R1
add wave -position end  sim:/processor/e_R2
add wave -position end  sim:/processor/d_instruction_op
add wave -position end  sim:/processor/e_Mread
add wave -position end  sim:/processor/e_Mwrite
add wave -position end  sim:/processor/e_RegWrite
add wave -position end  sim:/processor/e_Alu2
add wave -position end  sim:/processor/e_Alu1
add wave -position end  sim:/processor/e_Alu0
add wave -position end  sim:/processor/e_Branch
add wave -position end  sim:/processor/e_RegWrite
add wave -position end  sim:/processor/m_reg_write
add wave -position end  sim:/processor/wb_reg_write
add wave -position end  sim:/processor/m_result
add wave -position end  sim:/processor/reg_write
add wave -position end  sim:/processor/returned_rdst
add wave -position end  sim:/processor/wb_rdst




force -freeze sim:/processor/clk 1 0, 0 {5 ps} -r 10
force -freeze sim:/processor/rst 1 0
force -freeze sim:/processor/rst 0 15

run 90ps 