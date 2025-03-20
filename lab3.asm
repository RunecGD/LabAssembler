.model small
.386
.stack 128

.data
    x dw 1           ; x = 1
    y dw 12          ; y = 12
    result dd 0      ; результат
    height dd 0      ; для хранения результата умножения

.code
start:
    mov ax, @data
    mov ds, ax         

    ; Умножаем 8735 на 588
    mov ax, 8735
    mov bx, 588
    mul bx              ; Умножение ax (8735) на bx (588)
    
    ; Сохраняем результат в height
    mov word ptr height, ax     ; Сохраняем результат 32-битного умножения
    mov word ptr height+2, dx
    ; Извлекаем x
    mov ax, x
    sub word ptr height, ax      ; height = height - x
    sbb word ptr height+2, 0
    ; Делим y на 12
    mov ax, y           ; Загружаем y в ax
    mov cx, 12          ; Делитель
    xor dx, dx          ; Обнуляем dx перед делением
    div cx               ; Делим ax на cx, результат в ax, остаток в dx

    ; Добавляем результат деления к height
    add word ptr height, ax      ; height = height + (y / 12)
    adc word ptr height+2, 0
    mov eax, height
    ; Сохраняем результат в переменную result
    mov result, eax  ; Сохраняем результат в result

    ; Завершение программы
    mov ax, 4C00h       
    int 21h
end start