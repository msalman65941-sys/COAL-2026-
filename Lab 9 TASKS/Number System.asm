#make_COM#
org 100h

mov ax, 101101b
mov bx, 73
mov cx, 2Ah

nop

mov ax, 4C00h
int 21h
;b binary ko represent karta hai aur h hexadecimal ko
;CPU sab values binary mein store karta hai
;hum unko different number systems mein represent kar sakte hain.