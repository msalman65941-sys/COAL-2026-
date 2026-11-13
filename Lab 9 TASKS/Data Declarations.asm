#make_COM#
org 100h
jmp start

pos_b db 25
neg_b db -5

pos_w dw 300
neg_w dw -100

start:
    mov al, pos_b
    mov bl, neg_b

    mov cx, pos_w
    mov dx, neg_w

    nop

    mov ax, 4C00h
    int 21h 
;DB 1 byte aur DW 2 bytes store karta hai. 
;Negative numbers two's complement mein represent hote hain. 
;Word ke bytes little-endian order mein store hote hain.