.model small
.stack 100h
.data
    prompt db 'Enter the month number (1-12): $'
    msgWinter db ' Winter$'
    msgSpring db ' Spring$'
    msgSummer db ' Summer$'
    msgAutumn db ' Autumn$'
    month db ?
.code
main proc
    mov ax, @data
    mov ds, ax

    mov ah, 09h
    lea dx, prompt
    int 21h

    mov ah, 01h
    int 21h
    sub al, '0'       
    mov month, al

    cmp month, 12
    je  printWinter
    cmp month, 3
    je  printSpring
    cmp month, 6
    je  printSummer
    cmp month, 9
    je  printAutumn

    cmp month, 2
    jbe printWinter
    cmp month, 11
    jbe printWinter

    cmp month, 5
    jbe printSpring

    cmp month, 8
    jbe printSummer

    cmp month, 10
    jbe printAutumn

    jmp exit

printWinter:
    mov ah, 09h
    lea dx, msgWinter
    int 21h
    jmp exit

printSpring:
    mov ah, 09h
    lea dx, msgSpring
    int 21h
    jmp exit

printSummer:
    mov ah, 09h
    lea dx, msgSummer
    int 21h
    jmp exit

printAutumn:
    mov ah, 09h
    lea dx, msgAutumn
    int 21h
    jmp exit

exit:
    mov ax, 4C00h
    int 21h
main endp
end main