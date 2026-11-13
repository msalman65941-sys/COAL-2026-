.MODEL SMALL
.STACK 100H

.DATA
    msgInput   DB 'Enter an integer greater than 1: $'
    msgPrime   DB 13,10,' is prime.$'
    msgNot     DB 13,10,' is not prime.$'

    num DW ?

.CODE

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Input message
    LEA DX, msgInput
    MOV AH, 09H
    INT 21H

    ; Read number
    CALL READ_NUM
    MOV num, AX

    ; Print the number first
    CALL PRINT_NUM

    ; Start divisor = 2
    MOV BX, 2

CHECK_LOOP:

    ; AX = num
    MOV AX, num
    XOR DX, DX
    DIV BX

    ; If remainder = 0, not prime
    CMP DX, 0
    JE NOT_PRIME

    ; Increase divisor
    INC BX

    ; Stop when divisor >= number
    CMP BX, num
    JB CHECK_LOOP

    ; No divisor found
    LEA DX, msgPrime
    MOV AH, 09H
    INT 21H
    JMP EXIT


NOT_PRIME:
    LEA DX, msgNot
    MOV AH, 09H
    INT 21H


EXIT:
    MOV AH, 4CH
    INT 21H

MAIN ENDP


; =========================
; READ NUMBER
; =========================
READ_NUM PROC
    XOR BX, BX

READ_LOOP:
    MOV AH, 01H
    INT 21H

    CMP AL, 13
    JE READ_DONE

    SUB AL, '0'
    XOR AH, AH

    PUSH AX

    MOV AX, BX
    MOV DX, 10
    MUL DX
    MOV BX, AX

    POP AX
    ADD BX, AX

    JMP READ_LOOP

READ_DONE:
    MOV AX, BX
    RET
READ_NUM ENDP


; =========================
; PRINT NUMBER
; =========================
PRINT_NUM PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV BX, 10
    XOR CX, CX

CONVERT:
    XOR DX, DX
    DIV BX

    PUSH DX
    INC CX

    CMP AX, 0
    JNE CONVERT

DISPLAY:
    POP DX
    ADD DL, '0'

    MOV AH, 02H
    INT 21H

    LOOP DISPLAY

    POP DX
    POP CX
    POP BX
    POP AX
    RET

PRINT_NUM ENDP

END MAIN