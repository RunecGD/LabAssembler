.model small
.stack 100h
.data
    prompt db 'Enter the month number (1-12): $'
    msgWinter db ' Winter$'
    msgSpring db ' Spring$'
    msgSummer db ' Summer$'
    msgAutumn db ' Autumn$'
    msgInvalid db ' Invalid input. Please enter a number between 1 and 12.$'
.code 
start: 
    mov ax, @data 
    mov ds, ax 

input_loop:
    mov ah, 09h
    lea dx, prompt
    int 21h

    ; Ввод числа
    call InputNumber
    ; Проверка диапазона (1-12)
    cmp ax, 12
    jg printInvalid       ; Если больше 12, выводим сообщение об ошибке
    cmp ax, 1
    jl printInvalid       ; Если меньше 1, выводим сообщение об ошибке

    ; Определение поры года
    cmp ax, 12
    je printWinter
    cmp ax, 3
    je printSpring
    cmp ax, 6
    je printSummer
    cmp ax, 9
    je printAutumn

    jmp input_loop ; Вернуться к вводу, если число не 1-12

printWinter:
    mov ah, 09h
    lea dx, msgWinter
    int 21h
    jmp input_loop

printSpring:
    mov ah, 09h
    lea dx, msgSpring
    int 21h
    jmp input_loop

printSummer:
    mov ah, 09h
    lea dx, msgSummer
    int 21h
    jmp input_loop

printAutumn:
    mov ah, 09h
    lea dx, msgAutumn
    int 21h
    jmp input_loop

printInvalid:
    mov ah, 09h
    lea dx, msgInvalid
    int 21h
    jmp input_loop

InputNumber proc
    xor ax, ax             ; Обнуляем AX для хранения результата

FirstInput: 
    mov ah, 01h            ; Считывание символа
    int 21h  
    cmp al, 0dh            ; Проверка на Enter
    je EndInput            ; Переход к завершению ввода

    ; Проверка, является ли символ цифрой
    cmp al, '0'
    jb FirstInput          ; Если меньше '0', игнорируем
    cmp al, '9'
    ja FirstInput          ; Если больше '9', игнорируем

    sub al, '0'            ; Преобразование символа в число
    ; Умножаем текущее значение AX на 10
    mov bl, 10             ; Устанавливаем 10 в BL
    mul bl                 ; Умножаем AX на 10
    ; Добавляем новое число из AL
    add ax, ax             ; Это было ошибочно
    mov cx, ax             ; Сохраняем текущее значение в CX для дальнейшего использования
    add cx, ax            ; Добавляем новое число из AL в CX
    mov ax, cx             ; Пересохраняем результат обратно в AX

    jmp FirstInput         ; Переход к следующему символу

EndInput: 
    ret 
InputNumber endp
end start