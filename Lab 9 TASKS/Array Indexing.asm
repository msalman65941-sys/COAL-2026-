#make_COM#
org 100h
jmp start

nums db 10,20,30,40,50,60,70,80

start:
    mov si, offset nums

    mov al, [si+1]
    mov bl, [si+3]
    mov cl, [si+7]

    nop

    mov ax, 4C00h
    int 21h
;Array indexing zero se shuru hoti hai. 
;SI first element ka address hold karta hai.