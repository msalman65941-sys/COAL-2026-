#make_COM#
org 100h
jmp start

msg db 'WELCOME TO COAL LAB', 0

start:
    mov si, offset msg

    nop

    mov ax, 4C00h
    int 21h
;Message DB se declare hua hai. 
;SI mein message ka starting address load kiya hai. 0 null terminator hai.