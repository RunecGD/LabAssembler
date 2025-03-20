.model small
.386
.stack 400h
.data
    sign db ? 
    s dd 0
    x dw ? 
    y dw ?
    f dd ?
    height dd 0 
    vivod db '(8735 * 588) - X + (Y / 12)', 10, 13, '$'
    vvX db 'vvedite x: ', 10, 13, '$'
    vvY db 'vvedite y: ', 10, 13, '$'
    k dw 0
    ress dd ?

.code 
start: 
    mov ax, @data 
    mov ds, ax 
    mov ah, 09h
    mov dx, offset vivod ; вывод
    int 21h
    xor ax, ax ; обнуление регистров
    xor bx, bx 
    xor cx, cx
    xor dx, dx  

    ; Ввод X
    mov ah, 09h
    mov dx, offset vvX
    int 21h
    call InputNumber
    mov [x], cx ; Сохраняем значение X

    ; Ввод Y   \
    mov ah, 09h
    mov dx, offset vvY
    int 21h
    call InputNumber
    mov [y], cx ; Сохраняем значение Y

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
    mov f, eax  ; Сохраняем результат в result

    ; Вывод результата
    xor edx, edx
    push -1

    mov eax, [f]
    cmp eax, 0
    jnl cont
    mov ecx, eax
    mov ah, 02h
    mov dl, '-'
    int 21h
    mov eax, ecx
    neg eax

cont:
    mov ebx, 10

cont2:
    mov edx, 0
    div ebx
    push edx
    cmp eax, 0
    jne cont2

NumOut:
    pop edx
    cmp dx, -1
    je exit
    add dl, 30h
    mov ah, 02h
    int 21h
    jmp NumOut

    ; Завершение программы
exit:      
    mov ax, 4c00h
    int 21h

InputNumber proc
    ; Сбросим знак
    mov sign, 0 

    mov ah, 01h 
    int 21h 
    cmp al, '-' 
    jne coninput 
    mov sign, 1 

coninput: 
    sub al, 30h ; преобразование символа в число
    mov ah, 0 
    mov ebx, 10 
    mov ecx, eax 

    ; Начало цикла ввода                                                                                
FirstInput: 
    xor eax, eax
    mov ah, 01h ; считывание числа
    int 21h  
    cmp al, 0dh ; проверка на Enter
    je EndInput ; переход к завершению ввода
    sub al, 30h 
    cbw  ; расширение до 16 бит
    cwde   ; расширение до 32 бит
    xchg eax, ecx 
    mul ebx ; умножение числа на 10
    add ecx, eax 
    jmp FirstInput

EndInput: 
    cmp sign, 1 
    jne final 
    neg ecx    ; изменение знака    

final: 
    ret
InputNumber endp

end start
