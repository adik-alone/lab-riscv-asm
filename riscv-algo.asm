# вариант 11 
# Найти минимальную строку в массиве с минимальной суммой элементов N = 5, M = 3

# array of numbers
# {
# {a1, a2, a3, a4, a5},
# {b1, b2, b3, b4, b5},
# {c1, c2, c3, c4, c5},
# }

.data
array: 
    .word 1, 2, 3, 4, 5
    .word 1, 2, 3, 1, 6
    .word 2, 0, 4, 5, 1
n: 
    .word 5
m: 
    .word 3
sum:
    .word 0, 0, 0

.text
.globl _start
main:
	j _start

line_sum:
    li x10, 0        # x10 - sum
    lw x11, 4(sp)    # x11 - рамер массива
    lw x12, 0(sp)    # x12 - ссылка на массив

    loop:
        beqz x11, end
        lw x13, 0(x12)      # x13 - текущий элемент массива
        add x10, x10, x13   # Суммирование
        addi x12, x12, 4    # Переходим к следующему элементу массива
        addi x11, x11, -1   # Уменшаем счётчик
        j loop

    end:
        sw x10, 0(sp)
        jr ra


_start:
    la x6, n
    la x7, m
    lw x8, 0(x6)     # Значение длины строки
    lw x9, 0(x7)     # Значение длинны массива

    la x6, sum          # Ссылка на массив с значениями сумм
    la x7, array      # Ссылка на массив

    addi sp, sp, -16

    _start.loop: 
        beqz x9, done
        lw x5, 0(x6)    # Элемент массива сумм для текущей строки

        sw x7, 0(sp)    # Сохраняем на стеке ссылку на массив
        sw x8, 4(sp)    # Сохраняем на стеке размер массива

        jal ra, line_sum   # Вызываем функцию

        lw x10, 0(sp)   # Снимаем со стека значение суммы
        add x5, x5, x10 # Сохраняем значение суммы
        sw x10, 0(x6) 	# Реально сохраняем значение в массив сумм

        addi x6, x6, 4  # Переходим на следующий элемент массива сумм 
        addi x7, x7, 20 # Новый элемент массива

        addi x9, x9, -1 # Уменьшаем итерацию по массиву
        j _start.loop

    done:
        li x20, 0        # сюда загрузим ответ
        la x6, sum
        lw x28, 0(x6)
        li x29, 3
        li x27, 3		# Эталон 3

        done.loop:
            beqz x29, exit
            lw x30, 0(x6)

            bgt x30, x28, end_loop
            addi x28, x30, 0
            sub x20, x27, x29 		# вычисляем номер строки

            end_loop:
                addi x6, x6, 4
                addi x29, x29, -1
                j done.loop

    exit:
    	addi a0, x0, 1
        addi a1, x20, 0
        ecall
        addi a0, x0, 10
        ecall