#make_COM#
org 100h
jmp start

num1 equ 7
num2 equ 8

result dw 0

start:
    mov ax, num1
    mov bx, num2

    mul bx

    mov result, ax

    nop

    mov ax, 4C00h
    int 21h
;EQU constant define karta hai. 
;MUL BX AX aur BX ko unsigned multiply karta hai. 
;Full 16-bit multiplication result DX:AX mein hota hai.