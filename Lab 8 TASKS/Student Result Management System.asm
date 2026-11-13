
.model small
.stack 100h

.data
    msg1 db 'Enter number of students: $'
    msg2 db 13,10,13,10,'Enter student name: $'
    msg3 db 13,10,'Enter marks in Subject 1: $'
    msg4 db 13,10,'Enter marks in Subject 2: $'                       
    msg5 db 13,10,'Enter marks in Subject 3: $'

    msg6 db 13,10,13,10,'Student Name: $'
    msg7 db 13,10,'Total Marks: $'
    msg8 db 13,10,'Percentage: $'
    msg9 db 13,10,'Grade: $'

    msg10 db 13,10,13,10,'Passed Students: $'
    msg11 db 13,10,'Failed Students: $'

    grade1 db 'A+$'
    grade2 db 'A$'
    grade3 db 'B$'
    grade4 db 'C$'
    grade5 db 'D$'
    grade6 db 'Fail$'

    namebuf db 30,0,31 dup('$')

    students dw 0
    remaining dw 0
    marks1 dw 0
    marks2 dw 0
    marks3 dw 0
    total dw 0
    percentage dw 0
    passed dw 0
    failed dw 0

.code
main proc
    mov ax, @data
    mov ds, ax

    lea dx, msg1
    mov ah, 09h
    int 21h

    call read_num
    mov students, ax
    mov remaining, ax

student_loop:
    cmp remaining, 0
    je final_report

    lea dx, msg2
    mov ah, 09h
    int 21h

    lea dx, namebuf
    mov ah, 0Ah
    int 21h

    lea di, namebuf+2
    xor cx, cx
    mov cl, [namebuf+1]
    add di, cx
    mov byte ptr [di], '$'

    lea dx, msg3
    mov ah, 09h
    int 21h
    call read_num
    mov marks1, ax

    lea dx, msg4
    mov ah, 09h
    int 21h
    call read_num
    mov marks2, ax

    lea dx, msg5
    mov ah, 09h
    int 21h
    call read_num
    mov marks3, ax

    mov ax, marks1
    add ax, marks2
    add ax, marks3
    mov total, ax

    mov bx, 100
    mul bx
    mov bx, 300
    div bx
    mov percentage, ax

    cmp ax, 50
    jb is_fail
    inc passed
    jmp show_result

is_fail:
    inc failed

show_result:
    lea dx, msg6
    mov ah, 09h
    int 21h

    lea dx, namebuf+2
    mov ah, 09h
    int 21h

    lea dx, msg7
    mov ah, 09h
    int 21h

    mov ax, total
    call print_num

    lea dx, msg8
    mov ah, 09h
    int 21h

    mov ax, percentage
    call print_num

    mov dl, '%'
    mov ah, 02h
    int 21h

    lea dx, msg9
    mov ah, 09h
    int 21h

    mov ax, percentage
    cmp ax, 90
    jae show_Aplus

    cmp ax, 80
    jae show_A

    cmp ax, 70
    jae show_B

    cmp ax, 60
    jae show_C

    cmp ax, 50
    jae show_D

    lea dx, grade6
    jmp display_grade

show_Aplus:
    lea dx, grade1
    jmp display_grade

show_A:
    lea dx, grade2
    jmp display_grade

show_B:
    lea dx, grade3
    jmp display_grade

show_C:
    lea dx, grade4
    jmp display_grade

show_D:
    lea dx, grade5

display_grade:
    mov ah, 09h
    int 21h

    dec remaining
    jmp student_loop

final_report:
    lea dx, msg10
    mov ah, 09h
    int 21h

    mov ax, passed
    call print_num

    lea dx, msg11
    mov ah, 09h
    int 21h

    mov ax, failed
    call print_num

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
