#make_COM#
org 100h
jmp start

marks dw 80,75,90,85
total dw 0
avg dw 0

start:
    mov si, offset marks
    mov cx, 4
    mov ax, 0

again:
    add ax, [si]
    add si, 2
    loop again

    mov total, ax

    mov dx, 0
    mov bx, 4
    div bx

    mov avg, ax

    nop

    mov ax, 4C00h
    int 21h
;SI array ke first mark ko point karta hai.

;CX = 4 loop four times run karta hai.

;Har iteration mein current mark AX mein add hota hai.

;add si, 2 next WORD element par move karta hai.

;Total ko memory mein save karte hain.

;DIV BX se average calculate hota hai.