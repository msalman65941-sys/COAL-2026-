#make_COM#
org 100h
jmp start

zeros db 16 dup(0)
empty db 10 dup(?)
stars db 6 dup('*'), 0

start:
    mov si, offset zeros
    mov di, offset empty
    mov bx, offset stars

    nop

    mov ax, 4C00h
    int 21h
;DUP values repeat karta hai. 
;? uninitialized storage reserve karta hai.