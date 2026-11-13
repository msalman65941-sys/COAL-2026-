
.model small
.stack 100h

.data
    msg1 db 13,10,'===== BANK MENU =====$'
    msg2 db 13,10,'1. Deposit Money$'
    msg3 db 13,10,'2. Withdraw Money$'
    msg4 db 13,10,'3. Check Balance$'
    msg5 db 13,10,'4. Exit$'
    msg6 db 13,10,'Enter your choice: $'

    msg7 db 13,10,'Enter deposit amount: $'
    msg8 db 13,10,'Enter withdrawal amount: $'
    msg9 db 13,10,'Deposit successful.$'
    msg10 db 13,10,'Withdrawal successful.$'
    msg11 db 13,10,'Current balance: Rs. $'
    msg12 db 13,10,'Insufficient funds.$'
    msg13 db 13,10,'Invalid amount. Enter a positive amount.$'
    msg14 db 13,10,'Invalid menu choice.$'

    msg15 db 13,10,13,10,'===== FINAL REPORT =====$'
    msg16 db 13,10,'Final balance: Rs. $'
    msg17 db 13,10,'Successful deposits: $'
    msg18 db 13,10,'Successful withdrawals: $'
    msg19 db 13,10,'Thank you for using the bank simulator.$'

    balance dw 10000
    amount dw 0
    choice dw 0
    deposits dw 0
    withdrawals dw 0

.code
main proc
    mov ax, @data
    mov ds, ax

menu:
    lea dx, msg1
    mov ah, 09h
    int 21h

    lea dx, msg2
    mov ah, 09h
    int 21h

    lea dx, msg3
    mov ah, 09h
    int 21h

    lea dx, msg4
    mov ah, 09h
    int 21h

    lea dx, msg5
    mov ah, 09h
    int 21h

    lea dx, msg6
    mov ah, 09h
    int 21h

    call read_num
    mov choice, ax

    cmp ax, 1
    je deposit

    cmp ax, 2
    je withdraw

    cmp ax, 3
    je checkBalance

    cmp ax, 4
    je exit_program

    lea dx, msg14
    mov ah, 09h
    int 21h

    jmp menu

deposit:
    lea dx, msg7
    mov ah, 09h
    int 21h

    call read_num
    mov amount, ax

    cmp ax, 0
    jle invalid_amount

    add balance, ax
    inc deposits

    lea dx, msg9
    mov ah, 09h
    int 21h

    jmp menu

withdraw:
    lea dx, msg8
    mov ah, 09h
    int 21h

    call read_num
    mov amount, ax

    cmp ax, 0
    jle invalid_amount

    cmp ax, balance
    ja insufficient_funds

    sub balance, ax
    inc withdrawals

    lea dx, msg10
    mov ah, 09h
    int 21h

    jmp menu

checkBalance:
    lea dx, msg11
    mov ah, 09h
    int 21h

    mov ax, balance
    call print_num

    jmp menu

invalid_amount:
    lea dx, msg13
    mov ah, 09h
    int 21h

    jmp menu

insufficient_funds:
    lea dx, msg12
    mov ah, 09h
    int 21h

    jmp menu

exit_program:
    lea dx, msg15
    mov ah, 09h
    int 21h

    lea dx, msg16
    mov ah, 09h
    int 21h

    mov ax, balance
    call print_num

    lea dx, msg17
    mov ah, 09h
    int 21h

    mov ax, deposits
    call print_num

    lea dx, msg18
    mov ah, 09h
    int 21h

    mov ax, withdrawals
    call print_num

    lea dx, msg19
    mov ah, 09h
    int 21h

    mov ah, 4Ch
    int 21h
main endp

read_num proc
    push bx
    push cx
    push si

    xor bx, bx

read_digit:
    mov ah, 01h
    int 21h

    cmp al, 13
    je number_done

    sub al, '0'
    xor ah, ah
    mov si, ax

    mov ax, bx
    mov cx, 10
    mul cx
    add ax, si
    mov bx, ax

    jmp read_digit

number_done:
    mov ax, bx

    pop si
    pop cx
    pop bx
    ret
read_num endp

print_num proc
    push ax
    push bx
    push cx
    push dx

    mov bx, 10
    xor cx, cx

    cmp ax, 0
    jne convert_num

    mov dl, '0'
    mov ah, 02h
    int 21h
    jmp print_done

convert_num:
    xor dx, dx
    div bx
    push dx
    inc cx

    cmp ax, 0
    jne convert_num

print_digits:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop print_digits

print_done:
    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_num endp

end main
```