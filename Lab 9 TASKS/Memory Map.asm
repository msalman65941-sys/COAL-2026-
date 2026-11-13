#make_COM#
org 100h
jmp start

b1 db 11h
w1 dw 1234h
b2 db 22h
w2 dw 5678h

start:
    mov si, offset b1
    mov di, offset w1
    mov bx, offset b2
    mov cx, offset w2

    nop

    mov ax, 4C00h
    int 21h
;8086 little-endian architecture use karta hai. Isliye 1234h memory mein 34 12 hota hai.

;Ye offsets first variable ke relative hain. Actual addresses SI, DI, BX aur CX mein inspect kar sakte ho.