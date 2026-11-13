#make_COM#
org 100h

mov ax, 25
mov bx, 12

add ax, bx
sub ax, 7
inc ax

nop

mov ax, 4C00h
int 21h      

;Pehle AX mein 25 aur BX mein 12 load kiye. Dono add kiye, phir 7 minus aur last mein AX ko 1 increment kiya.