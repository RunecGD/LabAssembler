model small
.stack 100h
.data
stroka db 'Nachalo sigmenta dannyh$', 0 
    perem1  db  0ffh
 perem2  dw  3a7fh
 perem3  dd  0f54d567ah
 num1 db 10 
 num2 db 100
 num3 dw 1000
 num4 dw 10000 
 num5 db 0ch
 mas1 db 1,1,5 dup (?)
 adr_mas1 dw mas1 
 mas       db  10 dup (' ')
 pole    db  5 dup (?)
 adr       dw  perem3
 adr_full  dd  perem3
    fin    db 'Konec sigmenta dannyh programmy$', 0 
.code
main proc
    

    mov ax, @data
    mov ds, ax
    mov ah, 09h      
    lea dx, stroka   
    int 21h           

    
    mov ah, 09h
    lea dx, fin
    int 21h

    
    mov ax, 4C00h
    int 21h
main endp
end main
end  start