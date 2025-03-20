; .model small
; .stack 128

; .data
;     x dw 1
;     y db 1
;     z db 1
;     result dw 0     

; .code
; start:
;     mov ax, @data
;     mov ds, ax
;     mov ax, 879         
;     mov cx, 100         
;     mul cx              
;     add ax, 35          

;     mov bx, 588  
;     sub bx, x       

;     add bx, ax

;     mov al, y           
;     cbw                 
;     add bx, ax          

;     mov al, z          
;     cbw                
;     add ax, bx          

;     sub ax, 12          

;     mov result, ax      

;     mov ax, 4C00h       
;     int 21h
; end start
.model small
.386
.stack 100h
.data
X dw 1         
Y dw 1          
Z dw 1          
f dd 0      
.code
start:
    mov ax, @data
    mov ds, ax      

    ; result = 87935 + (12 - x + y) + z - 3699
    mov ax, 577fh
    mov  dx, 1
    add ax, 12
    adc dx, 0
    sub ax, X        
    sbb dx, 0
    add ax, Y        
    adc dx, 0
    add ax, Z        
    adc dx, 0 
    sub ax, 3699     
    sbb dx, 0
    sub ax, 1
    sbb dx, 0
     
    mov word ptr f, ax       ; Сохраняем результат в f
    mov word ptr f+2, dx

    mov ax, 4C00h   
    int 21h         
end start