.model small
.386
.stack 400h
.data
    sign db ? 
    x dw ? 
    y dw ?
    f dd ?
    vivod db '(458/481)*x+(y-36)', 10, 13, '$'   
    vvX db 'Write x: ', 10, 13, '$'
    vvY db 'Write y: ', 10, 13, '$'
.code 
start: 
    mov ax, @data 
    mov ds, ax 
    mov ah, 09h
    mov dx, offset vivod ; вывод формулы
    int 21h
    xor ax, ax ; обнуление регистров

    ; Ввод X
    mov ah, 09h
    mov dx, offset vvX
    int 21h
    call InputNumber
    mov [x], cx ; Сохраняем значение X

    ; Ввод Y   
    mov ah, 09h
    mov dx, offset vvY
    int 21h
    call InputNumber
    mov [y], cx ; Сохраняем значение Y

    ; Вычисления: (458/481)*x + (y-36)
    mov ax, 458
    xor dx, dx 
    mov bx, [x]          ; Загружаем x
    mul bx               ; Умножаем 458 на x
    mov bx, 481
    div bx               ; Делим результат на 481
    mov [f], eax         ; Сохраняем целую часть результата в f

    mov ax, [y]         ; Загружаем y
    sub ax, 36          ; Вычисляем (y - 36)
    add [f], eax         ; Добавляем к результату

    ; Вывод результата
    mov eax, [f]
    call PrintNumber     ; Печатаем число

    ; Завершение программы
exit:      
    mov ax, 4c00h
    int 21h

PrintNumber proc
    ; Если число отрицательное, выводим минус
    cmp ax, 0
    jge PrintPositive

    mov ah, 02h
    mov dl, '-'
    int 21h
    neg ax               ; Делаем число положительным

PrintPositive:
    ; Выводим число
    xor cx, cx          ; Обнуляем CX для хранения количества цифр
    mov bx, 10          ; Основание системы счисления

ConvertLoop:
    xor dx, dx          ; Обнуляем DX перед делением
    div bx              ; Делим AX на 10
    push dx             ; Сохраняем остаток
    inc cx              ; Увеличиваем количество цифр
    test ax, ax         ; Проверка на ноль
    jnz ConvertLoop      ; Если не ноль, продолжаем

PrintDigits:
    pop dx              ; Получаем остаток
    add dl, '0'         ; Преобразуем в ASCII
    mov ah, 02h
    int 21h
    loop PrintDigits     ; Печатаем все цифры

    ret
PrintNumber endp

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