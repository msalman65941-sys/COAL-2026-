#make_COM#
org 100h
jmp start

a dw 25
b dw 15
c dw 8
d dw 4

result dw 0

start:
    mov ax, a
    add ax, b

    mov bx, c
    add bx, d

    sub ax, bx

    mov result, ax

    nop

    mov ax, 4C00h
    int 21h  
;AX mein a+b aur BX mein c+d calculate kiya. 
;Phir AX se BX subtract karke result memory mein save kar diya.