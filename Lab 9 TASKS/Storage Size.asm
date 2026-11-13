#make_COM#
org 100h
jmp start

arr1 db 9 dup(0)
arr2 dw 6 dup(0)

course dw 'C','O','A','L',0

start:
    mov si, offset arr1
    mov di, offset arr2
    mov bx, offset course

    nop

    mov ax, 4C00h
    int 21h
;BYTE 1 byte aur WORD 2 bytes leta hai. 
;WORD string mein 4 characters aur 1 terminator hain, isliye 5 × 2 = 10 bytes.